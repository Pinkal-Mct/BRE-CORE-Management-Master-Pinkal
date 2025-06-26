page 53508 "Common Vendor Profile List"
{
    PageType = List;
    SourceTable = "Facility Vendor Profiles";
    Caption = 'Vendor Profile List';
    ApplicationArea = All;
    CardPageId = 53505; // "Vendor Profile"
    UsageCategory = Lists;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {

                field("Profile ID"; Rec."Profile ID")
                {
                    ApplicationArea = All;
                    Caption = 'Profile ID';
                }
                field("Profile Name"; Rec."Profile Name")
                {
                    ApplicationArea = All;
                    Caption = 'Profile Name';
                }
                field("Vendor ID"; Rec."Vendor ID")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor ID';

                }
                field("Vendor Name"; Rec."Vendor Name")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Name';

                }
                field("Primary Email Address"; Rec."Primary Email Address")
                {
                    ApplicationArea = All;
                    Caption = 'Primary Email Address';
                }
            }
        }
    }
}