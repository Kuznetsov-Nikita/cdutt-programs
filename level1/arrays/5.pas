{ 5. Элемент массива с максимальным значением }
program Array5;

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
	n, i, max: Integer;

begin
        Randomize;

        ReadLn (n);

        InitArray(a, n);

        max := a[1];
        for i := 2 to n do
                if a[i] > max then
                        max := a[i];

        PrintArray(a, n);
        WriteLn (max)
end.

