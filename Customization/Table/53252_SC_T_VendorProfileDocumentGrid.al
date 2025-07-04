table 53252 "Vendor Document Upload"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(53100; "Vendor ID"; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(53101; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }

        field(53102; "Document Category"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Category';
            TableRelation = "Document Type"."Document Type";
        }

        field(53103; "Document Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Name';
        }

        field(53104; "Issuing Authority"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Issuing Authority';
        }

        field(53105; "Upload Document"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Upload';
            InitValue = 'Upload';
        }

        field(52100; "View & Download"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'View & Download';
            InitValue = 'View & Download';
        }

        field(53106; "Document URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document URL';
        }

        field(53107; "Profile ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Profile ID';
        }


    }

    keys
    {
        key(PK; "Profile ID", "Entry No.")
        {
            Clustered = true;
        }
    }
}
