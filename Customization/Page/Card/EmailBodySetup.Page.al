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
            field("Email Type"; Rec."Email Type")
            {
                ApplicationArea = All;
                Caption = 'Email Type';
                ToolTip = 'Type of Email';

                trigger OnValidate()
                begin
                    LoadIntoControlAddIn();
                end;
            }
            group(SubjectGrp)
            {
                Caption = 'Subject';
                field(Subject; Subject)
                {
                    ApplicationArea = All;
                    ShowCaption = false;

                    trigger OnValidate()
                    begin
                        SetSubjectForType(Subject);
                    end;
                }
            }
            group(RichTextGroup)
            {
                Caption = 'Body';
                field(Body; Body)
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    MultiLine = true;
                    ExtendedDatatype = RichContent;

                    trigger OnValidate()
                    begin
                        WriteBodyForType(Body);
                    end;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action(Save)
            {
                ApplicationArea = All;
                Caption = 'Save';
                Image = Save;
                ToolTip = 'Save changes in the content.';

                trigger OnAction()
                begin
                    // CurrPage.Update(true);
                    // SaveChanges(Subject, Body);
                    SetSubjectForType(Subject);
                    WriteBodyForType(Body);
                    // Rec.Modify(true);
                end;
            }
        }

        area(Promoted)
        {
            actionref(Save_; Save) { }
        }
    }

    var
        Subject: Text;
        Body: Text;

    trigger OnAfterGetRecord()
    begin
        // GetRichText();
        Rec."Email Type" := Enum::"Email Type"::" ";

    end;

    trigger OnOpenPage()
    begin
        CurrPage.Editable := true;
        Rec.Reset;
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;

    procedure SaveChanges(SubjectTxt: Text; BodyTxt: Text)
    var
    begin
        SetSubjectForType(SubjectTxt);
        WriteBodyForType(BodyTxt);
    end;

    procedure Replace(TextIn: Text; FindWhat: Text; ReplaceWith: Text): Text
    begin
        if FindWhat = '' then
            exit(TextIn);
        exit(TextIn.Replace(FindWhat, ReplaceWith));
    end;

    local procedure LoadIntoControlAddIn()
    begin
        Subject := GetSubjectForType();
        Body := ReadBodyForType();
    end;

    local procedure GetSubjectForType(): Text
    begin
        case Rec."Email Type" of
            Enum::"Email Type"::"Property Recommendations":
                exit(Rec."Property Rcmd. Subject");
            Enum::"Email Type"::"UAE Market Updates":
                exit(Rec."UAE Market Updates Subject");
            else
                exit(''); // add more cases for new types
        end;
    end;

    local procedure SetSubjectForType(SubjectTxt: Text)
    begin
        case Rec."Email Type" of
            Enum::"Email Type"::"Property Recommendations":
                Rec."Property Rcmd. Subject" := SubjectTxt;
            Enum::"Email Type"::"UAE Market Updates":
                Rec."UAE Market Updates Subject" := SubjectTxt;
            else
        // add additional cases for new types
        end;
        Rec.Modify(true);
    end;

    local procedure ReadBodyForType(): Text
    var
        ins: InStream;
        bodyTxt: Text;
    begin
        bodyTxt := '';
        case Rec."Email Type" of
            Enum::"Email Type"::"Property Recommendations":
                begin
                    Rec.CalcFields("Property Rcmd. Body");
                    if Rec."Property Rcmd. Body".HasValue then begin
                        Rec."Property Rcmd. Body".CreateInStream(ins, TextEncoding::UTF8);
                        ins.Read(bodyTxt);
                    end;
                end;
            Enum::"Email Type"::"UAE Market Updates":
                begin
                    Rec.CalcFields("UAE Market Updates Body");
                    if Rec."UAE Market Updates Body".HasValue then begin
                        Rec."UAE Market Updates Body".CreateInStream(ins, TextEncoding::UTF8);
                        ins.Read(bodyTxt);
                    end;
                end;
            else
        // add cases for other types
        end;

        exit(bodyTxt);
    end;

    local procedure WriteBodyForType(BodyTxt: Text)
    var
        outs: OutStream;
    begin
        case Rec."Email Type" of
            Enum::"Email Type"::"Property Recommendations":
                begin
                    Rec."Property Rcmd. Body".CreateOutStream(outs, TextEncoding::UTF8);
                    outs.Write(BodyTxt);
                end;
            Enum::"Email Type"::"UAE Market Updates":
                begin
                    Rec."UAE Market Updates Body".CreateOutStream(outs, TextEncoding::UTF8);
                    outs.Write(BodyTxt);
                end;
            else
        // add cases for other types
        end;
        Rec.Modify(true);
    end;
}
