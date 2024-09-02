{ 11. Зеркальная часть массива }
program Array11;

const
	SIZE = 1000;

type
        TArr = array [1..SIZE] of Integer;

procedure InitArray(var a: TArr; n: Integer);
var
        i: Integer;
begin
        for i := 1 to n do
                a[i] := i
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
	n, i, l, r: Integer;

begin
        ReadLn (n, l, r);

        InitArray(a, n);

        PrintArray(a, n);

        for i := 0 to (r - l + 1) div 2 - 1 do
                Swap(a[l + i], a[r - i]);

        PrintArray(a, n);
end.
