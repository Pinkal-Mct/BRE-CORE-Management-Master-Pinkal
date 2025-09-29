codeunit 50910 "OverduePaymentReq"
{
    procedure SendApprovalrequest(Rec: Record "OverDuePaymentmode"): Text;
    var
        CompanyInfo: Record "Company Information";
        UserPersonalizationRec: Record "User Personalization";
        UserRec: Record User; // Record for User
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        Username: Text;
        EmailAddress: List of [Text];
    begin
        UserPersonalizationRec.SetRange("Profile ID", 'FINANCE MANAGER');
        if UserPersonalizationRec.FindSet() then
            repeat
                if UserRec.Get(UserPersonalizationRec."User SID") then
                    if UserRec."Contact Email" <> '' then
                        EmailAddress.Add(UserRec."Contact Email");
                Username := UserRec."User Name";
            until UserPersonalizationRec.Next() = 0;


        EmailMessage.Create(
             EmailAddress,
             'New Overdue Payment Request Created - Approval Required',
             '<html><body>' +
             '<p>Dear Finance Manager,</p>' +
             '<p>A new OverDue Payment Request has been created and requires your approval.</p>' +
             '<h3>Payment Details:</h3>' +
             '<b>Contract ID:</b> ' + Format(Rec."Contract ID") + '<br/>' +
             '<b>Payment Series:</b> ' + Rec."Payment Series" + '<br/>' +
             '<b>Due Date:</b> ' + Format(Rec."Due Date") + '<br/>' +
              '<b>Payment Status:</b> ' + Format(Rec."Payment Status") + '<br/>' +
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
}