table 50953 "Calculation Type"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = ID;

    fields
    {
        field(50100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true; // Automatically increment the ID
            Editable = false; // Make it read-only for the user
        }
        field(50101; "Calculation Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Calculation Type';

        }
    }

    keys
    {
        key(PK; "ID", "Calculation Type")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ID, "Calculation Type")
        {

        }
    }



}
