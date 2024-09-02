{ 6. Поменять местами максимальный и минимальный элементы массива }
program Array6;

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

procedure Swap(var a, b: Integer);
var
        t: Integer;
begin
        t := a;
        a := b;
        b := t
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
	n, i, maxi, mini: Integer;

begin
        Randomize;

        ReadLn (n);

        InitArray(a, n);

        maxi := 1;
        mini := 1;
        for i := 2 to n do
                if a[i] > a[maxi] then
                        maxi := i
                else
                        if a[i] < a[mini] then
                                mini := i;

        PrintArray(a, n);

        Swap(a[maxi], a[mini]);

        PrintArray(a, n);
end.

