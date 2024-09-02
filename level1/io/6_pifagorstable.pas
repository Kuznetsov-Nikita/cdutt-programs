{ 6. Таблица Пифагора }
program PifagorsTable;

var
        i, j: Byte;

begin
        WriteLn ('ТАБЛИЦА ПИФАГОРА' : 24);
        WriteLn ('  |  1  2  3  4  5  6  7  8  9');
        WriteLn ('-------------------------------');

        for i := 1 to 9 do begin
                Write (i, ' |');
                for j := 1 to 9 do
                        Write (i * j : 3);
                WriteLn
        end
end.
