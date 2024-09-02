{ 9. Сдвиг массива вправо на 1 }
program Array9;

const
	SIZE = 1000;

type
        TArr = array [1..SIZE] of Integer;

procedure InitArray(var a: TArr; n: Integer);
var
        i: Integer;
begin
        for i := 1 to n do
                a[i] := i;
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
	n, t, i: Integer;

begin
        ReadLn (n);

        InitArray(a, n);

        PrintArray(a, n);

        t := a[n];

        for i := n downto 2 do
                a[i] := a[i - 1];

        a[1] := t;

        PrintArray(a, n)
end.
