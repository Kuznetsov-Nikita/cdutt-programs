{ Сортировка выбором (a) }
program SelectionSort;

const
	SIZE = 1000000;

type
        TArr = array [1..SIZE] of LongInt;

procedure ReadArray(var a: TArr; n: LongInt);
var
        i: LongInt;
begin
        for i := 1 to n do
                Read (a[i])
end;

procedure Swap(var a, b: LongInt);
var
        t: LongInt;
begin
        t := a;
        a := b;
        b := t
end;

procedure SortArray(var a: TArr; n: LongInt);
var
        i, j, min: LongInt;
begin
        for i := 1 to n - 1 do begin
                min := i;

                for j := i + 1 to n do
                        if a[j] < a[min] then
                                min := j;

                Swap(a[i], a[min])
        end
end;

procedure WriteArray(const a: TArr; n: LongInt);
var
        i: LongInt;
begin
        for i := 1 to n do
                Write (a[i], ' ');
        WriteLn
end;

var
	arr: TArr;
	n, m: LongInt;

begin
        ReadLn (n);
        ReadArray(arr, n);

        SortArray(arr, n);

        WriteArray(arr, n);
end.
