page 53764 "Email Link Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Email Link Setup";
    Caption = 'Email Link Setup';

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Flow Base URL"; Rec."Flow Base URL") { ApplicationArea = All; }
                field("Expiry (Days)"; Rec."Expiry (Days)") { ApplicationArea = All; }
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
