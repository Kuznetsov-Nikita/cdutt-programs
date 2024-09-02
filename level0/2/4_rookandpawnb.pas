{ 2.4(б) Ладья и пешка }
program RookAndPawn;

var
        cp, cr: string;

begin
        ReadLn (cp);
        ReadLn (cr);

        if (cp[1] = cr[1]) or (cp[2] = cr[2]) then
                WriteLn ('Бьёт')
        else
                WriteLn ('Не бьёт')
end.
{
a1
a3
Бьёт

c5
b5
Бьёт

h6
h3
Бьёт

b4
c4
Бьёт

d7
h8
Не бьёт
}
