{ 4. Массив рандомных чисел }
program Array4;

const
	SIZE = 1000;
        LEFT = -5;
        RIGHT = 5;

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
        Randomize;

        ReadLn (n);

        for i := 1 to n do
                a[i] := Random(RIGHT - LEFT + 1) + LEFT;

        PrintArray(a, n)
end.

