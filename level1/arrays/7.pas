{ 7. Заменить на 0 все отрицательные элементы массива }
program Array7;

const
	SIZE = 1000;

type
        TArr = array [1..SIZE] of Integer;

procedure InitArray(var a: TArr; n: Integer);
const
        LEFT = -100;
        RIGHT = 100;
var
        i: Integer;
begin
        for i := 1 to n do
                a[i] := Random(RIGHT - LEFT + 1) + LEFT
end;

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
        Randomize;

        ReadLn (n);

        InitArray(a, n);

        PrintArray(a, n);

        for i := 1 to n do
                if a[i] < 0 then
                        a[i] := 0;

        PrintArray(a, n)
end.
