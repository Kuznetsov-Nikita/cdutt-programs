{ 2.7 Квадратное уравнение }
program QuadraticEquation;

var
        a, b, c: Integer;
        d: LongInt;
        x1, x2: Double;

begin
        Readln (a, b, c);

        d := Sqr(b) - 4 * a * c;

        if d < 0 then
                WriteLn ('Вещественных корней нет')
        else
                if d = 0 then begin
                        x1 := - b / (2 * a);
                        WriteLn ('x1 = ', x1 : 0 : 3)
                end
                else begin
                        x1 := (- b - Sqrt(d)) / (2 * a);
                        x2 := (- b + Sqrt(d)) / (2 * a);
                        WriteLn ('x1 = ', x1 : 0 : 3, ' x2 = ', x2 : 0 : 3)
                end
end.
{
1 2 1
x1 = -1.000

2 5 7
Вещественных корней нет

3 5 -8
x1 = 1.000 x2 = -2.667

1000 1000 -1000
x1 = -1.618 x2 = 0.618
}
