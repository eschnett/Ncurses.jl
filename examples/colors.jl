using Ncurses

const NC = Ncurses

atexit(NC.endwin)

win = NC.initscr()
# NC.nonl()
NC.start_color()

NC.wclear(win)
NC.wmove(win, 0, 0)
NC.waddnstr(win, "Hello, World!", -1)
maxy = getmaxy(win)
maxx = getmaxx(win)
NC.waddnstr(win, "1", -1)

NC.wrefresh(win)

nothing
