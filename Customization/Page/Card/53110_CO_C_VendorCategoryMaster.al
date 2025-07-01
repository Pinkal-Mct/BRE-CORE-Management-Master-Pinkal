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
                    Visible = ShowPropertyField; // Control visibility based on installed app
                }
                field("Sales"; Rec."Sales")
                {
                    ApplicationArea = All;
                    Visible = ShowSalesField;
                }
                field("Facility"; Rec."Facility")
                {
                    ApplicationArea = All;
                    Visible = ShowFacilityField;
                }
                field("Legal"; Rec."Legal")
                {
                    ApplicationArea = All;
                    Visible = ShowLegalField;
                }
            }
        }
    }


    // Triggers to control visibility of fields based on installed apps
    // Variables to control visibility
    var
        ShowPropertyField: Boolean;
        ShowSalesField: Boolean;
        ShowFacilityField: Boolean;
        ShowLegalField: Boolean;

    trigger OnOpenPage()
    var
        InstalledApp: Record "NAV App Installed App";
    begin

        if InstalledApp.FindSet() then
            repeat
                if InstalledApp.Name = 'Property-RealEstate' then begin
                    ShowPropertyField := true;
                end else if InstalledApp.Name = 'Sales-RealEstate' then begin
                    ShowSalesField := true;
                end else if InstalledApp.Name = 'Facility-RealEstate' then begin
                    ShowFacilityField := true;
                end else if InstalledApp.Name = 'Legal-RealEstate' then begin
                    ShowLegalField := true;
                end;
            until InstalledApp.Next() = 0;
    end;
    // Triggers to control visibility of fields based on installed apps

}