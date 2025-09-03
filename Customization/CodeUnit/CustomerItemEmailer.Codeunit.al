codeunit 53752 "Customer Item Emailer"
{
    SingleInstance = false;

    procedure SendItemsEmail(ContactNo: Code[20]; ItemNosCsv: Text)
    var
        Contact: Record Contact;
        Item: Record Item;
        Setup: Record "Email Link Setup";
        TokenRec: Record "Email Link Token";
        EmailMsg: Codeunit "Email Message";
        Email: Codeunit Email;
        Html: TextBuilder;
        Subject: Text;
        FlowBaseUrl: Text;
        ExpiryDays: Integer;
        CustomerEmail: Text;
        ItemNos: List of [Text];
        ItemNo: Text;
        TokenGuid: Guid;
        NowDT: DateTime;
        ExpDT: DateTime;
        Uri: Codeunit Uri;
        encodedURL: Text;
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

        // Build HTML header
        Html.AppendLine('<div style="font-family:Segoe UI,Arial,sans-serif;font-size:14px">');
        Html.AppendLine(StrSubstNo('Dear <b>%1</b>,<br/><br/>Thank you for your inquiry. <b>%2</b> from <b>%3</b> will be assisting you with your search for a <b>%4</b> in <b>%5</b>.<br/>Based on your stated budget of <b>%6</b> we have prepared an initial list of properties for you to review:<br/>View your personalized recommendations: <br/>', Contact.Name, Contact."Lead Owner", CompanyName, Contact."Property Type", Contact."Preferred Location", Contact."Budget Range (AED)"));
        Html.AppendLine('<table cellpadding="8" cellspacing="0" border="0" style="border-collapse:collapse;width:100%;max-width:700px;margin-top:10px">');
        Html.AppendLine('<tr style="background:#f2f2f2;text-align:left;">' +
                        '<th>Item No.</th><th>Description</th><th>Unit Price</th><th></th></tr>');

        NowDT := CurrentDateTime();
        ExpDT := CreateDateTime(Today(), Time()) + (ExpiryDays * 24 * 60 * 60 * 1000);

        // Each item row + token + button
        // foreach ItemNo in ItemNos do begin
        Item.SetRange("No.", 'UC00010');
        if Item.FindSet() then
            repeat
                TokenRec.Init();
                TokenGuid := CreateGuid();
                TokenRec.Token := TokenGuid;
                TokenRec."Contact No." := ContactNo;
                TokenRec."Item No." := Item."No.";
                TokenRec."Contact Email" := CustomerEmail;
                TokenRec."Expires At" := ExpDT;
                TokenRec.Insert();

                Html.Append('<tr style="border-bottom:1px solid #ddd">');
                Html.Append(StrSubstNo('<td>%1</td>', Item."No."));
                Html.Append(StrSubstNo('<td>%1</td>', Item.Description));
                Html.Append(StrSubstNo('<td>%1</td>', Format(Item."Unit Price", 0, 2)));
                Html.Append('<td>');

                encodedURL := Uri.EscapeDataString(FlowBaseUrl + '&token=' + Format(TokenGuid));
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

                Html.Append('</td>');
                Html.AppendLine('</tr>');
            until Item.Next() = 0;
        // end;

        Html.AppendLine('</table>');
        Html.AppendLine('<br/>This is a sample of what''s available. We are confident we can find the right property for you. <br/>Please do not hesitate to contact us with any questions.');
        Html.AppendLine('<br/><br/>Sincerely,<br/>' + Contact."Lead Owner" + '<br/>' + Contact."Position/Role" + '<br/>' + CompanyName + '<br/>' + '(Lead Owner Contact Info)');
        Html.AppendLine('<br/><div style="color:#666">These links expire on ' + Format(ExpDT) + '.</div>');
        Html.AppendLine('</div>');

        Subject := StrSubstNo('Welcome, %1! Your Personalized Property Recommendations', Contact.Name);

        // Send via BC Email (HTML = true)
        EmailMsg.Create(CustomerEmail, Subject, Html.ToText(), true);
        Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    end;
}
