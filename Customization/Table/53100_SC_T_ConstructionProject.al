table 53100 "Construction Project"
{
    DataClassification = ToBeClassified;
    Caption = 'Construction Project';
    fields
    {
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
        field(53102; "Project Location"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Location';
        }
        field(53103; "Project Scope"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Scope';
        }
        field(53104; "Project Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Project Start Date';
        }
        field(53105; "Project End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Project End Date';
        }
        field(53106; "Project Status"; Option)
        {
            OptionCaption = ' ,In Progress,Completed,On Hold';
            OptionMembers = " ",InProgress,Completed,OnHold;
            DataClassification = ToBeClassified;
            Caption = 'Project Status';
        }
        field(53107; "Milestone ID"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Milestone ID';
        }
        field(53108; "Milestone Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Milestone Name';
        }
        field(53109; "Milestone Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Milestone Start Date';
        }
        field(53110; "Milestone End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Milestone End Date';
        }
        field(53111; "Milestone Status"; Option)
        {
            OptionCaption = ' ,Not Started,In Progress,Completed';
            OptionMembers = " ",NotStarted,InProgress,Completed;
            DataClassification = ToBeClassified;
            Caption = 'Milestone Status';
        }
        field(53112; "Milestone Progress"; Decimal)
        {
            DecimalPlaces = 2;
            MinValue = 0;
            MaxValue = 100;
            DataClassification = ToBeClassified;
            Caption = 'Milestone Progress';
        }
        field(53113; "Milestone Notes"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Milestone Notes';
        }
        field(53114; "Task ID"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Task ID';
        }
        field(53115; "Task Name"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Task Name';
        }
        field(53116; "Task Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Task Start Date';
        }
        field(53117; "Task End Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Task End Date';
        }
        field(53118; "Task Status"; Option)
        {
            OptionCaption = ' ,Not Started,In Progress,Completed';
            OptionMembers = " ",NotStarted,InProgress,Completed;
            DataClassification = ToBeClassified;
            Caption = 'Task Status';
        }
        field(53119; "Task Progress"; Decimal)
        {
            DecimalPlaces = 2;
            MinValue = 0;
            MaxValue = 100;
            DataClassification = ToBeClassified;
            Caption = 'Task Progress';
        }
        field(53120; "Task Notes"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Task Notes';
        }
        field(53121; "Issue ID"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Issue ID';
        }
        field(53122; "Issue Description"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Issue Description';
        }
        field(53123; "Issue Start Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Issue Start Date';
        }
        field(53124; "Issue Resolution Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Issue Resolution Date';
        }
        field(53125; "Issue Status"; Option)
        {
            OptionCaption = ' ,Open,In Progress,Resolved';
            OptionMembers = " ",Open,InProgress,Resolved;
            DataClassification = ToBeClassified;
            Caption = 'Issue Status';
        }
        field(53126; "Issue Notes"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Issue Notes';
        }
        field(53127; "Report ID"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Report ID';
        }
        field(53128; "Report Date"; Date)
        {
            DataClassification = ToBeClassified;
            Caption = 'Report Date';
        }
        field(53129; "Report Type"; Option)
        {
            OptionCaption = ' ,Weekly Progress,Monthly Progress';
            OptionMembers = " ",WeeklyProgress,MonthlyProgress;
            DataClassification = ToBeClassified;
            Caption = 'Report Type';
        }
        field(53130; "Report File"; Blob)
        {
            DataClassification = ToBeClassified;
            Caption = 'Report File';
        }
        field(53131; "Report Notes"; Text[100])
        {
            DataClassification = ToBeClassified;
            Caption = 'Report Notes';
        }

    }

    keys
    {
        key(PK; "Project ID")
        {
            Clustered = true;
        }
    }
}