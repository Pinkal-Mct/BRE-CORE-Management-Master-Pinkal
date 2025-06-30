table 53755 "Construction Project Documents"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(53100; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(53101; "Project ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53102; "Document Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ","Drawings/Revisions","Permit Numbers & Relevant Documents","Contract Documents","Inspection Reports";
            Caption = 'Document Type';
        }
        field(53103; "Upload Document"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Upload Document';
        }
        field(53105; "View & Download"; Text[20])
        {
            DataClassification = ToBeClassified;
            Editable = false;
            InitValue = 'View';
        }
        field(53106; "Document URL"; Text[2048])
        {
            DataClassification = ToBeClassified;
        }

        field(53107; "Document Name"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document Name';
        }
    }

    keys
    {
        key(PK; "Entry No.", "Project ID")
        {
            Clustered = true;
        }
    }
}