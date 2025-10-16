table 52005 "Lead Stage"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(52001; "Stage ID"; Integer)
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
        field(52005; "Lead Status"; Enum "Lead Status")
        {
            DataClassification = ToBeClassified;
        }
    }


    keys
    {
        key(PK; "Stage ID", "Stage Name")
        {
            Clustered = true;
        }

        key(CompanyStage; "Stage Name") { }
    }
}