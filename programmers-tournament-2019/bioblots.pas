{ Игра "Биокляксы": финальная версия }
program BioBlots;

const
        EMPTY = 0;            // Значение свободной клетки
        SIZE = 26;            // Размер поля
        NULL = 0;             // Пропуск хода

        { Химикаты }
        CARBON = 15;          // Углерод
        HYDRARGIUM = 4;       // Ртуть
        URAN = 13;            // Уран

type
        TField = array [1..SIZE, 1..SIZE] of Integer;
        GameState = record
                field: array [1..SIZE, 1..SIZE] of Integer;   //Поле для игры

                movenum: Word;                          // Номер текущего хода
                gamernum: Word;                         // Номер нашего игрока
                n: Word;                                // Количество клеток хода
                nextn: Word;                            // Показатель того была ли ртуть

                firstmove: array [1..4] of record       // Первый ход
                                row, col: Integer
                end;

                numberofcells: array [0..1] of Word;    // Количество клеток
                cells: array [1..Sqr(SIZE), 0..1] of record // Список клеток
                                row, col: Integer
                        end;

                aktivecells: array [1..Sqr(SIZE)] of Word; // Доступна ли клетка для хода: 0 да, 1 нельзя ходить, 2 нельзя ни ходить ею ни к ней

                aktivefield: array [1..SIZE, 1..SIZE] of Boolean; // Доступно ли поле для хода

                move: array [1..100] of record    // Ходы
                                startpos, finishpos: record
                                        row, col: Integer
                                end
                        end;

                score: array [0..1] of Word;            // Счет игры
        end;

//////////////////////////////////////////////////////////////////////////////
// Инициализация игры ////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

{ Чтение поля }
procedure ReadField(var gms: GameState);
var
        i, j: Word;
        chemical: Char;
begin
        with gms do
                for i := 1 to SIZE do begin
                        for j := 1 to SIZE do begin
                                Read (chemical);

                                if chemical = 'D' then
                                        field[i, j] := URAN
                                else
                                        field[i, j] := Ord(chemical) - Ord('0')
                        end;
                        ReadLn
                end
end;

{ Инициализация игры }
procedure InitGame(var gms: GameState);
begin
        ReadField(gms);                                 // Читаем поле

        ReadLn (gms.gamernum);                          // Читаем номер нашего игрока

        gms.movenum := 0;

        gms.score[0] := 0;
        gms.score[1] := 0;

        FillChar(gms.aktivecells, SizeOf(gms.aktivecells), 0);
        FillChar(gms.aktivefield, SizeOf(gms.aktivefield), TRUE);

        gms.nextn := 1
end;

//////////////////////////////////////////////////////////////////////////////
// Процесс игры //////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

{ Поставить организм }
procedure PutOrganism(var gms: GameState);
var
        i: Word;
begin
        gms.numberofcells[gms.movenum mod 2] := 4;

        for i := 1 to 4 do begin
                if (gms.field[gms.firstmove[i].row, gms.firstmove[i].col] = 8) and (gms.movenum mod 2 = gms.gamernum) then
                        gms.nextn := NULL;

                Inc(gms.score[gms.movenum mod 2], gms.field[gms.firstmove[i].row, gms.firstmove[i].col]);
                gms.field[gms.firstmove[i].row, gms.firstmove[i].col] := gms.movenum mod 2 - 2;
                gms.cells[i, gms.movenum mod 2].row := gms.firstmove[i].row;
                gms.cells[i, gms.movenum mod 2].col := gms.firstmove[i].col
        end;

        Inc(gms.movenum)
end;

{ Получить первый ход }
{ Есть предложение переписать: искать не 2х2 максимальную сумму, а больше, например 5х5 }
procedure GetFirstMove(var gms: GameState);
var
        i, j, max, maxrow, maxcol: Word;
