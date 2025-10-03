table 51260 "Opportunity Management"
{
    Caption = 'Opportunity';
    DataClassification = ToBeClassified;

    fields
    {
        field(51251; "Opportunity ID"; Code[20])
        {
            Caption = 'Opportunity ID';
            DataClassification = ToBeClassified;
        }
        field(51252; "Lead ID"; Code[20])
        {
            Caption = 'Lead ID';
            DataClassification = ToBeClassified;
            NotBlank = true;
            // TableRelation = "Lead Management"."Lead ID"; // Uncomment when Lead table is available
        }

        field(51253; "Project ID"; Code[20])
        {
            Caption = 'Project ID';
            DataClassification = ToBeClassified;
            TableRelation = "Construction Project"."Project ID"; // Uncomment when Project table is available
        }

        field(51254; "Unit ID"; Code[100])
        {
            Caption = 'Unit ID';
            DataClassification = ToBeClassified;
            TableRelation = Item."No." WHERE("Item Type Template" = CONST("Unit Service"));
        }

        field(51255; "Opportunity Name"; Text[100])
        {
            Caption = 'Opportunity Name';
            DataClassification = ToBeClassified;
        }

        field(51256; "Estimated Close Date"; Date)
        {
            Caption = 'Estimated Close Date';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if "Estimated Close Date" < WorkDate() then
                    if not Confirm('Estimated Close Date is in the past. Do you want to continue?') then
                        Error('');
            end;
        }

        field(51257; "Opportunity Value"; Decimal)
        {
            Caption = 'Opportunity Value';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            MinValue = 0;
        }

        field(51258; "Pipeline Stage"; Enum "Pipeline Stage")
        {
            Caption = 'Pipeline Stage';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                UpdateStatusFromPipelineStage();
            end;
        }

        field(51259; Status; Enum "Opportunity Status")
        {
            Caption = 'Status';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if (xRec.Status in [Status::Won, Status::Lost]) and (Status = Status::Open) then
                    Error('Closed opportunities cannot be reactivated.');
            end;
        }

        field(51260; "Probability %"; Decimal)
        {
            Caption = 'Probability %';
            DataClassification = ToBeClassified;
            DecimalPlaces = 2 : 2;
            MinValue = 0;
            MaxValue = 100;
        }

        field(51261; Notes; Text[250])
        {
            Caption = 'Notes';
            DataClassification = ToBeClassified;
        }
        field(51262; "Created By"; Code[50])
        {
            Caption = 'Created By';
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
            TableRelation = User."User Name";
        }

        field(51263; "Created Date"; Date)
        {
            Caption = 'Created Date';
            DataClassification = ToBeClassified;
            Editable = false;
        }
    }
    keys
    {
        key(PK; "Opportunity ID", "Lead ID", "Project ID", "Unit ID")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    var
        noSeriesSetup: Record "No. Series Setup";
        noseries: Codeunit "No. Series";
    begin
        if noSeriesSetup.Get() then
            Rec."Opportunity ID" := noseries.GetNextNo(noSeriesSetup."Opportunity ID Nos.")
        else
            Error('No. Series Setup not found for Construction Project Nos.');

        // Set default Pipeline Stage to Inquiry (now it's the default value 0)
        "Pipeline Stage" := "Pipeline Stage"::Inquiry;

        // Set default dates
        "Created Date" := Today;
        Rec."Created By" := CopyStr(UserId(), 1, StrLen(UserId()));
    end;

    local procedure UpdateStatusFromPipelineStage()
    begin
        case "Pipeline Stage" of
            "Pipeline Stage"::Won:
                Status := Status::Won;
            "Pipeline Stage"::Lost:
                Status := Status::Lost;
            else
                if Status in [Status::Won, Status::Lost] then
                    Status := Status::Open;
        end;
    end;
}