{ 3.4(a) Факториал }
program Factorial;

var
        n, m: Byte;
        f: QWord;

begin
        ReadLn (n);

        m := 2;
        f := 1;

        while m <= n do begin
                f := f * m;
                Inc(m)
        end;

        WriteLn (n, '! = ', f)
end.
{
5
5! = 120

0
0! = 0

Delphi
20
20! =  2432902008176640000

FP
20
20! =  2432902008176640000
}
