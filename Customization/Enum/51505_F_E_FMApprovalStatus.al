enum 51505 "FM Approval Status"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; "Not Required")
    {
        Caption = 'Not Required';
    }
    value(2; Pending)
    {
        Caption = 'Pending';
    }
    value(3; Approved)
    {
        Caption = 'Approved';
    }
    value(4; Rejected)
    {
        Caption = 'Rejected';
    }
}