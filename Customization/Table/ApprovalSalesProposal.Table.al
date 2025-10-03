table 53506 "Approval Sales Proposal"
{
    DataClassification = ToBeClassified;
    Caption = 'Approval Sales Proposal';

    fields
    {
        field(53530; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            // AutoIncrement = true;    
            Editable = false;
            AutoIncrement = true;


        }
        field(53531; "Status"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(53532; "Created By"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Created By';
        }

        field(53533; "Sales Proposal ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Proposal ID';
        }
        field(53534; Remark; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Remark';
        }

        field(53535; "Customer No."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Customer No.';
        }

    }

    keys
    {
        key(PrimaryKey; "ID")
        {
            Clustered = false;
        }
        key(PK; SystemId)
        {
            Clustered = true;
        }
    }


}