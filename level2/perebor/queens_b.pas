program TaskOfNQueens;

const
        SIZE = 20;
var
        FreeRows: array [1..SIZE] of Boolean;
        FreeDiagUp: array [-SIZE..SIZE] of Boolean;
        FreeDiagDn: array [2..2 * SIZE] of Boolean;

procedure NextQueen (k, n: Integer; var cnt: LongInt);
var
        r: Integer;
begin
        if k > n then begin
                Inc(cnt);
                Exit
        end;

        for r := 1 to n do
                if FreeRows[r] and FreeDiagUp[k - r] and FreeDiagDn[k + r] then begin
                        FreeRows[r] := FALSE;
                        FreeDiagUp[k - r] := FALSE;
                        FreeDiagDn[k + r] := FALSE;

                        NextQueen(k + 1, n, cnt);

                        FreeRows[r] := TRUE;
                        FreeDiagUp[k - r] := TRUE;
                        FreeDiagDn[k + r] := TRUE;
                end
end;

var
        n: Integer;
        cnt: LongInt;

begin
        ReadLn (n);

        cnt := 0;
        FillChar(FreeRows, SizeOf(FreeRows), TRUE);
        FillChar(FreeDiagUp, SizeOf(FreeDiagUp), TRUE);
        FillChar(FreeDiagDn, SizeOf(FreeDiagDn), TRUE);

        NextQueen(1, n, cnt);

        WriteLn (cnt)
end.
