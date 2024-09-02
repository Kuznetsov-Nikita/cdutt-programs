program PowerOfA;

function Power (a, n: Word): QWord;
begin
        if n = 0 then
                Power := 1
        else
                Power := a * Power(a, n - 1)
end;

var
        a, n: Word;

begin
        ReadLn (a, n);

        WriteLn (a, '^', n, ' = ', Power(a, n))
end.
