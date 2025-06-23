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
        field(53102; "Project type"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project type';
            TableRelation = "Project Type";
        }
        field(53103; "Project status"; Option)
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
        field(53109; "Postal code"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Postal code';
        }
        field(53110; "latitude"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'latitude';
        }
        field(53111; "longitude"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'longitude';
        }
        field(53112; "Location link"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Location link';
        }
        // Project Location //

        // Timeline //
        field(53113; "Planned start date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Planned start date';
        }
        field(53114; "Planned end Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Planned end Date';
        }
        field(53115; "Actual start date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Actual start date';
        }
        field(53116; "Final completion date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Final completion date';
        }
        // Timeline //

        // Performance Metrics //
        field(53117; "Progress percentages"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Progress percentages';
        }
        // Performance Metrics //

        // Financial Details //
        field(53118; "Approved budget"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Approved budget';
        }
        field(53119; "Estimated cost breakdown"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Estimated cost breakdown';
        }
        field(53120; "Funding source"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Funding source';
        }
        field(53121; "Current spends tracking"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Current spends tracking';
        }
        // Financial Details //

        // Responsible Parties //
        field(53122; "Project owner"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project owner';
        }
        field(53123; "Primary contractor"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Primary contractor';
        }
        field(53124; "Project manager"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project manager';
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
        field(53131; "Number of floors"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Number of floors';
        }
        field(53132; "Construction materials"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Construction materials';
        }
        // Construction Specifications //

        // Stakeholders //
        field(53133; "Architect/design firm"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Architect/design firm';
        }
        field(53134; "Subcontractors list"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Subcontractors list';
        }
        field(53135; "Key consultants"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Key consultants';
        }
        // Stakeholders //

        // Extended Timeline //
        field(53136; "Design completion date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Design completion date';
        }
        field(53137; "Permit approval date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Permit approval date';
        }
        field(53138; "Substantial completion date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Substantial completion date';
        }
        field(53139; "Extended Final completion date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Extended Final completion date';
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
}