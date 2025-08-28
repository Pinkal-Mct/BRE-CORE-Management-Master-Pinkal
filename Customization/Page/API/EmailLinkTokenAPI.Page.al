page 53765 "Email Link Token API"
{
    PageType = API;
    Caption = 'Email Link Token API';
    SourceTable = "Email Link Token";
    DelayedInsert = true;
    APIPublisher = 'yourpub';
    APIGroup = 'emails';
    APIVersion = 'v2.0';
    EntityName = 'EmailLinkToken';
    EntitySetName = 'EmailLinkTokens';
    InsertAllowed = true;
    ModifyAllowed = true;
    DeleteAllowed = true;
    ODataKeyFields = Token;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Token; Rec.Token) { }
                field("Customer_No"; Rec."Customer No.") { }
                field("Item_No"; Rec."Item No.") { }
                field("Customer_Email"; Rec."Customer Email") { }
                field("Expires_At"; Rec."Expires At") { }
                field(Clicked; Rec.Clicked) { }
                field("Clicked_At"; Rec."Clicked At") { }
                field(SystemId; Rec.SystemId) { }
            }
        }
    }
}