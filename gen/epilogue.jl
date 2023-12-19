# Missing functions

getattrs(win) = @ccall libncurses.getattrs(win::Ptr{WINDOW})::Cint
getcurx(win) = @ccall libncurses.getcurx(win::Ptr{WINDOW})::Cint
getcury(win) = @ccall libncurses.getcury(win::Ptr{WINDOW})::Cint
getbegx(win) = @ccall libncurses.getbegx(win::Ptr{WINDOW})::Cint
getbegy(win) = @ccall libncurses.getbegy(win::Ptr{WINDOW})::Cint
getmaxx(win) = @ccall libncurses.getmaxx(win::Ptr{WINDOW})::Cint
getmaxy(win) = @ccall libncurses.getmaxy(win::Ptr{WINDOW})::Cint
getparx(win) = @ccall libncurses.getparx(win::Ptr{WINDOW})::Cint
getpary(win) = @ccall libncurses.getpary(win::Ptr{WINDOW})::Cint

scroll(win) = wscrl(win, 1)

touchwin(win) = wtouchln(win, 0, getmaxywin, 1)
touchline(win, s, c) = wtouchln(win, s, c, 1)
untouchwin(win) = wtouchln(win, 0, getmaxywin, 0)

box(win, v, h) = wborder(win, v, v, h, h, 0, 0, 0, 0)
border(ls, rs, ts, bs, tl, tr, bl, br) = wborder(stdscr, ls, rs, ts, bs, tl, tr, bl, br)
hline(ch, n) = whline(stdscr, ch, (n))
vline(ch, n) = wvline(stdscr, ch, (n))

winstr(w, s) = winnstr(w, s, -1)
winchstr(w, s) = winchnstr(w, s, -1)
winsstr(w, s) = winsnstr(w, s, -1)

@static if !Bool(NCURSES_OPAQUE)
    redrawwin(win) = wredrawln(win, 0, (NCURSES_OK_ADDR(win) ? win._maxy + 1 : -1))
end

waddstr(win, str) = waddnstr(win, str, -1)
waddchstr(win, str) = waddchnstr(win, str, -1)

COLOR_PAIR(n) = NCURSES_BITS(n, 0) & A_COLOR
PAIR_NUMBER(a) = NCURSES_CAST(Cint, ((NCURSES_CAST(Culong, (a)) & A_COLOR) >> NCURSES_ATTR_SHIFT))
