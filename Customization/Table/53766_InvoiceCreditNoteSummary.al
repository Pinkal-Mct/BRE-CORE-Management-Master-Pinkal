table 53766 "InvoiceCreditNoteSummary"
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
        field(53702; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53703; Invoice; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53704; "Credit Note"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53705; "Total Invoice"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(InvoiceCreditNoteSummary."Invoice" where("Contract No." = field("Contract No.")));

        }
        field(53708; "Total Credit Note"; Decimal)
        {
            FieldClass = FlowField;
            CalcFormula = sum(InvoiceCreditNoteSummary."Credit Note" where("Contract No." = field("Contract No.")));
        }
        field(53706; Invoiced; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53707; "Credit Noted"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53709; "Invoice ID"; Code[50])
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

    procedure CalculateInvoiceCreditNoteSummary(var pInvoiceCreditNoteSummary: Record "InvoiceCreditNoteSummary")
    var
        finanacialAdjustContractReduction: Record FinancialAdjContractReduction;
        totalcreditnote: Decimal;
    begin
        finanacialAdjustContractReduction.Reset();
        finanacialAdjustContractReduction.SetRange("Contract No.", pInvoiceCreditNoteSummary."Contract No.");
        if finanacialAdjustContractReduction.FindSet() then begin
            finanacialAdjustContractReduction.CalcSums("Amount Incl. VAT");
            totalcreditnote += finanacialAdjustContractReduction."Amount Incl. VAT";
        end;
        pInvoiceCreditNoteSummary."Credit Note" := totalcreditnote;
        pInvoiceCreditNoteSummary.Modify();

    end;

    procedure CalculateTotalInvoiceAmount(var pInvoiceCreditNoteSummary: Record "InvoiceCreditNoteSummary")
    var
        Terminationadditionalcharges: Record "Additional Charges Sub";
        totalinvoice: Decimal;
    begin
        Terminationadditionalcharges.Reset();
        Terminationadditionalcharges.SetRange("Contract ID", pInvoiceCreditNoteSummary."Contract No.");
        if Terminationadditionalcharges.FindSet() then begin
            Terminationadditionalcharges.CalcSums("Amount Including VAT");
            totalinvoice += Terminationadditionalcharges."Amount Including VAT";
        end;
        pInvoiceCreditNoteSummary."Invoice" := totalinvoice;
        pInvoiceCreditNoteSummary.Modify();
    end;

}