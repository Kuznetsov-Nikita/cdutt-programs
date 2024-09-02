{ 5. Перевод из десятичной системы счисления в шестнадцатеричную }
program DecToHex;

function Hex (n: LongWord): string;
const
        HEXDIGITS = '0123456789ABCDEF';
begin
        Hex := '';

        repeat
                Hex := HEXDIGITS[n mod 16 + 1] + Hex;
                n := n div 16
        until n = 0
end;

var
        x: LongWord;

begin
        ReadLn (x);

        WriteLn (x, ' = ', Hex(x), 'H')
end.
