{ 2.2 Функция }
program FunctionY;

var
        x, y: Double;

begin
        ReadLn (x);

        if x >= 0 then
                y := x - 5
        else
                y := 2 * x;

        WriteLn ('y = ', y : 0 : 1)
end.
{
2
y = -3.0

0
y = -5.0

-3
y = -6.0

2.5
y = -2.5

10
y = 5.0
}
