table 51011 "Service Request Line"
{
    DataClassification = ToBeClassified;


    fields
    {


        field(51001; "No."; Code[20])
        {
            DataClassification = ToBeClassified;

        }

        field(51002; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(51003; "Property Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(51004; "Unit No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(51005; "Location Description"; Text[100])
        {
            DataClassification = ToBeClassified;
        }

        field(51006; "Warranty Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(51007; "Warranty End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(51008; "Under AMC"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(51009; "AMC Vendor"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor."No.";
        }

        field(51010; "Insurance Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(51011; "Insurance End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(51012; "QR-Code ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(51013; "Service Request ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(PK; "Service Request ID", "No.")
        {
            Clustered = true;
        }

    }

}
