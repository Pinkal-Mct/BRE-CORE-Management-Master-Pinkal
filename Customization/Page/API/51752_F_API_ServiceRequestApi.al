page 51752 "Service Request Api"
{
    APIGroup = 'tenants';
    APIPublisher = 'RealeststeDev';
    APIVersion = 'v2.0';
    ApplicationArea = All;
    Caption = 'serviceRequestApi';
    DelayedInsert = true;
    EntityName = 'serviceRequest';
    EntitySetName = 'serviceRequests';
    PageType = API;
    SourceTable = "FM Service Request Header";
    ODataKeyFields = SystemId;
    DeleteAllowed = true;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(approvalStatus; Rec."Approval Status")
                {
                    Caption = 'Approval Status';
                }
                field(approvedBy; Rec."Approved By")
                {
                    Caption = 'Approved By';
                }
                field(approvedDate; Rec."Approved Date")
                {
                    Caption = 'Approved Date';
                }
                field(assetID; Rec."Asset ID")
                {
                    Caption = 'Asset ID';
                }
                field(assignedWorkOrderID; Rec."Assigned Work Order ID")
                {
                    Caption = 'Assigned Work Order ID';
                }
                field(contactEmail; Rec."Contact Email")
                {
                    Caption = 'Contact Email';
                }
                field(contactName; Rec."Contact Name")
                {
                    Caption = 'Contact Name';
                }
                field(contactPhone; Rec."Contact Phone")
                {
                    Caption = 'Contact Phone';
                }
                field(createdBy; Rec."Created By")
                {
                    Caption = 'Created By';
                }
                field(createdDateTime; Rec."Created DateTime")
                {
                    Caption = 'Created DateTime';
                }
                field(lastModifiedBy; Rec."Last Modified By")
                {
                    Caption = 'Last Modified By';
                }
                field(lastModifiedDateTime; Rec."Last Modified DateTime")
                {
                    Caption = 'Last Modified DateTime';
                }
                field(preferredServiceDate; Rec."Preferred Service Date")
                {
                    Caption = 'Preferred Service Date';
                }
                field(preferredTimeSlot; Rec."Preferred Time Slot")
                {
                    Caption = 'Preferred Time Slot';
                }
                field(problemDescription; Rec."Problem Description")
                {
                    Caption = 'Problem Description';
                }
                field(propertyCode; Rec."Property Code")
                {
                    Caption = 'Property Code';
                }
                field(requestStatus; Rec."Request Status")
                {
                    Caption = 'Request Status';
                }
                field(requestedByTenantContact; Rec."Requested By(Tenant / Contact)")
                {
                    Caption = 'Requested By(Tenant / Contact)';
                }
                field(requestedDate; Rec."Requested Date")
                {
                    Caption = 'Requested Date';
                }
                field(serviceCategory; Rec."Service Category")
                {
                    Caption = 'Service Category';
                }
                field(serviceRequestID; Rec."Service Request ID")
                {
                    Caption = 'Service Request ID';
                }
                field(serviceSubType; Rec."Service Sub-Type")
                {
                    Caption = 'Service Sub-Type';
                }
                field(submissionSource; Rec."Submission Source")
                {
                    Caption = 'Submission Source';
                }
                field(submittedByUserID; Rec."Submitted By (User ID)")
                {
                    Caption = 'Submitted By (User ID)';
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
                field(unitFlatNo; Rec."Unit/Flat No.")
                {
                    Caption = 'Unit/Flat No.';
                }
                field(urgencyLevel; Rec."Urgency Level")
                {
                    Caption = 'Urgency Level';
                }
            }
        }
    }
}
