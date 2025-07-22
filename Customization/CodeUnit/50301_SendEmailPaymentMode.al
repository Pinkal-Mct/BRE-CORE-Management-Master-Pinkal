codeunit 50301 "Send PaymentMode Email"
{
    procedure SendEmail(Rec: Record "Payment Mode2"): Text;
    var
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        CompanyInfo: Record "Company Information";
        PaymentMode: Record "Payment Mode"; // Add Payment Mode record variable
        EmailAddress: Text[250]; // Variable to store the email address
    begin
        if Rec."Payment Status" = Rec."Payment Status"::Received then begin
            // Find matching Payment Mode record by Tenant ID
            PaymentMode.Reset();
            PaymentMode.SetRange("Tenant ID", Rec."Tenant ID");
            PaymentMode.SetRange("Contract ID", Rec."Contract ID");

            if PaymentMode.FindFirst() then begin
                EmailAddress := PaymentMode."Tenant Email"; // Get email from Payment Mode table

                // Check if email address is not empty
                if EmailAddress = '' then
                    Error('Email address not found for Tenant ID: %1', Rec."Tenant ID");

            end else
                Error('Payment Mode record not found for Tenant ID: %1', Rec."Tenant ID");

            // Ensure that the correct record is passed and exists
            if CompanyInfo.Get() then begin
                // Create the email message with Payment Mode email address
                EmailMessage.Create(
                    EmailAddress, // Use email from Payment Mode table instead of Rec."Tenant Email"
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
                    Message('Email sent successfully for Payment Mode: %1', EmailAddress)
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
        PaymentMode: Record "Payment Mode"; // Add Payment Mode record variable
        EmailAddress: Text[250]; // Variable to store the email address
    begin
        // Similar structure for cancelled status
        if Rec."Payment Status" = Rec."Payment Status"::Cancelled then begin
            // Find matching Payment Mode record by Tenant ID
            PaymentMode.Reset();
            PaymentMode.SetRange("Tenant ID", Rec."Tenant ID");
            PaymentMode.SetRange("Contract ID", Rec."Contract ID");

            if PaymentMode.FindFirst() then begin
                EmailAddress := PaymentMode."Tenant Email"; // Get email from Payment Mode table

                // Check if email address is not empty
                if EmailAddress = '' then
                    Error('Email address not found for Tenant ID: %1', Rec."Tenant ID");

            end else
                Error('Payment Mode record not found for Tenant ID: %1', Rec."Tenant ID");

            if CompanyInfo.Get() then begin
                // Create the email message with Payment Mode email address
                EmailMessage.Create(
                    EmailAddress, // Use email from Payment Mode table instead of Rec."Tenant Email"
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
                    Message('Email sent successfully for Payment Mode: %1', EmailAddress)
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
        PaymentMode: Record "Payment Mode"; // Add Payment Mode record variable
        EmailAddress: Text[250]; // Variable to store the email address
    begin
        // Similar structure for overdue status
        if Rec."Payment Status" = Rec."Payment Status"::Overdue then begin
            // Find matching Payment Mode record by Tenant ID
            PaymentMode.Reset();
            PaymentMode.SetRange("Tenant ID", Rec."Tenant ID");
            PaymentMode.SetRange("Contract ID", Rec."Contract ID");

            if PaymentMode.FindFirst() then begin
                EmailAddress := PaymentMode."Tenant Email"; // Get email from Payment Mode table

                // Check if email address is not empty
                if EmailAddress = '' then
                    Error('Email address not found for Tenant ID: %1', Rec."Tenant ID");

            end else
                Error('Payment Mode record not found for Tenant ID: %1', Rec."Tenant ID");

            if CompanyInfo.Get() then begin
                // Create the email message with Payment Mode email address
                EmailMessage.Create(
                    EmailAddress, // Use email from Payment Mode table instead of Rec."Tenant Email"
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
                    Message('Email sent successfully for Payment Mode: %1', EmailAddress)
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;
        end;
    end;

}