page 53506 "Vendor Document List"
{
    PageType = List;
    SourceTable = "Vendor Documents";
    Caption = 'Vendor Document List';
    ApplicationArea = All;
    UsageCategory = Lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                }
                field("Vendor Document Name"; Rec."Vendor Document Name")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Document Name';
                }
            }
        }
    }


}