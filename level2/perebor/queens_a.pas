program TaskOfNQueens;

const
        SIZE = 20;

type
        TQueens = array [1..SIZE] of Integer;

function RightPos (const q: TQueens; row, col: Integer): Boolean;
var
        i: Integer;
begin
        RightPos := FALSE;

        for i := 1 to col - 1 do
                if (q[i] = row) or (Abs(q[i] - row) = Abs(col - i)) then
                        Exit;

        RightPos := TRUE
end;

procedure NextQueen (var q: TQueens; k, n: Integer; var cnt: LongInt);
var
        r: Integer;
begin
        if k > n then begin
                Inc(cnt);
                Exit
        end;

        for r := 1 to n do
                if RightPos(q, r, k) then begin
                        q[k] := r;
                        NextQueen(q, k + 1, n, cnt)
                end
end;

var
        n: Integer;
        cnt: LongInt;
        queens: TQueens;

begin
        ReadLn (n);

        cnt := 0;
        NextQueen(queens, 1, n, cnt);

        WriteLn (cnt)
end.
