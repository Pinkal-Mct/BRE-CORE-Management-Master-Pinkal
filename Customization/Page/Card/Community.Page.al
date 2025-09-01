page 51253 "Community Card"
{
    PageType = Card;
    SourceTable = Community;
    ApplicationArea = All;
    Caption = 'Community Card';
    // UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Community Details';
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                }
                field("Sl No."; Rec."Sl No.")
                {
                    ApplicationArea = All;
                }
                field("Community Name"; Rec."Community Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    NotBlank = true;
                }
                field("Emirate Name"; Rec."Emirate Name")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                    NotBlank = true;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;
                }
                field("Community Code"; Rec."Community Code")
                {
                    ApplicationArea = All;

                }

            }
        }
    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("Community Name");
        Rec.TestField("Emirate Name");
    end;
}
