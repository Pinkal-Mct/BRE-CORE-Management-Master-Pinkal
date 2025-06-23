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
                        Error('Total Task Weight for Milestone "%1" exceeds 100%% (Current: %2%%)', "Milestone ID", TotalWeight);
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
    end;
}