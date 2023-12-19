using Ncurses

const NC = Ncurses

atexit(NC.endwin)

win = NC.initscr()
# NC.nonl()
NC.curs_set(0)
NC.start_color()

NC.wclear(win)

NC.wmove(win, 0, 0)
NC.waddstr(win, "Hello, World!")

maxy = NC.getmaxy(win)
maxx = NC.getmaxx(win)
NC.wmove(win, 2, 4)
NC.waddstr(win, "This terminal has $maxy rows and $maxx colums.")

colwin = NC.newwin(9, 20, 4, 4)
@show colwin
NC.box(colwin, NC.ACS_HLINE, NC.ACS_VLINE)

NC.init_pair(1, NC.COLOR_RED, NC.COLOR_WHITE)
NC.init_pair(2, NC.COLOR_GREEN, NC.COLOR_WHITE)
NC.init_pair(3, NC.COLOR_YELLOW, NC.COLOR_WHITE)
NC.init_pair(4, NC.COLOR_BLUE, NC.COLOR_WHITE)
NC.init_pair(5, NC.COLOR_CYAN, NC.COLOR_WHITE)
NC.init_pair(6, NC.COLOR_MAGENTA, NC.COLOR_WHITE)
NC.init_pair(7, NC.COLOR_BLACK, NC.COLOR_WHITE)

colors = ["RED", "GREEN", "YELLOW", "BLUE", "CYAN", "MAGENTA", "WHITE"]

for n in 1:7
    NC.wmove(colwin, n, 1)
    NC.wattrset(colwin, NC.COLOR_PAIR(n))
    NC.waddnstr(colwin, "Color $(colors[n])" * ' '^18, 18)
end
 
NC.wrefresh(win)
NC.wrefresh(colwin)

sleep(10)

nothing
