table 50120 "Management Fee Calc. Header"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(50100; "Primary Key"; Integer)
        {
            DataClassification = ToBeClassified;

        }
        field(50101; "Report Date"; Date)
        {
            DataClassification = ToBeClassified;

        }

        field(50102; "Owner ID"; Integer)
        {
            DataClassification = ToBeClassified;
            TableRelation = "Owner Profile"."Owner ID";

            trigger OnValidate()
            begin
                CalcFields("Owner Name");
            end;

        }
        field(50103; "Owner Name"; Text[100])
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Owner Profile"."Full Name" where("Owner ID" = field("Owner ID")));
        }
        field(50104; "Property"; Text[100])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Property Registration"."Property Name" where("Owner ID" = Field("Owner ID"));
        }
        field(50105; "Financial Year"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50106; "Period From"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50107; "Period To"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
}