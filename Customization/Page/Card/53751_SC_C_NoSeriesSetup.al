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
                field("Contract Assignment Nos."; Rec."Contract Assignment Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the contract assignment number series.';
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