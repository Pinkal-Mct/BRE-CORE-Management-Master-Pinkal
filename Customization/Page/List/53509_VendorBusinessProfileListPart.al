page 53509 "Vendor Business Profile"
{
    PageType = ListPart;
    SourceTable = "Vendor Business Profile";
    Caption = 'Vendor Business Profile';
    ApplicationArea = All;
    UsageCategory = Lists;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Caption = 'Entry No.';
                }
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
                    Caption = 'Business Type';
                }
                field("Key Products"; Rec."Key Products")
                {
                    ApplicationArea = All;
                    Caption = 'Business Registration No.';
                }
                field("Team Size"; Rec."Team Size")
                {
                    ApplicationArea = All;
                    Caption = 'Team Size';
                }
                field("Number of years of experience"; Rec."Number of years of experience")
                {
                    ApplicationArea = All;
                    Caption = 'Number of years of experience';
                }
                field("Compliance Requirements"; Rec."Compliance Requirements")
                {
                    ApplicationArea = All;
                    Caption = 'Business Registration Date';
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
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        Rec."Profile ID" := profileid;
    end;

    var
        profileid: Code[20];

    procedure SetProfileID(pProfileID: Code[20])
    begin
        profileid := pProfileID;
    end;
}