begin
        max := 0;

        for i := 1 to SIZE - 1 do
                for j := 1 to SIZE - 1 do
                        if (gms.field[i, j] + gms.field[i + 1, j] + gms.field[i, j + 1] + gms.field[i + 1, j + 1] > max) and (gms.field[i, j] <> 8) and (gms.field[i + 1, j] <> 8) and (gms.field[i, j + 1] <> 8) and (gms.field[i + 1, j + 1] <> 8) and
                           (gms.field[i, j] > 0) and (gms.field[i + 1, j] > 0) and (gms.field[i, j + 1] > 0) and (gms.field[i + 1, j + 1] > 0) then begin
                                maxrow := i;
                                maxcol := j;
                                max := gms.field[i, j] + gms.field[i + 1, j] + gms.field[i, j + 1] + gms.field[i + 1, j + 1]
                        end;

        gms.firstmove[1].row := maxrow;
        gms.firstmove[1].col := maxcol;
        gms.firstmove[2].row := maxrow;
        gms.firstmove[2].col := maxcol + 1;
        gms.firstmove[3].row := maxrow + 1;
        gms.firstmove[3].col := maxcol;
        gms.firstmove[4].row := maxrow + 1;
        gms.firstmove[4].col := maxcol + 1
end;

{ Прочитать первый ход }
procedure ReadFirstMove(var gms: GameState);
var
        i: Word;
        c: Char;
begin
        for i := 1 to 4 do begin
                Read (c);                                       // Прочитать строку
                gms.firstmove[i].row := Ord(c) - Ord('a') + 1;
                Read (c);                                       // Прочитать столбец
                gms.firstmove[i].col := Ord(c) - Ord('a') + 1;
                Read (c)                                        // Прочитать пробел
        end
end;

{ Вывести первый ход }
procedure WriteFirstMove(var gms: GameState);
var
        i, j: Word;
begin
        for i := 1 to 3 do
                Write (Chr(gms.firstmove[i].row + Ord('a') - 1), Chr(gms.firstmove[i].col + Ord('a') - 1), ' ');

        Write (Chr(gms.firstmove[4].row + Ord('a') - 1), Chr(gms.firstmove[4].col + Ord('a') - 1));

        WriteLn;
        Flush(output);

        for i := 1 to SIZE do
                for j := 1 to SIZE do begin
                        if gms.field[i, j] = 8 then
                                gms.field[i, j] := HYDRARGIUM
                        else
                                if gms.field[i, j] = 1 then
                                        gms.field[i, j] := CARBON
                end;
end;

{ Сделать первый ход }
procedure FirstMove(var gms: GameState);
begin
        if gms.movenum mod 2 = gms.gamernum then begin
                GetFirstMove(gms);
                PutOrganism(gms);
                WriteFirstMove(gms);
                ReadFirstMove(gms);
                PutOrganism(gms)
        end
        else begin
                ReadFirstMove(gms);
                PutOrganism(gms);
                GetFirstMove(gms);
                PutOrganism(gms);
                WriteFirstMove(gms)
        end
end;

//////////////////////////////////////////////////////////////////////////////

{ Заперт ли игрок }
function CanntMove(const gms: GameState): Boolean;
var
        i, cnt1, cnt2: Word;
begin
        cnt1 := 0;
        cnt2 := 0;

        for i := 1 to gms.numberofcells[0] do begin
                if (gms.cells[i, 0].row <> 1) and (gms.field[gms.cells[i, 0].row - 1, gms.cells[i, 0].col] >= 0) then
                        Inc(cnt1);
                if (gms.cells[i, 0].col <> 1) and (gms.field[gms.cells[i, 0].row, gms.cells[i, 0].col - 1] >= 0) then
                        Inc(cnt1);
                if (gms.cells[i, 0].row <> SIZE) and (gms.field[gms.cells[i, 0].row + 1, gms.cells[i, 0].col] >= 0) then
                        Inc(cnt1);
                if (gms.cells[i, 0].col <> SIZE) and (gms.field[gms.cells[i, 0].row, gms.cells[i, 0].col + 1] >= 0) then
                        Inc(cnt1);

                if cnt1 <> 0 then
                        Break
        end;

        for i := 1 to gms.numberofcells[1] do begin
                if (gms.cells[i, 1].row <> 1) and (gms.field[gms.cells[i, 1].row - 1, gms.cells[i, 1].col] >= 0) then
                        Inc(cnt2);
                if (gms.cells[i, 1].col <> 1) and (gms.field[gms.cells[i, 1].row, gms.cells[i, 1].col - 1] >= 0) then
                        Inc(cnt2);
                if (gms.cells[i, 1].row <> SIZE) and (gms.field[gms.cells[i, 1].row + 1, gms.cells[i, 1].col] >= 0) then
                        Inc(cnt2);
                if (gms.cells[i, 1].col <> SIZE) and (gms.field[gms.cells[i, 1].row, gms.cells[i, 1].col + 1] >= 0) then
                        Inc(cnt2);

                if cnt2 <> 0 then
                        Break
        end;

        CanntMove := (cnt1 = 0) or (cnt2 = 0);
