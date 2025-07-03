table 51259 "Service Request Insurance"
{
    DataClassification = ToBeClassified;
    Caption = 'Service Request Insurance';

    fields
    {
        field(51251; "Policy ID"; Code[20])
        {
            Caption = 'Policy ID';
            DataClassification = ToBeClassified;
        }

        field(51252; "Asset ID"; Code[20])
        {
            Caption = 'Asset ID';
            DataClassification = ToBeClassified;
            // TableRelation = "Fixed Asset"."No.";
        }

        field(51253; "Name of Insurer"; Text[100])
        {
            Caption = 'Name of Insurer';
            DataClassification = ToBeClassified;
        }

        field(51254; "Insurance Policy No."; Code[50])
        {
            Caption = 'Insurance Policy No.';
            DataClassification = ToBeClassified;
        }

        field(51255; "Insurance Start Date"; Date)
        {
            Caption = 'Insurance Start Date';
            DataClassification = ToBeClassified;
        }

        field(51256; "Insurance End Date"; Date)
        {
            Caption = 'Insurance End Date';
            DataClassification = ToBeClassified;
        }

        field(51257; "Insured Value"; Decimal)
        {
            Caption = 'Insured Value';
            DataClassification = ToBeClassified;
        }
        field(51258; "Service Request ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Service Request ID", "Policy ID", "Asset ID")
        {
            Clustered = true;
        }
        key(AssetDate; "Asset ID", "Insurance Start Date")
        {
        }
    }
}
