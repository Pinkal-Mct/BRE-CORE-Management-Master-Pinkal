table 53758 "Project Milestone Sub Task"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(53100; "Task ID"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Task ID';
        }
        field(53101; "Sub Task ID"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53102; "Sub Task Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Sub Task Name';
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
                projectMilestoneSubTask: Record "Project Milestone Sub Task";
                TotalWeight: Decimal;
            begin
                projectMilestoneSubTask.Reset();
                projectMilestoneSubTask.SetRange("Task ID", "Task ID");
                if projectMilestoneSubTask.FindSet() then begin
                    TotalWeight := 0;
                    repeat
                        if projectMilestoneSubTask."Sub Task ID" = "Sub Task ID" then
                            TotalWeight += Rec.Weight
                        else
                            TotalWeight += projectMilestoneSubTask.Weight;
                    until projectMilestoneSubTask.Next() = 0;

                    if TotalWeight > 100 then
                        Error('Total Sub Task Weight for Task "%1" exceeds 100% (Current: %2%)', "Task ID", TotalWeight);
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
        key(PK; "Sub Task ID", "Task ID")
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
            Rec."Sub Task ID" := noseries.GetNextNo(noSeriesSetup."Milestone Sub Task Nos.");
        end else
            Error('No. Series Setup not found for Milestone Sub Task Nos.');
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
}