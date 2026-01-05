page 53751 "No. Series Setup"
{
    PageType = Card;
    SourceTable = "No. Series Setup";
    Caption = 'No. Series Setup';
    ApplicationArea = All;
    DeleteAllowed = false;
    InsertAllowed = false;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group("Property Management")
            {
                field("Payment Receipt ID Nos."; Rec."Payment Receipt ID Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Payment Receipt number series.';
                }
                field("Management Fee Master"; Rec."Management Fee Master")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Management fee master series.';
                }
            }
            group("Sales Management")
            {

                Caption = 'No. Series Setup';
                Visible = false;
                field("Construction Project Nos."; Rec."Construction Project Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the construction project number series.';
                }
                field("Vendor Assignment Nos."; Rec."Vendor Assignment Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor assignment number series.';
                }
                field("Milestone Nos."; Rec."Milestone Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the milestone number series.';
                }
                field("Milestone Task Nos."; Rec."Milestone Task Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the milestone task number series.';
                }
                field("Milestone Sub Task Nos."; Rec."Milestone Sub Task Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the milestone sub-task number series.';
                }
                field("Vendor Profile Nos."; Rec."Vendor Profile Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor profile number series.';
                }

                // This field is used to store the vendor proposal number series. Table 53105 "Vendor Proposal" has a field for vendor proposal numbers.
                field("Vendor Proposal Nos."; Rec."Vendor Proposal Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor proposal number series.';
                }
                // This field is used to store the vendor proposal number series. Table 53105 "Vendor Proposal" has a field for vendor proposal numbers.

                // This field is used to store the vendor contract number series. Table 53106 "Vendor Contract" has a field for vendor contract numbers.
                field("Vendor Contract Nos."; Rec."Vendor Contract Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the vendor contract number series.';
                }
                field("Lead ID"; Rec."Lead ID Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Lead ID';
                    ToolTip = 'Specifies the Lead number series';
                }
                field("Opportunity ID Nos."; Rec."Opportunity ID Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Opportunity Master number series.';
                }
                field("Project Budget ID Nos."; Rec."Project Budget ID Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Project Budget Master number series.';
                }
                // This field is used to store the vendor contract number series. Table 53106 "Vendor Contract" has a field for vendor contract numbers.
                field("Client Info ID Nos."; Rec."Client Info ID Nos.")
                {
                    ApplicationArea = All;
                    Caption = 'Client Info ID';
                    ToolTip = 'Specifies the Client number series';
                }
                field("Sales Proposal ID Nos."; Rec."Sales Proposal ID Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Sales Proposal number series.';
                    Caption = 'Sales Proposal ID';
                }
                field("Customer Eligibility ID Nos."; Rec."Customer Eligibility ID Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Customer Eligibility number series.';
                    Caption = 'Customer Eligibility ID';
                }

            }
            group("Facility Management")
            {
                Visible = false;
                field("OEM ID Nos."; Rec."OEM ID Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the OEM Master number series.';
                }
                field("Equipment ID Nos."; Rec."Equipment ID Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Equipment Master number series.';
                }
                field("Part ID Nos."; Rec."Part ID Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Part Master number series.';
                }
                field("Sub-Equipment ID Nos."; Rec."Sub-Equipment ID Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Sub-Equipmen Master number series.';
                }
                field("Service Request ID Nos."; Rec."Service Request ID Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Service Request Master number series.';
                }
                // field("Fixed Asset ID Nos."; Rec."Fixed Asset ID Nos.")
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'Specifies the Fixed Asset Master number series.';
                // }
                field("Service Type ID Nos."; Rec."Service Type ID Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Service Type Master number series.';
                }
                field("Service Sub-Type ID Nos."; Rec."Service Sub-Type ID Nos.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the Service Sub-Type Master number series.';
                }

            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action(Refresh)
            {
                ApplicationArea = All;
                Caption = 'Refresh';
                Image = Refresh;
                ToolTip = 'Refresh the page to see the latest data.';
                trigger OnAction()
                begin
                    CurrPage.Update();
                end;
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