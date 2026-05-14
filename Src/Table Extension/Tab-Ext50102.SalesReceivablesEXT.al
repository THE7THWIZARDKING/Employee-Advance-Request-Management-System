tableextension 50102 "Sales & Receivables EXT" extends "Sales & Receivables Setup"
{
    fields
    {
        field(50100; "Employee Advance Nos."; Code[20])
        {
            Caption = 'Employee Advance Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
}
