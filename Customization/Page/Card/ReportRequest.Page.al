page 50433 "Report Request"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(SelectReport)
            {
                Caption = 'Select Report';
                field("Report Type"; reportType)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the type of report to be generated.';
                    Caption = 'Report Type';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(GenerateReport)
            {
                ApplicationArea = All;
                Caption = 'Generate Report';
                ToolTip = 'Generates the selected report type.';
                Image = SelectReport;
                trigger OnAction()
                begin
                    case reportType of
                        Enum::"Report Type"::"Security Deposit Report":
                            Report.Run(Report::"Security Deposit");
                        Enum::"Report Type"::"PDC Transaction Report":
                            Report.Run(Report::"PDC Transaction Report");
                        Enum::"Report Type"::"Contract Master Data Report":
                            Report.Run(Report::ContractMasterData);
                        Enum::"Report Type"::"Revenue Allocation Report":
                            RedirectToRevenueAlloationReport();
                        Enum::"Report Type"::"Unearned Revenue Report":
                            RedirectToUnearnedRevenueReport();
                        else
                            Error('Please select a valid report type.');
                    end;
                end;
            }
        }

        area(Promoted)
        {
            actionref(Generate_Report; GenerateReport) { }
        }
    }

    var
        reportType: Enum "Report Type";

    procedure RedirectToRevenueAlloationReport()
    begin

    end;

    procedure RedirectToUnearnedRevenueReport()
    var
        unearnedRevenueReport: Record "Unearned Revenue Report";
        unearnedRevenueCard: Page "Unearned Revenue Report Card";
    begin
        if unearnedRevenueReport.FindFirst() then begin
            unearnedRevenueCard.SetRecord(unearnedRevenueReport);
            unearnedRevenueCard.Run();
        end else
            Error('No unearned revenue report data found.');
    end;
}