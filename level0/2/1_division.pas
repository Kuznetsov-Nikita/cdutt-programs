{ 2.1 Деление }
program Division;

var
        a, b: Integer;
        r: Double;

begin
        ReadLn (a, b);

        if b = 0 then
                WriteLn ('На ноль делить нельзя!')
        else begin
                r := a / b;
                WriteLn (a, ' : ', b, ' = ', r : 0 : 2)
        end
end.
{
4 2
4 : 2 = 2.00

5 0
На ноль делить нельзя!

1000 1
1000 : 1 = 1000.00

-1000 1
-1000 : 1 = -1000.00

-27 -3
-27 : -3 = 9.00
}
