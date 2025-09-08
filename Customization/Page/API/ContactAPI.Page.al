page 53767 "Contact API"
{
    APIGroup = 'emails';
    APIPublisher = 'yourpub';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'contact';
    DelayedInsert = true;
    EntityName = 'contact';
    EntitySetName = 'contacts';
    PageType = API;
    SourceTable = Contact;
    DeleteAllowed = true;
    ModifyAllowed = true;
    ODataKeyFields = SystemId;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(SystemId; Rec.SystemId)
                {
                    Caption = 'System Id';
                }
                field(Name; Rec.Name)
                {
                    Caption = 'Name';
                }
                field("Primary_Classification"; Rec."Primary Classification")
                {
                    Caption = 'Primary Classification';
                }
                field("Usage_Type"; Rec."Usage Type")
                {
                    Caption = 'Usage Type';
                }
                field("Preferred_Location"; Rec."Preferred Location")
                {
                    Caption = 'Preferred Location';
                }
                field(Bedrooms; Rec.Bedrooms)
                {
                    Caption = 'Bedrooms';
                }
                field(Budget; Rec."Budget Range (AED)")
                {
                    Caption = 'Budget';
                }
                field("Size"; Rec."Size (Sq. Ft.)")
                {
                    Caption = 'Size (Sq. Ft.)';
                }
            }
        }
    }
}
