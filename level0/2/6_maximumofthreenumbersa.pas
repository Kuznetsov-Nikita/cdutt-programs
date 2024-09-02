{ 2.6(a) Наибольшее из трех чисел }
program MaximumOfThreeNumbers;

var
        a, b, c, m: LongInt;

begin
        ReadLn (a, b, c);

        if a > b then
                m := a
        else
                m := b;

        if c > m then
                m := c;

        WriteLn (m)
end.
{
1 2 3
3

1 3 2
3

2 1 3
3

2 3 1
3

3 1 2
3

3 2 1
3

1 1 3
3

1 3 1
3

3 1 1
3

1 3 3
3

3 1 3
3

3 3 1
3

3 3 3
3

-1 -2 -3
-1

-1000000000 0 1000000000
1000000000
}
