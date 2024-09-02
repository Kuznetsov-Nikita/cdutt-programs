{ 3.4(б) Факториал }
program Factorial;

var
        n, m: Byte;
        f: QWord;

begin
        ReadLn (n);

        f := 1;

        for m := 2 to n do
                f := f * m;

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
20! = 2432902008176640000
}
