{ 3.1(а) НОД (Алгоритм Евклида) }
program EuclideanAlgorithm;

var
        a, b: LongWord;

begin
        ReadLn (a, b);

        Write ('НОД (', a, ', ', b, ') = ');

        while a <> b do
                if a > b then
                        a := a - b
                else
                        b := b - a;

        WriteLn (a)
end.
{
17 17
НОД (17, 17) = 17

15 24
НОД (15, 24) = 3

13 33
НОД (13, 33) = 1

1 1000000000
НОД (1, 1000000000) = 1
}
