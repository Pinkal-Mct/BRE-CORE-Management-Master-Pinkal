table 52006 "Lead Score Range"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(52001; "Range ID"; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }

        field(52002; "Lead Rating"; Enum "Lead Rating")
        {
            DataClassification = CustomerContent;
            NotBlank = true;
        }

        field(52003; "Min Score Percent"; Integer)
        {
            Caption = 'Min Score %';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("Min Score Percent" < 0) or ("Min Score Percent" > 100) then
                    Error('Minimum Score Percent must be between 0 and 100.');
                if ("Min Score Percent" > "Max Score Percent") then
                    Error('Minimum Score Percent cannot be greater than Maximum Score Percent.');
            end;
        }

        field(52004; "Max Score Percent"; Integer)
        {
            Caption = 'Max Score %';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if ("Max Score Percent" < 0) or ("Max Score Percent" > 100) then
                    Error('Maximum Score Percent must be between 0 and 100.');
                if ("Max Score Percent" < "Min Score Percent") then
                    Error('Maximum Score Percent cannot be less than Minimum Score Percent.');
            end;
        }
    }

    keys
    {
        key(PK; "Range ID")
        {
            Clustered = true;
        }

        key(CompanyCategory; "Lead Rating") { }
    }
}
