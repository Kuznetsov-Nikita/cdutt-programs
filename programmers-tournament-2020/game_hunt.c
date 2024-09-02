#define _CRT_SECURE_NO_WARNINGS

/* Игра "Охота на кроликов" version Release 1.0.2 - готовый "Random" для кроликов, волновой для охотников */
/* TODO - получение хода для кроликов волновым
*/

#include <stdio.h>
#include <time.h>
#include <stdlib.h>

//#define DEBUG

// Размер поля
#define FIELD_SIZE 24

// Количество кроликов и охотников
#define RABBITS_COUNT 8
#define HUNTERS_COUNT 6

// Капуста, пустота и другие клетки поля
#define CABBAGE 100
#define EMPTY_CELL 0

typedef struct {
    int x, y;        // Координаты кролика
    int is_alive;    // Живой ли кролик: 1 - да, 0 - нет
} rabbit;

typedef struct {
    int x, y;      // Координаты охотника
    int target;    // Цель охотника
} hunter;

typedef struct {
    int b, e;
    int q[FIELD_SIZE * FIELD_SIZE * FIELD_SIZE][2];
} queue;

typedef struct {
    int field[FIELD_SIZE][FIELD_SIZE];              // Поле для игры (только клетки и их состояние, без стен)
    int cells_walls[FIELD_SIZE * FIELD_SIZE][4];    // Для каждой клетки показывает, в какие сосдние клетки можно из нее попасть. Клетки - числа в 24ричной системе (24 * номер строки + номер столбца). 0 - N, 1 - E, 2 - S, 3 - W

    int move_num;                                   // Номер текущего хода
    int gamer_num;                                  // Номер игрока: 0 - кролики, 1 - охотники

    int score[2];                                   // Счет игры: 0 - кролики, 1 - охотники

    char move[8];                                   // Ход игрока

    int mover_num;                                  // Кто ходит

    rabbit rabbits[RABBITS_COUNT];                  // Массив кроликов
    hunter hunters[HUNTERS_COUNT];                  // Массив охотников
} game_state;

// Инициализация игры ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* Инициализация поля */
void init_field(game_state* gms) {
    int i, j;

    for (i = 0; i < FIELD_SIZE; i++)    // Засаживаем поле капустой
        for (j = 0; j < FIELD_SIZE; j++)
            gms->field[i][j] = CABBAGE;

    for (j = 11; j <= 12; j++)          // Инициализируем клетки охотников пустыми
        gms->field[9][j] = EMPTY_CELL;

    for (j = 10; j <= 13; j++)          // Инициализируем клетки охотников пустыми
        gms->field[10][j] = EMPTY_CELL;

    for (i = 13; i <= 14; i++)          // Инициализируем клетки кроликов пустыми
        for (j = 10; j <= 13; j++)
            gms->field[i][j] = EMPTY_CELL;
}

/* Инициализация границ у клеток */
void init_cells_wands(game_state* gms) {
    char s[FIELD_SIZE * FIELD_SIZE] = "955391115555555539111553AD3AAAA8555555552AAAA97AC56AAAA8393939392AAAAC569112AAAAC6C6C6C6AAAA811380004468111111110446800284445552AAAAAAAA85554442A9555552AAAAAAAA8555553AAA955552EEEEEEEE855553AAAAA955501111111105553AAAAAAAD390000000000397AAAAAAAC56800000000002C56AAA840555004444444400555042810555001111111100555012AAA953800000000002953AAAAAAAD6C00000000006C7AAAAAAAC55504444444405556AAAAAC55552BBBBBBBB855556AAAC555552AAAAAAAA8555556A81115552AAAAAAAA85551112800011384444444401138002C442AAAA93939393AAAA8446953AAAA86C6C6C6C2AAAA953AD6AAAA8555555552AAAAC7AC556C444555555556C444556";
    int k, cell_num;

    for (k = 0; k < FIELD_SIZE * FIELD_SIZE; k++) {
        cell_num = (s[k] >= 'A' && s[k] <= 'F') ? s[k] - 'A' + 10 : s[k] - '0';

        gms->cells_walls[k][0] = 1 - cell_num % 2;
        gms->cells_walls[k][1] = 1 - cell_num / 2 % 2;
        gms->cells_walls[k][2] = 1 - cell_num / 4 % 2;
        gms->cells_walls[k][3] = 1 - cell_num / 8;
    }
}

