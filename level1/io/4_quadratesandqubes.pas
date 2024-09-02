{ 4. Таблица квадратов и кубов от 1 до 15 }
program QuadratesAndQubes;

var
        i: Word;

begin
        for i := 1 to 15 do
                WriteLn (i : 2, Sqr(i) : 4, Sqr(i) * i : 6)
end.
