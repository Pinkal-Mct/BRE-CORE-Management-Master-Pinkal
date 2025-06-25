table 53502 "Vendor Documents"
{
    DataClassification = ToBeClassified;
    Caption = 'Vendor Documents';
    fields
    {
        field(53500; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            AutoIncrement = true;

        }
        field(53501; "Vendor Document Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Document Name';

        }

    }

    keys
    {
        key(PK; ID)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        fieldgroup(DropDown; ID, "Vendor Document Name")
        {
            Caption = 'Vendor Documents';
        }
    }
}