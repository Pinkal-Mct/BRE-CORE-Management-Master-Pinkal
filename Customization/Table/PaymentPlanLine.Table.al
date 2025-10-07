table 52009 PaymentplanLine
{
    DataClassification = ToBeClassified;


    fields
    {
        field(52000; "Plan No"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Plan No';
            Editable = false;
        }
        field(52001; "Installment Stages"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Installment Stages';
            TableRelation = PaymentplanStages."Installment Stages";
        }
        field(52002; "Percentage"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Percentage';
        }
        field(52003; "Entry No."; Integer)
        {
            Caption = 'Entry No.';
            Editable = false;
            AutoIncrement = true;
        }
    }

    keys
    {
        key(Key1; "Plan No", "Entry No.")
        {
            Clustered = true;
        }
    }
}