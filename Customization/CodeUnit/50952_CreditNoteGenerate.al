codeunit 50952 "Credit Memo Generate"
{
    Subtype = Normal;
    trigger OnRun()
    begin
    end;

    procedure GenerateCreditMemo(requestcreditnoteapproval: Record RequestCreditNoteApprovalList)
    var
        myInt: Integer;
        NewSalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Customer: Record Customer;
        GLAccount: Record "G/L Account";
        SalesPost: Codeunit "Sales-Post";
        requestcreditnotegrid: Record "Request Credit Note Grid";
        customercard: Record Customer;
    begin
        Customer.SetRange("No.", requestcreditnoteapproval."Tenant No.");
        if not Customer.FindFirst() then
            Error('Customer not found for the given Sales Credit Memo.');
        requestcreditnotegrid.SetRange("Request No.", requestcreditnoteapproval."Request No.");
        requestcreditnotegrid.SetRange("Contract ID", requestcreditnoteapproval."Contract ID");
        if requestcreditnotegrid.FindSet() then
            repeat
                if requestcreditnotegrid."Credit Memo Generated" = false then begin
                    NewSalesHeader := CreateSalesHeader(requestcreditnotegrid."Contract ID", requestcreditnotegrid."Tenant No.", requestcreditnotegrid."Property Classification");

                    customercard.SetRange("No.", NewSalesHeader."Sell-to Customer No.");
                    if customercard.FindSet() then begin
                        if NewSalesHeader."Property Classification" <> '' then begin
                            customercard.Validate("Gen. Bus. Posting Group", NewSalesHeader."Property Classification");
                            customercard.Validate("Customer Posting Group", NewSalesHeader."Property Classification");
                            customercard.Modify();
                        end
                    end;
                    if NewSalesHeader."Property Classification" <> '' then begin

                        NewSalesHeader.Validate("Gen. Bus. Posting Group", NewSalesHeader."Property Classification");
                        NewSalesHeader.Validate("Customer Posting Group", NewSalesHeader."Property Classification");
                        NewSalesHeader.Modify();
                    end;
                    createSalesLines(NewSalesHeader, requestcreditnotegrid);
                    SalesPost.Run(NewSalesHeader);
                    Message('Sales Credit Memo created successfully with No. %1', NewSalesHeader."No.");
                    requestcreditnotegrid."Credit Memo Generated" := true;
                    requestcreditnotegrid."Credit Note No." := NewSalesHeader."No.";
                    requestcreditnotegrid.Modify();
                end;
            until requestcreditnotegrid.Next() = 0;

    end;

    procedure CreateSalesHeader(pContractID: Integer; pTenantID: Code[50]; pUnitType: Text[50]): Record "Sales Header";
    var
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        Customer: Record Customer;
        salesReciveable: Record "Sales & Receivables Setup";
        noseries: Codeunit "No. Series";
        requestcreditnotegrid: Record "Request Credit Note Grid";
    begin
        salesHeader.Init();
        if salesReciveable.FindSet() then
            salesHeader."No." := noseries.GetNextNo(salesReciveable."Credit Memo Nos.", Today, true);
        salesHeader."Document Type" := SalesHeader."Document Type"::"Credit Memo";

        salesHeader.Validate("Sell-to Customer No.", pTenantID);
        salesHeader."Document Date" := Today;
        salesHeader.Validate("Contract ID", pcontractid);
        //   salesHeader."Document Date" := Today;
        salesHeader."Posting Date" := Today;
        salesHeader."Due Date" := Today;
        salesHeader."Property Classification" := pUnitType;
        SalesHeader."Posting No. Series" := salesReciveable."Posted Credit Memo Nos.";
        SalesHeader."Approval Status for CreditNote" := SalesHeader."Approval Status for CreditNote"::Approved;

        salesHeader.Insert();
        exit(salesHeader);
    end;

    procedure createSalesLines(salesheader1: Record "Sales Header"; requestcreditnotegrid: Record "Request Credit Note Grid")
    var
        saleline: Record "Sales Line";
        newSaleslines: Record "Sales Line";
        item: Record Item;
        salesTaxCalculate: Codeunit "Sales Tax Calculate";
        currency: Record Currency;
        vatpostingsetup: Record "VAT Posting Setup";
    begin


        saleline.Init();
        saleline."Document Type" := saleline."Document Type"::"Credit Memo";

        newSaleslines.SetRange("Document No.", salesheader1."No.");
        newSaleslines.SetRange("Document Type", Enum::"Sales Document Type"::"Credit Memo");
        newSaleslines.SetRange("Contract ID", salesheader1."Contract ID");
        newSaleslines.SetCurrentKey("Line No.");
        if newSaleslines.FindLast() then begin
            saleline."Line No." := newSaleslines."Line No." + 1000;
        end
        else begin
            saleline."Line No." := 1000;
        end;
        saleline.Validate("Document No.", salesheader1."No.");
        saleline.Validate("Contract ID", salesheader1."Contract ID");
        saleline.Type := saleline.Type::Item;
        saleline.Validate("Sell-to Customer No.", salesheader1."Sell-to Customer No.");
        item.SetRange(Description, requestcreditnotegrid."Secondary Item Type");
        if item.FindSet() then begin

            saleline.Validate("No.", item."No.");

        end;
        saleline.Validate("Quantity (Base)", 1);
        saleline.Validate(Quantity, 1);
        saleline.Validate("Unit Price", Abs(requestcreditnotegrid."Total Reduction"));
        saleline."Contract ID" := requestcreditnotegrid."Contract ID";
        saleline.Insert();




        Clear(saleline);
    end;

}