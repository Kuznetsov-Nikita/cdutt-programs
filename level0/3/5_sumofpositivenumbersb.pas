{ 3.5(б) Сумма положительных элементов последовательности }
program SumOfPositiveNumbers;

var
        a: Integer;
        s: QWord;

begin
        s := 0;

        Read (a);

        while a <> 0 do begin
                if a > 0 then
                        s := s + a;
                Read (a)
        end;

        WriteLn;
        WriteLn (s)
end.
{
-3 2 4 -1 -7 0
6

0
0

Дополнительное задание:
Дана последовательность целых чисел (в диапазоне от -32000 до 32000), заканчивающаяся нулём,
максимальное число чисел в последовательности 1000000000. Найти сумму положительных чисел, входящих в эту последовательность.

1000000000 чисел со значением 32000
}
