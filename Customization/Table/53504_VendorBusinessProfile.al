table 53504 "Vendor Business Profile"
{
    dataclassification = ToBeClassified;
    Caption = 'Vendor Business Profile';

    fields
    {
        field(53509; "Vendor Category"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Category';
            TableRelation = "Vendor Category Master".Name;
        }
        field(53510; "Service Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Business Type';
            TableRelation = "Service Type"."Service Type";
        }
        field(53511; "Key Products"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Business Registration No.';
        }
        field(53512; "Team Size"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Team Size';
            OptionCaption = ' ,0-1,2-10,11-50,51-100,101-200,201-500';
            OptionMembers = " ","0-1","2-10","11-50","51-100","101-200","201-500";
        }
        field(53513; "Number of years of experience"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Number of years of experience';
        }
        field(53514; "Compliance Requirements"; Option)
        {
            DataClassification = ToBeClassified;
            Caption = 'Business Registration Date';
            OptionCaption = ' ,Yes,No';
            OptionMembers = " ","Yes","No";
        }
        field(53515; "Previous Projects in UAE"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Previous Projects in UAE';
        }

        field(53516; "Additional note"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Additional Note';
        }
        field(53517; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'Entry No.';
        }
        field(53518; "Profile ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Profile ID';
        }
    }
    keys
    {
        key(PK; "Entry No.", "Profile ID")
        {
            Clustered = true;
        }
    }
}
