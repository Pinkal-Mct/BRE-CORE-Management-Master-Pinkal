codeunit 52001 "Send Expiry Date Email"
{
    procedure SendEmail(Rec: Record "Facility Vendor Profiles"): Text;
    var
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        CompanyInfo: Record "Company Information";
    begin
        if (Rec."Trade License Expiry Date" - 30) = Today then begin
            // Ensure that the correct record is passed and exists
            if CompanyInfo.Get() then begin
                // Create the email message
                EmailMessage.Create(
    Rec."E-mail", // Recipient email
    'Trade License Expiry Reminder - ' + Format(Rec."Vendor ID"),
    '<html><body>' +
    '<p>Dear ' + Rec."Vendor Name" + ',</p>' +
    '<p>This is a friendly reminder that your Trade License is set to expire in <b>30 days</b>.</p>' +
    '<h3>License Details:</h3>' +
    '<b>Vendor ID:</b> ' + Format(Rec."Vendor ID") + '<br/>' +
    '<b>Vendor Name:</b> ' + Rec."Vendor Name" + '<br/>' +
    '<b>Expiry Date:</b> ' + Format(Rec."Trade License Expiry Date", 0, '<Day,2>-<Month,2>-<Year4>') + '<br/>' +
    '<p>Please take the necessary steps to renew your license before the expiration date to avoid any service disruption.</p>' +
    '<p>If you have already initiated the renewal process, kindly ignore this message.</p>' +
    '<p>Best regards,<br/>' +
    CompanyInfo.Name + '</p>' +
    '</body></html>',
    true
);

                // Send the email
                if Email.Send(EmailMessage) then
                    Message('Email sent successfully')
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
        end;
    end;

    procedure SendEmailss(Rec: Record "Facility Vendor Profiles"): Text;
    var
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        CompanyInfo: Record "Company Information";
    begin
        if (Rec."Expiry Date" - 30) = Today then begin
            // Ensure that the correct record is passed and exists
            if CompanyInfo.Get() then begin
                // Create the email message
                EmailMessage.Create(
    Rec."E-mail", // Recipient email
    'Expiry Reminder - ' + Format(Rec."Vendor ID"),
    '<html><body>' +
    '<p>Dear ' + Rec."Vendor Name" + ',</p>' +
    '<p>This is a friendly reminder that your Establishment details is set to expire in <b>30 days</b>.</p>' +
    '<h3>License Details:</h3>' +
    '<b>Vendor ID:</b> ' + Format(Rec."Vendor ID") + '<br/>' +
    '<b>Vendor Name:</b> ' + Rec."Vendor Name" + '<br/>' +
    '<b>Expiry Date:</b> ' + Format(Rec."Expiry Date", 0, '<Day,2>-<Month,2>-<Year4>') + '<br/>' +
    '<p>Please take the necessary steps to renew your o	Establishment details before the expiration date to avoid any service disruption.</p>' +
    '<p>If you have already initiated the renewal process, kindly ignore this message.</p>' +
    '<p>Best regards,<br/>' +
    CompanyInfo.Name + '</p>' +
    '</body></html>',
    true
);

                // Send the email
                if Email.Send(EmailMessage) then
                    Message('Email sent successfully')
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
        end;
    end;
}