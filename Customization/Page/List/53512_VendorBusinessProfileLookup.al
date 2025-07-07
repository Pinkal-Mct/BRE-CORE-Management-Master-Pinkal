page 53512 "Vendor Business Profile Lookup"
{
    PageType = List;
    SourceTable = "Vendor Business Profile";
    Caption = 'Vendor Business Profile Lookup';
    //  UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;
    DeleteAllowed = false;

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
                field("Vendor Category"; Rec."Vendor Category")
                {
                    ApplicationArea = All;
                    Caption = 'Vendor Category';

                }
                field("Service Type"; Rec."Service Type")
                {
                    ApplicationArea = All;
                    Caption = 'Service Type';
                }
                field("Key Products"; Rec."Key Products")
                {
                    ApplicationArea = All;
                    Caption = 'Key Products';
                }
                field("Team Size"; Rec."Team Size")
                {
                    ApplicationArea = All;
                    Caption = 'Team Size';
                }
                field("Number of years of experience"; Rec."Number of years of experience")
                {
                    ApplicationArea = All;
                    Caption = 'No. of years of experience';
                }
                field("Compliance Requirements"; Rec."Compliance Requirements")
                {
                    ApplicationArea = All;
                    Caption = 'Compliance Requirements';
                }
                field("Previous Projects in UAE"; Rec."Previous Projects in UAE")
                {
                    ApplicationArea = All;
                    Caption = 'Previous Projects in UAE';
                }
                field("Additional note"; Rec."Additional note")
                {
                    ApplicationArea = All;
                    Caption = 'Additional Note';
                }
            }
        }
    }
    procedure GetLookUpValues(pVendorBusinessprofilelist: Page "Vendor Business Profile Lookup"; pvendorbusinessprofile: Record "Vendor Business Profile"): Text
    var
        isFirst: Boolean;
        lookUpValues: Text;
        Vendorproposal: Record "Vendor Proposal";
    begin


        pvendorbusinessprofilelist.SetSelectionFilter(pvendorbusinessprofile);
        if pvendorbusinessprofile.FindSet() then begin
            isFirst := true;
            repeat
                if isFirst then begin
                    lookUpValues := pvendorbusinessprofile."Service Type";
                    isFirst := false;
                end else
                    lookUpValues += ', ' + pvendorbusinessprofile."Service Type";
            until pvendorbusinessprofile.Next() = 0;
        end;
        exit(lookUpValues);
    end;
}