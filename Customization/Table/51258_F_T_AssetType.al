// Asset Type Table
table 51258 "Asset Type"
{
    DataClassification = ToBeClassified;
    Caption = 'FM Asset Type';

    fields
    {
        field(51251; "Code"; Code[20])
        {
            Caption = 'Code';
            DataClassification = ToBeClassified;
        }

        field(51252; "Description"; Text[100])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Code")
        {
            Clustered = true;
        }
    }
}
