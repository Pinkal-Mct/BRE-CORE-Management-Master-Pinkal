tableextension 53111 ContactExtension extends Contact
{
    fields
    {
        // Lead Information (Basic Details)
        field(53100; "Lead Source"; Enum "Lead Source")
        {
            DataClassification = ToBeClassified;
            Caption = 'Lead Source';
        }
        field(53101; "Lead Owner"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Lead Name';
        }
        field(53102; "Lead Status"; Enum "Lead Status")
        {
            DataClassification = ToBeClassified;
            Caption = 'Lead Status';
        }
        field(53103; "Lead Rating"; Enum "Lead Rating")
        {
            DataClassification = ToBeClassified;
            Caption = 'Lead Rating';
        }
        field(53104; "Date Created"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Date Created';
        }
        field(53105; "Expected Follow-up Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Expected Follow-up Date';
        }
        // Lead Information (Basic Details)

        // Contact & Company Details
        field(53107; "Position/Role"; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Position/Role';
        }
        field(53134; "Primary Classification"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Classification';
            TableRelation = "Primary Classification"."Classification Name";
        }
        field(53108; "Property Type"; Text[100])
        {
            Caption = 'Property Type';
            DataClassification = CustomerContent;
            TableRelation = "Property Type"."Property Type" where("Classification Name" = FIELD("Primary Classification"));
        }

        field(53109; "Preferred Location"; Text[100])
        {
            Caption = 'Preferred Location';
            DataClassification = CustomerContent;
        }

        field(53110; "Budget Range (AED)"; Text[100])
        {
            Caption = 'Budget Range (AED)';
            DataClassification = CustomerContent;
        }

        field(53111; "Size (Sq. Ft.)"; Decimal)
        {
            Caption = 'Size (Sq. Ft.)';
            DataClassification = CustomerContent;

        }
        // Property Requirements

        // Financial & Legal Details (For Compliance)
        field(53112; "Emirates ID/Passport No."; Text[50])
        {
            Caption = 'Emirates ID / Passport No.';
            DataClassification = CustomerContent;
        }

        field(53113; "Visa Status"; Enum "Visa Status")
        {
            Caption = 'Visa Status';
            DataClassification = CustomerContent;
        }

        field(53114; "Source of Funds"; Enum "Source of Funds")
        {
            Caption = 'Source of Funds';
            DataClassification = CustomerContent;
        }

        field(53115; "Mortgage Pre-Approved"; Boolean)
        {
            Caption = 'Mortgage Pre-Approved';
            DataClassification = CustomerContent;
        }

        field(53116; "RERA Broker ID"; Text[30])
        {
            Caption = 'RERA Broker ID';
            DataClassification = CustomerContent;
        }

        field(53117; "Preferred Sale Type"; Enum "Preferred Sales Type")
        {
            Caption = 'Preferred Sale Type';
            DataClassification = CustomerContent;
        }
        // Financial & Legal Details (For Compliance)

        // Lead Information (Basic Details)
        field(53118; "Others"; Text[250])
        {
            Caption = 'Others';
            DataClassification = CustomerContent;
        }
        field(53119; "Campaign Name"; Text[250])
        {
            Caption = 'Campaign Name';
            DataClassification = CustomerContent;
        }
        // Lead Information (Basic Details)

        // Property Requirements
        field(53120; "Usage Type"; Text[100])
        {
            Caption = 'Usage Type';
            DataClassification = CustomerContent;
            TableRelation = "Secondary Classification"."Property Type" where("Classification Name" = FIELD("Primary Classification"));
        }
        field(53122; "Competitor Information"; Text[100])
        {
            Caption = 'Competitor Information';
            DataClassification = CustomerContent;
        }
        field(53123; "Furnishing Status"; Enum "Furnishing Status")
        {
            Caption = 'Furnishing Status';
            DataClassification = CustomerContent;
        }
        field(53124; "Preferred Payment Plan"; Enum "Preferred Payment Plan")
        {
            Caption = 'Preferred Payment Plan ';
            DataClassification = CustomerContent;
        }
        field(53125; "Move-in Timeline"; Text[250])
        {
            Caption = 'Move-in Timeline';
            DataClassification = CustomerContent;
            TableRelation = "Move-in Timeline"."Name";
        }
        field(53126; "Bedrooms"; Integer)
        {
            Caption = 'Bedrooms';
            DataClassification = CustomerContent;
        }
        field(53127; "Bathrooms"; Integer)
        {
            Caption = 'Bathrooms';
            DataClassification = CustomerContent;
        }
        // Property Requirements
        field(53128; "Allow Reopen"; Boolean)
        {
            Caption = 'Allow Reopen';
            DataClassification = CustomerContent;
        }
        field(53129; "Disqualification Reason"; Text[500])
        {
            Caption = 'Disqualification Reason';
            DataClassification = CustomerContent;
        }
        field(53130; "Previous Status"; Enum "Lead Status")
        {
            Caption = 'Previous Status';
            DataClassification = CustomerContent;
        }
        field(53131; "Status Changed By"; Text[50])
        {
            Caption = 'Status Changed By';
            DataClassification = CustomerContent;
        }
        field(53132; "Status Changed On"; DateTime)
        {
            Caption = 'Status Changed On';
            DataClassification = CustomerContent;
        }
        field(53133; "Disqualification Date"; Date)
        {
            Caption = 'Disqualification Date';
            DataClassification = CustomerContent;
        }
        field(53135; "Owner Email"; Text[250])
        {
            Caption = 'Owner Email';
            DataClassification = CustomerContent;
        }
        field(53136; "Owner Contact No."; Text[20])
        {
            Caption = 'Owner Contact No.';
            DataClassification = CustomerContent;
        }
        field(53137; "Owner Type"; Option)
        {
            Caption = 'Owner Type';
            DataClassification = CustomerContent;
            OptionCaption = 'Agent,Sales Representative';
            OptionMembers = "Agent","Sales Representative";
        }
        field(53140; "Threshold Value"; Decimal)
        {
            Caption = 'Threshold Value';
            DataClassification = CustomerContent;
        }
        field(53141; "Client Info ID"; Code[20])
        {
            Caption = 'Client Info ID';
            DataClassification = CustomerContent;
            TableRelation = "Client Info"."Client Info ID";

            trigger OnValidate()
            var
                ClientInfoRec: Record "Client Info";
            begin
                ClientInfoRec.SetRange("Client Info ID", "Client Info ID");
                if ClientInfoRec.FindFirst() then begin
                    "Name" := ClientInfoRec."Client Name";
                    "Company Name" := ClientInfoRec."Company Name";
                    "Position/Role" := ClientInfoRec."Position/Role";
                    "Language Code" := ClientInfoRec."Preferred Language";
                    Address := ClientInfoRec.Address;
                    "Address 2" := ClientInfoRec."Address 2";
                    "Country/Region Code" := ClientInfoRec."Country/Region Code";
                    "Post Code" := ClientInfoRec."Post Code";
                    City := ClientInfoRec.City;
                    "E-Mail" := ClientInfoRec.Email;
                    "Phone No." := ClientInfoRec."Phone No.";
                    "Mobile Phone No." := ClientInfoRec."Mobile No.";
                    "Others" := ClientInfoRec.Notes;
                    "Emirates ID/Passport No." := ClientInfoRec."Emirates ID/Passport Number";
                    "Visa Status" := ClientInfoRec."Visa Status";
                    "Source of Funds" := ClientInfoRec."Source of Funds";
                    "VAT Registration No." := ClientInfoRec."TAX Registration_VAT";
                    "RERA Broker ID" := ClientInfoRec."RERA Broker ID";
                    "Preferred Sale Type" := ClientInfoRec."Preferred Sale Type";
                end;
            end;
        }
        field(53142; "SalesPerson Name"; Text[50])
        {
            Caption = 'SalesPerson Name';
            Editable = false;

        }
        field(53143; "Next Action"; Text[1000])
        {
            Caption = 'Next Action';
            DataClassification = ToBeClassified;
        }
        field(52001; "Total Score"; Integer)
        {
            DataClassification = CustomerContent;
        }

        modify("Salesperson Code")
        {
            trigger OnAfterValidate()
            var
                SalesPersonRec: Record "Salesperson/Purchaser";
            begin
                SalesPersonRec.SetRange(Code, "Salesperson Code");
                if SalesPersonRec.FindFirst() then
                    "SalesPerson Name" := SalesPersonRec.Name;
            end;
        }



    }

    trigger OnInsert()
    begin
        if ("Date Created" = 0D) then
            "Date Created" := Today;
    end;


    trigger OnAfterModify()
    var
        LeadInfo: Record "Lead Information";
    begin
        if (Rec."Client Info ID" <> '') AND (Rec."No." <> '') AND (Rec."Primary Classification" <> '') AND (Rec."Property Type" <> '') AND (Rec."Usage Type" <> '') AND (Rec."SalesPerson Name" <> '')
        then begin
            LeadInfo.SetRange("Lead ID", Rec."No.");
            if LeadInfo.FindFirst() then begin
                LeadInfo."Lead ID" := Rec."No.";
                LeadInfo."Property Name" := Rec."Primary Classification";
                LeadInfo."Property Type" := Rec."Property Type";
                LeadInfo."Unit Type" := Rec."Usage Type";
                LeadInfo."Sales Person" := Rec."SalesPerson Name";
                LeadInfo."Lead Status" := Rec."Lead Status";
                LeadInfo."Lead Rating" := Rec."Lead Rating";
                LeadInfo."CLient Info Id" := Rec."Client Info ID";
                LeadInfo."Contact Phone" := Rec."Phone No.";
                LeadInfo."Contact Email" := Rec."E-Mail";
                LeadInfo.Modify();
            end
            else begin
                LeadInfo.Init();
                LeadInfo."Lead ID" := Rec."No.";
                LeadInfo."Property Name" := Rec."Primary Classification";
                LeadInfo."Property Type" := Rec."Property Type";
                LeadInfo."Unit Type" := Rec."Usage Type";
                LeadInfo."Sales Person" := Rec."SalesPerson Name";
                LeadInfo."Lead Status" := Rec."Lead Status";
                LeadInfo."Lead Rating" := Rec."Lead Rating";
                LeadInfo."CLient Info Id" := Rec."Client Info ID";
                LeadInfo."Contact Phone" := Rec."Phone No.";
                LeadInfo."Contact Email" := Rec."E-Mail";
                LeadInfo.Insert();
            end;
        end;
    end;

}