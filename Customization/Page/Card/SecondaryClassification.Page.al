page 51256 "Secondary Classification Card"
{
    PageType = Card;
    SourceTable = "Secondary Classification";
    ApplicationArea = All;
    Caption = 'Unit Type';
    // UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(Group)
            {
                Caption = 'Unit Type Details';
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Editable = false; // The ID is not editable since it's auto-incrementing

                }
                field("Classification Name"; Rec."Classification Name")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Classification';
                    ToolTip = 'Select the associated primary classification.';
                    ShowMandatory = true;
                    NotBlank = true;


                }
                field("Property Type"; Rec."Property Type")
                {
                    ApplicationArea = All;
                    Caption = 'Unit Type';
                    ToolTip = 'Enter the property type.';
                    ShowMandatory = true;
                    NotBlank = true;

                    trigger OnValidate()
                    begin
                        CurrPage.SaveRecord();
                    end;


                }
            }
        }

    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec.TestField("Classification Name");
        Rec.TestField("Property Type");
    end;

}
