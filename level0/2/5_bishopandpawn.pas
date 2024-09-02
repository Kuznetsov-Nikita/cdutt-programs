{ 2.5 Слон и пешка }
program BishopAndPawn;

var
        b, p: string;

begin
        ReadLn (b);
        ReadLn (p);

        if Abs(Ord(b[1]) - Ord(p[1])) = Abs(Ord(b[2]) - Ord(p[2])) then { (Ord(b[1]) - Ord(b[2]) = Ord(p[1]) - Ord(p[2])) or (Ord(b[1] + Ord(b[2]) = Ord(p[1]) + Ord(p[2]))
                WriteLn ('Бьёт')
        else
                WriteLn ('Не бьёт')
end.
{
a3
c5
Бьёт

a5
a3
Бьёт

a5
c3
Бьёт

a3
a5
Бьёт

a2
b4
Не бьёт
}
