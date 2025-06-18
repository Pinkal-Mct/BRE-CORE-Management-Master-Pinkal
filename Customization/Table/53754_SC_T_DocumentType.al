table 53754 "Document Type"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(53100; "Document Type ID"; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(53101; "Document Type"; Text[100])
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
        key(PK; "Document Type ID", "Document Type")
        {
            Clustered = true;
        }
    }
}