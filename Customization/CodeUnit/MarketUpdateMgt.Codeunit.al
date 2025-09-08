codeunit 52005 "Market Update Mgt."
{

    procedure SendMarketUpdates(MarketUpdateRec: Record "Market Update")
    var
        LeadRec: Record Contact;
        SetupRec: Record "Email Body Setup";
        EmailMessage: Codeunit "Email Message";
        Email: Codeunit Email;
        BodyText: Text;
        InS: InStream;
        SubjectText: Text;
    begin
        // ✅ Ensure setup exists
        if not SetupRec.Get() then
            Error('Please configure Email Body Setup first.');

        // ✅ Get Body Text from BLOB
        SetupRec.CalcFields("UAE Market Followup Body");
        SetupRec."UAE Market Followup Body".CreateInStream(InS, TextEncoding::UTF8);
        InS.Read(BodyText);

        LeadRec.Reset();
        LeadRec.SetFilter("Lead Status", 'Qualified|Contacted');

        if LeadRec.FindSet() then
            repeat
                if LeadRec."E-Mail" <> '' then begin
                    // ✅ Replace placeholders with dynamic values
                    BodyText := ReplacePlaceholders(BodyText, LeadRec);
                    SubjectText := ReplacePlaceholders(SetupRec."UAE Market Followup Subject", LeadRec);

                    EmailMessage.Create(
                        LeadRec."E-Mail",
                        SubjectText,
                        // SetupRec."UAE Market Followup Subject",
                        BodyText,
                        true // HTML
                    );

                    if not Email.Send(EmailMessage) then
                        Error('Failed to send Welcome email to %1 (%2).', LeadRec."Lead Owner", LeadRec."E-Mail");
                end;
            until LeadRec.Next() = 0;
    end;

    /// 🔹 Helper function for replacing placeholders in email templates
    local procedure ReplacePlaceholders(Template: Text; LeadRec: Record Contact): Text
    begin
        Template := Template.Replace('{{Contact Person Name}}', LeadRec."Lead Owner");
        Template := Template.Replace('{{Company Name}}', LeadRec."Company Name");
        Template := Template.Replace('{{Location}}', LeadRec."Preferred Location");
        Template := Template.Replace('{{Lead Owner Name}}', LeadRec."Name");
        Template := Template.Replace('{{Lead Owner Contact Information}}', LeadRec."Owner Contact No.");
        Template := Template.Replace('{{Lead Owner Title}}', Format(LeadRec."Owner Type"));
        Template := Template.Replace('{{Lead Owner Contact Information}}', LeadRec."Owner Email");
        exit(Template);
    end;

}