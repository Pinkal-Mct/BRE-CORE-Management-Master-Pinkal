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
    }
    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}