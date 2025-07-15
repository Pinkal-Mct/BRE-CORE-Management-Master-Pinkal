page 50523 "COA Setup List"
{
    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "COA Setup Line";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Item; Rec."Secondary Item") { ApplicationArea = All; }
                field(Residential; Rec.Residential) { ApplicationArea = All; }
                field(Commercial; Rec.Commercial) { ApplicationArea = All; }
                field("Residential-Unearned"; Rec."Residential-Unearned") { ApplicationArea = All; }
                field("Commercial-Unearned"; Rec."Commercial-Unearned") { ApplicationArea = All; }

            }
        }
    }
}