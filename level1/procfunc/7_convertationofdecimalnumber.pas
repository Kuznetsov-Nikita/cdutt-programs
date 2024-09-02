{ 7. Перевод десятичного числа в любую другую систему счисления }
program ConvertOfDecimalNumber;

function ConvertRadix (n: LongWord; r: Byte): string;
const
        DIGITS = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
begin
        ConvertRadix := '';

        repeat
                ConvertRadix := DIGITS[n mod r + 1] + ConvertRadix;
                n := n div r
        until n = 0;
end;

var
        x: LongWord;
        g: Byte;

begin
        ReadLn (x, g);

        WriteLn (x, ' = ', ConvertRadix(x, g), ' в ', g, ' системе счисления')
end.
{
574037080 30
574037080 = NIKITA в 30 системе счисления
}

