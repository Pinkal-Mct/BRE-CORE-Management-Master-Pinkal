table 53751 "No. Series Setup"
{
    DataClassification = ToBeClassified;
    Caption = 'No. Series Setup';
    fields
    {
        field(53751; "Primary Key"; Code[10])
        {
            AllowInCustomizations = Never;
            Caption = 'Primary Key';
        }
        field(53752; "Vendor Assignment Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Assignment Nos.';
            TableRelation = "No. Series".Code;
        }
        field(53753; "Construction Project Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Construction Project Nos.';
            TableRelation = "No. Series".Code;
        }
        field(53754; "Milestone Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Milestone Nos.';
            TableRelation = "No. Series".Code;
        }
        field(53755; "Milestone Task Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Milestone Task Nos.';
            TableRelation = "No. Series".Code;
        }
        field(53756; "Milestone Sub Task Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Milestone Sub Task Nos.';
            TableRelation = "No. Series".Code;
        }
        field(53757; "Vendor Profile Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Profile Nos.';
            TableRelation = "No. Series".Code;
        }

        // This field is used to store the vendor proposal number series. Table 53105 "Vendor Proposal" has a field for vendor proposal numbers.
        field(53758; "Vendor Proposal Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Proposal Nos.';
            TableRelation = "No. Series".Code;
        }
        // This field is used to store the vendor proposal number series. Table 53105 "Vendor Proposal" has a field for vendor proposal numbers.

        // This field is used to store the vendor contract number series. Table 53106 "Vendor Contract" has a field for vendor contract numbers.
        field(53759; "Vendor Contract Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Contract Nos.';
            TableRelation = "No. Series".Code;
        }
        // This field is used to store the vendor contract number series. Table 53106 "Vendor Contract" has a field for vendor contract numbers.

        field(53760; "OEM ID Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'OEM ID';
            TableRelation = "No. Series".Code;
        }
        field(53761; "Equipment ID Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Equipment ID';
            TableRelation = "No. Series".Code;
        }
        field(53762; "Part ID Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Part ID';
            TableRelation = "No. Series".Code;
        }
        field(53763; "Sub-Equipment ID Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sub-Equipment ID';
            TableRelation = "No. Series".Code;
        }
        field(53764; "Service Request ID Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Request ID';
            TableRelation = "No. Series".Code;
        }
        // field(53765; "Fixed Asset ID Nos."; Code[20])
        // {
        //     DataClassification = ToBeClassified;
        //     Caption = 'Fixed Asset ID';
        //     TableRelation = "No. Series".Code;
        // }
        field(53766; "Service Type ID Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Type ID';
            TableRelation = "No. Series".Code;
        }
        field(53767; "Service Sub-Type ID Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Sub-Type ID';
            TableRelation = "No. Series".Code;
        }
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}