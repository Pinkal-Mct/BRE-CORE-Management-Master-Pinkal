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
        field(53752; "Automated FollowUp Subject"; Text[250])
        {
            Caption = 'Subject';
        }
        field(53753; "Automated FollowUp Body"; Blob)
        {
            Caption = 'Body';
            SubType = Memo;
        }
    }

    keys
    {
        key(PK; "Primary Key") { Clustered = true; }
    }
}