end;

{ Определение пустоты поля }
function isFieldEmpty(const gms: GameState): Boolean;
var
        i, j, cnt: Word;
begin
        cnt := 0;

        for i := 1 to SIZE do
                for j := 1 to SIZE do
                        if gms.field[i, j] < 1 then
                                Inc(cnt);

        isFieldEmpty := cnt = Sqr(SIZE)
end;

{ Проверка конца игры }
function isGameOver(const gms: GameState): Boolean;
begin
        isGameOver := CanntMove(gms) or isFieldEmpty(gms) or (gms.movenum >= 160)
end;

//////////////////////////////////////////////////////////////////////////////

{ Проверка принадлежности хода }
function isOurMove(const gms: GameState): Boolean;
begin
        isOurMove := gms.movenum mod 2 = gms.gamernum;
end;

//////////////////////////////////////////////////////////////////////////////

{ Отмечает все соединенные клетки }
procedure NextCell(row, col: Word; var cellszone: TField);
begin
        cellszone[row, col] := 0;
        if (row <> 1) and (cellszone[row - 1, col] = 1) then
                NextCell(row - 1, col, cellszone);
        if (col <> 1) and (cellszone[row, col - 1] = 1) then
                NextCell(row, col - 1, cellszone);
        if (row <> SIZE) and (cellszone[row + 1, col] = 1) then
                NextCell(row + 1, col, cellszone);
        if (col <> SIZE) and (cellszone[row, col + 1] = 1) then
                NextCell(row, col + 1, cellszone);
end;

{ Проверяет неделимость недвижимой части }
function isPosibleMove2(gms: GameState; i, j, row, col: Word): Boolean;
var
        k, l, cnt: Word;
        cellszone: TField;
begin
        FillChar(cellszone, SizeOf(cellszone), 0);

        for k := 1 to gms.numberofcells[gms.gamernum] do
                if k <> i then
                        cellszone[gms.cells[k, gms.gamernum].row, gms.cells[k, gms.gamernum].col] := 1;

        cellszone[gms.cells[i, gms.gamernum].row, gms.cells[i, gms.gamernum].col] := 0;
        cellszone[row, col] := 0;

        for k := 1 to gms.n do
                cellszone[gms.move[k].startpos.row, gms.move[k].startpos.col] := 0;

        cnt := 0;
        NextCell(gms.cells[j, gms.gamernum].row, gms.cells[j, gms.gamernum].col, cellszone);

        for k := 1 to SIZE do begin
                for l := 1 to SIZE do
                        if cellszone[k, l] <> 0 then
                                Inc(cnt);
                if cnt <> 0 then
                        Break
        end;

        isPosibleMove2 := cnt = 0
end;

{ Проверяет возможность хода }
function isPosibleMove(gms: GameState; i, j, row, col: Word): Boolean;
var
        cnt, k, l: Word;
        cellszone: TField;
        curcells: array [1..Sqr(SIZE)] of record
                                row, col: Integer
                        end;
