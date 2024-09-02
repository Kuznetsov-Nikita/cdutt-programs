{ 1. Сложение дробей }
program FractionsAddition;

function Gcd (p, q: LongInt): LongInt;
begin
        while (p <> 0) and (q <> 0) do
                if p > q then
                        p := p mod q
                else
                        q := q mod p;

        Gcd := p + q
end;

procedure PrintFraction (n, f: LongInt);
begin
        if n div f <> 0 then begin
                Write (n div f);
                if n mod f <> 0 then
                        WriteLn (' ', Abs(n mod f), '/', f)
        end
        else
                if n = 0 then
                        WriteLn ('0')
                else
                        WriteLn (n, '/', f)
end;

var
        a, b, c, d, t, n, f: LongInt;

begin
        ReadLn (a, b, c, d);

        t := Gcd (a, b);
        a := a div t;
        b := b div t;

        t := Gcd (c, d);
        c := c div t;
        d := d div t;

        t := Gcd (b, d);
        f := b div t * d;
        a := a * f div b;
        c := c * f div d;
        n := a + c;

        t := Gcd (n, f);
        n := n div t;
        f := f div t;

        PrintFraction (n, f)
end.
{
1 2 1 2
1

3 9 1 3
2/3

1 5 -1 5
0

1 4 9 4
2 1/2

-1 2 -1 2
-1

3 9 -2 3
-1/3
}
