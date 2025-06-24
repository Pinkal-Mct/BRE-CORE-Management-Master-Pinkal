page 53104 "Vendor Category Master List"
{
    PageType = List;
    SourceTable = "Vendor Category Master";
    ApplicationArea = All;
    Caption = 'Vendor Category Master List';
    UsageCategory = Lists;


    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Property; Rec.Property)
                {
                    ApplicationArea = All;
                }
                field(Sales; Rec.Sales)
                {
                    ApplicationArea = All;
                }
                field(Facility; Rec.Facility)
                {
                    ApplicationArea = All;
                }
                field(Legal; Rec.Legal)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}