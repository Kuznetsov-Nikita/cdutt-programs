{ 3.3 Игра "Чет-Нечет" до трёх побед }
program GameEvenUnevenToTreeWins;

var
        cmp, usr, cmpv, usrv: Byte;

begin
        Randomize;

        usrv := 0;
        cmpv := 0;

        while (cmpv < 3) and (usrv < 3) do begin
                cmp := Random(2);

                ReadLn (usr);

                if usr = cmp then
                        Inc(usrv)
                else
                        Inc(cmpv);

                WriteLn (usrv, ' : ', cmpv)
        end;

        if usrv > cmpv then
                WriteLn ('Вы выиграли')
        else
                WriteLn ('Вы проиграли')
end.
