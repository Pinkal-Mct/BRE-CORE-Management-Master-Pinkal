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
        field(53705; Total; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53706; Invoiced; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(53707; "Credit Noted"; Boolean)
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
}