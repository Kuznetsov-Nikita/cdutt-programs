{ 12(б). Сдвиг массива на m элементов вправо }
program Array12;

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

procedure SwapArray (var a: TArr; l, r: Integer);
var
        i: Integer;
begin
        for i := 0 to (r - l + 1) div 2 - 1 do
                Swap(a[l + i], a[r - i])
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
	n, m: Integer;

begin
        ReadLn (n, m);

        InitArray(a, n);

        PrintArray(a, n);

        m := m mod n;

        SwapArray(a, 1, n);
        SwapArray(a, 1, m);
        SwapArray(a, m + 1, n);

        PrintArray(a, n);
end.
