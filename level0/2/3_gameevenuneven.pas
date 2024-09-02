{ 2.3 Игра 'Чет-Нечет' }
program GameEvenUneven;

var
        cmp, usr: Byte;

begin
        Randomize;

        cmp := Random(2);

        ReadLn (usr);

        if usr = cmp then
                WriteLn ('Вы выиграли')
        else
                WriteLn ('Вы проиграли')
end.
