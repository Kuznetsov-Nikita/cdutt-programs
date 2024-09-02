program X_O_RandomGamer;

const
        EMPTY = -1;
        SIZE = 3;

type
        TGameState = record
                movenum: Integer;
                gamernum: Integer;
                field: array [1..SIZE, 1..SIZE] of Integer;

                move: record
                        row, col: Integer
                end
        end;

///////////////////////////Инициализация игровых данных////////////////////////

procedure InitGame (var gms: TGameState);
begin
        Randomize;

        with gms do begin
                FillChar(field, SizeOf(field), Byte(EMPTY));
                movenum := 0;
                ReadLn (gamernum)
        end
end;

///////////////////////////Процесс игры////////////////////////////////////////

function isOurMove (const gms: TGameState): Boolean;
begin
        isOurMove := gms.movenum mod 2 = gms.gamernum
end;

procedure GetMove (var gms: TGameState);
begin
        with gms, gms.move do
                repeat
                        row := Random(3) + 1;
                        col := Random(3) + 1
                until field[row, col] = EMPTY
end;

procedure MakeMove (var gms: TGameState);
begin
        with gms, gms.move do begin
                field[row, col] := movenum mod 2;
                Inc(movenum)
        end
end;

procedure WriteMove (const gms: TGameState);
begin
        with gms.move do
                WriteLn (Chr(col + Ord('a') - 1), Chr(row + Ord('0')))
end;

procedure ReadMove (var gms: TGameState);
var
        grow, gcol: Char;
begin
        ReadLn (gcol, grow);

        with gms.move do begin
                col := Ord(gcol) - Ord('a') + 1;
                row := Ord(grow) - Ord('0')
        end
end;

function isWinPos (const gms: TGameState): Boolean;
begin
        with gms, gms.move do
                isWinPos := ((field[row, 1] = field[row, 2]) and (field[row, 2] = field[row, 3])) or
                            ((field[1, col] = field[2, col]) and (field[2, col] = field[3, col])) or
                            ((field[1, 1] = field[2, 2]) and (field[3, 3] = field[2, 2]) or
                            (field[1, 3] = field[2, 2]) and (field[3, 1] = field[2, 2]) and (field[2, 2] <> EMPTY))
end;

function isGameOver (const gms: TGameState): Boolean;
begin
        with gms do
                isGameOver := isWinPos(gms) or (movenum = Sqr(SIZE))
end;

procedure PlayGame (var gms: TGameState);
begin
        repeat
                if isOurMove(gms) then begin
                        GetMove(gms);
                        WriteMove(gms)
                end
                else
                        ReadMove(gms);

                MakeMove(gms)
        until isGameOver(gms)
end;

///////////////////////////Подсчет результатов игры///////////////////////////

function isWinEndPos (const gms: TGameState): Boolean;
begin
        with gms, gms.move do
                isWinEndPos := (field[row, 1] = field[row, 2]) and (field[row, 2] = field[row, 3]) or
                            (field[1, col] = field[2, col]) and (field[2, col] = field[3, col]) or
                            (field[1, 1] = field[2, 2]) and (field[3, 3] = field[2, 2]) and
                            (field[1, 3] = field[2, 2]) and (field[3, 1] = field[2, 2]) and (field[2, 2] <> EMPTY)
end;


procedure ShowGameResults (const gms: TGameState);
begin
        with gms do
                if not isWinEndPos(gms) and (movenum = Sqr(SIZE)) then
                        WriteLn ('Ничья')
                else
                        if movenum mod 2 = 0 then
                                WriteLn ('Победил 2 игрок')
                        else
                                WriteLn ('Победил 1 игрок')
end;

//////////////////////////////////////////////////////////////////////////////

var
        gms: TGameState;

begin
        InitGame(gms);

        PlayGame(gms);

        ShowGameResults(gms)
end.
