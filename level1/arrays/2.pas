{ 2. Значение элементов массива от n до 1 }
program Array2;

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
                a[i] := n - i + 1;

        PrintArray(a, n)
end.

