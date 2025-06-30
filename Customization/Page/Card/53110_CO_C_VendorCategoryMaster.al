page 53110 "VendorCategoryMaster"
{
    PageType = Card;
    SourceTable = "Vendor Category Master";
    ApplicationArea = All;
    Caption = 'Vendor Category Master Card';
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group("")
            {
                field("Name"; Rec."Name")
                {
                    ApplicationArea = All;
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field("Property"; Rec."Property")
                {
                    ApplicationArea = All;
                }
                field("Sales"; Rec."Sales")
                {
                    ApplicationArea = All;
                }
                field("Facility"; Rec."Facility")
                {
                    ApplicationArea = All;
                }
                field("Legal"; Rec."Legal")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}