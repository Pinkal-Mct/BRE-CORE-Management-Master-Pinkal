page 53766 "Email Body Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Email Body Setup";
    Caption = 'Email Body Setup';

    layout
    {
        area(content)
        {
            group(AutomatedFollowUp)
            {
                Caption = 'Automated FollowUps';
                field("Automated FollowUp Subject"; Rec."Automated FollowUp Subject")
                {
                    ApplicationArea = All;
                    Caption = 'Subject';
                }
                field("Automated FollowUp Body"; afBody)
                {
                    ApplicationArea = All;
                    Caption = 'Body';
                }
            }
        }
    }

    var
        afBody: Text;

    trigger OnAfterGetRecord()
    begin
        GetRichText();
    end;

    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    local procedure GetRichText()
    var
        RichTextInS: InStream;
    begin
        Rec.CalcFields("Automated FollowUp Body");
        Rec."Automated FollowUp Body".CreateInStream(RichTextInS, TextEncoding::UTF8);
        RichTextInS.Read(afBody);
    end;

    local procedure SetRichText()
    var
        RichTextOutS: OutStream;
    begin
        Rec."Automated FollowUp Body".CreateOutStream(RichTextOutS, TextEncoding::UTF8);
        RichTextOutS.Write(afBody);
        Rec.Modify(true);
    end;
}
