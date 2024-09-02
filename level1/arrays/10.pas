{ 10. Зеркальный массив }
program Array10;

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
	n, i: Integer;

begin
        Randomize;

        ReadLn (n);

        InitArray(a, n);

        PrintArray(a, n);

        for i := 1 to n div 2 do
                Swap(a[i], a[n - i + 1]);

        PrintArray(a, n);
end.
