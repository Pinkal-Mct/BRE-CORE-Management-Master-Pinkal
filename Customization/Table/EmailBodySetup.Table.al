table 53762 "Email Body Setup"
{
    Caption = 'Email Body Setup';
    DataClassification = ToBeClassified;

    fields
    {
        field(53751; "Primary Key"; Code[20])
        {
            Caption = 'User ID';
            TableRelation = "User Setup"."User ID";
        }
        field(53752; "Property Rcmd. Subject"; Text[250])
        {
            Caption = 'Property Recommendations Subject';
        }
        field(53753; "Property Rcmd. Body"; Blob)
        {
            Caption = 'Property Recommendations Body';
            SubType = Memo;
        }
        field(53754; "UAE Market Updates Subject"; Text[250])
        {
            Caption = 'UAE Market Updates Subject';
        }
        field(53755; "UAE Market Updates Body"; Blob)
        {
            Caption = 'UAE Market Updates Body';
            SubType = Memo;
        }
        field(53756; "Email Type"; Enum "Email Type")
        {
            Caption = 'Email Type';
        }
    }
    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }
}
