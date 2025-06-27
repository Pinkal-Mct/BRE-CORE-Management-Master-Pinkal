table 51011 "Service Request Line"
{
    DataClassification = ToBeClassified;


    fields
    {
        field(51001; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset"."No." WHERE(
                "Property Code" = FIELD("Property Code"),
                "Unit No." = FIELD("Unit No."));

            trigger OnValidate()
            var
                fixedAsset: Record "Fixed Asset";
            begin
                fixedAsset.SetRange("No.", Rec."No.");
                if fixedAsset.FindFirst() then begin
                    Rec."Property Code" := fixedAsset."Property Code";
                    Rec."Unit No." := fixedAsset."Unit No.";
                    Rec."Location Description" := fixedAsset."Location Description";
                    Rec."Warranty Start Date" := fixedAsset."Warranty Start Date";
                    Rec."Warranty End Date" := fixedAsset."Warranty End Date";
                    Rec."Under AMC" := fixedAsset."Under AMC";
                    Rec."AMC Vendor" := fixedAsset."AMC Vendor";
                    Rec."Insurance Start Date" := fixedAsset."Insurance Start Date";
                    Rec."Insurance End Date" := fixedAsset."Insurance End Date";
                    Rec."Barcode ID" := fixedAsset."Barcode ID";
                end;
            end;
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

        field(51012; "Barcode ID"; Code[30])
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
        key(PK; "No.", "Service Request ID")
        {
            Clustered = true;
        }
    }
}
