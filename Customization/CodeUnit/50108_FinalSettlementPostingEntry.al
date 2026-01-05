
codeunit 50108 "Final Settlement Posting Mgt."
{
    procedure PostFinalSettlementAmount(FinalSettlement: Record "FinalSettlement")
    var
        GenJnlLine: Record "Gen. Journal Line";
        GenJnlTemplate: Record "Gen. Journal Template";
        GenJnlBatch: Record "Gen. Journal Batch";
        LineNo: Integer;
        DocNo: Code[20];
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        FinalcalculationRec: Record "Final Calculation";
        PendingReceivableRID: Record "Pending Receviable Grid";
        AdditionalCharges: Record "Additional Charges Sub";
        BillingSetup: Record "Final Billing Calculation Grid";
        Amount: Decimal;
        remainingInvoiceAmount: Decimal;
        PendingAmount: Decimal;
        GLSetup: Record "General Ledger Setup";
        TenantName: Text[100];
        BankAccount: Record "Bank Account";
        BankAccountNo: Code[20];
        CustomerCard: Record Customer;
        JournalTemplateName: Code[10];
        JournalBatchName: Code[10];
        additionalChargesInvoiceID: Code[20];
        finalBillingInvoiceID: Code[20];
        InvoiceID: Code[20];
        HasJournalEntries: Boolean;
        finalBillingAdjusted: Boolean;
        COASetup: Record "COA Setup";
        respectiveAccountNo: Code[20];
        balAccountType: Enum "Gen. Journal Account Type";

    begin
        // Load G/L Setup for rounding
        GLSetup.Get();
        GenJnlLine.DeleteAll();
        // Check if there's any amount to post
        Amount := FinalSettlement."Receivable Total Amount";
        if Amount = 0 then
            Error('Final Settlement Amount is zero. Cannot post.');

        // Round the amount according to G/L setup
        Amount := Round(Amount, GLSetup."Amount Rounding Precision");

        // Set Journal Template and Batch
        JournalTemplateName := 'CASH RECE';
        JournalBatchName := 'DEFAULT';

        // Get tenant contract information
        FinalcalculationRec.Reset();
        FinalcalculationRec.SetRange("Contract ID", FinalSettlement."Contract ID");
        if not FinalcalculationRec.FindFirst() then
            Error('Contract not found for Contract ID %1', FinalSettlement."Contract ID");

        TenantName := FinalcalculationRec."Tenant Name";

        if FinalcalculationRec."Unit Type" <> '' then begin
            CustomerCard.Reset();
            CustomerCard.SetRange("No.", FinalSettlement."Tenant ID");
            if CustomerCard.FindFirst() then begin
                CustomerCard.Validate("Gen. Bus. Posting Group", FinalcalculationRec."Unit Type");
                CustomerCard.Validate("Customer Posting Group", FinalcalculationRec."Unit Type");
                CustomerCard.Modify();
            end;
        end;


        // Get pending receivable information
        PendingReceivableRID.Reset();
        PendingReceivableRID.SetRange("Contract ID", FinalSettlement."Contract ID");
        if PendingReceivableRID.FindFirst() then
            PendingAmount := PendingReceivableRID."Total Receivable"
        else
            PendingAmount := 0;

        // Get Invoice ID (Optional - try multiple sources)
        AdditionalCharges.Reset();
        AdditionalCharges.SetRange("Contract ID", FinalSettlement."Contract ID");
        if AdditionalCharges.FindFirst() then
            additionalChargesInvoiceID := AdditionalCharges."Invoiced ID";

        BillingSetup.Reset();
        BillingSetup.SetRange("Contract ID", FinalSettlement."Contract ID");
        if BillingSetup.FindFirst() then
            finalBillingInvoiceID := BillingSetup."Invoice ID";

        // Find Bank Account
        // BankAccountNo := '';
        // BankAccount.Reset();
        // BankAccount.SetRange("Search Name", FinalSettlement."Deposit Bank");
        // if BankAccount.FindFirst() then
        //     BankAccountNo := BankAccount."No.";
        if FinalSettlement."Receivable Payment mode" = 'Cash' then begin
            COASetup.Get();
            if COASetup.Cash <> '' then begin
                respectiveAccountNo := COASetup.Cash;
                balAccountType := balAccountType::"G/L Account";
            end
            else
                Error('COA Setup doest not exist for Cash Payment');
        end
        else begin
            respectiveAccountNo := '';
            BankAccount.Reset();
            BankAccount.SetRange("Search Name", FinalSettlement."Deposit Bank");
            if BankAccount.FindFirst() then begin
                if BankAccount."Bank Acc. Posting Group" <> '' then begin

                    respectiveAccountNo := BankAccount."No.";
                    balAccountType := balAccountType::"Bank Account";
                end
                else
                    Error('Bank Acc. Posting Group is blank in Bank Account %1', BankAccount."No.");
            end;
        end;


        // Generate Document No
        DocNo := 'FS-' + Format(FinalSettlement."Contract ID") + '-' + Format(FinalSettlement."FC ID");

        // Start with first line number
        LineNo := 10000;
        HasJournalEntries := false;

        finalBillingAdjusted := false;
        remainingInvoiceAmount := 0;

        while Amount > 0 do begin
            Clear(GenJnlLine);
            GenJnlLine.Init();
            GenJnlLine."Journal Template Name" := JournalTemplateName;
            GenJnlLine."Journal Batch Name" := JournalBatchName;
            GenJnlLine."Line No." := LineNo;
            GenJnlLine."Posting Date" := Today;
            GenJnlLine."Document No." := DocNo;
            GenJnlLine."Document Type" := GenJnlLine."Document Type"::Payment;
            GenJnlLine."Account Type" := GenJnlLine."Account Type"::Customer;
            GenJnlLine."Account No." := FinalSettlement."Tenant ID";
            GenJnlLine.Description := TenantName;
            GenJnlLine."Contract ID" := FinalSettlement."Contract ID";
            GenJnlLine."Applies-to Doc. Type" := GenJnlLine."Applies-to Doc. Type"::Invoice;

            // if BankAccountNo <> '' then begin
            //     GenJnlLine."Bal. Account Type" := GenJnlLine."Bal. Account Type"::"Bank Account";
            //     GenJnlLine."Bal. Account No." := BankAccountNo;
            // end else begin
            GenJnlLine."Bal. Account Type" := balAccountType;
            GenJnlLine."Bal. Account No." := respectiveAccountNo;


            if not finalBillingAdjusted then begin
                if CheckRemainingAmount(finalBillingInvoiceID, remainingInvoiceAmount) then begin
                    GenJnlLine."Applies-to Doc. No." := finalBillingInvoiceID;
                    finalBillingAdjusted := true;
                end;
            end
            else begin
                if finalBillingAdjusted or (remainingInvoiceAmount = 0) then begin
                    if CheckRemainingAmount(additionalChargesInvoiceID, remainingInvoiceAmount) then
                        GenJnlLine."Applies-to Doc. No." := additionalChargesInvoiceID;
                end;
            end;

            GenJnlLine.Validate(Amount, -remainingInvoiceAmount);
            GenJnlLine.Insert();

            LineNo += 10000;
            Amount -= remainingInvoiceAmount;
            HasJournalEntries := true;
        end;

        // Check if at least one journal line was created
        if not HasJournalEntries then
            Error('No journal entries were created. Both Total Receive (%1) and Pending Amount (%2) are zero or negative for Contract ID %3',
                  FinalcalculationRec."Total Receive", PendingAmount, FinalSettlement."Contract ID");

        // Update customer posting groups if Unit Type exists

        // Post the Journal
        GenJnlPost.Run(GenJnlLine);

        // Clean up journal lines
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", JournalTemplateName);
        GenJnlLine.SetRange("Journal Batch Name", JournalBatchName);
        if GenJnlLine.FindSet() then
            GenJnlLine.DeleteAll(true);

        Message('Final Settlement amount posted successfully. Total Receive: %1, Pending: %2',
                FinalcalculationRec."Total Receive", PendingAmount);
    end;

    procedure CheckRemainingAmount(invoiceId: Code[20]; var remainingAmount: Decimal): Boolean
    var
        postedSalesInvoice: Record "Sales Invoice Header";
    begin
        if postedSalesInvoice.Get(invoiceId) then begin
            postedSalesInvoice.CalcFields("Remaining Amount");
            if postedSalesInvoice."Remaining Amount" > 0 then begin
                remainingAmount := postedSalesInvoice."Remaining Amount";
                exit(true);
            end
            else begin
                remainingAmount := 0;
                exit(false);
            end;
        end
        else begin
            remainingAmount := 0;
            exit(false);
        end;
    end;
}