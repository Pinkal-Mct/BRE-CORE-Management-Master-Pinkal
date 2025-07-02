codeunit 52003 "Service Request Approval"
{
    procedure Sendservicerequest(Rec: Record "FM Service Request Header"): Text;
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
             'New Service Request Created - Approval Required',
             '<html><body>' +
             '<p>Dear Finance Manager,</p>' +
             '<p>A new Service Request has been created and requires your approval.</p>' +
             '<h3>Service Request Details:</h3>' +
             '<b>Service Request ID:</b> ' + Format(Rec."Service Request ID") + '<br/>' +
               '<b>Request Date:</b> ' + Format(Rec."Requested Date", 0, '<Day,2>-<Month,2>-<Year4>') + '<br/>' +
             '<b>Contact Name:</b> ' + Rec."Contact Name" + '<br/>' +
              '<b>Contact Phone:</b> ' + Rec."Contact Phone" + '<br/>' +
             '<b>Contact Email:</b> ' + Rec."Contact Email" + '<br/>' +
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


    procedure Approvalservicerequest(Rec: Record "FM Service Request Approval"): Text;
    var
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        CompanyInfo: Record "Company Information";
        UserPersonalizationRec: Record "User Personalization";
        UserRec: Record User; // Record for User
        Username: Text;
        EmailAddress: List of [Text];
    begin
        if Rec."Status" = Rec."Status"::Approved then begin
            // Ensure that the correct record is passed and exists
            if CompanyInfo.Get() then begin
                // Create the email message
                EmailMessage.Create(
     Rec."Contact Email", // Or the person who submitted the Service Request
     'Service Request Approved',
     '<html><body>' +
     '<p>Dear ' + Rec."Contact Name" + ',</p>' +
     '<p>We are pleased to inform you that your Service Request has been reviewed and <b>approved</b>.</p>' +
    '<h3>Service Request Details:</h3>' +
     '<b>Service Request ID:</b> ' + Format(Rec."Service Request ID") + '<br/>' +
               '<b>Request Date:</b> ' + Format(Rec."Requested Date", 0, '<Day,2>-<Month,2>-<Year4>') + '<br/>' +
             '<b>Contact Name:</b> ' + Rec."Contact Name" + '<br/>' +
              '<b>Contact Phone:</b> ' + Rec."Contact Phone" + '<br/>' +
             '<b>Contact Email:</b> ' + Rec."Contact Email" + '<br/>' +
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


    procedure Rejectservicerequest(Rec: Record "FM Service Request Approval"): Text;
    var
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        CompanyInfo: Record "Company Information";
        UserPersonalizationRec: Record "User Personalization";
        UserRec: Record User; // Record for User
        Username: Text;
        EmailAddress: List of [Text];
    begin
        if Rec."Status" = Rec."Status"::Rejected then begin
            // Ensure that the correct record is passed and exists
            if CompanyInfo.Get() then begin
                // Create the email message

                EmailMessage.Create(
       Rec."Contact Email", // Or the person who submitted the Service Request
     'Service Request Rejected',
     '<html><body>' +
     '<p>Dear ' + Rec."Contact Name" + ',</p>' +
     '<p>We regret to inform you that your Service Request has been <b>rejected</b> after review.</p>' +
    '<h3>Service Request Details:</h3>' +
     '<b>Service Request ID:</b> ' + Format(Rec."Service Request ID") + '<br/>' +
               '<b>Request Date:</b> ' + Format(Rec."Requested Date", 0, '<Day,2>-<Month,2>-<Year4>') + '<br/>' +
             '<b>Contact Name:</b> ' + Rec."Contact Name" + '<br/>' +
              '<b>Contact Phone:</b> ' + Rec."Contact Phone" + '<br/>' +
             '<b>Contact Email:</b> ' + Rec."Contact Email" + '<br/>' +
     '<p>Please review the feedback and resubmit your request if applicable.</p>' +
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