begin
        FillChar(cellszone, SizeOf(cellszone), 0);

        for k := 1 to gms.numberofcells[gms.gamernum] do begin
                curcells[k].row := gms.cells[k, gms.gamernum].row;
                curcells[k].col := gms.cells[k, gms.gamernum].col
        end;

        gms.field[curcells[i].row, curcells[i].col] := EMPTY;
        curcells[i].row := row;
        curcells[i].col := col;

        gms.field[row, col] := gms.gamernum - 2;

        for k := 1 to gms.n do begin
                if gms.field[gms.move[k].finishpos.row, gms.move[k].finishpos.col] <> CARBON then
                        gms.field[gms.move[k].startpos.row, gms.move[k].startpos.col] := EMPTY
                else begin
                        Inc(gms.numberofcells[gms.gamernum]);
                        curcells[gms.numberofcells[gms.gamernum]].row := gms.move[k].startpos.row;
                        curcells[gms.numberofcells[gms.gamernum]].col := gms.move[k].startpos.col;
                end;

                l := 1;
                while (curcells[l].row <> gms.move[k].startpos.row) or (curcells[l].col <> gms.move[k].startpos.col) do
                        Inc(l);

                curcells[l].row := gms.move[k].finishpos.row;
                curcells[l].col := gms.move[k].finishpos.col
        end;

        for k := 1 to gms.numberofcells[gms.gamernum] do
                cellszone[curcells[k].row, curcells[k].col] := 1;

        cellszone[curcells[1].row, curcells[1].col] := 0;
        if (curcells[1].row <> 1) and (cellszone[curcells[1].row - 1, curcells[1].col] = 1) then
                NextCell(curcells[1].row - 1, curcells[1].col, cellszone);
        if (curcells[1].col <> 1) and (cellszone[curcells[1].row, curcells[1].col - 1] = 1) then
                NextCell(curcells[1].row, curcells[1].col - 1, cellszone);
        if (curcells[1].row <> SIZE) and (cellszone[curcells[1].row + 1, curcells[1].col] = 1) then
                NextCell(curcells[1].row + 1, curcells[1].col, cellszone);
        if (curcells[1].col <> SIZE) and (cellszone[curcells[1].row, curcells[1].col + 1] = 1) then
                NextCell(curcells[1].row, curcells[1].col + 1, cellszone);

        cnt := 0;
        for k := 1 to gms.numberofcells[gms.gamernum] do
                if cellszone[curcells[k].row, curcells[k].col] = 0 then
                        Inc(cnt);

        isPosibleMove := cnt = gms.numberofcells[gms.gamernum]
end;

{ Выбирает ход }
procedure SelectMove(const gms: GameState; var max, maxrow, maxcol, maxnum, j, i: Word);
begin
        if (gms.cells[j, gms.gamernum].row <> 1) and (gms.field[gms.cells[j, gms.gamernum].row - 1, gms.cells[j, gms.gamernum].col] >= max) and (gms.aktivecells[j] <> 2) and
        isPosibleMove(gms, i, j, gms.cells[j, gms.gamernum].row - 1, gms.cells[j, gms.gamernum].col) and gms.aktivefield[gms.cells[j, gms.gamernum].row - 1, gms.cells[j, gms.gamernum].col] and
        isPosibleMove2(gms, i, j, gms.cells[j, gms.gamernum].row - 1, gms.cells[j, gms.gamernum].col) then begin
                max := gms.field[gms.cells[j, gms.gamernum].row - 1, gms.cells[j, gms.gamernum].col];
                maxrow := gms.cells[j, gms.gamernum].row - 1;
                maxcol := gms.cells[j, gms.gamernum].col;
                maxnum := j
        end;

        if (gms.cells[j, gms.gamernum].col <> 1) and (gms.field[gms.cells[j, gms.gamernum].row, gms.cells[j, gms.gamernum].col - 1] >= max) and (gms.aktivecells[j] <> 2) and
        isPosibleMove(gms, i, j, gms.cells[j, gms.gamernum].row, gms.cells[j, gms.gamernum].col - 1) and gms.aktivefield[gms.cells[j, gms.gamernum].row, gms.cells[j, gms.gamernum].col - 1] and
        isPosibleMove2(gms, i, j, gms.cells[j, gms.gamernum].row, gms.cells[j, gms.gamernum].col - 1) then begin
                max := gms.field[gms.cells[j, gms.gamernum].row, gms.cells[j, gms.gamernum].col - 1];
                maxrow := gms.cells[j, gms.gamernum].row;
                maxcol := gms.cells[j, gms.gamernum].col - 1;
                maxnum := j
        end;

        if (gms.cells[j, gms.gamernum].row <> SIZE) and (gms.field[gms.cells[j, gms.gamernum].row + 1, gms.cells[j, gms.gamernum].col] >= max) and (gms.aktivecells[j] <> 2) and
        isPosibleMove(gms, i, j, gms.cells[j, gms.gamernum].row + 1, gms.cells[j, gms.gamernum].col) and gms.aktivefield[gms.cells[j, gms.gamernum].row + 1, gms.cells[j, gms.gamernum].col] and
        isPosibleMove2(gms, i, j, gms.cells[j, gms.gamernum].row + 1, gms.cells[j, gms.gamernum].col) then begin
                max := gms.field[gms.cells[j, gms.gamernum].row + 1, gms.cells[j, gms.gamernum].col];
                maxrow := gms.cells[j, gms.gamernum].row + 1;
                maxcol := gms.cells[j, gms.gamernum].col;
                maxnum := j
        end;

        if (gms.cells[j, gms.gamernum].col <> SIZE) and (gms.field[gms.cells[j, gms.gamernum].row, gms.cells[j, gms.gamernum].col + 1] >= max) and (gms.aktivecells[j] <> 2) and
        isPosibleMove(gms, i, j, gms.cells[j, gms.gamernum].row, gms.cells[j, gms.gamernum].col + 1) and gms.aktivefield[gms.cells[j, gms.gamernum].row, gms.cells[j, gms.gamernum].col + 1] and
        isPosibleMove2(gms, i, j, gms.cells[j, gms.gamernum].row, gms.cells[j, gms.gamernum].col + 1) then begin
                max := gms.field[gms.cells[j, gms.gamernum].row, gms.cells[j, gms.gamernum].col + 1];
                maxrow := gms.cells[j, gms.gamernum].row;
                maxcol := gms.cells[j, gms.gamernum].col + 1;
                maxnum := j
        end
