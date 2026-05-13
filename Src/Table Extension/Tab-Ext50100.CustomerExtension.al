tableextension 50100 "Customer Extension" extends Customer
{
    fields
    {
        field(50100; "Employee Reference No."; Code[20])
        {
            Caption = 'Employee Reference No.';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                if "Is Internal Employee" and ("Employee Reference No." = '') then
                    Error('Employee Reference No. is required for internal employees.');
            end;
        }

        field(50101; "Employee Department"; Text[50])
        {
            Caption = 'Employee Department';
            DataClassification = CustomerContent;
        }

        field(50102; "Is Internal Employee"; Boolean)
        {
            Caption = 'Is Internal Employee';
            DataClassification = CustomerContent;
        }
    }
} 