/* Инициализация кроликов */
void init_rabbits(game_state* gms) {
    int k = 0, i, j;

    for (i = 13; i <= 14; i++)
        for (j = 10; j <= 13; j++) {
            gms->rabbits[k].is_alive = 1;

            gms->rabbits[k].x = i;
            gms->rabbits[k].y = j;

            k++;
        }
}

/* Инициализация охотников */
void init_hunters(game_state* gms) {
    int k = 0, j;

    for (j = 10; j <= 13; j++) {
        gms->hunters[k].x = 10;
        gms->hunters[k].y = j;

        k++;
    }

    gms->hunters[4].x = 9;
    gms->hunters[4].y = 11;

    gms->hunters[5].x = 9;
    gms->hunters[5].y = 12;

    for (k = 0; k < HUNTERS_COUNT; k++)
        gms->hunters[k].target = -1;
}

/* Инициализация */
void init_game(game_state* gms) {
    gms->score[0] = 0;               // Обнуление счета игры
    gms->score[1] = 0;

    init_field(gms);                 // Инициализируем поле
    init_cells_wands(gms);
    init_rabbits(gms);
    init_hunters(gms);

    scanf("%d", &gms->move_num);     // Читаем количество ходов
    gms->move_num *= 2;

    scanf("%d", &gms->gamer_num);    // Читаем номер игрока, за которого играем (0 - кролики, 1 - охотники)

    gms->mover_num = 0;              // Будут ходить кролики (то есть первый игрок)
}

// Процесс игры /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* Проверка количества капусты на поле */
int is_field_empty(game_state* gms) {
    int i, j, cnt = 0;

    for (i = 0; i < FIELD_SIZE; i++)
        for (j = 0; j < FIELD_SIZE; j++)
            cnt += gms->field[i][j];

    return cnt == 0;
}

/* Проверка пойманности всех кроликов */
int are_rabbits_dead(game_state* gms) {
    int i, cnt = 0;

    for (i = 0; i < RABBITS_COUNT; i++)
        cnt += gms->rabbits[i].is_alive;

    return cnt == 0;
}