end;

{ Получить ход }
procedure GetMove(var gms: GameState);
var
        i, max, maxrow, maxcol, maxnum, j, cnt1, cnt2: Word;
begin
        if gms.nextn = 0 then begin
                gms.n := 0;
                Exit
        end;

        gms.n := 0;
        i := 1;

        cnt1 := 0;
        cnt2 := 0;
        for j := 1 to gms.numberofcells[gms.gamernum] do begin
                                if (gms.cells[j, gms.gamernum].row <> 1) and (gms.field[gms.cells[j, gms.gamernum].row - 1, gms.cells[j, gms.gamernum].col] = 0) then
                                        Inc(cnt1);
                                if (gms.cells[j, gms.gamernum].col <> 1) and (gms.field[gms.cells[j, gms.gamernum].row, gms.cells[j, gms.gamernum].col - 1] = 0) then
                                        Inc(cnt1);
                                if (gms.cells[j, gms.gamernum].row <> SIZE) and (gms.field[gms.cells[j, gms.gamernum].row + 1, gms.cells[j, gms.gamernum].col] = 0) then
                                        Inc(cnt1);
                                if (gms.cells[j, gms.gamernum].row <> SIZE) and (gms.field[gms.cells[j, gms.gamernum].row, gms.cells[j, gms.gamernum].col + 1] = 0) then
                                        Inc(cnt1)
                        end;
        for j := 1 to gms.numberofcells[gms.gamernum] do begin
                                if (gms.cells[j, gms.gamernum].row <> 1) and (gms.field[gms.cells[j, gms.gamernum].row - 1, gms.cells[j, gms.gamernum].col] >= 0) then
                                        Inc(cnt2);
                                if (gms.cells[j, gms.gamernum].col <> 1) and (gms.field[gms.cells[j, gms.gamernum].row, gms.cells[j, gms.gamernum].col - 1] >= 0) then
                                        Inc(cnt2);
                                if (gms.cells[j, gms.gamernum].row <> SIZE) and (gms.field[gms.cells[j, gms.gamernum].row + 1, gms.cells[j, gms.gamernum].col] >= 0) then
                                        Inc(cnt2);
                                if (gms.cells[j, gms.gamernum].row <> SIZE) and (gms.field[gms.cells[j, gms.gamernum].row, gms.cells[j, gms.gamernum].col + 1] >= 0) then
                                        Inc(cnt2)
                        end;

        while i <= gms.numberofcells[gms.gamernum] do begin
                if gms.aktivecells[i] = 0 then begin
                        gms.aktivecells[i] := 2;
                        max := 0;
                        maxrow := 0;
                        maxcol := 0;

                        j := 1;
                        while j <= gms.numberofcells[gms.gamernum] do begin
                                SelectMove(gms, max, maxrow, maxcol, maxnum, j, i);
                                Inc(j)
                        end;

                        if (max <> 0) or ((cnt1 = cnt2) and (gms.n = 0) and (max = 0) and (maxrow <> 0) and (maxcol <> 0)) then begin
                                if (gms.movenum <> 2) and (gms.movenum <> 3) then begin
                                        if (gms.cells[i, gms.gamernum].col <> SIZE) and (gms.field[gms.cells[i, gms.gamernum].row, gms.cells[i, gms.gamernum].col + 1] = gms.gamernum - 2) then begin
                                                j := 1;
                                                while (gms.cells[j, gms.gamernum].row <> gms.cells[i, gms.gamernum].row) or (gms.cells[j, gms.gamernum].col <> gms.cells[i, gms.gamernum].col + 1) do
                                                        Inc(j);
                                                gms.aktivecells[j] := 1
                                        end;
                                        if (gms.cells[i, gms.gamernum].row <> 1) and (gms.field[gms.cells[i, gms.gamernum].row - 1, gms.cells[i, gms.gamernum].col] = gms.gamernum - 2) then begin
                                                j := 1;
                                                while (gms.cells[j, gms.gamernum].row <> gms.cells[i, gms.gamernum].row - 1) or (gms.cells[j, gms.gamernum].col <> gms.cells[i, gms.gamernum].col) do
                                                        Inc(j);
                                                gms.aktivecells[j] := 1
                                        end;
                                        if (gms.cells[i, gms.gamernum].col <> 1) and (gms.field[gms.cells[i, gms.gamernum].row, gms.cells[i, gms.gamernum].col - 1] = gms.gamernum - 2) then begin
                                                j := 1;
                                                while (gms.cells[j, gms.gamernum].row <> gms.cells[i, gms.gamernum].row) or (gms.cells[j, gms.gamernum].col <> gms.cells[i, gms.gamernum].col - 1) do
                                                        Inc(j);
                                                gms.aktivecells[j] := 1
                                        end;
                                        if (gms.cells[i, gms.gamernum].row <> SIZE) and (gms.field[gms.cells[i, gms.gamernum].row + 1, gms.cells[i, gms.gamernum].col] = gms.gamernum - 2) then begin
                                                j := 1;
                                                while (gms.cells[j, gms.gamernum].row <> gms.cells[i, gms.gamernum].row + 1) or (gms.cells[j, gms.gamernum].col <> gms.cells[i, gms.gamernum].col) do
                                                        Inc(j);
                                                gms.aktivecells[j] := 1
                                        end;
                                        {if (gms.cells[i, gms.gamernum].col <> SIZE) and (gms.cells[i, gms.gamernum].row <> SIZE) and (gms.field[gms.cells[i, gms.gamernum].row + 1, gms.cells[i, gms.gamernum].col + 1] = gms.gamernum - 2) then begin
                                                j := 1;
                                                while (gms.cells[j, gms.gamernum].row <> gms.cells[i, gms.gamernum].row + 1) or (gms.cells[j, gms.gamernum].col <> gms.cells[i, gms.gamernum].col + 1) do
                                                        Inc(j);
                                                gms.aktivecells[j] := 1
                                        end;
                                        if (gms.cells[i, gms.gamernum].row <> 1) and (gms.cells[i, gms.gamernum].col <> 1) and (gms.field[gms.cells[i, gms.gamernum].row - 1, gms.cells[i, gms.gamernum].col - 1] = gms.gamernum - 2) then begin
                                                j := 1;
                                                while (gms.cells[j, gms.gamernum].row <> gms.cells[i, gms.gamernum].row - 1) or (gms.cells[j, gms.gamernum].col <> gms.cells[i, gms.gamernum].col - 1) do
                                                        Inc(j);
                                                gms.aktivecells[j] := 1
                                        end;
                                        if (gms.cells[i, gms.gamernum].col <> 1) and (gms.cells[i, gms.gamernum].row <> SIZE) and (gms.field[gms.cells[i, gms.gamernum].row + 1, gms.cells[i, gms.gamernum].col - 1] = gms.gamernum - 2) then begin
                                                j := 1;
                                                while (gms.cells[j, gms.gamernum].row <> gms.cells[i, gms.gamernum].row + 1) or (gms.cells[j, gms.gamernum].col <> gms.cells[i, gms.gamernum].col - 1) do
                                                        Inc(j);
                                                gms.aktivecells[j] := 1
                                        end;
                                        if (gms.cells[i, gms.gamernum].col <> SIZE) and (gms.cells[i, gms.gamernum].row <> 1) and (gms.field[gms.cells[i, gms.gamernum].row - 1, gms.cells[i, gms.gamernum].col + 1] = gms.gamernum - 2) then b
                                                j := 1;
                                                while (gms.cells[j, gms.gamernum].row <> gms.cells[i, gms.gamernum].row - 1) or (gms.cells[j, gms.gamernum].col <> gms.cells[i, gms.gamernum].col + 1) do
                                                        Inc(j);
                                                gms.aktivecells[j] := 1
                                        end;}
                                end;

                                gms.aktivecells[maxnum] := 1;
                                gms.aktivecells[i] := 2;

                                Inc(gms.n);
                                gms.move[gms.n].startpos.row := gms.cells[i, gms.gamernum].row;
                                gms.move[gms.n].startpos.col := gms.cells[i, gms.gamernum].col;
                                gms.move[gms.n].finishpos.row := maxrow;
                                gms.move[gms.n].finishpos.col := maxcol;
                                gms.aktivefield[maxrow, maxcol] := FALSE
                        end
                        else begin
                                gms.aktivecells[i] := 0;
                                gms.field[gms.cells[i, gms.gamernum].row, gms.cells[i, gms.gamernum].col] := gms.gamernum - 2
                        end
                end;
                Inc(i)
        end
