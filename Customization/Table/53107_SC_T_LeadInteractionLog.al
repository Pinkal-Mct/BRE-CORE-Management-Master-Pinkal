table 53107 "Lead Interaction Log"
{
    DataClassification = ToBeClassified;
    Caption = 'Lead Interaction Log';
    fields
    {
        field(53100; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(53101; "Lead ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lead ID';
            TableRelation = "Lead Management";
        }
        field(53102; "Interaction Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Interaction Date';
        }
        field(53103; "Interaction Method"; Enum "Lead Interaction Method")
        {
            DataClassification = ToBeClassified;
            Caption = 'Interaction Method';
        }
        field(53104; "Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Notes';
        }
        field(53105; "Sales Rep ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Rep ID';
            // TO DO, data type is lookup, but not decided which table here linked. 
        }
        field(53106; "Next Follow-Up Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Next Follow-Up Date';
        }
        field(53107; "Created DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Caption = 'Created DateTime';
        }
        field(53108; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Created By';
        }
        field(53109; "Sales Stage"; Enum "Sales Stage")
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales Stage';
        }
        field(53110; "Competitor Information"; Text[200])
        {
            DataClassification = ToBeClassified;
            Caption = 'Competitor Information';
        }
    }

    keys
    {
        key(PK; "Entry No.", "Lead ID")
        {
            Clustered = true;
        }
    }
}