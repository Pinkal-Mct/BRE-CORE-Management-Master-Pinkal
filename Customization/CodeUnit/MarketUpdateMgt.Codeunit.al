codeunit 52005 "Market Update Mgt."
{

    procedure SendMarketUpdates(MarketUpdateRec: Record "Market Update")
    var
        LeadRec: Record "Lead Management";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit "Email";
        BodyText: Text;
    begin
        // ✅ Get only Warm & Cold leads
        LeadRec.Reset();
        LeadRec.SetFilter("Lead Rating", 'Warm|Cold');

        if LeadRec.FindSet() then
            repeat
                if LeadRec."Email" <> '' then begin
                    // ✅ Build HTML Email Body per lead
                    BodyText :=
                        '<html>' +
                        '<head>' +
                        '<style>' +
                        'body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; background-color: #f8f9fa; margin: 0; padding: 20px; }' +
                        '.container { max-width: 600px; margin: 0 auto; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 0 20px rgba(0,0,0,0.1); }' +
                        '.header { background: linear-gradient(135deg, #2c5282 0%, #3182ce 100%); color: white; padding: 30px 20px; text-align: center; }' +
                        '.header h1 { margin: 0; font-size: 24px; font-weight: bold; }' +
                        '.content { padding: 30px 20px; }' +
                        '.greeting { font-size: 16px; margin-bottom: 20px; }' +
                        '.update-card { background: #f7fafc; border-left: 4px solid #3182ce; padding: 20px; margin: 20px 0; border-radius: 0 8px 8px 0; }' +
                        '.footer { background: #f7fafc; padding: 20px; text-align: center; border-top: 1px solid #e2e8f0; }' +
                        '.cta { background: #3182ce; color: white; padding: 12px 25px; text-decoration: none; border-radius: 5px; display: inline-block; margin: 15px 0; font-weight: bold; }' +
                        '.signature { margin-top: 20px; color: #4a5568; }' +
                        '</style>' +
                        '</head><body>' +
                        '<div class="container">' +
                        '<div class="header">' +
                        '<h1>Welcome, ' + LeadRec."Lead Name" + '!</h1>' +
                        '<p>Your Property Journey Begins</p>' +
                        '</div>' +
                        '<div class="content">' +
                        '<div class="greeting">Hi ' + LeadRec."Lead Name" + ',</div>' +
                        '<p>Thank you for connecting with us at <strong>' + LeadRec."Company Name" + '</strong>. My name is ' + LeadRec."Lead Owner" + ', and I will be your dedicated point of contact and expert guide to the ' + LeadRec."Preferred Location" + ' real estate market.</p>' +

                        '<p>I have prepared some initial property recommendations based on current availability and the areas you mentioned. I will share more detailed options as we clarify your preferences.</p>' +

                        '<div class="update-card">' +
                        '<strong>Quick Market Update:</strong>' +
                        '<ul>' +
                        '<li>Downtown Dubai sees record-breaking transaction for a penthouse at AED 500M, signaling unwavering confidence in the luxury segment.</li>' +
                        '<li>New regulations from the DLD streamline the off-plan purchase process, boosting buyer protection and investor confidence.</li>' +
                        '<li>New 5-year green residency visa announced for real estate investors purchasing properties valued at AED 2M or more.</li>' +
                        '<li>Dubai Land Department reports a 20% year-on-year increase in overall transaction values.</li>' +
                        '</ul>' +
                        '</div>' +

                        '<p>My goal is to keep you informed with actionable insights. I also have access to off-market deals and advanced market data that can be invaluable for your search.</p>' +

                        '<p><a href="mailto:' + LeadRec."Lead Owner" + '" class="cta">📞 Let''s Talk</a></p>' +
                        '<p>The best way to move forward is a quick conversation. Please feel free to call me directly or simply reply to this email to find a time that works for you.</p>' +

                        '<p>Sincerely,<br/>' +
                         LeadRec."Lead owner" + '<br/>' +
                        LeadRec."Position/Role" + '<br/>' +
                         LeadRec."Company Name" + '<br/>' +
                        'Your Real Estate Team</p>' +
                        '</div>' +
                        '</div>' +
                        '</body></html>';

                    // ✅ Create Email
                    EmailMessage.Create(
                        LeadRec."Email",
                        'Welcome, ' + LeadRec."Lead Name" + '! Your Property Journey Begins',
                        BodyText,
                        true // HTML
                    );

                    // ✅ Send Email
                    if not Email.Send(EmailMessage) then
                        Error('Failed to send Welcome email to %1 (%2).', LeadRec."Lead Name", LeadRec."Email");
                end;
            until LeadRec.Next() = 0;
    end;



    // procedure SendMarketUpdates(MarketUpdateRec: Record "Market Update"): Text
    // var
    //     LeadRec: Record "Lead Management";
    //     EmailMessage: Codeunit "Email Message";
    //     Email: Codeunit "Email";
    //     BodyText: Text;
    // begin
    //     // ✅ Filter only Warm & Cold leads
    //     LeadRec.Reset();
    //     LeadRec.SetFilter("Lead Rating", 'Warm|Cold');

    //     // ✉️ Build Welcome Email Body
    //     BodyText :=
    //         '<html>' +
    //         '<head>' +
    //         '<style>' +
    //         'body { font-family: Arial, sans-serif; line-height: 1.6; color: #333; background-color: #f8f9fa; margin: 0; padding: 20px; }' +
    //         '.container { max-width: 600px; margin: 0 auto; background: white; border-radius: 10px; overflow: hidden; box-shadow: 0 0 20px rgba(0,0,0,0.1); }' +
    //         '.header { background: linear-gradient(135deg, #2c5282 0%, #3182ce 100%); color: white; padding: 30px 20px; text-align: center; }' +
    //         '.header h1 { margin: 0; font-size: 24px; font-weight: bold; }' +
    //         '.content { padding: 30px 20px; }' +
    //         '.greeting { font-size: 16px; margin-bottom: 20px; }' +
    //         '.update-card { background: #f7fafc; border-left: 4px solid #3182ce; padding: 20px; margin: 20px 0; border-radius: 0 8px 8px 0; }' +
    //         '.footer { background: #f7fafc; padding: 20px; text-align: center; border-top: 1px solid #e2e8f0; }' +
    //         '.cta { background: #3182ce; color: white; padding: 12px 25px; text-decoration: none; border-radius: 5px; display: inline-block; margin: 15px 0; font-weight: bold; }' +
    //         '.signature { margin-top: 20px; color: #4a5568; }' +
    //         '</style>' +
    //         '</head><body>' +
    //         '<div class="container">' +
    //         '<div class="header">' +
    //         '<h1>Welcome, ' + LeadRec."Lead Name" + '!</h1>' +
    //         '<p>Your Property Journey Begins</p>' +
    //         '</div>' +
    //         '<div class="content">' +
    //         '<div class="greeting">Hi ' + LeadRec."Lead Name" + ',</div>' +
    //         '<p>Thank you for connecting with us at <strong>' + LeadRec."Company Name" + '</strong>. My name is ' + LeadRec."Lead Name" + ', and I will be your dedicated point of contact and expert guide to the ' + LeadRec."Preferred Location" + ' real estate market.</p>' +

    //         '<p>I have prepared some initial property recommendations based on current availability and the areas you mentioned. I will share more detailed options as we clarify your preferences.</p>' +

    //         '<div class="update-card">' +
    //         '<strong>Quick Market Update:</strong>' +
    //         '<ul>' +
    //         '<li>Downtown Dubai sees record-breaking transaction for a penthouse at AED 500M, signaling unwavering confidence in the luxury segment.</li>' +
    //         '<li>New regulations from the DLD streamline the off-plan purchase process, boosting buyer protection and investor confidence.</li>' +
    //         '<li>New 5-year green residency visa announced for real estate investors purchasing properties valued at AED 2M or more.</li>' +
    //         '<li>Dubai Land Department reports a 20% year-on-year increase in overall transaction values.</li>' +
    //         '</ul>' +
    //         '</div>' +

    //         '<p>My goal is to keep you informed with actionable insights. I also have access to off-market deals and advanced market data that can be invaluable for your search.</p>' +

    //        '<p><a href="mailto:' + LeadRec."Lead Owner" + '" class="cta">📞 Let''s Talk</a></p>' +
    //     '<p>Sincerely,<br/>' +
    //     LeadRec."Position/Role" + '<br/>' +
    //     'Your Real Estate Team</p>' +
    //     '</body></html>';

    //     EmailMessage.Create(
    //         LeadRec."Email",
    //         'Welcome, ' + LeadRec."Lead Name" + '! Your Property Journey Begins',
    //         BodyText,
    //         true // HTML
    //     );

    //     if not Email.Send(EmailMessage) then
    //         Error('Failed to send Welcome email to %1.', LeadRec."Lead Name");
    // end;


    // // ✅ ALTERNATIVE: Send all active updates (your original approach)
    // procedure SendAllMarketUpdates(CurrentRec: Record "Market Update"): Text
    // var
    //     LeadRec: Record "Lead Management";
    //     AllUpdatesRec: Record "Market Update";
    //     EmailMessage: Codeunit "Email Message";
    //     Email: Codeunit "Email";
    //     BodyText: Text;
    // begin
    //     LeadRec.Reset();
    //     LeadRec.SetFilter("Lead Rating", 'Warm|Cold');

    //     if LeadRec.FindSet() then
    //         repeat
    //             BodyText :=
    //                 '<html><body>' +
    //                 '<p>Dear <b>' + LeadRec."Lead Name" + '</b>,</p>' +
    //                 '<p>Here are the latest <b>UAE Real Estate Market Updates</b>:</p>';

    //             // Get all active updates
    //             AllUpdatesRec.Reset();
    //             AllUpdatesRec.SetRange(Active, true);
    //             if AllUpdatesRec.FindSet() then
    //                 repeat
    //                     BodyText +=
    //                         '<p><b>' + AllUpdatesRec."Title" + '</b><br/>' +
    //                         AllUpdatesRec."Description" + '<br/>' +
    //                         '<i>Category: ' + Format(AllUpdatesRec.Category) + '</i><br/>' +
    //                         '<small><b>Published on:</b> ' + Format(AllUpdatesRec."Publish Date") + '</small></p><hr>';
    //                 until AllUpdatesRec.Next() = 0;

    //             BodyText +=
    //                 '<p>Stay connected with us for more insights and opportunities.</p>' +
    //                 '<p>Best Regards,<br/><b>Your Sales Team</b></p>' +
    //                 '<p><i>This is a system-generated email. Please do not reply.</i></p>' +
    //                 '</body></html>';

    //             EmailMessage.Create(
    //                 LeadRec."Email",
    //                 'UAE Real Estate Market Updates',
    //                 BodyText,
    //                 true
    //             );

    //             if not Email.Send(EmailMessage) then
    //                 Error('Failed to send Market Update email to %1.', LeadRec."Lead Name");

    //         until LeadRec.Next() = 0;
    // end;
}