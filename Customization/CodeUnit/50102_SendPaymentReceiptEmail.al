codeunit 50102 "Send Payment Receipt"
{
    procedure SendEmail(Rec: Record "Payment Mode2"): Text;
    var
        TempBlob: Codeunit "Temp Blob";
        OutStream: OutStream;
        InStream: InStream;
        FileName: Text[250];
        TempFilePath: Text[250];
        ReportID: Integer;
        Email: Codeunit "Email";
        EmailMessage: Codeunit "Email Message";
        CompanyInfo: Record "Company Information";
        ConsolidatedInvoiceHeader: Record "Payment Mode2";
        PaymentMode: Record "Payment Mode"; // Add Payment Mode record variable
        RecRef: RecordRef;
        FileManagement: Codeunit "File Management";
        NoSeriesManagement: Codeunit "No. Series";
        ReceiptNo: Code[20];
        EmailAddress: Text[250]; // Variable to store the email address
    begin
        ReportID := 50112;

        // Apply filters to fetch the specific record
        ConsolidatedInvoiceHeader.Reset();
        ConsolidatedInvoiceHeader.SetRange("Tenant ID", Rec."Tenant ID");
        ConsolidatedInvoiceHeader.SetRange("Contract ID", Rec."Contract ID");
        ConsolidatedInvoiceHeader.SetRange("Payment Series", Rec."Payment Series");

        if ConsolidatedInvoiceHeader.FindFirst() then begin
            // Find matching Payment Mode record by Tenant ID
            PaymentMode.Reset();
            PaymentMode.SetRange("Tenant ID", ConsolidatedInvoiceHeader."Tenant ID");
            PaymentMode.SetRange("Contract ID", ConsolidatedInvoiceHeader."Contract ID");

            if PaymentMode.FindSet() then begin
                EmailAddress := PaymentMode."Tenant Email"; // Get email from Payment Mode table

                // Check if email address is not empty
                if EmailAddress = '' then
                    Error('Email address not found for Tenant ID: %1', ConsolidatedInvoiceHeader."Tenant ID");

            end else
                Error('Payment Mode record not found for Tenant ID: %1', ConsolidatedInvoiceHeader."Tenant ID");

            // Generate auto-incremented receipt number
            // if ConsolidatedInvoiceHeader."Receipt #" = '' then begin
            //     ReceiptNo := NoSeriesManagement.GetNextNo('RECEIPTNO', WorkDate(), true);
            //     ConsolidatedInvoiceHeader."Receipt #" := ReceiptNo;
            //     ConsolidatedInvoiceHeader.Modify();
            // end;

            // Prepare the report output
            RecRef.GetTable(ConsolidatedInvoiceHeader);
            TempBlob.CreateOutStream(OutStream);

            Report.SaveAs(ReportID, '', ReportFormat::Pdf, OutStream, RecRef);

            TempBlob.CreateInStream(InStream);
            FileName := 'Receipt_' + Format(ConsolidatedInvoiceHeader."Receipt #") + '.pdf';

            // Debugging to confirm email creation parameters
            Message('Preparing to send email to: %1', EmailAddress);

            // Retrieve company information
            if CompanyInfo.Get() then begin
                // Create email with Payment Mode email address
                EmailMessage.Create(
                    EmailAddress, // Use email from Payment Mode table
                    'Payment Receipt Attached_' + Format(ConsolidatedInvoiceHeader."Receipt #"),
                    '<html>' +
                    '<body>' +
                    '<p>Dear ' + ConsolidatedInvoiceHeader."Tenant Name" + ',' +
                    'Your payment has been received. Please find your receipt attached.</p>' +
                    '</body>' +
                    '</html>',
                    true
                );

                // Attach the PDF document
                EmailMessage.AddAttachment(FileName, '', InStream);

                // Send the email
                if Email.Send(EmailMessage) then
                    Message('Email sent successfully to: %1', EmailAddress)
                else
                    Error('Failed to send email. Please verify SMTP settings and email addresses.');
            end;

            exit('Email sent successfully');
        end else
            Error('No Payment Receipt details found for Tenant ID: %1, Contract ID: %2, Payment Series: %3', Rec."Tenant ID", Rec."Contract ID", Rec."Payment Series");
    end;
}