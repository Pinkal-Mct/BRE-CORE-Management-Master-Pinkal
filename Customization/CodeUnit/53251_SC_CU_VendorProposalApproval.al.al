codeunit 53251 "Approval Vendor Proposal"
{
    procedure SubmitVendorProposal(var VendorProposalRec: Record "Vendor Proposal")
    var
        ApprovalStatusList: Record "Vendor Proposal Approval";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
        UserPersonalizationRec: Record "User Personalization";
        UserRec: Record User;
        EmailList: List of [Text];
        LeaseManagerName: Text;
        CompanyInfo: Record "Company Information";
        EmailBody: Text;
    begin
        // Insert new record in Approval Request list
        ApprovalStatusList.Init();
        ApprovalStatusList."Vendor Proposal ID" := VendorProposalRec."Proposal ID";
        ApprovalStatusList."Vendor ID" := VendorProposalRec."Vendor ID";
        ApprovalStatusList."Created By" := VendorProposalRec."Created By";

        ApprovalStatusList.Status := 'Pending';
        ApprovalStatusList.Insert();

        // 🔄 Update status of Vendor Contract to Pending
        VendorProposalRec."Internal Approval Status" := VendorProposalRec."Internal Approval Status"::Pending;
        VendorProposalRec.Modify();

        // Prepare email to Lease Managers
        LeaseManagerName := '';

        UserPersonalizationRec.SetRange("Profile ID", 'PROJECT MANAGER');
        if UserPersonalizationRec.FindSet() then
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then
                    if UserRec."Contact Email" <> '' then begin
                        EmailList.Add(UserRec."Contact Email");
                        if LeaseManagerName = '' then
                            LeaseManagerName := UserRec."User Name"
                        else
                            LeaseManagerName += ', ' + UserRec."User Name";
                    end;
            until UserPersonalizationRec.Next() = 0;

        if EmailList.Count = 0 then
            Error('No valid email addresses found for PROJECT MANAGER.');

        if CompanyInfo.Get() then begin
            EmailBody :=
                '<html><body>' +
                '<p>Dear <b>PROJECT MANAGER</b>,</p>' +
                '<p>This is an automated notification from the system.</p>' +
                '<p>A new vendor proposal has been submitted with the following details:</p>' +
                '<p>' +
                '<b>Vendor Proposal ID:</b> ' + Format(VendorProposalRec."Proposal ID") + '<br/>' +
                '<b>Project ID:</b> ' + Format(VendorProposalRec."Project ID") + '<br/>' +
                '<b>Project Name:</b> ' + VendorProposalRec."Project Name" + '<br/>' +
                '<b>Project Location:</b> ' + VendorProposalRec."Project Location" + '<br/>' +
                '<b>Proposed Contract Start Date:</b> ' + Format(VendorProposalRec."Start Date") + '<br/>' +
                '<b>Proposed Contract End Date:</b> ' + Format(VendorProposalRec."End Date") + '<br/>' +
                '<b>Total Contract Value </b> ' + Format(VendorProposalRec."Total Contract Value (AED)") + '<br/>' +
                '</p>' +
                '<p>Please review the <b>Vendor Proposal Approval List</b> and take the necessary action.</p>' +
                '<p>This is a system-generated email. Please do not reply.</p>' +
                '<p>Thank you,</p>' +
                '</body></html>';



            EmailMessage.Create(
                    EmailList,
                    'System Notification: Action Required - Review Vendor Proposal For Approval - Vendor ID ' + Format(VendorProposalRec."Vendor ID"),
                    EmailBody,
                    true
                );

            if not Email.Send(EmailMessage) then
                Error('Email failed to send. Please check SMTP settings.');
        end;
    end;

}
