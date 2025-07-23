table 50116 "Unearned Revenue Report"
{
    DataClassification = ToBeClassified;
    DataCaptionFields = "No.";
    fields
    {
        field(50100; "No."; Integer)
        {
            DataClassification = SystemMetadata;
            Editable = false;
            AutoIncrement = true;
            Caption = 'ID';
        }
        field(50101; "Starting Date Year"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Starting Date Year';

            trigger OnValidate()
            begin
                // Validate that starting date is always 1st January
                if (Date2DMY("Starting Date Year", 1) <> 1) or (Date2DMY("Starting Date Year", 2) <> 1) then
                    Error('Starting Date must be 1st January of the year.');

                if "Starting Date Year" > "Ending Date Year" then
                    Error('Starting Date Year cannot be greater than Ending Date Year.');
            end;
        }
        field(50103; "Ending Date Year"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Ending Date Year';

            trigger OnValidate()
            begin
                if "Ending Date Year" < "Starting Date Year" then
                    Error('Ending Date Year cannot be less than Starting Date Year.');
            end;
        }
    }
    keys
    {
        key(PK; "No.") { Clustered = true; }
    }
}