end;

/////////////////////////////////////////////////////////////////////////////

{ Сделать ход }
procedure MakeMove(var gms: GameState);
var
        i, j: Word;
        isHydr: Boolean;     // Была ли в ходе ртуть
begin
        isHydr := FALSE;
        for i := 1 to gms.n do begin
                if gms.field[gms.move[i].finishpos.row, gms.move[i].finishpos.col] <> CARBON then
                        gms.field[gms.move[i].startpos.row, gms.move[i].startpos.col] := EMPTY
                else begin
                        Inc(gms.numberofcells[gms.movenum mod 2]);
                        gms.cells[gms.numberofcells[gms.movenum mod 2], gms.movenum mod 2].row := gms.move[i].startpos.row;
                        gms.cells[gms.numberofcells[gms.movenum mod 2], gms.movenum mod 2].col := gms.move[i].startpos.col
                end;

                if gms.field[gms.move[i].finishpos.row, gms.move[i].finishpos.col] = HYDRARGIUM then
                        isHydr := TRUE;

                if gms.field[gms.move[i].finishpos.row, gms.move[i].finishpos.col] = CARBON then
                        Inc(gms.score[gms.movenum mod 2])
                else
                        if gms.field[gms.move[i].finishpos.row, gms.move[i].finishpos.col] = HYDRARGIUM then
                                Inc(gms.score[gms.movenum mod 2], 8)
                        else
                                Inc(gms.score[gms.movenum mod 2], gms.field[gms.move[i].finishpos.row, gms.move[i].finishpos.col]);
                gms.field[gms.move[i].finishpos.row, gms.move[i].finishpos.col] := gms.movenum mod 2 - 2;

                j := 1;
                while (gms.cells[j, gms.movenum mod 2].row <> gms.move[i].startpos.row) or (gms.cells[j, gms.movenum mod 2].col <> gms.move[i].startpos.col) do
                        Inc(j);

                gms.cells[j, gms.movenum mod 2].row := gms.move[i].finishpos.row;
                gms.cells[j, gms.movenum mod 2].col := gms.move[i].finishpos.col
        end;

        Inc(gms.movenum);

        FillChar(gms.aktivecells, SizeOf(gms.aktivecells), 0);
        FillChar(gms.aktivefield, SizeOf(gms.aktivefield), TRUE);

        if isHydr and ((gms.movenum - 1) mod 2 = gms.gamernum) then
                gms.nextn := NULL
        else
                if (gms.movenum - 1) mod 2 = gms.gamernum then
                        gms.nextn := 1
