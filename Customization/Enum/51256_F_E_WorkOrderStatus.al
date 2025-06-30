enum 51256 "FM Work Order Status"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Pending)
    {
        Caption = 'Pending';
    }
    value(2; "In Progress")
    {
        Caption = 'In Progress';
    }
    value(3; Completed)
    {
        Caption = 'Completed';
    }
    value(4; Closed)
    {
        Caption = 'Closed';
    }
}