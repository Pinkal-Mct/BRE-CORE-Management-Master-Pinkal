page 53763 "Project Milestone Tasks"
{
    PageType = ListPart;
    SourceTable = "Project Milestone Task";
    ApplicationArea = All;
    Caption = 'Project Milestones';
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Milestone ID"; Rec."Milestone ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier for the milestone.';
                }
                field("Milestone Name"; Rec."Milestone Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the milestone.';
                }
                field(Status; Rec."Milestone Status")
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    ToolTip = 'Indicates the current status of the milestone.';
                }
                field(Progress; Rec."Milestone Progress")
                {
                    ApplicationArea = All;
                    Caption = 'Progress (%)';
                    ToolTip = 'Indicates the progress percentage of the milestone.';
                }
                field("Start Date"; Rec."Milestone Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the start date of the milestone.';
                }
                field("End Date"; Rec."Milestone End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the end date of the milestone.';
                }
                field(Weight; Rec."Milestone Weight")
                {
                    ApplicationArea = All;
                    Caption = 'Weight (%)';
                    ToolTip = 'Indicates the weight of the milestone in the project.';
                }
                field(Description; Rec."Milestone Description")
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                    ToolTip = 'Provides additional details about the milestone.';
                }
                field(Notes; Rec."Milestone Notes")
                {
                    ApplicationArea = All;
                    Caption = 'Notes';
                    ToolTip = 'Contains any notes related to the milestone.';
                }
            }
        }
    }
}