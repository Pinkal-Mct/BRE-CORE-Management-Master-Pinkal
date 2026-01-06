table 50121 "Management Fee Calc. Line"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            AutoIncrement = true;
        }
        field(50101; "Primary Key"; Code[10])
        {
            DataClassification = SystemMetadata;
            Caption = 'Primary Key';
        }
        // field(50102; "")
    }

    keys
    {
        key(Key1; "Entry No.", "Primary Key")
        {
            Clustered = true;
        }
    }

}