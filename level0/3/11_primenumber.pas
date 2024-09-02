{ 3.11 Простое число }
program PrimeNumber;

var
        n, i, sq: LongWord;

begin
        ReadLn (n);

        i := 2;
        sq := Trunc(Sqrt(n));

        while (i <= sq) and (n mod i <> 0) do
                Inc(i);

        if i <= sq then
                WriteLn ('Составное')
        else
                WriteLn ('Простое')
end.
{
24
Составное

15
Составное

17
Простое

2000000000
Составное

1919999197
Простое
}
