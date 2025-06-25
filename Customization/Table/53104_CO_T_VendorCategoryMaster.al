table 53104 "Vendor Category Master"
{
    DataClassification = ToBeClassified;
    Caption = 'Vendor Category Master';
    fields
    {
        // Project Details //
        field(53100; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
            Caption = 'ID';
        }
        field(53101; "Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Name';
        }
        field(53102; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(53103; Property; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Property';
        }
        field(53104; Sales; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Sales';
        }
        field(53105; Facility; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Facility';
        }
        field(53106; Legal; Boolean)
        {
            DataClassification = ToBeClassified;
            Caption = 'Legal';
        }
    }

    keys
    {
        key(PK; "ID", "Name")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; "ID", "Name", "Description")
        {
            Caption = 'Vendor Category Master';
        }
    }
}