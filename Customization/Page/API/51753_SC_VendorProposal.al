namespace BRECOREManagementMastermegha.BRECOREManagementMastermegha;

page 51753 VendorProposalApi
{
    APIGroup = 'vendor';
    APIPublisher = 'RealeststeDev';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'scVendorProposal';
    DelayedInsert = true;
    EntityName = 'vendorProposal';
    EntitySetName = 'vendorProposals';
    PageType = API;
    SourceTable = "Vendor Proposal";
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;


    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(complianceRequired; Rec."Compliance Required")
                {
                    Caption = 'Compliance Required';
                }
                field(createdBy; Rec."Created By")
                {
                    Caption = 'Created By';
                }
                field(createdDateTime; Rec."Created DateTime")
                {
                    Caption = 'Created DateTime';
                }
                field(endDate; Rec."End Date")
                {
                    Caption = 'End Date';
                }
                field(internalApprovalStatus; Rec."Internal Approval Status")
                {
                    Caption = 'Internal Approval Status';
                }
                field(internalRemarks; Rec."Internal Remarks")
                {
                    Caption = 'Internal Remarks';
                }
                field(paymentTerms; Rec."Payment Terms")
                {
                    Caption = 'Payment Terms';
                }
                field(projectID; Rec."Project ID")
                {
                    Caption = 'Project ID';
                }
                field(proposalDate; Rec."Proposal Date")
                {
                    Caption = 'Proposal Date';
                }
                field(proposalID; Rec."Proposal ID")
                {
                    Caption = 'Proposal ID';
                }
                field(quotedPrice; Rec."Quoted Price")
                {
                    Caption = 'Quoted Price';
                }
                field(startDate; Rec."Start Date")
                {
                    Caption = 'Start Date';
                }
                field(systemCreatedAt; Rec.SystemCreatedAt)
                {
                    Caption = 'SystemCreatedAt';
                }
                field(systemCreatedBy; Rec.SystemCreatedBy)
                {
                    Caption = 'SystemCreatedBy';
                }
                field(systemId; Rec.SystemId)
                {
                    Caption = 'SystemId';
                }
                field(systemModifiedAt; Rec.SystemModifiedAt)
                {
                    Caption = 'SystemModifiedAt';
                }
                field(systemModifiedBy; Rec.SystemModifiedBy)
                {
                    Caption = 'SystemModifiedBy';
                }
                field(vendorApprovalStatus; Rec."Vendor Approval Status")
                {
                    Caption = 'Vendor Approval Status';
                }
                field(vendorDesignation; Rec."Vendor Designation")
                {
                    Caption = 'Vendor Designation';
                }
                field(vendorEmail; Rec."Vendor Email")
                {
                    Caption = 'Vendor Email';
                }
                field(vendorID; Rec."Vendor ID")
                {
                    Caption = 'Vendor ID';
                }
                field(vendorName; Rec."Vendor Name")
                {
                    Caption = 'Vendor Name';
                }
                field(vendorRemarks; Rec."Vendor Remarks")
                {
                    Caption = 'Vendor Remarks';
                }
                field(workScope; Rec."Work Scope")
                {
                    Caption = 'Work Scope';
                }
            }
        }
    }
}
