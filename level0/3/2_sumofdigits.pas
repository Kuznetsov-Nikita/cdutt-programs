{ 3.2 Сумма цифр целого числа }
program SumOfDigits;

var
        a: QWord;
        s: Byte;

begin
        ReadLn (a);

        s := 0;

        while a <> 0 do begin
                s := s + a mod 10;
                a := a div 10
        end;

        WriteLn (s)
end.
{
123
6

0
0

Delphi
1000000000000000000
1

8999999999999999999
170

FP
10000000000000000000
1

9999999999999999999
171
}
