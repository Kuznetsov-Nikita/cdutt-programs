{ 1.3 ФИО }
program SnNmPt;

var
        sn, nm, pt: string;

begin
        ReadLn (sn);
        ReadLn (nm);
        ReadLn (pt);

        WriteLn (sn, ' ', nm[1], '.', pt[1], '.')
end.
{
Иванов
Иван
Иванович
Иванов И.И.

Пушкин
Александр
Сергеевич
Пушкин А.С.
}
