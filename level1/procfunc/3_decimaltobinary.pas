{ 3. Перевод из десятичной системы счисления в двоичную }
program DecimalToBinary;

function Bin (n: LongWord): string;
begin
        Bin := '';

        repeat
                Bin := Chr(n mod 2 + 48) + Bin;
                n := n div 2
        until n = 0;
end;

var
        x: LongWord;

begin
        ReadLn (x);

        WriteLn (x, ' = ', Bin (x), ' B')
end.
