{ 1.1 Сумма двух целых чисел }
program SumOfTwoNumbers;

var
        a, b, c: Integer;

begin
        ReadLn (a, b);

        c := a + b;

        WriteLn (a, ' + ', b, ' = ', c)
end.
{
3 5
3 + 5 = 8

-3 -5
-3 + -5 = -8

-3 5
-3 + 5 = 2

3 -5
3 + -5 = -2

0 0
0 + 0 = 0

0 1
0 + 1 = 1

-1 0
-1 + 0 = -1

1000 1000
1000 + 1000 = 2000

-1000 -1000
-1000 + -1000 = -2000
}