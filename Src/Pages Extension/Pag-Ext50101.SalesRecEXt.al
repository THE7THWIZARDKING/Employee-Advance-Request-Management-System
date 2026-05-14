pageextension 50101 "Sales & Rec EXt" extends "Sales & Receivables Setup"
{
    layout
    {
        addafter("Customer Nos.")
        {
            // group(EmployeeAdvanceGroup)
            // {
            //     Caption = 'Employee Advance Request';
            field("Employee Advance Nos."; Rec."Employee Advance Nos.")
            {
                ApplicationArea = All;
            }
            // }
        }
    }
}
