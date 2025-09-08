table 51504 "Lead Information"
{
    DataClassification = ToBeClassified;
    caption = 'Lead Information';

    fields
    {
        field(51501; "Lead ID"; code[20])
        {
            DataClassification = ToBeClassified;
            notBlank = true;
            caption = 'Lead ID';
        }
        field(51502; "Property Name"; Text[100])
        {
            caption = 'Property Name';
            DataClassification = ToBeClassified;
        }

        field(51503; "Property Type"; Text[100])
        {
            caption = 'Property Type';
            DataClassification = ToBeClassified;
        }
        field(51504; "Unit Type"; text[50])
        {
            caption = 'Unit Type';
            DataClassification = ToBeClassified;
        }
        field(51505; "Sales Person"; Text[100])
        {
            caption = 'Sales Person';
            DataClassification = ToBeClassified;
        }
        field(51506; "Lead Rating"; Enum "Lead Rating")
        {
            DataClassification = ToBeClassified;
        }
        field(51507; "Lead Status"; Enum "Lead Status")
        {
            DataClassification = ToBeClassified;
        }
        field(51508; "Contact Phone"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51509; "Contact Email"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51510; "Created Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51511; "Last Modified Date"; DateTime)
        {
            DataClassification = ToBeClassified;

        }
        field(51512; "Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(51513; "CLient Info Id"; Code[20])
        {
            DataClassification = ToBeClassified;
        }



    }

    keys
    {
        key(Key1; "lead ID")
        {
            Clustered = true;
        }
        key(Key2; "Lead Status")
        {

        }
        key(Key3; "Lead Rating")
        {

        }
        key(Key4; "Sales Person")
        {

        }
    }

    fieldgroups
    {
        // Add changes to field groups here
    }



    trigger OnInsert()
    begin
        "Created Date" := Today();
        "Last Modified Date" := CurrentDateTime();
    end;

    trigger OnModify()
    begin
        "Last Modified Date" := CurrentDateTime();
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}