table 51257 "FM Work Order Header"
{
    DataClassification = ToBeClassified;
    Caption = 'FM Work Order Header';

    fields
    {
        field(51251; "Work Order ID"; Code[20])
        {
            Caption = 'Work Order ID';
            DataClassification = ToBeClassified;
        }

        field(51252; "Asset ID"; Code[20])
        {
            Caption = 'Asset ID';
            DataClassification = ToBeClassified;
            // TableRelation = "Fixed Asset"."No.";
        }

        field(51253; "Work Order Type"; Enum "FM Work Order Type")
        {
            Caption = 'Work Order Type';
            DataClassification = ToBeClassified;
        }

        field(51254; "Work Order Status"; Enum "FM Work Order Status")
        {
            Caption = 'Work Order Status';
            DataClassification = ToBeClassified;
        }

        field(51255; "Work Order Date"; Date)
        {
            Caption = 'Work Order Date';
            DataClassification = ToBeClassified;
        }

        field(51256; "Service Category Code"; Code[20])
        {
            Caption = 'Service Category Code';
            DataClassification = ToBeClassified;
        }

        field(51257; "Vendor Name"; Text[100])
        {
            Caption = 'Vendor Name';
            DataClassification = ToBeClassified;
        }

        field(51258; "Actual Completion Date"; Date)
        {
            Caption = 'Actual Completion Date';
            DataClassification = ToBeClassified;
        }

        field(51259; "Labor Hours"; Decimal)
        {
            Caption = 'Labor Hours';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }

        field(51260; "Total Cost"; Decimal)
        {
            Caption = 'Total Cost';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
        }

        field(51261; "Technician Remarks"; Text[250])
        {
            Caption = 'Technician Remarks';
            DataClassification = ToBeClassified;
        }

        field(51262; "Attachment Link"; Date)
        {
            Caption = 'Requested Date';
            DataClassification = ToBeClassified;
        }
        field(51263; "Service Request ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Service Request ID", "Work Order ID", "Asset ID")
        {
            Clustered = true;
        }
        key(AssetDate; "Asset ID", "Work Order Date")
        {
        }
    }
}
