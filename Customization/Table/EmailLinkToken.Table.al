table 53760 "Email Link Token"
{
    DataClassification = CustomerContent;

    fields
    {
        field(53751; Token; Guid) { DataClassification = CustomerContent; }
        field(53752; "Customer No."; Code[20]) { DataClassification = CustomerContent; }
        field(53753; "Item No."; Code[20]) { DataClassification = CustomerContent; }
        field(53754; "Customer Email"; Text[250]) { DataClassification = CustomerContent; }
        field(53755; "Expires At"; DateTime) { DataClassification = CustomerContent; }
        field(53756; Clicked; Boolean) { DataClassification = CustomerContent; }
        field(53757; "Clicked At"; DateTime) { DataClassification = CustomerContent; }
    }

    keys
    {
        key(PK; Token) { Clustered = true; }
    }
}
