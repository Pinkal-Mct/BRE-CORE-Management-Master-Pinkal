table 53753 "Project Type"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(53100; "Project Type ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(53101; "Project Type"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(53102; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Project Type ID", "Project Type")
        {
            Clustered = true;
        }
    }
}