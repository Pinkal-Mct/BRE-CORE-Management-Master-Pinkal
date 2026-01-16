table 53765 "FinancialAdjContractReduction"
{
    DataClassification = ToBeClassified;
    fields
    {

        field(53700; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(53701; "Contract No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(53702; "Revenue Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = Item WHERE("Item type template" = const("Item Type Template Enum"::"Secondary Item"));
            trigger OnValidate()
            var
                SecondaryItemRec: Record "Item";
            begin
                // Check if a record with the selected Secondary Item Type exists
                SecondaryItemRec.SetRange("No.", Rec."Revenue Description");
                if SecondaryItemRec.FindFirst() then begin
                    "Revenue Description" := SecondaryItemRec.Description;
                    // Retrieve the VAT % from the Secondary Item record
                    "VAT %" := SecondaryItemRec."VAT %";
                end else
                    // Clear the VAT % field if no matching record is found
                    "VAT %" := 0;
            end;

        }
        field(53703; Amount; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;
        }
        field(53704; "VAT %"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "0%","5%";
            Caption = 'VAT';
            Editable = false;
            trigger OnValidate()
            begin
                CalcVATAndTotal();
            end;
        }
        field(53705; "Amount Incl. VAT"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53706; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53707; Total; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(FinancialAdjContractReduction."Amount" where("Contract No." = field("Contract No.")));
        }
        field(53708; "Total VAT"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(FinancialAdjContractReduction."VAT Amount" where("Contract No." = field("Contract No.")));
        }
        field(53709; "Total Amount Incl.VAT"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(FinancialAdjContractReduction."Amount Incl. VAT" where("Contract No." = field("Contract No.")));
        }
        field(53710; "VAT Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'VAT Amount';
            Editable = false;

            trigger OnValidate()
            var
                vatPer: Integer;
                finalcalculationRec: Record "Final Calculation";
            begin
                if "VAT %" = "VAT %"::"5%" then
                    vatPer := 5
                else
                    vatPer := 0;

                "VAT Amount" := Amount * (vatPer / 100);
            end;
        }
        field(53711; "Credit Note ID"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Entry No.", "Contract No.")
        {
            Clustered = true;
        }
    }
    local procedure CalcVATAndTotal()
    var
        InvoiceCreditNoteSummaryRec: Record "InvoiceCreditNoteSummary";
        vatPer: Integer;
        TotalCreditNote: Decimal;
    begin
        if "VAT %" = "VAT %"::"5%" then
            vatPer := 5
        else
            vatPer := 0;

        "VAT Amount" := Amount * (vatPer / 100);
        "Amount Incl. VAT" := Amount + "VAT Amount";
        Rec.Modify();

        InvoiceCreditNoteSummaryRec.SetRange("Contract No.", Rec."Contract No.");
        InvoiceCreditNoteSummaryRec.SetRange("Description", 'Financial Adjustments / Contract Reductions');
        if InvoiceCreditNoteSummaryRec.FindFirst() then begin
            InvoiceCreditNoteSummaryRec.CalculateInvoiceCreditNoteSummary(InvoiceCreditNoteSummaryRec);
        end;
    end;

    trigger OnDelete()
    var
        InvoiceCreditNoteSummaryRec: Record "InvoiceCreditNoteSummary";
    begin
        InvoiceCreditNoteSummaryRec.SetRange("Contract No.", Rec."Contract No.");
        InvoiceCreditNoteSummaryRec.SetRange("Description", 'Financial Adjustments / Contract Reductions');
        if InvoiceCreditNoteSummaryRec.FindFirst() then begin
            InvoiceCreditNoteSummaryRec."Credit Note" -= Rec."Amount Incl. VAT";
        end;
        InvoiceCreditNoteSummaryRec.Modify();
    end;

}