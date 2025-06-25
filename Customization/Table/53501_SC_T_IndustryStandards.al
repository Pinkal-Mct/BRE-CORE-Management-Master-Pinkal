table 53501 "Industry Standards"
{
    DataClassification = ToBeClassified;


    fields
    {
        field(53500; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Editable = false;
        }
        field(53501; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(53502; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK; "ID", "Name")
        {
            Clustered = true;
        }
    }


}