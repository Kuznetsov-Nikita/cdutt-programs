{ 3.16(а) Числа Фибоначчи }
program FibonachiNumbers;

var
        fa, fb, t: QWord;
        n, k: Byte;

begin
        ReadLn (n);

        fa := 1;
        fb := 1;
        k := 2;

        while k < n do begin
                t := fa + fb;
                fa := fb;
                fb := t;

                Inc(k)
        end;

        WriteLn (fb)
end.
{
8
21

1
1

2
1

FP
93
12200160415121876738

Delphi
92
7540113804746346429
}
