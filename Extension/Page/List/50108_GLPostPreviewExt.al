pageextension 50108 "G/L Posting Preview Ext" extends "G/L Posting Preview"
{
    actions
    {
        addafter(Process)
        {
            action(Post)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'P&ost';
                Image = PostOrder;
                ShortCutKey = 'F9';
                ToolTip = 'Finalize the document or journal by posting the amounts and quantities to the related accounts in your company books.';

                trigger OnAction()
                var
                    GenJournal: Record "Gen. Journal Line";
                    tenancyContract: Record "Tenancy Contract";
                begin
                    GenJournal.Reset();
                    GenJournal.SetRange("Journal Template Name", 'GENERAL');
                    GenJournal.SetRange("Journal Batch Name", 'DEFAULT');
                    if GenJournal.FindSet() then
                        if tenancyContract.Get(GenJournal."Contract ID") then begin
                            tenancyContract.Validate(Refund, tenancyContract.Refund + Abs(GenJournal.Amount));
                            tenancyContract.Modify();
                            GenJournal.SendToPosting(Codeunit::"Gen. Jnl.-Post");
                        end;
                end;
            }
        }
    }
}