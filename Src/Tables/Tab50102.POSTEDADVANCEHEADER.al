table 50102 "Posted Advance Header"
{
    Caption = 'Posted Advance Header';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Posted No."; Code[20])
        {
            Caption = 'Posted No.';
            DataClassification = CustomerContent;
        }

        field(2; "Employee No."; Code[20])
        {
            Caption = 'Employee No.';
            DataClassification = CustomerContent;
        }

        field(3; "Employee Name"; Text[100])
        {
            Caption = 'Employee Name';
            DataClassification = CustomerContent;
        }

        field(4; Department; Text[50])
        {
            Caption = 'Department';
            DataClassification = CustomerContent;
        }

        field(5; "Request Date"; Date)
        {
            Caption = 'Request Date';
            DataClassification = CustomerContent;
        }

        field(6; Status; Enum "Advance Status")
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
        }

        field(7; "Total Amount"; Decimal)
        {
            Caption = 'Total Amount';
            DataClassification = CustomerContent;
        }

        field(8; "Approved Amount"; Decimal)
        {
            Caption = 'Approved Amount';
            DataClassification = CustomerContent;
        }

        field(9; Remarks; Text[250])
        {
            Caption = 'Remarks';
            DataClassification = CustomerContent;
        }

        field(10; "Request No."; Code[20])
        {
            Caption = 'Request No.';
            DataClassification = CustomerContent;
        }

        field(11; "Posted Date"; Date)
        {
            Caption = 'Posted Date';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Posted No.")
        {
            Clustered = true;
        }
    }
}