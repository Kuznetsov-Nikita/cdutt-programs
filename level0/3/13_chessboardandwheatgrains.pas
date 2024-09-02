{ 3.13 Шахматная доска и пшеничные зерна }
program ChessboardAndWheatGrains;

var
        n, s: Int64;
        k: Byte;

begin
        ReadLn (n);

        k := 1;
        s := 1;

        while s < n do begin
                s := s * 2;
                Inc(k)
        end;

        WriteLn (k)
end.
{
10
5

8
4

1
1

FP
9000000000000000000
64

Delphi
4000000000000000000
63
}
