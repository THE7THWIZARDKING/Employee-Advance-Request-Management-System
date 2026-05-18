report 50100 "Employee Advance Report"
{
    Caption = 'Employee Advance Report';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultLayout = RDLC;
    RDLCLayout = './EmployeeAdvanceReport.rdl';
    dataset
    {
        dataitem(Header; "Employee Advance Header")
        {
            RequestFilterFields = "Employee No.";

            column(RequestNo; "Request No.")
            {
            }

            column(EmployeeNo; "Employee No.")
            {
            }

            column(EmployeeName; "Employee Name")
            {
            }
            column(comppicture; CompInfo.Picture)
            {
            }

            column(Department; Department)
            {
            }

            column(RequestDate; "Request Date")
            {
            }

            column(Status; Status)
            {
            }

            column(TotalAmount; "Total Amount")
            {
            }

            dataitem(Line; "Employee Advance Line")
            {
                DataItemLink = "Request No." = field("Request No.");

                column(LineNo; "Line No.")
                {
                }

                column(ExpenseType; "Expense Type")
                {
                }


                column(Description; Description)
                {
                }

                column(Quantity; Quantity)
                {
                }

                column(UnitCost; "Unit Cost")
                {
                }

                column(LineAmount; "Line Amount")
                {
                }

                column(IsUrgent; "Is Urgent")
                {
                }
            }

        }

    }
    trigger OnPreReport()
    begin
        CompInfo.Get();
        CompInfo.CalcFields(Picture);
    end;

    var
        CompInfo: Record "Company Information";
}





