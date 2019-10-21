enum 50002 "TTT-PR WsTestAuthenticationType"
{
    Extensible = true;

    value(0; Basic)
    {
        Caption = 'Basic';
    }
    value(1; OAuth)
    {
        Caption = 'OAuth';
    }
    value(2; Windows)
    {
        Caption = 'Windows';
    }
    value(3; Default)
    {
        Caption = 'Default';
    }
    value(4; Anonymous)
    {
        Caption = 'Anonymous';
    }
}