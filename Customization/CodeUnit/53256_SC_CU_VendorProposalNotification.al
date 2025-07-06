codeunit 53256 "Vendor Proposal Notification"
{
    procedure SendApprovalEmail(ProposalID: Code[20]; CreatedBy: Code[50]; RemarkText: Text): Text
    var
        VendorProposalRec: Record "Vendor Proposal";
        UserRec: Record User;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
        CompanyInfo: Record "Company Information";
        EmailBody: Text;
        RecipientEmail: Text;
    begin
        if not VendorProposalRec.Get(ProposalID) then
            Error('Vendor Proposal ID %1 not found.', ProposalID);

        // 🔍 Lookup User by Name instead of using Get()
        UserRec.SetRange("User Name", CreatedBy);
        if not UserRec.FindFirst() then
            Error('User "%1" not found in the User table.', CreatedBy);

        RecipientEmail := UserRec."Contact Email";
        if RecipientEmail = '' then
            Error('User "%1" does not have a valid email address.', CreatedBy);

        // ✉️ Compose the email
        if CompanyInfo.Get() then begin
            EmailBody :=
                '<html><body>' +
                '<p>Dear <b>' + CreatedBy + '</b>,</p>' +
                '<p>Your Vendor Proposal ID :-<b>(' + ProposalID + ')</b> has been <b>Approved by the Project Manager</b> with the following Remarks:</p>' +
                '<p><b>Remarks:</b> ' + RemarkText + '</p>' +
                // '<p>' +
                // '<b>Vendor Proposal ID:</b> ' + Format(VendorProposalRec."Proposal ID") + '<br/>' +
                // '<b>Project ID:</b> ' + Format(VendorProposalRec."Project ID") + '<br/>' +
                // '<b>Project Name:</b> ' + VendorProposalRec."Project Name" + '<br/>' +
                // '<b>Start Date:</b> ' + Format(VendorProposalRec."Start Date") + '<br/>' +
                // '<b>End Date:</b> ' + Format(VendorProposalRec."End Date") + '<br/>' +
                // '<b>Total Contract Value:</b> ' + Format(VendorProposalRec."Total Contract Value (AED)") + '</p>' +
                '<p>This is a system-generated email. Please do not reply.</p>' +
                '<p>Thank you.</p>' +
                '</body></html>';

            EmailMessage.Create(
                RecipientEmail,
                'Vendor Proposal Approved - ID: ' + ProposalID,
                EmailBody,
                true
            );

            if not Email.Send(EmailMessage) then
                Error('Failed to send approval email to %1.', CreatedBy);


        end;
        exit(RecipientEmail); // ✅ Return recipient email
    end;



    procedure SendContractApprovalEmail(ContractID: Code[20]; CreatedBy: Code[50]; RemarkText: Text): Text
    var
        VendorContractRec: Record "Vendor Contract";
        UserRec: Record User;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
        CompanyInfo: Record "Company Information";
        EmailBody: Text;
        RecipientEmail: Text;
    begin
        if not VendorContractRec.Get(ContractID) then
            Error('Vendor Contract ID %1 not found.', ContractID);

        // 🛠️ Use SetRange instead of Get for User
        UserRec.SetRange("User Name", CreatedBy);
        if not UserRec.FindFirst() then
            Error('User "%1" not found.', CreatedBy);

        RecipientEmail := UserRec."Contact Email";
        if RecipientEmail = '' then
            Error('No email found for user %1.', CreatedBy);

        if CompanyInfo.Get() then begin
            EmailBody :=
                '<html><body>' +
                '<p>Dear <b>' + CreatedBy + '</b>,</p>' +
                '<p>Your Vendor Contract ID -<b>(' + ContractID + ')</b> has been <b>Approved by the Project Manager</b> with the following Remarks:</p>' +
                '<p><b>Remarks:</b> ' + RemarkText + '</p>' +
                '<p>This is a system-generated email. Please do not reply.</p>' +
                '</body></html>';

            EmailMessage.Create(
                RecipientEmail,
                'Vendor Contract Approved - ID: ' + ContractID,
                EmailBody,
                true
            );

            if not Email.Send(EmailMessage) then
                Error('Failed to send email to %1.', CreatedBy);
        end;

        exit(RecipientEmail); // ✅ Return recipient email
    end;

    procedure SendAssignmentApprovalEmail(AssignmentID: Code[20]; CreatedBy: Code[50]; RemarkText: Text): Text
    var
        AssignmentRec: Record "Vendor Assignment";
        UserRec: Record User;
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
        CompanyInfo: Record "Company Information";
        EmailBody: Text;
        RecipientEmail: Text;
    begin
        if not AssignmentRec.Get(AssignmentID) then
            Error('Assignment ID %1 not found.', AssignmentID);

        // 🛠️ Use SetRange instead of Get for User
        UserRec.SetRange("User Name", CreatedBy);
        if not UserRec.FindFirst() then
            Error('User "%1" not found.', CreatedBy);

        RecipientEmail := UserRec."Contact Email";
        if RecipientEmail = '' then
            Error('No email found for user %1.', CreatedBy);

        if CompanyInfo.Get() then begin
            EmailBody :=
                '<html><body>' +
                '<p>Dear <b>' + CreatedBy + '</b>,</p>' +
                '<p>Your Vendor Assignment ID - <b>(' + AssignmentID + ')</b> has been <b>Approved by the Project Manager</b> with the following Remarks:</p>' +
                '<p><b>Remarks:</b> ' + RemarkText + '</p>' +
                '<p>This is a system-generated email. Please do not reply.</p>' +
                '</body></html>';

            EmailMessage.Create(
                RecipientEmail,
                'Vendor Assignment Approved - ID: ' + AssignmentID,
                EmailBody,
                true
            );

            if not Email.Send(EmailMessage) then
                Error('Failed to send email to %1.', CreatedBy);
        end;
        exit(RecipientEmail); // ✅ Return recipient email
    end;
}
