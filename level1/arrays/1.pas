{ 1. Значение элемента массива на 1 больше индекса }
program Array1;

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

        for i := 1 to n do
                a[i] := i + 1;

        PrintArray(a, n)
end.

