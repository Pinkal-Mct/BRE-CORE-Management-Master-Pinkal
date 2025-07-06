codeunit 53255 "Vendor Assignment Approval"
{


    procedure SubmitVendorAssignment(var VendorProposalRec: Record "Vendor Assignment")
    var
        ApprovalStatusList: Record "Vendor Assignment Approval";
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
        ApprovalStatusList."Vendor Assignment ID" := VendorProposalRec."Assignment ID";
        ApprovalStatusList."Vendor ID" := VendorProposalRec."Vendor/Subcontractor ID";
        ApprovalStatusList."Contract ID" := VendorProposalRec."Contract ID";
        ApprovalStatusList."Created By" := VendorProposalRec."Created By";
        ApprovalStatusList.Status := 'Pending';
        ApprovalStatusList.Insert();

        // 🔄 Update status of Vendor Contract to Pending
        VendorProposalRec."Vendor Assignment Status" := VendorProposalRec."Vendor Assignment Status"::"Pending Approval";
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
                '<p>Dear PROJECT MANAGER,</p>' +
                '<p>This is an automated notification from the system.</p>' +
                '<p>A New Vendor Assignment has been submitted for <b>Vendor Assignment ID - ' + Format(VendorProposalRec."Assignment ID") + '</b>.</p>' +
                '<p>Please review the <b>Vendor Assignment Approval List</b> and take the necessary action.</p>' +
                '<p>This is a system-generated email. Please do not reply.</p>' +
                '<p>Thank you,</p>' +
                '</body></html>';

            EmailMessage.Create(
                EmailList,
                'System Notification: Action Required - Review Vendor Assignment For Approval - Vendor Assignment ID ' + Format(VendorProposalRec."Assignment ID"),
                EmailBody,
                true
            );

            if not Email.Send(EmailMessage) then
                Error('Email failed to send. Please check SMTP settings.');
        end;
    end;
}