end;

/////////////////////////////////////////////////////////////////////////////

{ Вывести ход }
procedure WriteMove(const gms: GameState);
var
        i: Word;
        //s: string;
begin
        Write (gms.n);

        //s:= '';

        for i := 1 to gms.n do begin
                {s := s +' ' + Chr(gms.move[i].startpos.row + Ord('a') - 1) + Chr(gms.move[i].startpos.col + Ord('a') - 1) +
                       Chr(gms.move[i].finishpos.row + Ord('a') - 1) + Chr(gms.move[i].finishpos.col + Ord('a') - 1);}
                Write (' ', Chr(gms.move[i].startpos.row + Ord('a') - 1), Chr(gms.move[i].startpos.col + Ord('a') - 1),
                       Chr(gms.move[i].finishpos.row + Ord('a') - 1), Chr(gms.move[i].finishpos.col + Ord('a') - 1));
                //Flush(output)
        end;

        WriteLn {(s)};
        Flush(output)
end;

/////////////////////////////////////////////////////////////////////////////

{ Прочитать ход }
procedure ReadMove(var gms: GameState);
var
        i: Word;
        c: Char;
begin
        Read (gms.n);

        for i := 1 to gms.n do begin
                Read (c);                                          // Читаем пробел

                Read (c);                                          // Строка стартовой позиции клетки
                gms.move[i].startpos.row := Ord(c) - Ord('a') + 1;
                Read (c);                                          // Столбец стартовой позиции клетки
                gms.move[i].startpos.col := Ord(c) - Ord('a') + 1;
                Read (c);                                          // Строка конечной позиции клетки
                gms.move[i].finishpos.row := Ord(c) - Ord('a') + 1;
                Read (c);                                          // Столбец конечной позиции клетки
                gms.move[i].finishpos.col := Ord(c) - Ord('a') + 1
        end
