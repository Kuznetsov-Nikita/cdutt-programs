{ 3. Треугольные числа }
program Array3;

const
	SIZE = 1000;

type
        TArr = array [1..SIZE] of Integer;

procedure PrintArray(const a: TArr; n: Integer);
var
        i: Integer;
begin
        for i := 1 to n do
                Write (a[i], ' ');
        WriteLn
end;

var
	a: TArr;
	n, i: Integer;

begin
        ReadLn (n);

        a[1] := 1;

        for i := 2 to n do
                a[i] := a[i - 1] + i;

        PrintArray(a, n)
end.

