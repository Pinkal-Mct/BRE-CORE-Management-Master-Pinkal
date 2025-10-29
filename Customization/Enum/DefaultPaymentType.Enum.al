enum 50101 "Default Payment Type"
{
    Extensible = true;

    value(0; Pending)
    {
        Caption = 'Pending';
    }
    value(1; Cash)
    {
        Caption = 'Cash';
    }
    value(2; "Bank Transfer")
    {
        Caption = 'Bank Transfer';
    }
    value(3; Cheque)
    {
        Caption = 'Cheque';
    }
    value(4; "Credit Card")
    {
        Caption = 'Credit Card';
    }
    value(5; "Mobile Wallet")
    {
        Caption = 'Mobile Wallet';
    }
}