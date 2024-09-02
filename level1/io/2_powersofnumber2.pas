{ 2. Таблица степеней числа 2 }
program PowersOfNumber2;

var
        i: Byte;

begin
        for i := 0 to 16 do
                WriteLn (i : 2, 1 shl i : 11)
end.
