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
        field(53752; "Contract Assignment Nos."; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract Assignment Nos.';
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
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}