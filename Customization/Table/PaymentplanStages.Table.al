table 52008 PaymentplanStages
{
    DataClassification = ToBeClassified;


    fields
    {
        field(52000; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            AutoIncrement = true;
            Editable = false;
        }
        field(52001; "Installment Stages"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Installment Stages';
        }
    }

    keys
    {
        key(PK; "ID", "Installment Stages")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "ID", "Installment Stages")
        {

        }
    }

}