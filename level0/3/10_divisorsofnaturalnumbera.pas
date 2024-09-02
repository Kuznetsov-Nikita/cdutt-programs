{ 3.10(a) Делители натурального числа }
program DivisorsOfNaturalNumber;

var
        n, i, sq: LongWord;
begin
        Read (n);

        i := 1;
        sq := Trunc(Sqrt(n));

        while i < sq do begin
                if n mod i = 0 then
                        Write (i, ' ', n div i, ' ');
                Inc(i)
        end;

        if n mod i = 0 then
                if Sqr(i) = n then
                        Write (i)
                else
                        Write (i, ' ', n div i);
        WriteLn
end.
{
24
1 24 2 12 3 8 4 6

17
1 17

16
1 16 2 8 4

15
1 15 3 5
}
