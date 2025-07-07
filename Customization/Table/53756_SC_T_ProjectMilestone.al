table 53756 "Project Milestone"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(53100; "Project ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project ID';
        }
        field(53101; "Milestone ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53102; "Milestone Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Milestone Name';
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
                projectMilestone: Record "Project Milestone";
                TotalWeight: Decimal;
            begin
                projectMilestone.Reset();
                projectMilestone.SetRange("Milestone ID", "Milestone ID");
                if projectMilestone.FindSet() then begin
                    TotalWeight := 0;
                    repeat
                        if projectMilestone."Milestone ID" = "Milestone ID" then
                            TotalWeight += Rec.Weight
                        else
                            TotalWeight += projectMilestone.Weight;
                    until projectMilestone.Next() = 0;

                    if TotalWeight > 100 then
                        Error('Total Milestone Weight for Project "%1" exceeds 100% (Current: %2%)', "Milestone ID", TotalWeight)
                    else
                        Rec.RecalculateProgress();
                end;
            end;
        }
        field(53108; "Description"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Description';
        }
        field(53109; "Notes"; Text[250])
        {
            DataClassification = ToBeClassified;
            Caption = 'Notes';
        }
    }

    keys
    {
        key(PK; "Milestone ID", "Project ID")
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
            Rec."Milestone ID" := noseries.GetNextNo(noSeriesSetup."Milestone Nos.");
        end else
            Error('No. Series Setup not found for Milestone Nos.');
    end;

    trigger OnModify()
    begin
        if Rec."Progress" = 0 then
            Rec.Status := "Status"::Pending
        else if Rec."Progress" < 100 then
            Rec.Status := "Status"::"InProgress"
        else
            Rec.Status := "Status"::Completed;

        updateRelatedTasks(Rec."Milestone ID");
    end;

    procedure RecalculateProgress()
    var
        project: Record "Construction Project";
        projectMilestoneTask: Record "Project Milestone Task";
        TotalProgress, TotalWeight : Decimal;
    begin
        projectMilestoneTask.Reset();
        projectMilestoneTask.SetRange("Milestone ID", "Milestone ID");
        if projectMilestoneTask.FindSet() then begin
            repeat
                TotalProgress += projectMilestoneTask."Progress" * projectMilestoneTask."Weight";
                TotalWeight += projectMilestoneTask."Weight";
            until projectMilestoneTask.Next() = 0;

            if TotalWeight > 0 then begin
                Rec."Progress" := TotalProgress / 100;
                Rec.Modify(true);
            end
            else
                Rec."Progress" := 0;

            if project.Get("Project ID") then begin
                project.RecalculateProgress();
            end;
        end;
    end;

    procedure updateRelatedTasks(MilestoneID: Code[20])
    var
        projectMilestoneTask: Record "Project Milestone Task";
    begin
        projectMilestoneTask.Reset();
        projectMilestoneTask.SetRange("Milestone ID", MilestoneID);
        if projectMilestoneTask.FindSet() then begin
            repeat
                projectMilestoneTask."Project ID" := Rec."Project ID";
                projectMilestoneTask."Milestone Name" := Rec."Milestone Name";
                projectMilestoneTask."Milestone Status" := Rec.Status;
                projectMilestoneTask."Milestone Description" := Rec.Description;
                projectMilestoneTask."Milestone End Date" := Rec."End Date";
                projectMilestoneTask."Milestone Notes" := Rec.Notes;
                projectMilestoneTask."Milestone Start Date" := Rec."Start Date";
                projectMilestoneTask."Milestone Progress" := Rec.Progress;
                projectMilestoneTask."Milestone Weight" := Rec.Weight;
                projectMilestoneTask.Modify(true);
            until projectMilestoneTask.Next() = 0;
        end;
    end;
}