codeunit 52002 "Approval Vendor Profile"
{
    procedure SendApprovalrequest(Rec: Record "Approval Vendor Profile"): Text;
    var
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        CompanyInfo: Record "Company Information";
        UserPersonalizationRec: Record "User Personalization";
        UserRec: Record User; // Record for User
        Username: Text;
        EmailAddress: List of [Text];
    begin
        UserPersonalizationRec.SetRange("Profile ID", 'FINANCE MANAGER');
        if UserPersonalizationRec.FindSet() then begin
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then
                    if UserRec."Contact Email" <> '' then
                        EmailAddress.Add(UserRec."Contact Email");
                Username := UserRec."User Name";
            until UserPersonalizationRec.Next() = 0;
        end;

        EmailMessage.Create(
             EmailAddress,
             'New Vendor Profile Created - Approval Required',
             '<html><body>' +
             '<p>Dear Finance Manager,</p>' +
             '<p>A new vendor profile has been created and requires your approval.</p>' +
             '<h3>Vendor Details:</h3>' +
             '<b>Vendor ID:</b> ' + Format(Rec."Vendor ID") + '<br/>' +
             '<b>Vendor Name:</b> ' + Rec."Vendor Name" + '<br/>' +
             '<b>Vendor Email:</b> ' + Rec."E-mail" + '<br/>' +
             '<p>Please log in to Business Central to review and take the necessary action.</p>' +
             '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
             '</body></html>',
             true
         );

        if Email.Send(EmailMessage) then
            Message('Email sent successfully')
        else
            Error('Failed to send email. Please verify SMTP settings and email addresses.');
    end;


    procedure Approvalrequest(Rec: Record "Approval Vendor Profile"): Text;
    var
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        CompanyInfo: Record "Company Information";
        UserPersonalizationRec: Record "User Personalization";
        UserRec: Record User; // Record for User
        Username: Text;
        EmailAddress: List of [Text];
    begin
        if Rec.Status = Rec.Status::Approved then begin
            // Ensure that the correct record is passed and exists
            if CompanyInfo.Get() then begin
                // Create the email message
                EmailMessage.Create(
     Rec."E-mail", // Or the person who submitted the vendor profile
     'Vendor Profile Approved',
     '<html><body>' +
     '<p>Dear ' + Rec."Vendor Name" + ',</p>' +
     '<p>We are pleased to inform you that your vendor profile has been reviewed and <b>approved</b>.</p>' +
     '<h3>Vendor Details:</h3>' +
     '<b>Vendor ID:</b> ' + Format(Rec."Vendor ID") + '<br/>' +
     '<b>Vendor Name:</b> ' + Rec."Vendor Name" + '<br/>' +
     '<b>Approval Date:</b> ' + Format(CurrentDateTime, 0, '<Day,2>-<Month,2>-<Year4>') + '<br/>' +
     '<p>You can now proceed with transactions in Business Central.</p>' +
     '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
     '</body></html>',
     true
 );

                if Email.Send(EmailMessage) then
                    Message('Email sent successfully')
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
        end;
    end;


    procedure Rejectrequest(Rec: Record "Approval Vendor Profile"): Text;
    var
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        CompanyInfo: Record "Company Information";
        UserPersonalizationRec: Record "User Personalization";
        UserRec: Record User; // Record for User
        Username: Text;
        EmailAddress: List of [Text];
    begin
        if Rec.Status = Rec.Status::Rejected then begin
            // Ensure that the correct record is passed and exists
            if CompanyInfo.Get() then begin
                // Create the email message

                EmailMessage.Create(
     Rec."E-mail", // Or the person who submitted the vendor profile
     'Vendor Profile Rejected',
     '<html><body>' +
     '<p>Dear ' + Rec."Vendor Name" + ',</p>' +
     '<p>We regret to inform you that your vendor profile has been <b>rejected</b> after review.</p>' +
     '<h3>Vendor Details:</h3>' +
     '<b>Vendor ID:</b> ' + Format(Rec."Vendor ID") + '<br/>' +
     '<b>Vendor Name:</b> ' + Rec."Vendor Name" + '<br/>' +
     '<b>Rejection Date:</b> ' + Format(CurrentDateTime, 0, '<Day,2>-<Month,2>-<Year4>') + '<br/>' +
     '<p>Please review the feedback and resubmit your profile if applicable.</p>' +
     '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
     '</body></html>',
     true
 );
                if Email.Send(EmailMessage) then
                    Message('Email sent successfully')
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
        end;
    end;
}