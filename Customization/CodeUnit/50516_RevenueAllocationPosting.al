codeunit 50516 "Revenue Allocation Posting"
{
    Subtype = Normal;

    procedure PostRevenueAllocation(RevenueAllocationRec: Record "Revenue Allocation Details")
    var
        GenJournalLineRec: Record "Gen. Journal Line";
        GenJournalTemplate: Record "Gen. Journal Template";
        GenJournalBatch: Record "Gen. Journal Batch";
        GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line";
        GenJnlPost: Codeunit "Gen. Jnl.-Post";
        LineNumber: Integer;
        RevenueAllocationGrid: Record "Revenue Allocation SubGrid";
        CommercialRentCharges: Code[20];
        ResidentialRentCharges: Code[20];
        UnearnedRentcharges: Code[20];
        BatchName: Code[20];
        ErrorMessage: Text[100];
        ParkingCharges: Code[20];
        parkingAccessCard: Code[20];
        JournalBatchName: Code[10];
        OtherChargesAllocationGrid: Record "Revenue Recognition Details";
        COASetup: Record "COA Setup";
        COASetupLine: Record "COA Setup Line";
    begin


        COASetup.Get();

        //Load journal template and batch
        // if not GenJournalTemplate.Get('GENERAL') then
        //     Error('General Journal Template not found.');

        // JournalBatchName := 'DEFAULT';
        // if not GenJournalBatch.Get(GenJournalTemplate.Name, JournalBatchName) then
        //     Error('General Journal Batch %1 not found.', JournalBatchName);

        // Clear existing lines (optional, based on use case)

        GenJournalLineRec.DeleteAll();

        // Loop through the Revenue Allocation records

        RevenueAllocationGrid.SetRange("Header No.", RevenueAllocationRec."No.");
        if RevenueAllocationGrid.FindSet() then begin
            LineNumber := 0;
            repeat

                LineNumber := GenJournalLineRec."Line No." + 10000;
                GenJournalLineRec.Init();
                GenJournalLineRec."Journal Template Name" := 'GENERAL';
                GenJournalLineRec."Journal Batch Name" := 'DEFAULT';
                GenJournalLineRec."Line No." := LineNumber;
                GenJournalLineRec."Account Type" := GenJournalLineRec."Account Type"::"G/L Account";
                GenJournalLineRec."Document No." := RevenueAllocationGrid.Description;
                GenJournalLineRec."Posting Date" := Today;
                GenJournalLineRec.Description := 'Rent - ' + RevenueAllocationGrid."Posting Period";
                // GenJournalLineRec.Amount := RevenueAllocationGrid."Total Value";
                GenJournalLineRec.Validate(Amount, RevenueAllocationGrid."Total Value");
                GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"G/L Account";
                if (RevenueAllocationGrid."Unit Type" = 'COMMERCIAL') or (RevenueAllocationGrid."Unit Type" = 'Commercial') then begin
                    GenJournalLineRec."Account No." := COASetup."Commercial Unearned Rent";
                    GenJournalLineRec."Bal. Account No." := COASetup."Commercial Rent";
                end
                else if (RevenueAllocationGrid."Unit Type" = 'RESIDENTIAL') or (RevenueAllocationGrid."Unit Type" = 'Residential') then begin
                    GenJournalLineRec."Account No." := COASetup."Residential Unearned Rent";
                    GenJournalLineRec."Bal. Account No." := COASetup."Residential Rent";
                end;

                GenJournalLineRec.Insert();

            until RevenueAllocationGrid.Next() = 0;

        end;

        OtherChargesAllocationGrid.SetRange("RR_No.", RevenueAllocationRec."No.");
        if OtherChargesAllocationGrid.FindSet() then begin
            LineNumber := GenJournalLineRec."Line No." + 10000;
            repeat
                COASetupLine.SetRange("Secondary Item", OtherChargesAllocationGrid."Item Type");
                COASetupLine.FindSet();

                LineNumber := GenJournalLineRec."Line No." + 10000;
                GenJournalLineRec.Init();
                GenJournalLineRec."Journal Template Name" := 'GENERAL';
                GenJournalLineRec."Journal Batch Name" := 'DEFAULT';
                GenJournalLineRec."Line No." := LineNumber;
                GenJournalLineRec."Account Type" := GenJournalLineRec."Account Type"::"G/L Account";
                GenJournalLineRec."Document No." := OtherChargesAllocationGrid.Description;
                GenJournalLineRec."Posting Date" := Today;
                GenJournalLineRec.Description := OtherChargesAllocationGrid."Item Type" + ' - ' + OtherChargesAllocationGrid."Posting Period";
                // GenJournalLineRec.Amount := OtherChargesAllocationGrid.Amount;
                GenJournalLineRec.Validate(Amount, OtherChargesAllocationGrid."Total Value");
                GenJournalLineRec."Bal. Account Type" := GenJournalLineRec."Bal. Account Type"::"G/L Account";
                if (OtherChargesAllocationGrid."Unit Type" = 'COMMERCIAL') or (OtherChargesAllocationGrid."Unit Type" = 'Commercial') then begin
                    GenJournalLineRec."Account No." := COASetupLine."Commercial-Unearned";
                    GenJournalLineRec."Bal. Account No." := COASetupLine.Commercial;
                end
                else if (OtherChargesAllocationGrid."Unit Type" = 'RESIDENTIAL') or (OtherChargesAllocationGrid."Unit Type" = 'Residential') then begin
                    GenJournalLineRec."Account No." := COASetupLine."Residential-Unearned";
                    GenJournalLineRec."Bal. Account No." := COASetupLine.Residential;
                end;
                GenJournalLineRec.Insert();


            until OtherChargesAllocationGrid.Next() = 0;
        end;

        Commit();
        GenJnlPost.Preview(GenJournalLineRec);



    end;
}