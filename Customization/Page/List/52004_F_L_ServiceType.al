page 52004 "Service Type List"
{
    PageType = List;
    SourceTable = "Service Type";
    Caption = 'Service Type List';
    ApplicationArea = All;
    UsageCategory = Lists;


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Service Type"; Rec."Service Type")
                {
                    ApplicationArea = All;
                    Caption = 'Service Type';
                }
                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    Caption = 'Description';
                }

            }

        }
    }

}