end;

/////////////////////////////////////////////////////////////////////////////

{ Показать поле (только для отладки) }
procedure ShowField(const gms: GameState);
var
        i, j: Word;
begin
        for i := 1 to SIZE do begin
                Write (Chr(i + Ord('a') - 1), ' ');

                for j := 1 to SIZE do
                        if gms.field[i, j] >= 0 then
                                if gms.field[i, j] = URAN then
                                        Write ('D')
                                else
                                        if gms.field[i, j] = HYDRARGIUM then
                                                Write ('8')
                                        else
                                                if gms.field[i, j] = CARBON then
                                                        Write ('1')
                                                else
                                                        Write (Chr(gms.field[i, j] + Ord('0')))
                        else begin
                                if gms.field[i, j] = -2 then
                                        Write ('R');   //R -> red т.е. 1 игрок
                                if gms.field[i, j] = -1 then
                                        Write ('B')  //B -> blue т.е. 2 игрок
                        end;
                WriteLn
        end;

        WriteLn ('  abcdefghijklmnopqrstuvwxyz   ', gms.movenum);
        WriteLn (gms.score[0], ' : ', gms.score[1])
end;

{ Процесс игры }
procedure PlayGame(var gms: GameState);
begin
        FirstMove(gms);
{$ifndef REFEREE}
        ShowField(gms);
{$endif}
        while not isGameOver(gms) do begin
                if isOurMove(gms) then begin
                        GetMove(gms);
                        WriteMove(gms)
                end
                else
                        ReadMove(gms);

                MakeMove(gms);
{$ifndef REFEREE}
                ShowField(gms)
{$endif}
        end
end;

//////////////////////////////////////////////////////////////////////////////
// Основная программа ////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

var
        gms: GameState;

begin
        InitGame(gms);

        PlayGame(gms)
end.
