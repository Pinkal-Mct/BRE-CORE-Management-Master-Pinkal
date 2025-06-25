table 53100 "Construction Project"
{
    DataClassification = ToBeClassified;
    Caption = 'Construction Project';
    fields
    {
        // Project Details //
        field(53100; "Project ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project ID';
        }
        field(53101; "Project Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Name';
        }
        field(53102; "Project Type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Type';
            TableRelation = "Project Type"."Project Type";
        }
        field(53103; "Project Status"; Option)
        {
            OptionCaption = ' ,Planned,In progress,Completed,On Hold,Cancelled';
            OptionMembers = " ",Planned,InProgress,Completed,OnHold,Cancelled;
            DataClassification = ToBeClassified;
            Caption = 'Project Status';
        }
        // Project Details // 

        // Project scope //
        field(53104; "Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(53105; "Objectives"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Objectives';
        }
        field(53106; "Additional Notes"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Additional Notes';
        }
        // Project scope //

        // Project Location //
        field(53107; "Address Line 1"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Address Line 1';
        }
        field(53108; "Address Line 2"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Address Line 2';
        }
        field(53109; "Postal Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Postal Code';
        }
        field(53110; "Latitude"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Latitude';
        }
        field(53111; "Longitude"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Longitude';
        }
        field(53112; "Location Link"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Location Link';
        }
        // Project Location //

        // Timeline //
        field(53113; "Planned Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Planned Start Date';
        }
        field(53114; "Planned End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Planned End Date';
        }
        field(53115; "Actual Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Actual Start Date';
        }
        field(53116; "Final Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Final Completion Date';
        }
        // Timeline //

        // Performance Metrics //
        field(53117; "Progress Percentages"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Progress Percentages';
            MaxValue = 100;
        }
        // Performance Metrics //

        // Financial Details //
        field(53118; "Approved Budget"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Approved Budget';
        }
        field(53119; "Estimated Cost Breakdown"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Estimated Cost Breakdown';
        }
        field(53120; "Funding Source"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Funding Source';
        }
        field(53121; "Current Spends Tracking"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Current Spends Tracking';
        }
        // Financial Details //

        // Responsible Parties //
        field(53122; "Project Owner"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Owner';
        }
        field(53123; "Primary Contractor"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary Contractor';
        }
        field(53124; "Project Manager"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Manager';
        }
        // Responsible Parties //

        // Construction Specifications //
        field(53129; "Building Type/Classification"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Building Type or Classification';
        }
        field(53130; "UOM"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'UOM';
        }
        field(53131; "Number of Floors"; Integer)
        {
            DataClassification = ToBeClassified;
            Caption = 'Number of Floors';
        }
        field(53132; "Construction Materials"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Construction Materials';
        }
        // Construction Specifications //

        // Stakeholders //
        field(53133; "Architect/Design Firm"; Option)
        {
            OptionCaption = ' ,Vendor,Related party,Internal Team';
            OptionMembers = " ",Vendor,Relatedparty,InternalTeam;
            DataClassification = ToBeClassified;
            Caption = 'Architect/Design Firm';
        }
        field(53134; "Subcontractors List"; Option)
        {
            OptionCaption = ' ,Vendor,Related party';
            OptionMembers = " ",Vendor,Relatedparty;
            DataClassification = ToBeClassified;
            Caption = 'Subcontractors List';
        }
        field(53135; "Key Consultants"; Option)
        {
            OptionCaption = ' ,Vendor,Related party,Internal Team';
            OptionMembers = " ",Vendor,Relatedparty,InternalTeam;
            DataClassification = ToBeClassified;
            Caption = 'Key Consultants';
        }
        // Stakeholders //

        // Extended Timeline //
        field(53136; "Design Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Design Completion Date';
        }
        field(53137; "Permit Approval Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Permit Approval Date';
        }
        field(53138; "Substantial Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Substantial Completion Date';
        }
        field(53139; "Extended Final Completion Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Extended Final Completion Date';
        }
        field(53140; SelectedMilestoneId; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        // Extended Timeline //

    }

    keys
    {
        key(PK; "Project ID")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()

    var
        noSeriesSetup: Record "No. Series Setup";
        noseries: Codeunit "No. Series";
    begin
        if noSeriesSetup.Get() then begin
            Rec."Project ID" := noseries.GetNextNo(noSeriesSetup."Construction Project Nos.");
        end else
            Error('No. Series Setup not found for Construction Project Nos.');
    end;

    // Recalculate Progress //
    procedure RecalculateProgress()
    var
        projectMilestone: Record "Project Milestone";
        TotalProgress, TotalWeight : Decimal;
    begin
        projectMilestone.Reset();
        projectMilestone.SetRange("Project ID", "Project ID");
        if projectMilestone.FindSet() then begin
            repeat
                TotalProgress += projectMilestone."Progress" * projectMilestone."Weight";
                TotalWeight += projectMilestone."Weight";
            until projectMilestone.Next() = 0;

            if TotalWeight > 0 then begin
                Rec."Progress percentages" := TotalProgress / 100;
                Rec.Modify();
            end
            else
                Rec."Progress percentages" := 0;
        end;
    end;
    // Recalculate Progress //
}