table 53505 "VendorSignedContractDocument"
{
    DataClassification = ToBeClassified;
    Caption = 'Vendor Signed Contract Document';

    fields
    {
        field(53519; "Document ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'Document ID';
        }
        field(53520; "Contract ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';

        }
        field(53521; "Vendor Profile ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Profile ID';

        }
        field(53522; "Project ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project ID';

        }
        field(53523; "Project Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Name';
        }
        field(53524; "Milestone"; Text[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Milestone';
            InitValue = 'Click here';
        }
        field(53525; "Service Provided"; Text[2000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Provided';
        }
        field(53526; "Signed Upload Document"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Signed Document';
        }
        field(53527; "View/Download"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'View/Download';
        }
        field(53528; "Document URL"; Text[2048])
        {
            DataClassification = ToBeClassified;
            Caption = 'Document URL';
        }
        field(53529; "Task ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Task ID';

        }

    }

    keys
    {
        key(PK; "Document ID")
        {
            Clustered = true;
        }
    }
}