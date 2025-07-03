enum 51501 "FM Request Status"
{
    Extensible = true;

    value(0; " ")
    {
        Caption = ' ';
    }
    value(1; Open)
    {
        Caption = 'Open';
    }
    value(2; "Sending Approval")
    {
        Caption = 'Sending Approval';
    }
    value(3; "Pending Approval")
    {
        Caption = 'Pending Approval';
    }
    value(4; Approved)
    {
        Caption = 'Approved';
    }
    value(5; Rejected)
    {
        Caption = 'Rejected';
    }
    value(6; "Work Order Created")
    {
        Caption = 'Work Order Created';
    }
    value(7; Closed)
    {
        Caption = 'Closed';
    }

}