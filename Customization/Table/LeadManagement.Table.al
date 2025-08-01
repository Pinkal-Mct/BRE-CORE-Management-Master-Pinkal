table 53506 "Lead Management"
{
    DataClassification = ToBeClassified;
    Caption = 'Lead Management';
    fields
    {
        field(53530; "Lead ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53531; "Lead Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(53532; "Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53533; "Mobile No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53534; "Lead Source"; Enum "Lead Source ")
        {
            DataClassification = ToBeClassified;
        }
        field(53535; "Lead Status"; Enum "Lead Status")
        {
            DataClassification = ToBeClassified;
        }
        field(53536; "Expected Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53537; "Follow-up Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(53538; "Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(53539; "Interst Area"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53540; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(53541; "Created By"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53542; "Assigned Sales Person"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}