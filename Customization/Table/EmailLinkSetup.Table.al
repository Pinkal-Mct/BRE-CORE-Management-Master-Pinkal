table 53761 "Email Link Setup"
{
    Caption = 'Email Link Setup';
    DataClassification = SystemMetadata;

    fields
    {
        field(53751; "Primary Key"; Code[10]) { }
        field(53752; "Flow Base URL"; Text[2048]) { Caption = 'Flow Base URL (HTTP trigger)'; }
        field(53753; "Expiry (Days)"; Integer) { Caption = 'Token Expiry (Days)'; InitValue = 7; }
    }

    keys { key(PK; "Primary Key") { Clustered = true; } }
}
