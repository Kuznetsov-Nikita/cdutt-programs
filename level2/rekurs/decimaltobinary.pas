program DecimalToBinary;

function DecToBin (a: LongWord): string;
begin
        if a <= 1 then
                DecToBin := Chr(a + 48)
        else
                DecToBin := DecToBin(a div 2) + Chr(a mod 2 + 48)
end;

var
        n: LongWord;

begin
        ReadLn (n);

        WriteLn (n, ' = ', DecToBin(n), 'B')
end.
