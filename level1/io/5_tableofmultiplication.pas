{ 5. Таблица умножения от 2 до 9 }
program TableOfMultiplication;

var
        i, j: Byte;

begin
        WriteLn ('ТАБЛИЦА УМНОЖЕНИЯ' : 33);

        for i := 1 to 9 do begin
                for j := 2 to 5 do
                        Write (j, ' x ', i, ' =', j * i : 3, '   ');
                WriteLn
        end;

        WriteLn;

        for i := 1 to 9 do begin
                for j := 6 to 9 do
                        Write (j, ' x ', i, ' =', j * i : 3, '   ');
                WriteLn
        end
end.

