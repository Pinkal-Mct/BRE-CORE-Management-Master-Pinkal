table 52007 "Lead Stage SubPage"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(52001; "ID"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }

        field(52002; "Stage Name"; Text[100])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(52003; "Description"; Text[250])
        {
            DataClassification = CustomerContent;
        }

        field(52004; "Lead Score"; Integer)
        {
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("Lead Score" < 0) or ("Lead Score" > 100) then
                    Error('Lead Score must be between 0 and 100.');
            end;
        }
        field(52008; "Lead Status"; Enum "Lead Status")
        {
            DataClassification = ToBeClassified;
        }

        field(52007; "Stage ID"; Integer)
        {
            DataClassification = CustomerContent;
            TableRelation = "Lead Stage"."Stage ID";
        }
        field(52009; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }

    }


    keys
    {
        key(Key1; "ID", "No.")
        {
            Clustered = true;
        }
    }
}