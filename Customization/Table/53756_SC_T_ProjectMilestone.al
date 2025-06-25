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

    procedure RecalculateProgress()
    var
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
                Rec.Modify();
            end
            else
                Rec."Progress" := 0;
        end;
    end;
}