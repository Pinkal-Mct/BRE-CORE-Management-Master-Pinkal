pageextension 53750 "Customer Card Ext" extends "Customer Card"
{
    actions
    {
        addlast(Processing)
        {
            action(SendItemButtonsEmail)
            {
                ApplicationArea = All;
                Caption = 'Send Items Email';
                Image = Email;

                trigger OnAction()
                var
                    Emailer: Codeunit "Customer Item Emailer";
                    ItemsCsv: Text;
                begin
                    // TODO: replace with a proper picker; for demo:
                    ItemsCsv := '1896-S,1000'; // sample list
                    Emailer.SendItemsEmail(Rec."No.", ItemsCsv);
                    Message('Email sent to %1.', Rec."E-Mail");
                end;
            }
        }
    }
}