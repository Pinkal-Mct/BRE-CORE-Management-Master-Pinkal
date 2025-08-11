page 50983 "RevenueAllocationApproval List"
{
    PageType = List;
    SourceTable = "Revenue Allocation Approval";
    ApplicationArea = All;
    Caption = 'Revenue Allocation Approval List';
    UsageCategory = Lists;
    InsertAllowed = false;
    ModifyAllowed = false;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Status"; Rec."Status")
                {
                    ApplicationArea = All;
                    Caption = 'Status';
                    Editable = false;
                    ToolTip = 'Specifies the current status of the record.';
                }
                field("RA_ID"; Rec."RA_ID")
                {
                    ApplicationArea = All;
                    Caption = 'RA_ID';
                    Editable = false;
                    ToolTip = 'Represents the Revenue Allocation ID.';
                }
                field("ID"; Rec."ID")
                {
                    ApplicationArea = All;
                    Caption = 'ID';
                    Editable = false;
                    DrillDown = true;
                    ToolTip = 'Unique identifier for the revenue allocation record. Click to open related details.';


                    trigger OnDrillDown()
                    var
                        revenueallocation: Record "Revenue Allocation Details";
                    begin
                        revenueallocation.SetRange("No.", Rec."ID");
                        if revenueallocation.FindSet() then
                            PAGE.RunModal(PAGE::"Revenue Allocation Card", revenueallocation)
                        else
                            Message('No Revenue Allocation found using FindFirst either.');
                    end;
                }
                field("Financial Year"; Rec."Financial Year")
                {
                    ApplicationArea = All;
                    Caption = 'Financial Year';
                    Editable = false;
                    ToolTip = 'Displays the financial year related to the revenue allocation.';
                }
                field("Month"; Rec."Month")
                {
                    ApplicationArea = All;
                    Caption = 'Month';
                    Editable = false;
                    ToolTip = 'Displays the month associated with the revenue allocation.';
                }

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Image = Approve;
                Visible = IsFinanceManager;
                ToolTip = 'Approve the current request after verification.';


                trigger OnAction()
                var
                    revenueallocation: Record "Revenue Allocation Details";
                    RevenueAllocationPosting: Codeunit "Revenue Allocation Posting";
                    approvalRevenuerequest: Codeunit "Approval Revenue Allocation";
                begin
                    if Rec.Status = Rec.Status::Approved then
                        Error('This entry is already approved');

                    if Confirm('Do you want to approve this entry?') then begin
                        // Update entry status
                        Rec.Status := Rec.Status::Approved;
                        Rec.Modify();

                        if revenueallocation.Get(Rec."ID") then begin
                            revenueallocation.Status := revenueallocation.Status::Approve;
                            approvalRevenuerequest.ApprovalRevenuerequest(Rec);
                            revenueallocation.Modify();

                            RevenueAllocationPosting.PostRevenueAllocation(revenueallocation);
                        end;

                        Message('Entry has been approved successfully!');
                    end;
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Cancel;
                Visible = IsFinanceManager;
                ToolTip = 'Reject the current request as per your review.';

                trigger OnAction()
                var
                    revenueallocation: Record "Revenue Allocation Details";
                    approvalRevenuerequest: Codeunit "Approval Revenue Allocation";
                begin
                    if Rec.Status = Rec.Status::Reject then
                        Error('This entry is already rejected');
                    // Update current record
                    Rec.Status := Rec.Status::Reject;
                    // Rec."Reason for Rejection" := ReasonForRejection;
                    Rec.Modify();

                    // Update Credit Note record
                    if revenueallocation.Get(Rec."ID") then begin
                        revenueallocation.Status := revenueallocation.Status::Reject;
                        approvalRevenuerequest.RejectRevenuerequest(Rec);
                        revenueallocation.Modify();
                    end;

                    Message('Entry has been rejected successfully!');
                end;


            }
        }

    }

    trigger OnOpenPage()
    var

    begin
        // Check if the current user has the 'LEASE_MANAGER' permission set

        IsFinanceManager := VisibleApproveAction();
    end;

    procedure VisibleApproveAction(): Boolean
    var
        UserPersonalization: Record "User Personalization";
    begin

        if UserPersonalization.Get(UserSecurityId()) then
            case UserPersonalization."Profile ID" of
                'PROPERTY MANAGER':
                    exit(false);
                'LEASE_MANAGER':
                    exit(false);
                'finance manager':
                    exit(true);
            end;


        exit(false);
    end;

    var
        IsFinanceManager: Boolean;
}
