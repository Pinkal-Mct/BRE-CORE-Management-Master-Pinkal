table 53104 "Vendor Category Master"
{
    DataClassification = ToBeClassified;
    Caption = 'Vendor Category Master';
    fields
    {
        // Project Details //
        field(53100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'ID';
        }
        field(53101; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(53102; "Description"; Text[250])
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