{ 12(a). Сдвиг массива на m элементов вправо }
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

{procedure SwapArray (var a: TArr; l, r: Integer);
var
        i: Integer;
begin
        for i := 0 to (r - l + 1) div 2 - 1 do
                Swap(a[l + i], a[r - i])
end;}

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
	n, m, ti, i, j, t: Integer;

begin
        ReadLn (n, m);

        InitArray(a, n);

        PrintArray(a, n);

        m := m mod n;

        ti := 1;
        t := a[1];
        j := 1 + m;
        for i := 1 to n do
                if (j <> ti) and (i <> 1) then begin
                        Swap(a[j], t);
                        j := (j + m) mod n;
                        if j = 0 then
                                j := n
                end
                else begin
                        Inc(j);
                        ti := j;
                        Swap(a[j], t);
                        j := (j + m) mod n;
                        if j = 0 then
                                j := n
                end;

        PrintArray(a, n);
end.
