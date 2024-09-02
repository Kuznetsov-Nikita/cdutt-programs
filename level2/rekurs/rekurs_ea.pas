program EuclideanAlgorithm;

function Gcd (a, b: LongWord): LongWord;
begin
        if b = 0 then
                Gcd := a
        else
                Gcd := Gcd(b, a mod b)
end;

var
        a, b: LongWord;

begin
        ReadLn (a, b);

        WriteLn ('НОД (', a, ', ', b, ') = ', Gcd(a, b))
end.
