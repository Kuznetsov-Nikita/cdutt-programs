{ 2.6(б) Наибольшее из трех чисел }
program MaximumOfThreeNumbers;

var
        a, b, c, m: LongWord;

begin
        ReadLn (a, b, c);

        if a > b then
                if a > c then
                        m := a
                else
                        m := c
        else
                if b > c then
                        m := b
                else
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
