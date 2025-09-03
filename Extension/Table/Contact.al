tableextension 53111 ContactExtension extends Contact
{
    fields
    {
        // Lead Information (Basic Details)
        field(50100; "Lead Source"; Enum "Lead Source")
        {
            DataClassification = ToBeClassified;
            Caption = 'Lead Source';
        }
        field(50101; "Lead Owner"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lead Owner';
        }
        field(50102; "Lead Status"; Enum "Lead Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Lead Status';
        }
        field(50103; "Lead Rating"; Enum "Lead Rating")
        {
            DataClassification = ToBeClassified;
            Caption = 'Lead Rating';
        }
        field(50104; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date Created';
        }
        field(50105; "Expected Follow-up Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Expected Follow-up Date';
        }
        // Lead Information (Basic Details)

        // Contact & Company Details
        field(50107; "Position/Role"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Position/Role';
        }
        field(50108; "Property Type"; Text[100])
        {
            Caption = 'Property Type';
            DataClassification = CustomerContent;
            TableRelation = "Property Type"."Property Type";

            // trigger OnValidate()
            // var
            //     PropertyTypeRec: Record "Property Type";  // Used to get Primary Classification
            // begin
            //     // Clear the Property Type field when Property Classification is changed
            //     "Usage Type" := '';
            //     PropertyTypeRec.SetRange("Property Type", "Property Type");
            //     if PropertyTypeRec.FindFirst() then
            //         "PrimaryClassification" := PropertyTypeRec."Classification Name"
            //     else
            //         "PrimaryClassification" := '';
            // end;
        }
        // field(50126; "PrimaryClassification"; Text[100])
        // {
        //     DataClassification = CustomerContent;

        // }
        field(50109; "Preferred Location"; Text[100])
        {
            Caption = 'Preferred Location';
            DataClassification = CustomerContent;
        }

        field(50110; "Budget Range (AED)"; Decimal)
        {
            Caption = 'Budget Range (AED)';
            DataClassification = CustomerContent;
        }

        field(50111; "Size (Sq. Ft.)"; Code[10])
        {
            Caption = 'Size (Sq. Ft.)';
            DataClassification = CustomerContent;
            TableRelation = "Unit of Measure"."Code";
        }
        // Property Requirements

        // Financial & Legal Details (For Compliance)
        field(50112; "Emirates ID/Passport No."; Text[50])
        {
            Caption = 'Emirates ID / Passport No.';
            DataClassification = CustomerContent;
        }

        field(50113; "Visa Status"; Enum "Visa Status")
        {
            Caption = 'Visa Status';
            DataClassification = CustomerContent;
        }

        field(50114; "Source of Funds"; Enum "Source of Funds")
        {
            Caption = 'Source of Funds';
            DataClassification = CustomerContent;
        }

        field(50115; "Mortgage Pre-Approved"; Boolean)
        {
            Caption = 'Mortgage Pre-Approved';
            DataClassification = CustomerContent;
        }

        field(50116; "RERA Broker ID"; Text[30])
        {
            Caption = 'RERA Broker ID';
            DataClassification = CustomerContent;
        }

        field(50117; "Preferred Sale Type"; Enum "Preferred Sales Type")
        {
            Caption = 'Preferred Sale Type';
            DataClassification = CustomerContent;
        }
        // Financial & Legal Details (For Compliance)

        // Lead Information (Basic Details)
        field(50118; "Others"; Text[250])
        {
            Caption = 'Others';
            DataClassification = CustomerContent;
        }
        field(50119; "Campaign Name"; Text[250])
        {
            Caption = 'Campaign Name';
            DataClassification = CustomerContent;
        }
        // Lead Information (Basic Details)

        // Property Requirements
        // field(50120; "Usage Type"; Code[20])
        // {
        //     Caption = 'Usage Type';
        //     DataClassification = CustomerContent;
        //     TableRelation = "Secondary Classification"."Property Type" where("Classification Name" = FIELD("PrimaryClassification"));

        // }
        field(50121; "Lead Sales Stages"; Text[100])
        {
            Caption = 'Lead Sales Stages';
            DataClassification = CustomerContent;
            TableRelation = "Lead Sales Stages"."Name";
        }
        field(50122; "Competitor Information"; Text[100])
        {
            Caption = 'Competitor Information';
            DataClassification = CustomerContent;
        }
        field(50123; "Furnishing Status"; Enum "Furnishing Status")
        {
            Caption = 'Furnishing Status';
            DataClassification = CustomerContent;
        }
        field(50124; "Preferred Payment Plan"; Enum "Preferred Payment Plan")
        {
            Caption = 'Preferred Payment Plan ';
            DataClassification = CustomerContent;
        }
        field(50125; "Move-in Timeline"; Text[250])
        {
            Caption = 'Move-in Timeline';
            DataClassification = CustomerContent;
            TableRelation = "Move-in Timeline"."Name";
        }
        field(50126; "Bedrooms"; Integer)
        {
            Caption = 'Bedrooms';
            DataClassification = CustomerContent;
        }
        field(50127; "Bathrooms"; Integer)
        {
            Caption = 'Bathrooms';
            DataClassification = CustomerContent;
        }
        // Property Requirements
        field(50128; "Allow Reopen"; Boolean)
        {
            Caption = 'Allow Reopen';
            DataClassification = CustomerContent;
        }
        field(50129; "Disqualification Reason"; Text[500])
        {
            Caption = 'Disqualification Reason';
            DataClassification = CustomerContent;
        }
        field(50130; "Previous Status"; Enum "Lead Status")
        {
            Caption = 'Previous Status';
            DataClassification = CustomerContent;
        }
        field(50131; "Status Changed By"; Text[50])
        {
            Caption = 'Status Changed By';
            DataClassification = CustomerContent;
        }
        field(50132; "Status Changed On"; DateTime)
        {
            Caption = 'Status Changed On';
            DataClassification = CustomerContent;
        }
        field(50133; "Disqualification Date"; Date)
        {
            Caption = 'Disqualification Date';
            DataClassification = CustomerContent;
        }
    }

    trigger OnInsert()
    begin
        if ("Date Created" = 0D) then
            "Date Created" := Today;
    end;
}