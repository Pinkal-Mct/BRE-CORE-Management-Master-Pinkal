codeunit 53254 "Approval Vendor Contract"
{
    procedure SubmitVendorContract(var VendorContractRec: Record "Vendor Contract")
    var
        ApprovalStatusList: Record "Vendor Contract Approval";
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
        ApprovalStatusList."Vendor Contract ID" := VendorContractRec."Contract ID";
        ApprovalStatusList."Vendor ID" := VendorContractRec."Vendor ID";
        ApprovalStatusList."Created By" := VendorContractRec."Created By";

        ApprovalStatusList.Status := 'Pending';
        ApprovalStatusList.Insert();

        // 🔄 Update status of Vendor Contract to Pending
        VendorContractRec."Internal Approval Status" := VendorContractRec."Internal Approval Status"::Pending;
        VendorContractRec.Modify();

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
                '<p>A new vendor contract has been submitted with the following details:</p>' +
                '<p>' +
                '<b>Vendor Contract ID:</b> ' + Format(VendorContractRec."Contract ID") + '<br/>' +
                 '<b>Project ID:</b> ' + Format(VendorContractRec."Project ID") + '<br/>' +
                '<b>Project Name:</b> ' + VendorContractRec."Project Name" + '<br/>' +
                '<b>Project Location:</b> ' + VendorContractRec."Project Location" + '<br/>' +
                '<b>Contract Start Date:</b> ' + Format(VendorContractRec."Contract Start Date") + '<br/>' +
                '<b>Contract End Date:</b> ' + Format(VendorContractRec."Contract End Date") + '<br/>' +
                '<b>Total Contract Value </b> ' + Format(VendorContractRec."Total Contract Value (AED)") + '<br/>' +
                '</p>' +
                '<p>Please review the <b>Vendor Contract Approval List</b> and take the necessary action.</p>' +
                '<p>This is a system-generated email. Please do not reply.</p>' +
                '<p>Thank you,</p>' +
                '</body></html>';



            EmailMessage.Create(
                    EmailList,
                    'System Notification: Action Required - Review Vendor Contract For Approval - Vendor Contract ID ' + Format(VendorContractRec."Contract ID"),
                    EmailBody,
                    true
                );

            if not Email.Send(EmailMessage) then
                Error('Email failed to send. Please check SMTP settings.');
        end;
    end;
}
