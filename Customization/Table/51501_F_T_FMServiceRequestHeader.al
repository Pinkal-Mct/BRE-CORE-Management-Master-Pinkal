table 51501 "FM Service Request Header"

{

    Caption = 'FM Service Request Header';
    DataClassification = ToBeClassified;
    DataCaptionFields = "Service Request ID";

    fields
    {
        field(51501; "Service Request ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Service Request ID';
        }

        field(51502; "Request Status"; Enum "FM Request Status")
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            var
                sendapprovalrequest: Codeunit "Service Request Approval";
                approvalstatus: Enum "FM Request Status";
            begin
                if Rec."Request Status" = approvalstatus::"Sending Approval" then begin
                    sendapprovalrequest.Sendservicerequest(Rec);
                end
            end;
        }
        field(51503; "Requested Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(51504; "Submission Source"; Enum "FM Submission Source")
        {
            DataClassification = ToBeClassified;
        }
        field(51505; "Submitted By (User ID)"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51506; "Requested By(Tenant / Contact)"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51507; "Contact Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51508; "Contact Phone"; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51509; "Contact Email"; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(51510; "Property Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51511; "Unit/Flat No."; Text[20])
        {
            DataClassification = ToBeClassified;
        }
        field(51512; "Service Category"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Service Type Master"."Service Type ID";
            trigger onValidate()
            begin
                Clear("Service Sub-Type");
            end;
        }
        field(51513; "Service Sub-Type"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Service Sub-Type Master"."Service Sub-Type ID" where("Service type ID" = field("Service Category"));
            trigger onValidate()
            var
                SubTypeRec: Record "Service Sub-Type Master";
            begin
                if not SubTypeRec.Get("Service Category", "Service Sub-Type") then
                    Error('Selected Sub-Type does not belong to selected Category.');
            end;
        }
        field(51514; "Asset ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset"."No.";
        }
        field(51515; "Problem Description"; Text[500])
        {
            DataClassification = ToBeClassified;
        }
        field(51516; "Urgency Level"; Enum "FM Urgency Level")
        {
            DataClassification = ToBeClassified;
            trigger onValidate()
            begin
                if Rec."Urgency Level" = Rec."Urgency Level"::" " then
                    Error('Urgency Level must be specified.');
            end;
        }
        field(51517; "Preferred Service Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(51518; "Preferred Time Slot"; Enum "FM Time Slot")
        {
            DataClassification = ToBeClassified;
        }
        field(51519; "Approval Status"; Enum "FM Approval Status")
        {
            DataClassification = ToBeClassified;
        }
        field(51520; "Approved By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51521; "Approved Date"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(51522; "Assigned Work Order ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }

        field(51523; "Created DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51524; "Created By"; Code[50])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(51525; "Last Modified DateTime"; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(51526; "Last Modified By"; Code[50])
        {
            DataClassification = ToBeClassified;
        }
        field(51527; "Image"; Text[50])
        {
            DataClassification = ToBeClassified;

        }

        field(51528; "Image URL"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Image URL';
        }
    }

    keys
    {
        key(Key1; "Service Request ID")
        {
            Clustered = true;
        }

    }

    fieldgroups
    {
        // Add changes to field groups here
    }

    var
        myInt: Integer;

    trigger OnInsert()
    var
        noSeriesSetup: Record "No. Series Setup";
        noseries: Codeunit "No. Series";
    begin
        if noSeriesSetup.Get() then begin
            Rec."Service Request ID" := noseries.GetNextNo(noSeriesSetup."Service Request ID Nos.");
        end else
            Error('No. Series Setup not found for Construction Project Nos.');
        "Requested Date" := CurrentDateTime();
        "Created DateTime" := CurrentDateTime();
        "Created By" := UserId();
    end;

    trigger OnModify()
    begin
        "Last Modified DateTime" := CurrentDateTime();
        "Last Modified By" := UserId();
    end;


    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}