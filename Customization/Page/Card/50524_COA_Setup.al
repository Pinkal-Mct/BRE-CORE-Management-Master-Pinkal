page 50524 "COA Setup"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "COA Setup";

    layout
    {
        area(Content)
        {
            group(Tenant)
            {
                Caption = 'Tenant Accounts';
                field("Tenant Receivables-Residential"; Rec."Tenant Receivables-Residential")
                {
                    ApplicationArea = All;
                }
                field("Tenant Receivables-Commercial"; Rec."Tenant Receivables-Commercial")
                {
                    ApplicationArea = All;
                }
            }
            group(Rent)
            {
                Caption = 'Rent Accounts';
                field("Residential Rent"; Rec."Residential Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for residential rent.';
                }
                field("Commercial Rent"; Rec."Commercial Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for commercial rent.';
                }
                field("Residential Unearned Rent"; Rec."Residential Unearned Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for unearned residential rent.';
                }
                field("Commercial Unearned Rent"; Rec."Commercial Unearned Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the G/L account for unearned commercial rent.';
                }
                field(Cash; Rec.Cash)
                {
                    ApplicationArea = All;
                    Caption = 'Cash';
                }

            }
            group(CarryForward)
            {
                Caption = 'Carry Forward Security Deposit Account';

                field("Carriedforward in SD"; Rec."Carried Forward in SD")
                {
                    ApplicationArea = All;
                }
                field("Carried Forward Out SD"; Rec."Carried Forward Out SD")
                {
                    ApplicationArea = All;
                }
            }
            group(PDCAcoounts)
            {
                Caption = 'PDC Accounts';
                field("PDC Received"; Rec."PDC Received")
                {
                    ApplicationArea = All;
                }
                field("PDC Collection/Return"; Rec."PDC Collection/Return")
                {
                    ApplicationArea = All;
                }
                field("PDC Issued"; Rec."PDC Issued")
                {
                    ApplicationArea = All;
                }
                field("PDC Cleared/Returned"; Rec."PDC Cleared/Returned")
                {
                    ApplicationArea = All;
                }
            }
            part(COASetupLines; "COA Setup List")
            {
                ApplicationArea = All;
                Caption = 'COA Setup Lines';
                SubPageLink = "Primary Key" = field("Primary Key");
            }
        }
    }

    trigger OnOpenPage()
    begin
        Rec.Reset;
        if not Rec.Get() then begin
            Rec.Init();
            Rec.Insert();
        end;
    end;
}