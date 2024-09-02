{ 2.8(a) Возраст }
program MyAge;

uses
        Dos;

var
        d, m, y, td, tm, ty, twd, age: Word;

begin
        ReadLn (d, m, y);

        GetDate(ty, tm, td, twd);

        age := ty - y;

        if (tm < m) or ((tm = m) and (td < d)) then
                Dec(age);

        WriteLn ('Вам ', age, ' лет')
end.
{
Сегодня 20. 04. 2018

1 1 2004
Вам 14 лет

20 1 2004
Вам 14 лет

25 1 2004
Вам 14 лет

1 4 2004
Вам 14 лет

20 4 2004
Вам 14 лет

25 4 2004
Вам 13 лет

1 5 2004
Вам 13 лет

20 5 2004
Вам 13 лет

25 5 2004
Вам 13 лет
}
