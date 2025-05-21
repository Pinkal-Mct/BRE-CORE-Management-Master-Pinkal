codeunit 50301 "Send PaymentMode Email"
{
    procedure SendEmail(Rec: Record "Payment Mode2"): Text;
    var
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        CompanyInfo: Record "Company Information";
    begin
        if Rec."Payment Status" = Rec."Payment Status"::Received then begin
            // Ensure that the correct record is passed and exists
            if CompanyInfo.Get() then begin
                // Create the email message
                EmailMessage.Create(
                    Rec."Tenant Email", // The recipient's email address
                    'Payment Mode Details - ' + Format(Rec."Contract ID"),
                    '<html><body>' +
                    '<p>Dear ' + Rec."Tenant Name" + ',</p>' +
                    '<p>I hope this message finds you well. We confirm the receipt of your payment towards Rent/Charges.</p>' +
                    '<h3>Details of the Payment:</h3>' +
                    '<b>Contract ID:</b> ' + Format(Rec."Contract ID") + '<br/>' +
                    '<b>Payment ID:</b> ' + Rec."Payment Series" + '<br/>' +
                    '<b>Amount Including VAT:</b> ' + Format(Rec."Amount Including VAT") + '<br/>' +
                    '<b>Due Date:</b> ' + Format(Rec."Due Date", 0, '<Day,2>-<Month,2>-<Year4>') + '<br/>' +
                    '<b>Payment Mode:</b> ' + Rec."Payment Mode" + '<br/>' +
                      '<b>Payment Status:</b> ' + Format(Rec."Payment Status") + '</p>' +
                    '<p>Kindly review the information provided and let us know if you have any questions or need further clarification.</p>' +
                    '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                    '</body></html>',
                    true
                );

                // Send the email
                if Email.Send(EmailMessage) then
                    Message('Email sent successfully for Payment Mode: %1', Rec."Tenant Email")
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
        end;
    end;

    procedure SendEmailCancelled(Rec: Record "Payment Mode2"): Text;
    var
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        CompanyInfo: Record "Company Information";
    begin
        // Similar structure for cancelled status
        if Rec."Payment Status" = Rec."Payment Status"::Cancelled then begin
            if CompanyInfo.Get() then begin
                // Create the email message
                EmailMessage.Create(
                    Rec."Tenant Email", // The recipient's email address
                    'Payment Mode Details - ' + Format(Rec."Contract ID"),
                    '<html><body>' +
                    '<p>Dear ' + Rec."Tenant Name" + ',</p>' +
                    '<p>I hope this message finds you well. This is to inform you that your payment towards Rent/Charges is Cancelled.</p>' +
                    '<h3>Details of the Payment:</h3>' +
                    '<b>Contract ID:</b> ' + Format(Rec."Contract ID") + '<br/>' +
                    '<b>Payment ID:</b> ' + Rec."Payment Series" + '<br/>' +
                    '<b>Amount Including VAT:</b> ' + Format(Rec."Amount Including VAT") + '<br/>' +
                    '<b>Due Date:</b> ' + Format(Rec."Due Date", 0, '<Day,2>-<Month,2>-<Year4>') + '<br/>' +
                    '<b>Payment Mode:</b> ' + Rec."Payment Mode" + '<br/>' +
                    '<b>Payment Status:</b> ' + Format(Rec."Payment Status") + '</p>' +

                    '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                    '</body></html>',
                    true
                );

                // Send the email
                if Email.Send(EmailMessage) then
                    Message('Email sent successfully for Payment Mode: %1', Rec."Tenant Email")
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
        end;
    end;

    procedure SendEmailOverdue(Rec: Record "Payment Mode2"): Text;
    var
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        CompanyInfo: Record "Company Information";
    begin
        // Similar structure for overdue status
        if Rec."Payment Status" = Rec."Payment Status"::Overdue then begin
            if CompanyInfo.Get() then begin
                // Create the email message
                EmailMessage.Create(
                    Rec."Tenant Email", // The recipient's email address
                    'Payment Mode Details - ' + Format(Rec."Contract ID"),
                    '<html><body>' +
                    '<p>Dear ' + Rec."Tenant Name" + ',</p>' +
                    '<p>I hope this message finds you well. This is a kind reminder that your payment for (Rent/Charges) is Overdue.</p>' +
                    '<h3>Details of the Payment:</h3>' +
                    '<b>Contract ID:</b> ' + Format(Rec."Contract ID") + '<br/>' +
                    '<b>Payment ID:</b> ' + Rec."Payment Series" + '<br/>' +
                    '<b>Amount Including VAT:</b> ' + Format(Rec."Amount Including VAT") + '<br/>' +
                    '<b>Due Date:</b> ' + Format(Rec."Due Date", 0, '<Day,2>-<Month,2>-<Year4>') + '<br/>' +
                    '<b>Payment Mode:</b> ' + Rec."Payment Mode" + '<br/>' +
                    '<b>Payment Status:</b> ' + Format(Rec."Payment Status") + '</p>' +
                    '<p>Best regards,<br/>' + CompanyInfo.Name + '</p>' +
                    '</body></html>',
                    true
                );

                // Send the email
                if Email.Send(EmailMessage) then
                    Message('Email sent successfully for Payment Mode: %1', Rec."Tenant Email")
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
        end;
    end;

}