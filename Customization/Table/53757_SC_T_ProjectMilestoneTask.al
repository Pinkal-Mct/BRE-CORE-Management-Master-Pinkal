table 53757 "Project Milestone Task"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(53100; "Milestone ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Milestone ID';
        }
        field(53101; "Task ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53102; "Task Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Task Name';
        }
        field(53103; "Status"; Option)
        {
            OptionCaption = ' ,Pending,In Progress,Completed';
            OptionMembers = " ",Pending,InProgress,Completed;
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
        field(53104; "Progress"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Progress (%)';
            MaxValue = 100.0;
        }
        field(53105; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Start Date';
        }
        field(53106; "End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'End Date';

            trigger OnValidate()
            begin
                if "End Date" < "Start Date" then
                    Error('End Date cannot be earlier than Start Date.');
            end;
        }
        field(53107; "Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Weight (%)';
            MaxValue = 100.0;

            trigger OnValidate()
            var
                projectMilestoneTask: Record "Project Milestone Task";
                TotalWeight: Decimal;
            begin
                projectMilestoneTask.Reset();
                projectMilestoneTask.SetRange("Milestone ID", "Milestone ID");
                if projectMilestoneTask.FindSet() then begin
                    TotalWeight := 0;
                    repeat
                        if projectMilestoneTask."Task ID" = "Task ID" then
                            TotalWeight += Rec.Weight
                        else
                            TotalWeight += projectMilestoneTask.Weight;
                    until projectMilestoneTask.Next() = 0;

                    if TotalWeight > 100 then
                        Error('Total Task Weight for Milestone "%1" exceeds 100% (Current: %2%)', "Milestone ID", TotalWeight)
                    else
                        Rec.RecalculateProgress();
                end;
            end;
        }
        field(53108; "Description"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(53109; "Notes"; Text[1000])
        {
            DataClassification = ToBeClassified;
            Caption = 'Notes';
        }
        field(53110; "Project ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53111; "Contract ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Contract ID';
        }
        field(53112; "Vendor Profile ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Vendor Profile ID';
        }
        field(53113; "Milestone Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Milestone Name';
        }
        field(53114; "Milestone Progress"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53115; "Milestone Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(53116; "Milestone End Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(53117; "Milestone Weight"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(53118; "Milestone Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(53119; "Milestone Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(53120; "Milestone Status"; Option)
        {
            OptionCaption = ' ,Pending,In Progress,Completed';
            OptionMembers = " ",Pending,InProgress,Completed;
            DataClassification = ToBeClassified;
            Caption = 'Status';
        }
    }

    keys
    {
        key(PK; "Task ID", "Milestone ID")
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
            Rec."Task ID" := noseries.GetNextNo(noSeriesSetup."Milestone Task Nos.");
        end else
            Error('No. Series Setup not found for Milestone Task Nos.');

        PopulateMilestoneDetails(Rec."Milestone ID");
    end;

    trigger OnModify()
    begin
        if Rec."Progress" = 0 then
            Rec.Status := "Status"::Pending
        else if Rec."Progress" < 100 then
            Rec.Status := "Status"::"InProgress"
        else
            Rec.Status := "Status"::Completed;
    end;

    procedure RecalculateProgress()
    var
        milestone: Record "Project Milestone";
        projectMilestoneSubTask: Record "Project Milestone Sub Task";
        TotalProgress, TotalWeight : Decimal;
    begin
        projectMilestoneSubTask.Reset();
        projectMilestoneSubTask.SetRange("Task ID", "Task ID");
        if projectMilestoneSubTask.FindSet() then begin
            repeat
                TotalProgress += projectMilestoneSubTask."Progress" * projectMilestoneSubTask."Weight";
                TotalWeight += projectMilestoneSubTask."Weight";
            until projectMilestoneSubTask.Next() = 0;

            if TotalWeight > 0 then begin
                Rec."Progress" := TotalProgress / 100;
                Rec.Modify(true);
            end
            else
                Rec."Progress" := 0;

            milestone.SetRange("Milestone ID", Rec."Milestone ID");
            if milestone.FindSet() then begin
                milestone.RecalculateProgress();
            end;
        end;
    end;

    procedure PopulateMilestoneDetails(pMilestoneId: Code[20])
    var
        milestone: Record "Project Milestone";
    begin
        milestone.SetRange("Milestone ID", Rec."Milestone ID");
        if milestone.FindSet() then begin
            Rec."Project ID" := milestone."Project ID";
            Rec."Milestone Name" := milestone."Milestone Name";
            Rec."Milestone Status" := milestone.Status;
            Rec."Milestone Description" := milestone.Description;
            Rec."Milestone End Date" := milestone."End Date";
            Rec."Milestone Notes" := milestone.Notes;
            Rec."Milestone Start Date" := milestone."Start Date";
            Rec."Milestone Progress" := milestone.Progress;
            Rec."Milestone Weight" := milestone.Weight;
        end;
    end;
}