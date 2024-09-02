{ 1.2 Сумма цифр двузначного числа }
program SumOfDigits;

var
        a, d, e: Byte;

begin
        ReadLn (a);

        d := a div 10;
        e := a mod 10;

        WriteLn (d + e)
end.
{
21
3

50
5

10
1

99
18
}
