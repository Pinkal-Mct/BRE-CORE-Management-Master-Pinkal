page 50147 "Integer List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = None;
    SourceTable = Integer;

    layout
    {
        area(Content)
        {
            repeater(List)
            {
                field(Number; Rec.Number)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the integer number.';
                }
            }
        }
    }
}