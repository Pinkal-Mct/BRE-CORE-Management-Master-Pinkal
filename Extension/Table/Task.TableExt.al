tableextension 51254 "Task" extends "To-do"
{
    fields
    {
        field(51253; "Custome Type"; Enum "Custom Task Type")
        {
            Caption = 'Task Type';
            DataClassification = CustomerContent;
        }
    }
}