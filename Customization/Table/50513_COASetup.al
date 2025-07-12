table 50513 "COA Setup"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50501; "Primary Key"; Code[10])
        {
            DataClassification = SystemMetadata;
        }
        field(50502; "Residential Rent"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Residential Rent';
            TableRelation = "G/L Account"."No.";
        }
        field(50503; "Commercial Rent"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Commercial Rent';
            TableRelation = "G/L Account"."No.";
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