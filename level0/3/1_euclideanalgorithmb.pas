{ 3.1(б) НОД (Алгоритм Евклида) }
program EuclideanAlgorithm;

var
        a, b: LongWord;

begin
        ReadLn (a, b);

        Write ('НОД (', a, ', ', b, ') = ');

        while (a <> 0) and (b <> 0) do
                if a > b then
                        a := a mod b
                else
                        b := b mod a;

        WriteLn (a + b)
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
