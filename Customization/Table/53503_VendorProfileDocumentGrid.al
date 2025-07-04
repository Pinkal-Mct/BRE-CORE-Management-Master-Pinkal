table 53503 "Vendor Profile Document Grid"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(53503; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(53504; "Profile ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(53505; "Upload Document"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Upload Document';
            InitValue = 'Upload Document';
        }
        field(53506; "View & Download"; Text[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            InitValue = 'View & Download';
        }
        field(53507; "Document URL"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }
        field(53508; "Vendor Document Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Document Name';
        }
    }

    keys
    {
        key(PK; "Entry No.", "Profile ID")
        {
            Clustered = true;
        }
    }
}