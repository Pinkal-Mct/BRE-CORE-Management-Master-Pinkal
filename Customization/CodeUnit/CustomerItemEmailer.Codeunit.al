codeunit 53752 "Customer Item Emailer"
{
    SingleInstance = false;

    procedure SendItemsEmail(ContactNo: Code[20]; ItemNosCsv: Text)
    var
        Contact: Record Contact;
        Item: Record Item;
        Setup: Record "Email Link Setup";
        emailBodySetup: Record "Email Body Setup";
        emailBodySetupPage: Page "Email Body Setup";
        TokenRec: Record "Email Link Token";
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        Uri: Codeunit Uri;
        Html: TextBuilder;
        Subject: Text;
        FlowBaseUrl: Text;
        ExpiryDays: Integer;
        CustomerEmail: Text;
        TokenGuid: Guid;
        NowDT: DateTime;
        ExpDT: DateTime;
        encodedURL: Text;
        emailBody: Text;
        blob: Codeunit "Temp Blob";
    begin
        // Get config
        if not Setup.FindFirst() then
            Error('Please open "Email Link Setup" and enter your Flow URL once.');

        FlowBaseUrl := Setup."Flow Base URL";
        ExpiryDays := Setup."Expiry (Days)";

        // Customer & email
        if not Contact.Get(ContactNo) then
            Error('Customer %1 not found.', ContactNo);
        CustomerEmail := Contact."E-Mail";

        if emailBodySetup.Get() then begin
            emailBody := emailBodySetupPage.GetRichText();
            Subject := emailBodySetup."Automated FollowUp Subject";
        end;

        NowDT := CurrentDateTime();
        ExpDT := CreateDateTime(Today(), Time()) + (ExpiryDays * 24 * 60 * 60 * 1000);

        TokenRec.Init();
        TokenGuid := CreateGuid();
        TokenRec.Token := TokenGuid;
        TokenRec."Contact No." := ContactNo;
        TokenRec."Contact Email" := CustomerEmail;
        TokenRec."Expires At" := ExpDT;
        TokenRec.Insert();

        // encodedURL := Uri.EscapeDataString(FlowBaseUrl + '&token=' + Format(TokenGuid));
        encodedURL := FlowBaseUrl + '&token=' + Format(TokenGuid);
        Html.Append(
          StrSubstNo(
            '<a href="https://property-details.powerappsportals.com?workflowURL=%1" ' +
            'style="display:inline-block;padding:8px 14px;border-radius:6px;' +
            'background:#2563eb;color:#fff;text-decoration:none;font-weight:bold;' +
            'font-family:Helvetica, Arial, sans-serif;font-size:14px;" ' +
            '>' +
            'More Details' +
            '</a>',
            encodedURL));


        // Replace placeholders
        Subject := emailBodySetupPage.Replace(Subject, '{{Contact Person Name}}', Contact.Name);
        emailBody := ReplacePlaceHolders(emailBody, Contact, Html);
        // Subject := StrSubstNo('Welcome, %1! Your Personalized Property Recommendations', Contact.Name);

        // emailBody := '<div style = "color:#666" > These links expire on ' + Format(ExpDT) + '.</div>';
        // Send via BC Email (HTML = true)
        EmailMsg.Create(CustomerEmail, Subject, emailBody, true);
        Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    end;

    procedure ReplacePlaceHolders(TextIn: Text; var Contact: Record Contact; link: TextBuilder): Text
    var
        emailBodySetupPage: Page "Email Body Setup";
    begin
        TextIn := emailBodySetupPage.Replace(TextIn, '{{Contact Person Name}}', Contact.Name);
        TextIn := emailBodySetupPage.Replace(TextIn, '{{Lead Owner Name}}', Contact."Lead Owner");
        TextIn := emailBodySetupPage.Replace(TextIn, '{{Company Name}}', CompanyName);
        TextIn := emailBodySetupPage.Replace(TextIn, '{{Property Type}}', Contact."Property Type");
        TextIn := emailBodySetupPage.Replace(TextIn, '{{Preferred Location}}', Contact."Preferred Location");
        TextIn := emailBodySetupPage.Replace(TextIn, '{{Budget Range}}', Format(Contact."Budget Range (AED)"));
        TextIn := emailBodySetupPage.Replace(TextIn, '{{Unique Trackable URL Link}}', link.ToText());
        TextIn := emailBodySetupPage.Replace(TextIn, '{{Lead Owner Title}}', Contact."Position/Role");
        // TextIn := emailBodySetupPage.Replace(TextIn, '{{Lead Owner Contact Information}}', );
        exit(TextIn);
    end;
}
