{ 3.8(б) Максимальное из n чисел }
program MaximumNumber;

var
        n, k: LongWord;
        a, max: LongInt;

begin
        Read (n, max);

        for k := 2 to n do begin
                Read (a);

                if a > max then
                        max := a
        end;

        WriteLn (max)
end.
{
5
-3 4 0 -2 2
4

3
-1 -2 -5
-1

Дополнительное задание:
Дано натуральное число n (диапазона от 0 до 2000000000). Далее через пробел вводятся n целых чисел (диапазона от -2000000000 до 2000000000). Найти максимальное из данных n чисел.

2000000000 чисел со значениями, которые будут возрастать на 1, начиная от 1 и заканчивая 2000000000
}
