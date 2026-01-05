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
        field(50504; "Residential Unearned Rent"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Residential-Unearned Rent';
            TableRelation = "G/L Account"."No.";
        }
        field(50505; "Commercial Unearned Rent"; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Commercial-Unearned Rent';
            TableRelation = "G/L Account"."No.";
        }
        field(50506; "Cash"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Cash';
            TableRelation = "G/L Account"."No.";
        }
        field(50507; "PDC Received"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Received';
            TableRelation = "G/L Account"."No.";
        }
        field(50508; "PDC Collection/Return"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Collection/Return';
            TableRelation = "G/L Account"."No.";
        }
        field(50509; "PDC Issued"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Issued';
            TableRelation = "G/L Account"."No.";
        }
        field(50510; "PDC Cleared/Returned"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'PDC Cleared/Returned';
            TableRelation = "G/L Account"."No.";
        }
        field(50511; "Tenant Receivables-Residential"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Receivables-Residential';
            TableRelation = "G/L Account"."No.";
        }
        field(50512; "Tenant Receivables-Commercial"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Tenant Receivables-Commercial';
            TableRelation = "G/L Account"."No.";
        }
        field(50513; "Carried Forward in SD"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Carried forward In-Security Deposits';
            TableRelation = "G/L Account"."No.";
        }
        field(50514; "Carried Forward Out SD"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Carried forward Out-Security Deposits';
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