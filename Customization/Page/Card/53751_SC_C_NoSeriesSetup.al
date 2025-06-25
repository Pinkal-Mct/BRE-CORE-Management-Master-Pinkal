page 53751 "No. Series Setup"
{
    PageType = Card;
    SourceTable = "No. Series Setup";
    Caption = 'No. Series Setup';
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(Group)
            {

                Caption = 'No. Series Setup';
                field("Construction Project Nos."; Rec."Construction Project Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the construction project number series.';
                }
                field("Contract Assignment Nos."; Rec."Contract Assignment Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the contract assignment number series.';
                }
                field("Milestone Nos."; Rec."Milestone Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the milestone number series.';
                }
                field("Milestone Task Nos."; Rec."Milestone Task Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the milestone task number series.';
                }
                field("Milestone Sub Task Nos."; Rec."Milestone Sub Task Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the milestone sub-task number series.';
                }
                field("Vendor Profile Nos."; Rec."Vendor Profile Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor profile number series.';
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(Refresh)
            {
                ApplicationArea = All;
                Caption = 'Refresh';
                Image = Refresh;
                ToolTip = 'Refresh the page to see the latest data.';
                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}