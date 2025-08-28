namespace BRECOREManagementMastermegha.BRECOREManagementMastermegha;

page 54001 VendorContract
{
    APIGroup = 'vendor';
    APIPublisher = 'realestste';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'scVendorContract';
    DelayedInsert = true;
    EntityName = 'vendorContract';
    EntitySetName = 'vendorContracts';
    PageType = API;
    SourceTable = "Vendor Contract";
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(advancePayment; Rec."Advance Payment (%)")
                {
                    Caption = 'Advance Payment (%)';
                }
                field(complianceRequired; Rec."Compliance Required")
                {
                    Caption = 'Compliance Required';
                }
                field(contractDate; Rec."Contract Date")
                {
                    Caption = 'Contract Date';
                }
                field(contractEndDate; Rec."Contract End Date")
                {
                    Caption = 'Contract End Date';
                }
                field(contractID; Rec."Contract ID")
                {
                    Caption = 'Contract ID';
                }
                field(contractStartDate; Rec."Contract Start Date")
                {
                    Caption = 'Contract Start Date';
                }
                field(createdBy; Rec."Created By")
                {
                    Caption = 'Created By';
                }
                field(deliveryDate; Rec."Delivery Date")
                {
                    Caption = 'Delivery Date';
                }
                field(deliveryLocation; Rec."Delivery Location")
                {
                    Caption = 'Delivery Location';
                }
                field(description; Rec.Description)
                {
                    Caption = 'Description';
                }
                field(disputeResolution; Rec."Dispute Resolution")
                {
                    Caption = 'Dispute Resolution';
                }
                field("duration"; Rec."Duration")
                {
                    Caption = 'Duration';
                }
                field(finalPayment; Rec."Final Payment (%)")
                {
                    Caption = 'Final Payment (%)';
                }
                field(incoterms; Rec.Incoterms)
                {
                    Caption = 'Incoterms';
                }
                field(industryStandards; Rec."Industry Standards")
                {
                    Caption = 'Industry Standards';
                }
                field(interimPayment; Rec."Interim Payment (%)")
                {
                    Caption = 'Interim Payment (%)';
                }
                field(internalApprovalStatus; Rec."Internal Approval Status")
                {
                    Caption = 'Internal Approval Status';
                }
                field(internalRemarks; Rec."Internal Remarks")
                {
                    Caption = 'Internal Remarks';
                }
                field(lateDeliveryPenalty; Rec."Late Delivery Penalty %")
                {
                    Caption = 'Late Delivery Penalty %';
                }
                field(paymentMethod; Rec."Payment Method")
                {
                    Caption = 'Payment Method';
                }
                field(paymentTerms; Rec."Payment Terms")
                {
                    Caption = 'Payment Terms';
                }
                field(projectID; Rec."Project ID")
                {
                    Caption = 'Project ID';
                }
                field(projectLocation; Rec."Project Location")
                {
                    Caption = 'Project Location';
                }
                field(projectName; Rec."Project Name")
                {
                    Caption = 'Project Name';
                }
                field(proposalID; Rec."Proposal ID")
                {
                    Caption = 'Proposal ID';
                }
                field(serviceType; Rec."Service Type")
                {
                    Caption = 'Service Type';
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
                field(totalContractValueAED; Rec."Total Contract Value (AED)")
                {
                    Caption = 'Total Contract Value (AED)';
                }
                field(uaeComplianceRequirements; Rec."UAE Compliance Requirements")
                {
                    Caption = 'UAE Compliance Requirements';
                }
                field(vat; Rec."VAT %")
                {
                    Caption = 'VAT %';
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
                field(warrantyPeriodMonths; Rec."Warranty Period (Months)")
                {
                    Caption = 'Warranty Period (Months)';
                }
                field(workScope; Rec."Work Scope")
                {
                    Caption = 'Work Scope';
                }
            }
        }
    }
}
