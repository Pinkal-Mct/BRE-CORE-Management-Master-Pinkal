page 51263 "Item Dialog Box"
{
    PageType = StandardDialog;
    ApplicationArea = All;
    Caption = 'Item Dialog Box';

    layout
    {
        area(Content)
        {
            group(Group)
            {
                field(ItemCategory; ItemCategory)
                {
                    ApplicationArea = All;
                    Caption = 'Item Category';
                }
            }
        }
    }

    procedure GetItemCategory(): Enum "Item Template Enum"
    begin
        exit(ItemCategory);
    end;

    var
        ItemCategory: Enum "Item Template Enum";
}

