{ 3.10(б) Делители натурального числа }
program DivisorsOfNaturalNumber;

var
        n, i, sq: LongWord;

begin
        ReadLn (n);

        sq := Trunc(Sqrt(n));

        for i := 1 to sq - 1 do
                if n mod i = 0 then
                        Write (i, ' ', n div i, ' ');

        if n mod sq = 0 then
                if Sqr(sq) = n then
                        Write (sq)
                else
                        Write (sq, ' ', n div sq);
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