/* Проверка конца игры */
int is_game_over(game_state* gms) {
    return is_field_empty(gms) || (are_rabbits_dead(gms) && gms->mover_num == 0) || (gms->move_num == 0);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* Сделать ход */
void make_move(game_state* gms) {
    int k, i, is_dead;
    char dir;

    if (gms->mover_num == 0) {    // Если ходят кролики
        for (k = 0; k < RABBITS_COUNT; k++) {
            dir = gms->move[k];
            is_dead = 0;

            switch (dir) {    // Кролик передвигается
                case 'N':
                    gms->rabbits[k].x -= 1;
                    break;
                case 'E':
                    gms->rabbits[k].y += 1;
                    break;
                case 'S':
                    gms->rabbits[k].x += 1;
                    break;
                case 'W':
                    gms->rabbits[k].y -= 1;
                    break;
            }

            for (i = 0; i < HUNTERS_COUNT; i++)    // Проверка не попался ли кролик
                if (gms->rabbits[k].x == gms->hunters[i].x && gms->rabbits[k].y == gms->hunters[i].y)
                    is_dead = 1;

            if (is_dead)
                gms->rabbits[k].is_alive = 0;    // Кролик умер
            else if (gms->rabbits[k].is_alive == 1 && gms->field[gms->rabbits[k].x][gms->rabbits[k].y] != EMPTY_CELL) {
                gms->field[gms->rabbits[k].x][gms->rabbits[k].y] = EMPTY_CELL;    // Кролик съел капусту и жив
                gms->score[0]++;
            }
        }
    } else {    // Если ходят охотники
        for (k = 0; k < HUNTERS_COUNT; k++) {
            dir = gms->move[k];

            switch (dir) {    // Охотник передвигается
                case 'N':
                    gms->hunters[k].x -= 1;
                    break;
                case 'E':
                    gms->hunters[k].y += 1;
                    break;
                case 'S':
                    gms->hunters[k].x += 1;
                    break;
                case 'W':
                    gms->hunters[k].y -= 1;
                    break;
            }

            for (i = 0; i < RABBITS_COUNT; i++)    // Проверка не поймал ли охотник кролика
                if (gms->rabbits[i].x == gms->hunters[k].x && gms->rabbits[i].y == gms->hunters[k].y) {
                    gms->rabbits[i].is_alive = 0;
                    gms->score[1] += 75;
                }
        }
    }

    gms->mover_num = 1 - gms->mover_num;    // Теперь должен ходить другой игрок
    gms->move_num -= 1;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* Проверка есть ли уже кролик */
int is_occupied(game_state* gms, int dir, int x, int y, int gamer) {
    int i, value = 0;

    switch (dir) {
        case 0:
            x -= 1;
            break;
        case 1:
            y += 1;
            break;
        case 2:
            x += 1;
            break;
        case 3:
            y -= 1;
            break;
    }

    if (gamer == 0) {
        for (i = 0; i < RABBITS_COUNT; i++)
            if (gms->rabbits[i].x == x && gms->rabbits[i].y == y && gms->rabbits[i].is_alive == 1) {
                value = 1;
                break;
            }
    } else {
        for (i = 0; i < HUNTERS_COUNT; i++)
            if (gms->hunters[i].x == x && gms->hunters[i].y == y) {
                value = 1;
                break;
            }
    }

    return value;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* Функции для работы с очередью */
int is_empty_queue(queue* q) {
    if (q->e == q->b)
        return 1;
    else
        return 0;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void push(queue* q, int x, int y) {
    q->q[q->e][0] = x;
    q->q[q->e][1] = y;
    q->e = (q->e + 1) % (FIELD_SIZE * FIELD_SIZE * FIELD_SIZE);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void pop(queue* q, int* x, int* y) {
    *x = q->q[q->b][0];
    *y = q->q[q->b][1];
    q->b = (q->b + 1) % (FIELD_SIZE * FIELD_SIZE * FIELD_SIZE);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* Функции для получения хода охотниками */
void wave_hunter(game_state* gms, int field[FIELD_SIZE][FIELD_SIZE], queue* q, int now_x, int now_y, int* x, int* y, int number_hunter) {
    int move[4][2] = { {-1, 0}, {0, 1}, {1, 0}, {0, -1} };
    int b = 0, i;

    for (i = 0; i < RABBITS_COUNT; i++)
        if (gms->rabbits[i].is_alive && gms->rabbits[i].x == now_x && gms->rabbits[i].y == now_y) {
            *x = now_x;
            *y = now_y;
            b = 1;
        }

    if (b == 0 && (*x == gms->hunters[number_hunter].x && *y == gms->hunters[number_hunter].y)) {
        int j;
        int xq, yq;
        for (j = 0; j < 4; j++) {
            if (gms->cells_walls[now_x * 24 + now_y][j] && field[now_x + move[j][0]][now_y + move[j][1]] == 10000) {
                push(q, now_x + move[j][0], now_y + move[j][1]);
                field[now_x + move[j][0]][now_y + move[j][1]] = field[now_x][now_y] + 1;
            }
        }
        if (!is_empty_queue(q)) {
            pop(q, &xq, &yq);
            wave_hunter(gms, field, q, xq, yq, x, y, number_hunter);
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* Отладочная информация */
void print_field(game_state* gms, int field[FIELD_SIZE][FIELD_SIZE]) {
    int i, j, k;
    for (i = 0; i < FIELD_SIZE; i++) {
        for (j = 0; j < FIELD_SIZE; j++)
            if (field[i][j] == 10000)
                printf("%3d", -1);
            else
                printf("%3d", field[i][j]);

        printf("\n");
    }
    printf("\n");
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

char get_way_rabbits(game_state* gms, int number_rabbit, int x, int y, int field[FIELD_SIZE][FIELD_SIZE]) {
    char variants[5] = "SWNE-";
    int move[4][2] = { {-1, 0}, {0, 1}, {1, 0}, {0, -1} }, dir = 4, pos, i;

    for (i = 0; i < 4; i++) {
        if (gms->cells_walls[24 * x + y][i] && field[x + move[i][0]][y + move[i][1]] < field[x][y]) {
            if (field[x + move[i][0]][y + move[i][1]] == 0)
                return variants[i];

            return get_way_rabbits(gms, number_rabbit, x + move[i][0], y + move[i][1], field);
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int get_number_hunters(game_state* gms, int number_rabbits, int field[FIELD_SIZE][FIELD_SIZE]) {
    int min = 1000, number_hunters = HUNTERS_COUNT, i, j;
    //printf("get number rabbits\n");

    for (i = 0; i < HUNTERS_COUNT; i++) {
        if (field[gms->hunters[i].x][gms->hunters[i].y] < min) {
            min = field[gms->hunters->x][gms->hunters->y];
            number_hunters = i;
        }
    }
    return number_hunters;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void wave_rabbits(game_state* gms, int field[FIELD_SIZE][FIELD_SIZE], queue* q, int now_x, int now_y, int* x, int* y, int number_rabbit) {
    int move[4][2] = { {-1, 0}, {0, 1}, {1, 0}, {0, -1} };
    int b = 0, i;

    for (i = 0; i < HUNTERS_COUNT; i++)
        if (gms->hunters[i].x == now_x && gms->hunters[i].y == now_y) {
            *x = now_x;
            *y = now_y;
            b = 1;
        }

    if (b == 0 && (*x == gms->rabbits[number_rabbit].x && *y == gms->rabbits[number_rabbit].y)) {
        int j;
        int xq, yq;
        for (j = 0; j < 4; j++) {
            if (gms->cells_walls[now_x * 24 + now_y][j] && field[now_x + move[j][0]][now_y + move[j][1]] == 10000) {
                push(q, now_x + move[j][0], now_y + move[j][1]);
                field[now_x + move[j][0]][now_y + move[j][1]] = field[now_x][now_y] + 1;
            }
        }
        if (!is_empty_queue(q)) {
            pop(q, &xq, &yq);
            wave_rabbits(gms, field, q, xq, yq, x, y, number_rabbit);
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void get_move_rabbits(game_state* gms) {
    char variants[5] = "NESW", move1;
    int move[4][2] = { {-1, 0}, {0, 1}, {1, 0}, {0, -1} };
    int i, j, x[RABBITS_COUNT], y[RABBITS_COUNT], field[RABBITS_COUNT][FIELD_SIZE][FIELD_SIZE], r;
    queue q[RABBITS_COUNT];

    for (i = 0; i < RABBITS_COUNT; i++) {
        if (gms->rabbits[i].is_alive) {
            int j, k;
            q[i].e = 0;
            q[i].b = 0;
            push(&q[i], gms->rabbits[i].x, gms->rabbits[i].y);

            x[i] = gms->rabbits[i].x;
            y[i] = gms->rabbits[i].y;

            for (j = 0; j < FIELD_SIZE; j++)
                for (k = 0; k < FIELD_SIZE; k++)
                    field[i][j][k] = 10000;
            field[i][gms->rabbits[i].x][gms->rabbits[i].y] = 0;

            wave_rabbits(gms, field[i], &q[i], gms->rabbits[i].x, gms->rabbits[i].y, &x[i], &y[i], i);

#ifdef DEBUG
            print_field(gms, field[i]);
#endif;
            r = get_number_hunters(gms, i, field[i]);

            if (r == HUNTERS_COUNT)
                move1 = '-';
            else
                move1 = get_way_rabbits(gms, i, gms->hunters[r].x, gms->hunters[r].y, field[i]);

            if (move1 == '-')
                gms->move[i] = move1;
            else {
                int c, b = 0;
                for (j = 0; j < 4; j++)
                    if (variants[j] == move1)
                        c = j;

                for (j = 0; j < 4; j++) {
                    if (i % 4 == 3 || i % 4 == 0)
                        if (variants[c] != variants[4 - j - 1] && gms->cells_walls[gms->rabbits[i].x * 24 + gms->rabbits[i].y][4 - j - 1] && gms->field[gms->rabbits[i].x + move[4 - j - 1][0]][gms->rabbits[i].y + move[4 - j - 1][1]] == CABBAGE) {
                            b = 1;
                            c = 4 - j - 1;
                        } else if (variants[c] != variants[j] && gms->cells_walls[gms->rabbits[i].x * 24 + gms->rabbits[i].y][j] && gms->field[gms->rabbits[i].x + move[j][0]][gms->rabbits[i].y + move[j][1]] == CABBAGE) {
                            b = 1;
                            c = j;
                        }
                }

                if (!b) {
                    c = (j + 2) % 4;
                    if (gms->cells_walls[gms->rabbits[i].x * 24 + gms->rabbits[i].y][c])
                        gms->move[i] = variants[c];
                    else {
                        c = (c + 2) % 4;
                        if (gms->cells_walls[gms->rabbits[i].x * 24 + gms->rabbits[i].y][c])
                            gms->move[i] = variants[c];
                        else
                            gms->move[i] = move1;
                    }
                } else
                    gms->move[i] = variants[c];
            }
        } else
            gms->move[i] = '-';
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

char get_way_hunters(game_state* gms, int number_hunter, int x, int y, int field[FIELD_SIZE][FIELD_SIZE]) {
    char variants[5] = "SWNE-";
    int move[4][2] = { {-1, 0}, {0, 1}, {1, 0}, {0, -1} }, dir = 4, pos, i;

    for (i = 0; i < 4; i++) {
        if (gms->cells_walls[24 * x + y][i] && field[x + move[i][0]][y + move[i][1]] < field[x][y]) {
            if (field[x + move[i][0]][y + move[i][1]] == 0)
                return variants[i];

            return get_way_hunters(gms, number_hunter, x + move[i][0], y + move[i][1], field);
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int get_number_rabbits(game_state* gms, int number_hunter, int field[FIELD_SIZE][FIELD_SIZE]) {
    int min = 1000, number_rabbits = RABBITS_COUNT, i, j;
    //printf("get number rabbits\n");

    for (i = 0; i < RABBITS_COUNT; i++) {
        if (gms->rabbits[i].is_alive)
            if (field[gms->rabbits[i].x][gms->rabbits[i].y] < min) {
                min = field[gms->rabbits->x][gms->rabbits->y];
                number_rabbits = i;
            }
    }
    return number_rabbits;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void get_move_hunters(game_state* gms) {
    int i, x[HUNTERS_COUNT], y[HUNTERS_COUNT], field[HUNTERS_COUNT][FIELD_SIZE][FIELD_SIZE], r;
    queue q[HUNTERS_COUNT];

    for (i = 0; i < HUNTERS_COUNT; i++) {
        int j, k;
        q[i].e = 0;
        q[i].b = 0;
        push(&q[i], gms->hunters[i].x, gms->hunters[i].y);

        x[i] = gms->hunters[i].x;
        y[i] = gms->hunters[i].y;

        for (j = 0; j < FIELD_SIZE; j++)
            for (k = 0; k < FIELD_SIZE; k++)
                field[i][j][k] = 10000;
        field[i][gms->hunters[i].x][gms->hunters[i].y] = 0;

        wave_hunter(gms, field[i], &q[i], gms->hunters[i].x, gms->hunters[i].y, &x[i], &y[i], i);

#ifdef DEBUG
        print_field(gms, field[i]);
#endif;

        r = get_number_rabbits(gms, i, field[i]);

        if (r == RABBITS_COUNT)
            gms->move[i] = '-';
        else
            gms->move[i] = get_way_hunters(gms, i, gms->rabbits[r].x, gms->rabbits[r].y, field[i]);
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* Получить ход */
void get_move(game_state* gms) {
    char variants[5] = "NESW-";
    int i, dir, k, j, xi, xj, yi, yj;
    int x[RABBITS_COUNT], y[RABBITS_COUNT];

    srand(time(NULL));

    if (gms->gamer_num == 0) {    // Если играем за кроликов
        get_move_rabbits(gms);
        /*
        for (i = 0; i < RABBITS_COUNT; i++) {
            k = 0;
            do {
                dir = rand() % 4;
                k++;
            } while ((gms->cells_walls[gms->rabbits[i].x * 24 + gms->rabbits[i].y][dir] != 1 || is_occupied(gms, dir, gms->rabbits[i].x, gms->rabbits[i].y, 0)) && k < 50);

            if (gms->rabbits[i].is_alive == 0 || k == 50)
                gms->move[i] = '-';
            else
                gms->move[i] = variants[dir];
        }
        */

        for (k = 0; k < 8; k++) {
            for (i = 0; i < RABBITS_COUNT; i++) {
                x[i] = gms->rabbits[i].x;
                y[i] = gms->rabbits[i].y;

                switch (gms->move[i]) {
                    case 'N':
                        x[i] -= 1;
                        break;
                    case 'E':
                        y[i] += 1;
                        break;
                    case 'S':
                        x[i] += 1;
                        break;
                    case 'W':
                        y[i] -= 1;
                        break;
                }
            }

            for (i = 0; i < RABBITS_COUNT; i++) {
                for (j = 0; j < RABBITS_COUNT; j++)
                    if (j != i && x[i] == x[j] && y[i] == y[j]) {
                        xi = x[i];
                        xj = x[j];
                        yi = y[i];
                        yj = y[j];

                        switch (gms->move[i]) {
                            case 'N':
                                xi += 1;
                                break;
                            case 'E':
                                yi -= 1;
                                break;
                            case 'S':
                                xi -= 1;
                                break;
                            case 'W':
                                yi += 1;
                                break;
                        }

                        switch (gms->move[j]) {
                            case 'N':
                                xj += 1;
                                break;
                            case 'E':
                                yj -= 1;
                                break;
                            case 'S':
                                xj -= 1;
                                break;
                            case 'W':
                                yj += 1;
                                break;
                        }

                        if (xi == x[j] && yi == y[j])
                            gms->move[j] = '-';
                        else
                            gms->move[i] = '-';

                        break;
                    }
            }
        }
    } else {    // Если играем за охотников
        get_move_hunters(gms);

        for (k = 0; k < 6; k++) {
            for (i = 0; i < HUNTERS_COUNT; i++) {
                x[i] = gms->hunters[i].x;
                y[i] = gms->hunters[i].y;

                switch (gms->move[i]) {
                    case 'N':
                        x[i] -= 1;
                        break;
                    case 'E':
                        y[i] += 1;
                        break;
                    case 'S':
                        x[i] += 1;
                        break;
                    case 'W':
                        y[i] -= 1;
                        break;
                }
            }

            for (i = 0; i < HUNTERS_COUNT; i++) {
                for (j = 0; j < HUNTERS_COUNT; j++)
                    if (j != i && x[i] == x[j] && y[i] == y[j]) {
                        xi = x[i];
                        xj = x[j];
                        yi = y[i];
                        yj = y[j];

                        switch (gms->move[i]) {
                            case 'N':
                                xi += 1;
                                break;
                            case 'E':
                                yi -= 1;
                                break;
                            case 'S':
                                xi -= 1;
                                break;
                            case 'W':
                                yi += 1;
                                break;
                        }

                        switch (gms->move[j]) {
                            case 'N':
                                xj += 1;
                                break;
                            case 'E':
                                yj -= 1;
                                break;
                            case 'S':
                                xj -= 1;
                                break;
                            case 'W':
                                yj += 1;
                                break;
                        }

                        if (xi == x[j] && yi == y[j])
                            gms->move[j] = '-';
                        else
                            gms->move[i] = '-';

                        break;
                    }
            }
        }
        /*for (i = 0; i < HUNTERS_COUNT; i++) {
            k = 0;
            do {
                dir = rand() % 4;
                k++;
            } while ((gms->cells_walls[gms->hunters[i].x * 24 + gms->hunters[i].y][dir] != 1 || is_occupied(gms, dir, gms->hunters[i].x, gms->hunters[i].y, 1)) && k < 50);

            if (k == 50)
                gms->move[i] = '-';
            else
                gms->move[i] = variants[dir];
        }*/
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* Вывод нашего хода */
void write_move(game_state* gms) {
    int i;

    if (gms->gamer_num == 0) {
        for (i = 0; i < RABBITS_COUNT; i++)
            printf("%c", gms->move[i]);
        printf("\n");
    } else {
        for (i = 0; i < HUNTERS_COUNT; i++)
            printf("%c", gms->move[i]);
        printf("\n");
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* Чтение хода соперника */
void read_move(game_state* gms) {
    scanf("%s", gms->move);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* Проверка очередности хода */
int is_our_move(game_state* gms) {
    return gms->mover_num == gms->gamer_num;
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* Отладочная информация, показать информацию об игре на текущем ходу */
void show_game_info(game_state* gms) {
    int i, j;

    for (i = 0; i < FIELD_SIZE; i++) {
        for (j = 0; j < FIELD_SIZE; j++)
            if (gms->field[i][j] == CABBAGE)
                printf("*");
            else
                printf("%d", gms->field[i][j]);

        printf("\n");
    }

    printf("RABBITS\n");
    for (i = 0; i < RABBITS_COUNT; i++)
        printf("%d %d %d\n", gms->rabbits[i].x, gms->rabbits[i].y, gms->rabbits[i].is_alive);

    printf("HUNTERS\n");
    for (i = 0; i < HUNTERS_COUNT; i++)
        printf("%d %d\n", gms->hunters[i].x, gms->hunters[i].y);

    printf("%d : %d", gms->score[0], gms->score[1]);
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* Процесс игры */
void play_game(game_state* gms) {
    while (!is_game_over(gms)) {
        if (is_our_move(gms)) {
            get_move(gms);
            write_move(gms);
        } else
            read_move(gms);

        make_move(gms);

#ifdef DEBUG
        show_game_info(gms);    // Показать информацию об игре на текущем ходу, только для отладки
#endif
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/* Основная программа */
int main() {
    game_state gms;

    setlinebuf(stdout);

    init_game(&gms);

    play_game(&gms);

    return 0;
}
