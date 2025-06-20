table 53102 "UAE Regulatory Requirements"
{
    DataClassification = ToBeClassified;
    Caption = 'UAE Regulatory Requirements';
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
        field(53102; "Description"; Text[100])
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