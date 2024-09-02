{ Сортировка вставкой (г) }
program InsertionSort;

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

function BinarySearch(const a: TArr; n: LongInt): LongInt;
var
        l, r, m: LongInt;
begin
        l := 0;
        r := n;

        while r - l > 1 do begin
                m := l + (r - l) shr 1;

                if a[m] >= a[n] then
                        r := m
                else
                        l := m
        end;

        BinarySearch := r
end;

procedure SortArray(var a: TArr; n: LongInt);
var
        i, j, t: LongInt;
begin
        for i := 2 to n do begin
                t := a[i];

                j := BinarySearch(a, i);

                Move(a[j], a[j + 1], (i - j) * SizeOf(a[j]));

                a[j] := t
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
