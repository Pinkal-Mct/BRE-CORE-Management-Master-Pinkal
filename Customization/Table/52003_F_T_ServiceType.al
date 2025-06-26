table 52003 "Service Type"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "ID";
    fields
    {
        field(52000; "ID"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'ID';
            AutoIncrement = true;
        }

        field(52001; "Service Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Service Type';
        }
        field(52002; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
    }

    keys
    {
        key(PK; "ID")
        {
            Clustered = true;
        }
    }
}
