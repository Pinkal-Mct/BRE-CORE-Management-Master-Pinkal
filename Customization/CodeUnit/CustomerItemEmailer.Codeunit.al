codeunit 53752 "Customer Item Emailer"
{
    SingleInstance = false;

    procedure SendItemsEmail(CustomerNo: Code[20]; ItemNosCsv: Text)
    var
        Cust: Record Customer;
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
    begin
        // Get config
        if not Setup.FindFirst() then
            Error('Please open "Email Link Setup" and enter your Flow URL once.');

        FlowBaseUrl := Setup."Flow Base URL";
        ExpiryDays := Setup."Expiry (Days)";

        // Customer & email
        if not Cust.Get(CustomerNo) then
            Error('Customer %1 not found.', CustomerNo);
        CustomerEmail := Cust."E-Mail";
        // if IsNullOrEmpty(CustomerEmail) then
        //     Error('Customer %1 has no E-Mail.', CustomerNo);

        // Parse items from CSV
        // ItemNos := ParseCsv(ItemNosCsv);
        // if ItemNos.Count() = 0 then
        //     Error('No item numbers provided.');

        // Build HTML header
        Html.AppendLine('<div style="font-family:Segoe UI,Arial,sans-serif;font-size:14px">');
        Html.AppendLine(StrSubstNo('Hello %1,<br/><br/>Here are the items you asked about:', Cust.Name));
        Html.AppendLine('<table cellpadding="8" cellspacing="0" border="0" style="border-collapse:collapse;width:100%;max-width:700px;margin-top:10px">');
        Html.AppendLine('<tr style="background:#f2f2f2;text-align:left;">' +
                        '<th>Item No.</th><th>Description</th><th>Unit Price</th><th></th></tr>');

        NowDT := CurrentDateTime();
        ExpDT := CreateDateTime(Today(), Time()) + (ExpiryDays * 24 * 60 * 60 * 1000);

        // Each item row + token + button
        // foreach ItemNo in ItemNos do begin
        Item.SetRange("No.", 'UC00010');
        // Item.SetRange(Type, Item.Type::"Non-Inventory");
        // Item.SetRange("Item type template", Item."Item type template"::"Secondary Item");
        if Item.FindSet() then
            repeat
                TokenRec.Init();
                TokenGuid := CreateGuid();
                TokenRec.Token := TokenGuid;
                TokenRec."Customer No." := CustomerNo;
                TokenRec."Item No." := Item."No.";
                TokenRec."Customer Email" := CustomerEmail;
                TokenRec."Expires At" := ExpDT;
                TokenRec.Insert();

                Html.Append('<tr style="border-bottom:1px solid #ddd">');
                Html.Append(StrSubstNo('<td>%1</td>', Item."No."));
                Html.Append(StrSubstNo('<td>%1</td>', Item.Description));
                Html.Append(StrSubstNo('<td>%1</td>', Format(Item."Unit Price", 0, 2)));
                Html.Append('<td>');

                Html.Append(
                 //   StrSubstNo(
                 //     '<a href="%1&token=%2" ' +
                 //     'style="display:inline-block;padding:8px 14px;border-radius:6px;' +
                 //     'background:#2563eb;color:#fff;text-decoration:none;font-weight:600">' +
                 //     'More details</a>', FlowBaseUrl, Format(TokenGuid)));

                 // StrSubstNo('<button data-url="%1&token=%2" style="display:inline-block;padding:8px 14px;border-radius:6px;background:#2563eb;color:#fff;text-decoration:none;font-weight:600">More details</button>', FlowBaseUrl, Format(TokenGuid)));

                 StrSubstNo(
                    '<a role="button" href="%1&token=%2" ' +
                    'style="display:inline-block;padding:8px 14px;border-radius:6px;' +
                    'background:#2563eb;color:#fff;text-decoration:none;font-weight:600">' +
                    'More details</a>', FlowBaseUrl, Format(TokenGuid)));

                Html.Append('</td>');
                Html.AppendLine('</tr>');
            until Item.Next() = 0;
        // end;

        Html.AppendLine('</table>');
        Html.AppendLine('<br/><div style="color:#666">These links expire on ' + Format(ExpDT) + '.</div>');
        Html.AppendLine('</div>');

        Subject := StrSubstNo('Items for %1', Cust.Name);

        // Send via BC Email (HTML = true)
        EmailMsg.Create(CustomerEmail, Subject, Html.ToText(), true);
        Email.Send(EmailMsg, Enum::"Email Scenario"::Default);
    end;

    // local procedure ParseCsv(S: Text): List of [Text]
    // var
    //     L: List of [Text];
    //     p: Integer;
    //     t: Text;
    // begin
    //     S := DelChr(S, '<>', ' ');
    //     while StrLen(S) > 0 do begin
    //         p := StrPos(S, ',');
    //         if p = 0 then begin
    //             t := Trim(S);
    //             if t <> '' then L.Add(t);
    //             exit(L);
    //         end;
    //         t := Trim(CopyStr(S, 1, p - 1));
    //         if t <> '' then L.Add(t);
    //         S := CopyStr(S, p + 1);
    //     end;
    //     exit(L);
    // end;

    // local procedure IsNullOrEmpty(T: Text): Boolean
    // begin
    //     exit(Trim(T) = '');
    // end;
}
