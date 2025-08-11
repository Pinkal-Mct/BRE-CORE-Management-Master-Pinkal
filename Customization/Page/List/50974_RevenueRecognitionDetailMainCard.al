page 50974 "Revenue Recognition Detail Sub"
{

    PageType = ListPart;
    ApplicationArea = All;
    SourceTable = "Revenue Recognition Details";
    Caption = 'Revenue Recognition Details';

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
                    Visible = false;
                    ToolTip = 'Specifies the entry number for the record.';
                }

                field("Description"; Rec."Description")
                {
                    ApplicationArea = All;
                    ToolTip = 'Provides a description of the record.';
                }
                field("Unit Type"; Rec."Unit Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of unit (e.g., residential, commercial).';
                }
                field("Item Type"; Rec."Item Type")
                {
                    ApplicationArea = All;
                    ToolTip = 'Indicates the item type associated with the unit.';
                }
                field("Property Name"; Rec."Property Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Shows the name of the property.';
                }
                field("Single Unit Names"; Rec."Single Unit Names")
                {
                    ApplicationArea = All;
                    ToolTip = 'Lists the individual unit names involved.';
                }
                field("Contract Id"; Rec."Contract Id")
                {
                    ApplicationArea = All;
                    ToolTip = 'Unique identifier of the tenancy contract.';
                }
                field("Contract Tenure"; Rec."Contract Tenure")
                {
                    ApplicationArea = All;
                    ToolTip = 'Duration of the contract in months or years.';
                }
                field("Customer Name"; Rec."Customer Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the customer associated with the contract.';
                }
                field("Contract Start Date"; Rec."Contract Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Start date of the contract.';
                }
                field("Contract End Date"; Rec."Contract End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'End date of the contract.';
                }
                field("Grace Days"; Rec."Grace Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of grace days allowed in the contract.';
                }
                field("Grace Start Date"; Rec."Grace Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Start date of the grace period.';
                }
                field("Grace End Date"; Rec."Grace End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'End date of the grace period.';
                }
                field("Termination Date"; Rec."Termination Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Date on which the contract was terminated.';
                }
                field("Suspension Start Date"; Rec."Suspension Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Start date of the suspension period.';
                }
                field("Suspension End Date"; Rec."Suspension End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'End date of the suspension period.';
                }
                field("Multi Year Start Date"; Rec."Multi Year Start Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'Start date of the multi-year agreement.';
                }
                field("Multi Year End Date"; Rec."Multi Year End Date")
                {
                    ApplicationArea = All;
                    ToolTip = 'End date of the multi-year agreement.';
                }
                field("Contract Amount"; Rec."Contract Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total value of the contract.';
                }
                field("Annual Amount"; Rec."Annual Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Annual rent amount in the contract.';
                }
                field("Posting Month"; Rec."Posting Month")
                {
                    ApplicationArea = All;
                    ToolTip = 'Month for which the rent is posted.';
                }
                field("Posting Year"; Rec."Posting Year")
                {
                    ApplicationArea = All;
                    ToolTip = 'Year for which the rent is posted.';
                }
                field("Posting Period"; Rec."Posting Period")
                {
                    ApplicationArea = All;
                    ToolTip = 'Posting period for financial reporting.';
                }
                field("Final Annual Amount"; Rec."Final Annual Amount")
                {
                    ApplicationArea = All;
                    ToolTip = 'Final calculated annual rent after adjustments.';
                }
                field("No Of Days"; Rec."No Of Days")
                {
                    ApplicationArea = All;
                    ToolTip = 'Number of days used in rent calculation.';
                }
                field("Per Day Rent"; Rec."Per Day Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Rent amount per day.';
                }
                field("Per Month Rent"; Rec."Per Month Rent")
                {
                    ApplicationArea = All;
                    ToolTip = 'Rent amount per month.';
                }
                field("Total Value"; Rec."Total Value")
                {
                    ApplicationArea = All;
                    ToolTip = 'Total value calculated for the given period.';
                }
                field("Owner Name"; Rec."Owner Name")
                {
                    ApplicationArea = All;
                    ToolTip = 'Name of the property owner.';
                }
                field("Owner Share"; Rec."Owner Share")
                {
                    ApplicationArea = All;
                    ToolTip = 'Share of the owner in the rent.';
                }
            }
            // group(" ")
            // {
            //     field("Total Amount"; totalamounts)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Total Amount';
            //         Editable = false;
            //     }
            //     field("Total Contract Amount"; totalcontractAmounts)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Total Contract Amount';
            //         Editable = false;
            //     }
            // }

            // group("Final Amount")
            // {
            //     field("Total Amounts"; totalcombineamounts)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Total Amount';
            //         Editable = false;
            //     }
            //     field("Total Contract Amounts"; totalcombinecontractAmounts)
            //     {
            //         ApplicationArea = All;
            //         Caption = 'Total Contract Amount';
            //         Editable = false;
            //     }
            // }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GenerateExcel)
            {
                Caption = 'Generate Excel';
                ApplicationArea = All;
                Image = ExportToExcel;
                ToolTip = 'Generate an Excel report for the unearned other charges revenue.';

                trigger OnAction()
                var
                    createExcelReport: Codeunit "Create Excel Report";
                begin
                    createExcelReport.GenerateExcelReportForAnyTable(50962, 50123, Rec."RR_No.");
                end;
            }
        }
    }


    // procedure CalculateAndStoreTotalRevenue()
    // var
    //     revenueItemLine: Record "Revenue Recognition Details";
    //     revenueAllocLine: Record "Revenue Allocation Subgrid";
    // begin
    //     Clear(totalcontractAmounts);
    //     Clear(totalamounts);

    //     revenueItemLine.SetRange("RR_No.", RRID);
    //     if revenueItemLine.FindSet() then
    //         repeat
    //             totalcontractAmounts += revenueItemLine."Contract Amount";
    //             totalamounts += revenueItemLine."Total Value";
    //         until revenueItemLine.Next() = 0;


    //     revenueAllocLine.SetRange("Header No.", RRID);
    //     if revenueAllocLine.FindSet() then
    //         repeat
    //             totalcontractAmount += revenueAllocLine."Contract Amount";
    //             totalamount += revenueAllocLine."Total Value";
    //             totalannualamount += revenueAllocLine."Annual Amount";
    //             totalfinalannualamount += revenueAllocLine."Final Annual Amount";
    //         until revenueAllocLine.Next() = 0;


    //     totalcombinecontractAmounts := totalcontractAmount + totalcontractAmounts;
    //     totalcombineamounts := totalamount + totalamounts;
    // end;

    procedure SetRIID(pRRID: Integer)
    begin
        RRID := pRRID;

    end;


    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin

        Rec."RR_No." := RRID;
        // CalculateAndStoreTotalRevenue();
    end;

    // trigger OnAfterGetCurrRecord()
    // begin
    //     CalculateAndStoreTotalRevenue();
    // end;

    var
        RRID: Integer;

    //     totalcontractAmount: Decimal;
    //     totalamount: Decimal;
    //     totalannualamount: Decimal;
    //     totalfinalannualamount: Decimal;

    //     totalcontractAmounts: Decimal;
    //     totalamounts: Decimal;

    //     totalcombinecontractAmounts: Decimal;
    //     totalcombineamounts: Decimal;
}