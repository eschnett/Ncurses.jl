module Ncurses

using Ncurses_jll
export Ncurses_jll

using CEnum

# Missing bits

NCURSES_BITS(mask,shift) = (NCURSES_CAST(chtype,(mask)) << ((shift) + NCURSES_ATTR_SHIFT))
NCURSES_CAST(type,value) = type(value)

function NCURSES_ACS(c)
    acs_map = cglobal((:acs_map, libncurses), Cuchar)
    unsafe_load(acs_map, c + 1)
end

function NCURSES_MOUSE_MASK(b,m)
    if NCURSES_MOUSE_VERSION > 1
        ((m) << (((b) - 1) * 5))
    else
        ((m) << (((b) - 1) * 6))
    end
end

const ABSENT_BOOLEAN = Int8( - 1)
const ABSENT_STRING = Ptr{Cchar}(0)
const CANCELLED_BOOLEAN = Int8( - 2)
const CANCELLED_STRING = Ptr{Cchar}(-1)


const chtype = Cuint

function vidattr(arg1)
    ccall((:vidattr, libncurses), Cint, (chtype,), arg1)
end

# typedef int ( * NCURSES_OUTC ) ( int )
const NCURSES_OUTC = Ptr{Cvoid}

const attr_t = chtype

mutable struct ldat end

struct pdat
    _pad_y::Cshort
    _pad_x::Cshort
    _pad_top::Cshort
    _pad_left::Cshort
    _pad_bottom::Cshort
    _pad_right::Cshort
end

struct _win_st
    _cury::Cshort
    _curx::Cshort
    _maxy::Cshort
    _maxx::Cshort
    _begy::Cshort
    _begx::Cshort
    _flags::Cshort
    _attrs::attr_t
    _bkgd::chtype
    _notimeout::Bool
    _clear::Bool
    _leaveok::Bool
    _scroll::Bool
    _idlok::Bool
    _idcok::Bool
    _immed::Bool
    _sync::Bool
    _use_keypad::Bool
    _delay::Cint
    _line::Ptr{ldat}
    _regtop::Cshort
    _regbottom::Cshort
    _parx::Cint
    _pary::Cint
    _parent::Ptr{Cvoid} # _parent::Ptr{WINDOW}
    _pad::pdat
    _yoffset::Cshort
end

function Base.getproperty(x::_win_st, f::Symbol)
    f === :_parent && return Ptr{WINDOW}(getfield(x, f))
    return getfield(x, f)
end

const WINDOW = _win_st

function leaveok(arg1, arg2)
    ccall((:leaveok, libncurses), Cint, (Ptr{WINDOW}, Bool), arg1, arg2)
end

function wmove(arg1, arg2, arg3)
    ccall((:wmove, libncurses), Cint, (Ptr{WINDOW}, Cint, Cint), arg1, arg2, arg3)
end

function wgetnstr(arg1, arg2, arg3)
    ccall((:wgetnstr, libncurses), Cint, (Ptr{WINDOW}, Ptr{Cchar}, Cint), arg1, arg2, arg3)
end

function setupterm(arg1, arg2, arg3)
    ccall((:setupterm, libncurses), Cint, (Ptr{Cchar}, Cint, Ptr{Cint}), arg1, arg2, arg3)
end

function reset_prog_mode()
    ccall((:reset_prog_mode, libncurses), Cint, ())
end

function reset_shell_mode()
    ccall((:reset_shell_mode, libncurses), Cint, ())
end

function def_prog_mode()
    ccall((:def_prog_mode, libncurses), Cint, ())
end

function cbreak()
    ccall((:cbreak, libncurses), Cint, ())
end

function nocbreak()
    ccall((:nocbreak, libncurses), Cint, ())
end

function wattrset(arg1, arg2)
    ccall((:wattrset, libncurses), Cint, (Ptr{WINDOW}, Cint), arg1, arg2)
end

function wattr_on(arg1, arg2, arg3)
    ccall((:wattr_on, libncurses), Cint, (Ptr{WINDOW}, attr_t, Ptr{Cvoid}), arg1, arg2, arg3)
end

function wattr_off(arg1, arg2, arg3)
    ccall((:wattr_off, libncurses), Cint, (Ptr{WINDOW}, attr_t, Ptr{Cvoid}), arg1, arg2, arg3)
end

function wscrl(arg1, arg2)
    ccall((:wscrl, libncurses), Cint, (Ptr{WINDOW}, Cint), arg1, arg2)
end

function wtouchln(arg1, arg2, arg3, arg4)
    ccall((:wtouchln, libncurses), Cint, (Ptr{WINDOW}, Cint, Cint, Cint), arg1, arg2, arg3, arg4)
end

function wborder(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    ccall((:wborder, libncurses), Cint, (Ptr{WINDOW}, chtype, chtype, chtype, chtype, chtype, chtype, chtype, chtype), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
end

function whline(arg1, arg2, arg3)
    ccall((:whline, libncurses), Cint, (Ptr{WINDOW}, chtype, Cint), arg1, arg2, arg3)
end

function wvline(arg1, arg2, arg3)
    ccall((:wvline, libncurses), Cint, (Ptr{WINDOW}, chtype, Cint), arg1, arg2, arg3)
end

function winnstr(arg1, arg2, arg3)
    ccall((:winnstr, libncurses), Cint, (Ptr{WINDOW}, Ptr{Cchar}, Cint), arg1, arg2, arg3)
end

function winchnstr(arg1, arg2, arg3)
    ccall((:winchnstr, libncurses), Cint, (Ptr{WINDOW}, Ptr{chtype}, Cint), arg1, arg2, arg3)
end

function winsnstr(arg1, arg2, arg3)
    ccall((:winsnstr, libncurses), Cint, (Ptr{WINDOW}, Ptr{Cchar}, Cint), arg1, arg2, arg3)
end

function wredrawln(arg1, arg2, arg3)
    ccall((:wredrawln, libncurses), Cint, (Ptr{WINDOW}, Cint, Cint), arg1, arg2, arg3)
end

function waddnstr(arg1, arg2, arg3)
    ccall((:waddnstr, libncurses), Cint, (Ptr{WINDOW}, Ptr{Cchar}, Cint), arg1, arg2, arg3)
end

function waddchnstr(arg1, arg2, arg3)
    ccall((:waddchnstr, libncurses), Cint, (Ptr{WINDOW}, Ptr{chtype}, Cint), arg1, arg2, arg3)
end

function waddch(arg1, arg2)
    ccall((:waddch, libncurses), Cint, (Ptr{WINDOW}, chtype), arg1, arg2)
end

function wattr_get(arg1, arg2, arg3, arg4)
    ccall((:wattr_get, libncurses), Cint, (Ptr{WINDOW}, Ptr{attr_t}, Ptr{Cshort}, Ptr{Cvoid}), arg1, arg2, arg3, arg4)
end

function wattr_set(arg1, arg2, arg3, arg4)
    ccall((:wattr_set, libncurses), Cint, (Ptr{WINDOW}, attr_t, Cshort, Ptr{Cvoid}), arg1, arg2, arg3, arg4)
end

function wbkgd(arg1, arg2)
    ccall((:wbkgd, libncurses), Cint, (Ptr{WINDOW}, chtype), arg1, arg2)
end

function wbkgdset(arg1, arg2)
    ccall((:wbkgdset, libncurses), Cvoid, (Ptr{WINDOW}, chtype), arg1, arg2)
end

function wchgat(arg1, arg2, arg3, arg4, arg5)
    ccall((:wchgat, libncurses), Cint, (Ptr{WINDOW}, Cint, attr_t, Cshort, Ptr{Cvoid}), arg1, arg2, arg3, arg4, arg5)
end

function wclear(arg1)
    ccall((:wclear, libncurses), Cint, (Ptr{WINDOW},), arg1)
end

function wclrtobot(arg1)
    ccall((:wclrtobot, libncurses), Cint, (Ptr{WINDOW},), arg1)
end

function wclrtoeol(arg1)
    ccall((:wclrtoeol, libncurses), Cint, (Ptr{WINDOW},), arg1)
end

function wcolor_set(arg1, arg2, arg3)
    ccall((:wcolor_set, libncurses), Cint, (Ptr{WINDOW}, Cshort, Ptr{Cvoid}), arg1, arg2, arg3)
end

function wdelch(arg1)
    ccall((:wdelch, libncurses), Cint, (Ptr{WINDOW},), arg1)
end

function winsdelln(arg1, arg2)
    ccall((:winsdelln, libncurses), Cint, (Ptr{WINDOW}, Cint), arg1, arg2)
end

function wechochar(arg1, arg2)
    ccall((:wechochar, libncurses), Cint, (Ptr{WINDOW}, chtype), arg1, arg2)
end

function werase(arg1)
    ccall((:werase, libncurses), Cint, (Ptr{WINDOW},), arg1)
end

function wgetch(arg1)
    ccall((:wgetch, libncurses), Cint, (Ptr{WINDOW},), arg1)
end

function winch(arg1)
    ccall((:winch, libncurses), chtype, (Ptr{WINDOW},), arg1)
end

function winsch(arg1, arg2)
    ccall((:winsch, libncurses), Cint, (Ptr{WINDOW}, chtype), arg1, arg2)
end

function wrefresh(arg1)
    ccall((:wrefresh, libncurses), Cint, (Ptr{WINDOW},), arg1)
end

function wsetscrreg(arg1, arg2, arg3)
    ccall((:wsetscrreg, libncurses), Cint, (Ptr{WINDOW}, Cint, Cint), arg1, arg2, arg3)
end

function wtimeout(arg1, arg2)
    ccall((:wtimeout, libncurses), Cvoid, (Ptr{WINDOW}, Cint), arg1, arg2)
end

function slk_attroff(arg1)
    ccall((:slk_attroff, libncurses), Cint, (chtype,), arg1)
end

function slk_attron(arg1)
    ccall((:slk_attron, libncurses), Cint, (chtype,), arg1)
end

function wmouse_trafo(arg1, arg2, arg3, arg4)
    ccall((:wmouse_trafo, libncurses), Bool, (Ptr{WINDOW}, Ptr{Cint}, Ptr{Cint}, Bool), arg1, arg2, arg3, arg4)
end

function _tracechtype(arg1)
    ccall((:_tracechtype, libncurses), Ptr{Cchar}, (chtype,), arg1)
end

function _tracechtype2(arg1, arg2)
    ccall((:_tracechtype2, libncurses), Ptr{Cchar}, (Cint, chtype), arg1, arg2)
end

const mmask_t = Cuint

mutable struct screen end

const SCREEN = screen

function baudrate()
    ccall((:baudrate, libncurses), Cint, ())
end

function beep()
    ccall((:beep, libncurses), Cint, ())
end

function can_change_color()
    ccall((:can_change_color, libncurses), Bool, ())
end

function clearok(arg1, arg2)
    ccall((:clearok, libncurses), Cint, (Ptr{WINDOW}, Bool), arg1, arg2)
end

function color_content(arg1, arg2, arg3, arg4)
    ccall((:color_content, libncurses), Cint, (Cshort, Ptr{Cshort}, Ptr{Cshort}, Ptr{Cshort}), arg1, arg2, arg3, arg4)
end

function copywin(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    ccall((:copywin, libncurses), Cint, (Ptr{WINDOW}, Ptr{WINDOW}, Cint, Cint, Cint, Cint, Cint, Cint, Cint), arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
end

function curs_set(arg1)
    ccall((:curs_set, libncurses), Cint, (Cint,), arg1)
end

function def_shell_mode()
    ccall((:def_shell_mode, libncurses), Cint, ())
end

function delay_output(arg1)
    ccall((:delay_output, libncurses), Cint, (Cint,), arg1)
end

function delscreen(arg1)
    ccall((:delscreen, libncurses), Cvoid, (Ptr{SCREEN},), arg1)
end

function delwin(arg1)
    ccall((:delwin, libncurses), Cint, (Ptr{WINDOW},), arg1)
end

function derwin(arg1, arg2, arg3, arg4, arg5)
    ccall((:derwin, libncurses), Ptr{WINDOW}, (Ptr{WINDOW}, Cint, Cint, Cint, Cint), arg1, arg2, arg3, arg4, arg5)
end

function doupdate()
    ccall((:doupdate, libncurses), Cint, ())
end

function dupwin(arg1)
    ccall((:dupwin, libncurses), Ptr{WINDOW}, (Ptr{WINDOW},), arg1)
end

function echo()
    ccall((:echo, libncurses), Cint, ())
end

function endwin()
    ccall((:endwin, libncurses), Cint, ())
end

function erasechar()
    ccall((:erasechar, libncurses), Cchar, ())
end

function filter()
    ccall((:filter, libncurses), Cvoid, ())
end

function flash()
    ccall((:flash, libncurses), Cint, ())
end

function flushinp()
    ccall((:flushinp, libncurses), Cint, ())
end

function getwin(arg1)
    ccall((:getwin, libncurses), Ptr{WINDOW}, (Ptr{Libc.FILE},), arg1)
end

function halfdelay(arg1)
    ccall((:halfdelay, libncurses), Cint, (Cint,), arg1)
end

function has_colors()
    ccall((:has_colors, libncurses), Bool, ())
end

function has_ic()
    ccall((:has_ic, libncurses), Bool, ())
end

function has_il()
    ccall((:has_il, libncurses), Bool, ())
end

function idcok(arg1, arg2)
    ccall((:idcok, libncurses), Cvoid, (Ptr{WINDOW}, Bool), arg1, arg2)
end

function idlok(arg1, arg2)
    ccall((:idlok, libncurses), Cint, (Ptr{WINDOW}, Bool), arg1, arg2)
end

function immedok(arg1, arg2)
    ccall((:immedok, libncurses), Cvoid, (Ptr{WINDOW}, Bool), arg1, arg2)
end

function initscr()
    ccall((:initscr, libncurses), Ptr{WINDOW}, ())
end

function init_color(arg1, arg2, arg3, arg4)
    ccall((:init_color, libncurses), Cint, (Cshort, Cshort, Cshort, Cshort), arg1, arg2, arg3, arg4)
end

function init_pair(arg1, arg2, arg3)
    ccall((:init_pair, libncurses), Cint, (Cshort, Cshort, Cshort), arg1, arg2, arg3)
end

function intrflush(arg1, arg2)
    ccall((:intrflush, libncurses), Cint, (Ptr{WINDOW}, Bool), arg1, arg2)
end

function isendwin()
    ccall((:isendwin, libncurses), Bool, ())
end

function is_wintouched(arg1)
    ccall((:is_wintouched, libncurses), Bool, (Ptr{WINDOW},), arg1)
end

function keyname(arg1)
    ccall((:keyname, libncurses), Ptr{Cchar}, (Cint,), arg1)
end

function keypad(arg1, arg2)
    ccall((:keypad, libncurses), Cint, (Ptr{WINDOW}, Bool), arg1, arg2)
end

function killchar()
    ccall((:killchar, libncurses), Cchar, ())
end

function longname()
    ccall((:longname, libncurses), Ptr{Cchar}, ())
end

function meta(arg1, arg2)
    ccall((:meta, libncurses), Cint, (Ptr{WINDOW}, Bool), arg1, arg2)
end

function mvcur(arg1, arg2, arg3, arg4)
    ccall((:mvcur, libncurses), Cint, (Cint, Cint, Cint, Cint), arg1, arg2, arg3, arg4)
end

function mvderwin(arg1, arg2, arg3)
    ccall((:mvderwin, libncurses), Cint, (Ptr{WINDOW}, Cint, Cint), arg1, arg2, arg3)
end

function mvwin(arg1, arg2, arg3)
    ccall((:mvwin, libncurses), Cint, (Ptr{WINDOW}, Cint, Cint), arg1, arg2, arg3)
end

function napms(arg1)
    ccall((:napms, libncurses), Cint, (Cint,), arg1)
end

function newpad(arg1, arg2)
    ccall((:newpad, libncurses), Ptr{WINDOW}, (Cint, Cint), arg1, arg2)
end

function newterm(arg1, arg2, arg3)
    ccall((:newterm, libncurses), Ptr{SCREEN}, (Ptr{Cchar}, Ptr{Libc.FILE}, Ptr{Libc.FILE}), arg1, arg2, arg3)
end

function newwin(arg1, arg2, arg3, arg4)
    ccall((:newwin, libncurses), Ptr{WINDOW}, (Cint, Cint, Cint, Cint), arg1, arg2, arg3, arg4)
end

function nl()
    ccall((:nl, libncurses), Cint, ())
end

function nodelay(arg1, arg2)
    ccall((:nodelay, libncurses), Cint, (Ptr{WINDOW}, Bool), arg1, arg2)
end

function noecho()
    ccall((:noecho, libncurses), Cint, ())
end

function nonl()
    ccall((:nonl, libncurses), Cint, ())
end

function noqiflush()
    ccall((:noqiflush, libncurses), Cvoid, ())
end

function noraw()
    ccall((:noraw, libncurses), Cint, ())
end

function notimeout(arg1, arg2)
    ccall((:notimeout, libncurses), Cint, (Ptr{WINDOW}, Bool), arg1, arg2)
end

function overlay(arg1, arg2)
    ccall((:overlay, libncurses), Cint, (Ptr{WINDOW}, Ptr{WINDOW}), arg1, arg2)
end

function overwrite(arg1, arg2)
    ccall((:overwrite, libncurses), Cint, (Ptr{WINDOW}, Ptr{WINDOW}), arg1, arg2)
end

function pair_content(arg1, arg2, arg3)
    ccall((:pair_content, libncurses), Cint, (Cshort, Ptr{Cshort}, Ptr{Cshort}), arg1, arg2, arg3)
end

function pechochar(arg1, arg2)
    ccall((:pechochar, libncurses), Cint, (Ptr{WINDOW}, chtype), arg1, arg2)
end

function pnoutrefresh(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    ccall((:pnoutrefresh, libncurses), Cint, (Ptr{WINDOW}, Cint, Cint, Cint, Cint, Cint, Cint), arg1, arg2, arg3, arg4, arg5, arg6, arg7)
end

function prefresh(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    ccall((:prefresh, libncurses), Cint, (Ptr{WINDOW}, Cint, Cint, Cint, Cint, Cint, Cint), arg1, arg2, arg3, arg4, arg5, arg6, arg7)
end

function putwin(arg1, arg2)
    ccall((:putwin, libncurses), Cint, (Ptr{WINDOW}, Ptr{Libc.FILE}), arg1, arg2)
end

function qiflush()
    ccall((:qiflush, libncurses), Cvoid, ())
end

function raw()
    ccall((:raw, libncurses), Cint, ())
end

function resetty()
    ccall((:resetty, libncurses), Cint, ())
end

function ripoffline(arg1, arg2)
    ccall((:ripoffline, libncurses), Cint, (Cint, Ptr{Cvoid}), arg1, arg2)
end

function savetty()
    ccall((:savetty, libncurses), Cint, ())
end

function scr_dump(arg1)
    ccall((:scr_dump, libncurses), Cint, (Ptr{Cchar},), arg1)
end

function scr_init(arg1)
    ccall((:scr_init, libncurses), Cint, (Ptr{Cchar},), arg1)
end

function scrollok(arg1, arg2)
    ccall((:scrollok, libncurses), Cint, (Ptr{WINDOW}, Bool), arg1, arg2)
end

function scr_restore(arg1)
    ccall((:scr_restore, libncurses), Cint, (Ptr{Cchar},), arg1)
end

function scr_set(arg1)
    ccall((:scr_set, libncurses), Cint, (Ptr{Cchar},), arg1)
end

function set_term(arg1)
    ccall((:set_term, libncurses), Ptr{SCREEN}, (Ptr{SCREEN},), arg1)
end

function slk_attrset(arg1)
    ccall((:slk_attrset, libncurses), Cint, (chtype,), arg1)
end

function slk_attr()
    ccall((:slk_attr, libncurses), attr_t, ())
end

function slk_attr_set(arg1, arg2, arg3)
    ccall((:slk_attr_set, libncurses), Cint, (attr_t, Cshort, Ptr{Cvoid}), arg1, arg2, arg3)
end

function slk_clear()
    ccall((:slk_clear, libncurses), Cint, ())
end

function slk_color(arg1)
    ccall((:slk_color, libncurses), Cint, (Cshort,), arg1)
end

function slk_init(arg1)
    ccall((:slk_init, libncurses), Cint, (Cint,), arg1)
end

function slk_label(arg1)
    ccall((:slk_label, libncurses), Ptr{Cchar}, (Cint,), arg1)
end

function slk_noutrefresh()
    ccall((:slk_noutrefresh, libncurses), Cint, ())
end

function slk_refresh()
    ccall((:slk_refresh, libncurses), Cint, ())
end

function slk_restore()
    ccall((:slk_restore, libncurses), Cint, ())
end

function slk_set(arg1, arg2, arg3)
    ccall((:slk_set, libncurses), Cint, (Cint, Ptr{Cchar}, Cint), arg1, arg2, arg3)
end

function slk_touch()
    ccall((:slk_touch, libncurses), Cint, ())
end

function start_color()
    ccall((:start_color, libncurses), Cint, ())
end

function subpad(arg1, arg2, arg3, arg4, arg5)
    ccall((:subpad, libncurses), Ptr{WINDOW}, (Ptr{WINDOW}, Cint, Cint, Cint, Cint), arg1, arg2, arg3, arg4, arg5)
end

function subwin(arg1, arg2, arg3, arg4, arg5)
    ccall((:subwin, libncurses), Ptr{WINDOW}, (Ptr{WINDOW}, Cint, Cint, Cint, Cint), arg1, arg2, arg3, arg4, arg5)
end

function syncok(arg1, arg2)
    ccall((:syncok, libncurses), Cint, (Ptr{WINDOW}, Bool), arg1, arg2)
end

function termattrs()
    ccall((:termattrs, libncurses), chtype, ())
end

function termname()
    ccall((:termname, libncurses), Ptr{Cchar}, ())
end

function typeahead(arg1)
    ccall((:typeahead, libncurses), Cint, (Cint,), arg1)
end

function ungetch(arg1)
    ccall((:ungetch, libncurses), Cint, (Cint,), arg1)
end

function use_env(arg1)
    ccall((:use_env, libncurses), Cvoid, (Bool,), arg1)
end

function use_tioctl(arg1)
    ccall((:use_tioctl, libncurses), Cvoid, (Bool,), arg1)
end

function vidputs(arg1, arg2)
    ccall((:vidputs, libncurses), Cint, (chtype, NCURSES_OUTC), arg1, arg2)
end

function wcursyncup(arg1)
    ccall((:wcursyncup, libncurses), Cvoid, (Ptr{WINDOW},), arg1)
end

function wnoutrefresh(arg1)
    ccall((:wnoutrefresh, libncurses), Cint, (Ptr{WINDOW},), arg1)
end

function wsyncdown(arg1)
    ccall((:wsyncdown, libncurses), Cvoid, (Ptr{WINDOW},), arg1)
end

function wsyncup(arg1)
    ccall((:wsyncup, libncurses), Cvoid, (Ptr{WINDOW},), arg1)
end

function tigetflag(arg1)
    ccall((:tigetflag, libncurses), Cint, (Ptr{Cchar},), arg1)
end

function tigetnum(arg1)
    ccall((:tigetnum, libncurses), Cint, (Ptr{Cchar},), arg1)
end

function tigetstr(arg1)
    ccall((:tigetstr, libncurses), Ptr{Cchar}, (Ptr{Cchar},), arg1)
end

function putp(arg1)
    ccall((:putp, libncurses), Cint, (Ptr{Cchar},), arg1)
end

# typedef int ( * NCURSES_WINDOW_CB ) ( WINDOW * , void * )
const NCURSES_WINDOW_CB = Ptr{Cvoid}

# typedef int ( * NCURSES_SCREEN_CB ) ( SCREEN * , void * )
const NCURSES_SCREEN_CB = Ptr{Cvoid}

function is_term_resized(arg1, arg2)
    ccall((:is_term_resized, libncurses), Bool, (Cint, Cint), arg1, arg2)
end

function keybound(arg1, arg2)
    ccall((:keybound, libncurses), Ptr{Cchar}, (Cint, Cint), arg1, arg2)
end

function curses_version()
    ccall((:curses_version, libncurses), Ptr{Cchar}, ())
end

function alloc_pair(arg1, arg2)
    ccall((:alloc_pair, libncurses), Cint, (Cint, Cint), arg1, arg2)
end

function assume_default_colors(arg1, arg2)
    ccall((:assume_default_colors, libncurses), Cint, (Cint, Cint), arg1, arg2)
end

function define_key(arg1, arg2)
    ccall((:define_key, libncurses), Cint, (Ptr{Cchar}, Cint), arg1, arg2)
end

function extended_color_content(arg1, arg2, arg3, arg4)
    ccall((:extended_color_content, libncurses), Cint, (Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), arg1, arg2, arg3, arg4)
end

function extended_pair_content(arg1, arg2, arg3)
    ccall((:extended_pair_content, libncurses), Cint, (Cint, Ptr{Cint}, Ptr{Cint}), arg1, arg2, arg3)
end

function extended_slk_color(arg1)
    ccall((:extended_slk_color, libncurses), Cint, (Cint,), arg1)
end

function find_pair(arg1, arg2)
    ccall((:find_pair, libncurses), Cint, (Cint, Cint), arg1, arg2)
end

function free_pair(arg1)
    ccall((:free_pair, libncurses), Cint, (Cint,), arg1)
end

function get_escdelay()
    ccall((:get_escdelay, libncurses), Cint, ())
end

function init_extended_color(arg1, arg2, arg3, arg4)
    ccall((:init_extended_color, libncurses), Cint, (Cint, Cint, Cint, Cint), arg1, arg2, arg3, arg4)
end

function init_extended_pair(arg1, arg2, arg3)
    ccall((:init_extended_pair, libncurses), Cint, (Cint, Cint, Cint), arg1, arg2, arg3)
end

function key_defined(arg1)
    ccall((:key_defined, libncurses), Cint, (Ptr{Cchar},), arg1)
end

function keyok(arg1, arg2)
    ccall((:keyok, libncurses), Cint, (Cint, Bool), arg1, arg2)
end

function reset_color_pairs()
    ccall((:reset_color_pairs, libncurses), Cvoid, ())
end

function resize_term(arg1, arg2)
    ccall((:resize_term, libncurses), Cint, (Cint, Cint), arg1, arg2)
end

function resizeterm(arg1, arg2)
    ccall((:resizeterm, libncurses), Cint, (Cint, Cint), arg1, arg2)
end

function set_escdelay(arg1)
    ccall((:set_escdelay, libncurses), Cint, (Cint,), arg1)
end

function set_tabsize(arg1)
    ccall((:set_tabsize, libncurses), Cint, (Cint,), arg1)
end

function use_default_colors()
    ccall((:use_default_colors, libncurses), Cint, ())
end

function use_extended_names(arg1)
    ccall((:use_extended_names, libncurses), Cint, (Bool,), arg1)
end

function use_legacy_coding(arg1)
    ccall((:use_legacy_coding, libncurses), Cint, (Cint,), arg1)
end

function use_screen(arg1, arg2, arg3)
    ccall((:use_screen, libncurses), Cint, (Ptr{SCREEN}, NCURSES_SCREEN_CB, Ptr{Cvoid}), arg1, arg2, arg3)
end

function use_window(arg1, arg2, arg3)
    ccall((:use_window, libncurses), Cint, (Ptr{WINDOW}, NCURSES_WINDOW_CB, Ptr{Cvoid}), arg1, arg2, arg3)
end

function wresize(arg1, arg2, arg3)
    ccall((:wresize, libncurses), Cint, (Ptr{WINDOW}, Cint, Cint), arg1, arg2, arg3)
end

function nofilter()
    ccall((:nofilter, libncurses), Cvoid, ())
end

# typedef int ( * NCURSES_SP_OUTC ) ( SCREEN * , int )
const NCURSES_OUTC_sp = Ptr{Cvoid}

function new_prescr()
    ccall((:new_prescr, libncurses), Ptr{SCREEN}, ())
end

function baudrate_sp(arg1)
    ccall((:baudrate_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function beep_sp(arg1)
    ccall((:beep_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function can_change_color_sp(arg1)
    ccall((:can_change_color_sp, libncurses), Bool, (Ptr{SCREEN},), arg1)
end

function cbreak_sp(arg1)
    ccall((:cbreak_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function curs_set_sp(arg1, arg2)
    ccall((:curs_set_sp, libncurses), Cint, (Ptr{SCREEN}, Cint), arg1, arg2)
end

function color_content_sp(arg1, arg2, arg3, arg4, arg5)
    ccall((:color_content_sp, libncurses), Cint, (Ptr{SCREEN}, Cshort, Ptr{Cshort}, Ptr{Cshort}, Ptr{Cshort}), arg1, arg2, arg3, arg4, arg5)
end

function def_prog_mode_sp(arg1)
    ccall((:def_prog_mode_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function def_shell_mode_sp(arg1)
    ccall((:def_shell_mode_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function delay_output_sp(arg1, arg2)
    ccall((:delay_output_sp, libncurses), Cint, (Ptr{SCREEN}, Cint), arg1, arg2)
end

function doupdate_sp(arg1)
    ccall((:doupdate_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function echo_sp(arg1)
    ccall((:echo_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function endwin_sp(arg1)
    ccall((:endwin_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function erasechar_sp(arg1)
    ccall((:erasechar_sp, libncurses), Cchar, (Ptr{SCREEN},), arg1)
end

function filter_sp(arg1)
    ccall((:filter_sp, libncurses), Cvoid, (Ptr{SCREEN},), arg1)
end

function flash_sp(arg1)
    ccall((:flash_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function flushinp_sp(arg1)
    ccall((:flushinp_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function getwin_sp(arg1, arg2)
    ccall((:getwin_sp, libncurses), Ptr{WINDOW}, (Ptr{SCREEN}, Ptr{Libc.FILE}), arg1, arg2)
end

function halfdelay_sp(arg1, arg2)
    ccall((:halfdelay_sp, libncurses), Cint, (Ptr{SCREEN}, Cint), arg1, arg2)
end

function has_colors_sp(arg1)
    ccall((:has_colors_sp, libncurses), Bool, (Ptr{SCREEN},), arg1)
end

function has_ic_sp(arg1)
    ccall((:has_ic_sp, libncurses), Bool, (Ptr{SCREEN},), arg1)
end

function has_il_sp(arg1)
    ccall((:has_il_sp, libncurses), Bool, (Ptr{SCREEN},), arg1)
end

function init_color_sp(arg1, arg2, arg3, arg4, arg5)
    ccall((:init_color_sp, libncurses), Cint, (Ptr{SCREEN}, Cshort, Cshort, Cshort, Cshort), arg1, arg2, arg3, arg4, arg5)
end

function init_pair_sp(arg1, arg2, arg3, arg4)
    ccall((:init_pair_sp, libncurses), Cint, (Ptr{SCREEN}, Cshort, Cshort, Cshort), arg1, arg2, arg3, arg4)
end

function intrflush_sp(arg1, arg2, arg3)
    ccall((:intrflush_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{WINDOW}, Bool), arg1, arg2, arg3)
end

function isendwin_sp(arg1)
    ccall((:isendwin_sp, libncurses), Bool, (Ptr{SCREEN},), arg1)
end

function keyname_sp(arg1, arg2)
    ccall((:keyname_sp, libncurses), Ptr{Cchar}, (Ptr{SCREEN}, Cint), arg1, arg2)
end

function killchar_sp(arg1)
    ccall((:killchar_sp, libncurses), Cchar, (Ptr{SCREEN},), arg1)
end

function longname_sp(arg1)
    ccall((:longname_sp, libncurses), Ptr{Cchar}, (Ptr{SCREEN},), arg1)
end

function mvcur_sp(arg1, arg2, arg3, arg4, arg5)
    ccall((:mvcur_sp, libncurses), Cint, (Ptr{SCREEN}, Cint, Cint, Cint, Cint), arg1, arg2, arg3, arg4, arg5)
end

function napms_sp(arg1, arg2)
    ccall((:napms_sp, libncurses), Cint, (Ptr{SCREEN}, Cint), arg1, arg2)
end

function newpad_sp(arg1, arg2, arg3)
    ccall((:newpad_sp, libncurses), Ptr{WINDOW}, (Ptr{SCREEN}, Cint, Cint), arg1, arg2, arg3)
end

function newterm_sp(arg1, arg2, arg3, arg4)
    ccall((:newterm_sp, libncurses), Ptr{SCREEN}, (Ptr{SCREEN}, Ptr{Cchar}, Ptr{Libc.FILE}, Ptr{Libc.FILE}), arg1, arg2, arg3, arg4)
end

function newwin_sp(arg1, arg2, arg3, arg4, arg5)
    ccall((:newwin_sp, libncurses), Ptr{WINDOW}, (Ptr{SCREEN}, Cint, Cint, Cint, Cint), arg1, arg2, arg3, arg4, arg5)
end

function nl_sp(arg1)
    ccall((:nl_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function nocbreak_sp(arg1)
    ccall((:nocbreak_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function noecho_sp(arg1)
    ccall((:noecho_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function nonl_sp(arg1)
    ccall((:nonl_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function noqiflush_sp(arg1)
    ccall((:noqiflush_sp, libncurses), Cvoid, (Ptr{SCREEN},), arg1)
end

function noraw_sp(arg1)
    ccall((:noraw_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function pair_content_sp(arg1, arg2, arg3, arg4)
    ccall((:pair_content_sp, libncurses), Cint, (Ptr{SCREEN}, Cshort, Ptr{Cshort}, Ptr{Cshort}), arg1, arg2, arg3, arg4)
end

function qiflush_sp(arg1)
    ccall((:qiflush_sp, libncurses), Cvoid, (Ptr{SCREEN},), arg1)
end

function raw_sp(arg1)
    ccall((:raw_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function reset_prog_mode_sp(arg1)
    ccall((:reset_prog_mode_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function reset_shell_mode_sp(arg1)
    ccall((:reset_shell_mode_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function resetty_sp(arg1)
    ccall((:resetty_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function ripoffline_sp(arg1, arg2, arg3)
    ccall((:ripoffline_sp, libncurses), Cint, (Ptr{SCREEN}, Cint, Ptr{Cvoid}), arg1, arg2, arg3)
end

function savetty_sp(arg1)
    ccall((:savetty_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function scr_init_sp(arg1, arg2)
    ccall((:scr_init_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{Cchar}), arg1, arg2)
end

function scr_restore_sp(arg1, arg2)
    ccall((:scr_restore_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{Cchar}), arg1, arg2)
end

function scr_set_sp(arg1, arg2)
    ccall((:scr_set_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{Cchar}), arg1, arg2)
end

function slk_attroff_sp(arg1, arg2)
    ccall((:slk_attroff_sp, libncurses), Cint, (Ptr{SCREEN}, chtype), arg1, arg2)
end

function slk_attron_sp(arg1, arg2)
    ccall((:slk_attron_sp, libncurses), Cint, (Ptr{SCREEN}, chtype), arg1, arg2)
end

function slk_attrset_sp(arg1, arg2)
    ccall((:slk_attrset_sp, libncurses), Cint, (Ptr{SCREEN}, chtype), arg1, arg2)
end

function slk_attr_sp(arg1)
    ccall((:slk_attr_sp, libncurses), attr_t, (Ptr{SCREEN},), arg1)
end

function slk_attr_set_sp(arg1, arg2, arg3, arg4)
    ccall((:slk_attr_set_sp, libncurses), Cint, (Ptr{SCREEN}, attr_t, Cshort, Ptr{Cvoid}), arg1, arg2, arg3, arg4)
end

function slk_clear_sp(arg1)
    ccall((:slk_clear_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function slk_color_sp(arg1, arg2)
    ccall((:slk_color_sp, libncurses), Cint, (Ptr{SCREEN}, Cshort), arg1, arg2)
end

function slk_init_sp(arg1, arg2)
    ccall((:slk_init_sp, libncurses), Cint, (Ptr{SCREEN}, Cint), arg1, arg2)
end

function slk_label_sp(arg1, arg2)
    ccall((:slk_label_sp, libncurses), Ptr{Cchar}, (Ptr{SCREEN}, Cint), arg1, arg2)
end

function slk_noutrefresh_sp(arg1)
    ccall((:slk_noutrefresh_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function slk_refresh_sp(arg1)
    ccall((:slk_refresh_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function slk_restore_sp(arg1)
    ccall((:slk_restore_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function slk_set_sp(arg1, arg2, arg3, arg4)
    ccall((:slk_set_sp, libncurses), Cint, (Ptr{SCREEN}, Cint, Ptr{Cchar}, Cint), arg1, arg2, arg3, arg4)
end

function slk_touch_sp(arg1)
    ccall((:slk_touch_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function start_color_sp(arg1)
    ccall((:start_color_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function termattrs_sp(arg1)
    ccall((:termattrs_sp, libncurses), chtype, (Ptr{SCREEN},), arg1)
end

function termname_sp(arg1)
    ccall((:termname_sp, libncurses), Ptr{Cchar}, (Ptr{SCREEN},), arg1)
end

function typeahead_sp(arg1, arg2)
    ccall((:typeahead_sp, libncurses), Cint, (Ptr{SCREEN}, Cint), arg1, arg2)
end

function ungetch_sp(arg1, arg2)
    ccall((:ungetch_sp, libncurses), Cint, (Ptr{SCREEN}, Cint), arg1, arg2)
end

function use_env_sp(arg1, arg2)
    ccall((:use_env_sp, libncurses), Cvoid, (Ptr{SCREEN}, Bool), arg1, arg2)
end

function use_tioctl_sp(arg1, arg2)
    ccall((:use_tioctl_sp, libncurses), Cvoid, (Ptr{SCREEN}, Bool), arg1, arg2)
end

function vidattr_sp(arg1, arg2)
    ccall((:vidattr_sp, libncurses), Cint, (Ptr{SCREEN}, chtype), arg1, arg2)
end

function vidputs_sp(arg1, arg2, arg3)
    ccall((:vidputs_sp, libncurses), Cint, (Ptr{SCREEN}, chtype, NCURSES_OUTC_sp), arg1, arg2, arg3)
end

function keybound_sp(arg1, arg2, arg3)
    ccall((:keybound_sp, libncurses), Ptr{Cchar}, (Ptr{SCREEN}, Cint, Cint), arg1, arg2, arg3)
end

function alloc_pair_sp(arg1, arg2, arg3)
    ccall((:alloc_pair_sp, libncurses), Cint, (Ptr{SCREEN}, Cint, Cint), arg1, arg2, arg3)
end

function assume_default_colors_sp(arg1, arg2, arg3)
    ccall((:assume_default_colors_sp, libncurses), Cint, (Ptr{SCREEN}, Cint, Cint), arg1, arg2, arg3)
end

function define_key_sp(arg1, arg2, arg3)
    ccall((:define_key_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{Cchar}, Cint), arg1, arg2, arg3)
end

function extended_color_content_sp(arg1, arg2, arg3, arg4, arg5)
    ccall((:extended_color_content_sp, libncurses), Cint, (Ptr{SCREEN}, Cint, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), arg1, arg2, arg3, arg4, arg5)
end

function extended_pair_content_sp(arg1, arg2, arg3, arg4)
    ccall((:extended_pair_content_sp, libncurses), Cint, (Ptr{SCREEN}, Cint, Ptr{Cint}, Ptr{Cint}), arg1, arg2, arg3, arg4)
end

function extended_slk_color_sp(arg1, arg2)
    ccall((:extended_slk_color_sp, libncurses), Cint, (Ptr{SCREEN}, Cint), arg1, arg2)
end

function get_escdelay_sp(arg1)
    ccall((:get_escdelay_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function find_pair_sp(arg1, arg2, arg3)
    ccall((:find_pair_sp, libncurses), Cint, (Ptr{SCREEN}, Cint, Cint), arg1, arg2, arg3)
end

function free_pair_sp(arg1, arg2)
    ccall((:free_pair_sp, libncurses), Cint, (Ptr{SCREEN}, Cint), arg1, arg2)
end

function init_extended_color_sp(arg1, arg2, arg3, arg4, arg5)
    ccall((:init_extended_color_sp, libncurses), Cint, (Ptr{SCREEN}, Cint, Cint, Cint, Cint), arg1, arg2, arg3, arg4, arg5)
end

function init_extended_pair_sp(arg1, arg2, arg3, arg4)
    ccall((:init_extended_pair_sp, libncurses), Cint, (Ptr{SCREEN}, Cint, Cint, Cint), arg1, arg2, arg3, arg4)
end

function is_term_resized_sp(arg1, arg2, arg3)
    ccall((:is_term_resized_sp, libncurses), Bool, (Ptr{SCREEN}, Cint, Cint), arg1, arg2, arg3)
end

function key_defined_sp(arg1, arg2)
    ccall((:key_defined_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{Cchar}), arg1, arg2)
end

function keyok_sp(arg1, arg2, arg3)
    ccall((:keyok_sp, libncurses), Cint, (Ptr{SCREEN}, Cint, Bool), arg1, arg2, arg3)
end

function nofilter_sp(arg1)
    ccall((:nofilter_sp, libncurses), Cvoid, (Ptr{SCREEN},), arg1)
end

function reset_color_pairs_sp(arg1)
    ccall((:reset_color_pairs_sp, libncurses), Cvoid, (Ptr{SCREEN},), arg1)
end

function resize_term_sp(arg1, arg2, arg3)
    ccall((:resize_term_sp, libncurses), Cint, (Ptr{SCREEN}, Cint, Cint), arg1, arg2, arg3)
end

function resizeterm_sp(arg1, arg2, arg3)
    ccall((:resizeterm_sp, libncurses), Cint, (Ptr{SCREEN}, Cint, Cint), arg1, arg2, arg3)
end

function set_escdelay_sp(arg1, arg2)
    ccall((:set_escdelay_sp, libncurses), Cint, (Ptr{SCREEN}, Cint), arg1, arg2)
end

function set_tabsize_sp(arg1, arg2)
    ccall((:set_tabsize_sp, libncurses), Cint, (Ptr{SCREEN}, Cint), arg1, arg2)
end

function use_default_colors_sp(arg1)
    ccall((:use_default_colors_sp, libncurses), Cint, (Ptr{SCREEN},), arg1)
end

function use_legacy_coding_sp(arg1, arg2)
    ccall((:use_legacy_coding_sp, libncurses), Cint, (Ptr{SCREEN}, Cint), arg1, arg2)
end

struct MEVENT
    id::Cshort
    x::Cint
    y::Cint
    z::Cint
    bstate::mmask_t
end

function has_mouse()
    ccall((:has_mouse, libncurses), Bool, ())
end

function getmouse(arg1)
    ccall((:getmouse, libncurses), Cint, (Ptr{MEVENT},), arg1)
end

function ungetmouse(arg1)
    ccall((:ungetmouse, libncurses), Cint, (Ptr{MEVENT},), arg1)
end

function mousemask(arg1, arg2)
    ccall((:mousemask, libncurses), mmask_t, (mmask_t, Ptr{mmask_t}), arg1, arg2)
end

function wenclose(arg1, arg2, arg3)
    ccall((:wenclose, libncurses), Bool, (Ptr{WINDOW}, Cint, Cint), arg1, arg2, arg3)
end

function mouseinterval(arg1)
    ccall((:mouseinterval, libncurses), Cint, (Cint,), arg1)
end

function has_mouse_sp(arg1)
    ccall((:has_mouse_sp, libncurses), Bool, (Ptr{SCREEN},), arg1)
end

function getmouse_sp(arg1, arg2)
    ccall((:getmouse_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{MEVENT}), arg1, arg2)
end

function ungetmouse_sp(arg1, arg2)
    ccall((:ungetmouse_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{MEVENT}), arg1, arg2)
end

function mousemask_sp(arg1, arg2, arg3)
    ccall((:mousemask_sp, libncurses), mmask_t, (Ptr{SCREEN}, mmask_t, Ptr{mmask_t}), arg1, arg2, arg3)
end

function mouseinterval_sp(arg1, arg2)
    ccall((:mouseinterval_sp, libncurses), Cint, (Ptr{SCREEN}, Cint), arg1, arg2)
end

function mcprint(arg1, arg2)
    ccall((:mcprint, libncurses), Cint, (Ptr{Cchar}, Cint), arg1, arg2)
end

function has_key(arg1)
    ccall((:has_key, libncurses), Cint, (Cint,), arg1)
end

function has_key_sp(arg1, arg2)
    ccall((:has_key_sp, libncurses), Cint, (Ptr{SCREEN}, Cint), arg1, arg2)
end

function mcprint_sp(arg1, arg2, arg3)
    ccall((:mcprint_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{Cchar}, Cint), arg1, arg2, arg3)
end

function _traceattr(arg1)
    ccall((:_traceattr, libncurses), Ptr{Cchar}, (attr_t,), arg1)
end

function _traceattr2(arg1, arg2)
    ccall((:_traceattr2, libncurses), Ptr{Cchar}, (Cint, chtype), arg1, arg2)
end

function _tracechar(arg1)
    ccall((:_tracechar, libncurses), Ptr{Cchar}, (Cint,), arg1)
end

function trace(arg1)
    ccall((:trace, libncurses), Cvoid, (Cuint,), arg1)
end

function curses_trace(arg1)
    ccall((:curses_trace, libncurses), Cuint, (Cuint,), arg1)
end

function exit_curses(arg1)
    ccall((:exit_curses, libncurses), Cvoid, (Cint,), arg1)
end

function unctrl(arg1)
    ccall((:unctrl, libncurses), Ptr{Cchar}, (chtype,), arg1)
end

function unctrl_sp(arg1, arg2)
    ccall((:unctrl_sp, libncurses), Ptr{Cchar}, (Ptr{SCREEN}, chtype), arg1, arg2)
end

const FIELD_CELL = Ptr{Cvoid}

const Form_Options = Cint

const Field_Options = Cint

struct pagenode
    pmin::Cshort
    pmax::Cshort
    smin::Cshort
    smax::Cshort
end

const _PAGE = pagenode

struct formnode
    status::Cushort
    rows::Cshort
    cols::Cshort
    currow::Cint
    curcol::Cint
    toprow::Cint
    begincol::Cint
    maxfield::Cshort
    maxpage::Cshort
    curpage::Cshort
    opts::Form_Options
    win::Ptr{WINDOW}
    sub::Ptr{WINDOW}
    w::Ptr{WINDOW}
    field::Ptr{Ptr{Cvoid}} # field::Ptr{Ptr{FIELD}}
    current::Ptr{Cvoid} # current::Ptr{FIELD}
    page::Ptr{_PAGE}
    usrptr::Ptr{Cvoid}
    forminit::Ptr{Cvoid}
    formterm::Ptr{Cvoid}
    fieldinit::Ptr{Cvoid}
    fieldterm::Ptr{Cvoid}
end

function Base.getproperty(x::formnode, f::Symbol)
    f === :field && return Ptr{Ptr{FIELD}}(getfield(x, f))
    f === :current && return Ptr{FIELD}(getfield(x, f))
    return getfield(x, f)
end

struct var"##Ctag#247"
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#247"}, f::Symbol)
    f === :ofcheck && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :gfcheck && return Ptr{Ptr{Cvoid}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#247", f::Symbol)
    r = Ref{var"##Ctag#247"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#247"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#247"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#248"
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#248"}, f::Symbol)
    f === :occheck && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :gccheck && return Ptr{Ptr{Cvoid}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#248", f::Symbol)
    r = Ref{var"##Ctag#248"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#248"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#248"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#249"
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#249"}, f::Symbol)
    f === :onext && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :gnext && return Ptr{Ptr{Cvoid}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#249", f::Symbol)
    r = Ref{var"##Ctag#249"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#249"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#249"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct var"##Ctag#250"
    data::NTuple{8, UInt8}
end

function Base.getproperty(x::Ptr{var"##Ctag#250"}, f::Symbol)
    f === :oprev && return Ptr{Ptr{Cvoid}}(x + 0)
    f === :gprev && return Ptr{Ptr{Cvoid}}(x + 0)
    return getfield(x, f)
end

function Base.getproperty(x::var"##Ctag#250", f::Symbol)
    r = Ref{var"##Ctag#250"}(x)
    ptr = Base.unsafe_convert(Ptr{var"##Ctag#250"}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{var"##Ctag#250"}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct typenode
    data::NTuple{96, UInt8}
end

function Base.getproperty(x::Ptr{typenode}, f::Symbol)
    f === :status && return Ptr{Cushort}(x + 0)
    f === :ref && return Ptr{Clong}(x + 8)
    f === :left && return Ptr{Ptr{typenode}}(x + 16)
    f === :right && return Ptr{Ptr{typenode}}(x + 24)
    f === :makearg && return Ptr{Ptr{Cvoid}}(x + 32)
    f === :copyarg && return Ptr{Ptr{Cvoid}}(x + 40)
    f === :freearg && return Ptr{Ptr{Cvoid}}(x + 48)
    f === :fieldcheck && return Ptr{var"##Ctag#247"}(x + 56)
    f === :charcheck && return Ptr{var"##Ctag#248"}(x + 64)
    f === :enum_next && return Ptr{var"##Ctag#249"}(x + 72)
    f === :enum_prev && return Ptr{var"##Ctag#250"}(x + 80)
    f === :genericarg && return Ptr{Ptr{Cvoid}}(x + 88)
    return getfield(x, f)
end

function Base.getproperty(x::typenode, f::Symbol)
    r = Ref{typenode}(x)
    ptr = Base.unsafe_convert(Ptr{typenode}, r)
    fptr = getproperty(ptr, f)
    GC.@preserve r unsafe_load(fptr)
end

function Base.setproperty!(x::Ptr{typenode}, f::Symbol, v)
    unsafe_store!(getproperty(x, f), v)
end

struct fieldnode
    status::Cushort
    rows::Cshort
    cols::Cshort
    frow::Cshort
    fcol::Cshort
    drows::Cint
    dcols::Cint
    maxgrow::Cint
    nrow::Cint
    nbuf::Cshort
    just::Cshort
    page::Cshort
    index::Cshort
    pad::Cint
    fore::chtype
    back::chtype
    opts::Field_Options
    snext::Ptr{fieldnode}
    sprev::Ptr{fieldnode}
    link::Ptr{fieldnode}
    form::Ptr{formnode}
    type::Ptr{typenode}
    arg::Ptr{Cvoid}
    buf::Ptr{FIELD_CELL}
    usrptr::Ptr{Cvoid}
end

const FIELD = fieldnode

const FORM = formnode

const FIELDTYPE = typenode

# typedef void ( * Form_Hook ) ( FORM * )
const Form_Hook = Ptr{Cvoid}

function new_fieldtype(field_check, char_check)
    ccall((:new_fieldtype, libncurses), Ptr{FIELDTYPE}, (Ptr{Cvoid}, Ptr{Cvoid}), field_check, char_check)
end

function link_fieldtype(arg1, arg2)
    ccall((:link_fieldtype, libncurses), Ptr{FIELDTYPE}, (Ptr{FIELDTYPE}, Ptr{FIELDTYPE}), arg1, arg2)
end

function free_fieldtype(arg1)
    ccall((:free_fieldtype, libncurses), Cint, (Ptr{FIELDTYPE},), arg1)
end

function set_fieldtype_arg(arg1, make_arg, copy_arg, free_arg)
    ccall((:set_fieldtype_arg, libncurses), Cint, (Ptr{FIELDTYPE}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}), arg1, make_arg, copy_arg, free_arg)
end

function set_fieldtype_choice(arg1, next_choice, prev_choice)
    ccall((:set_fieldtype_choice, libncurses), Cint, (Ptr{FIELDTYPE}, Ptr{Cvoid}, Ptr{Cvoid}), arg1, next_choice, prev_choice)
end

function new_field(arg1, arg2, arg3, arg4, arg5, arg6)
    ccall((:new_field, libncurses), Ptr{FIELD}, (Cint, Cint, Cint, Cint, Cint, Cint), arg1, arg2, arg3, arg4, arg5, arg6)
end

function dup_field(arg1, arg2, arg3)
    ccall((:dup_field, libncurses), Ptr{FIELD}, (Ptr{FIELD}, Cint, Cint), arg1, arg2, arg3)
end

function link_field(arg1, arg2, arg3)
    ccall((:link_field, libncurses), Ptr{FIELD}, (Ptr{FIELD}, Cint, Cint), arg1, arg2, arg3)
end

function free_field(arg1)
    ccall((:free_field, libncurses), Cint, (Ptr{FIELD},), arg1)
end

function field_info(arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    ccall((:field_info, libncurses), Cint, (Ptr{FIELD}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), arg1, arg2, arg3, arg4, arg5, arg6, arg7)
end

function dynamic_field_info(arg1, arg2, arg3, arg4)
    ccall((:dynamic_field_info, libncurses), Cint, (Ptr{FIELD}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), arg1, arg2, arg3, arg4)
end

function set_max_field(arg1, arg2)
    ccall((:set_max_field, libncurses), Cint, (Ptr{FIELD}, Cint), arg1, arg2)
end

function move_field(arg1, arg2, arg3)
    ccall((:move_field, libncurses), Cint, (Ptr{FIELD}, Cint, Cint), arg1, arg2, arg3)
end

function set_new_page(arg1, arg2)
    ccall((:set_new_page, libncurses), Cint, (Ptr{FIELD}, Bool), arg1, arg2)
end

function set_field_just(arg1, arg2)
    ccall((:set_field_just, libncurses), Cint, (Ptr{FIELD}, Cint), arg1, arg2)
end

function field_just(arg1)
    ccall((:field_just, libncurses), Cint, (Ptr{FIELD},), arg1)
end

function set_field_fore(arg1, arg2)
    ccall((:set_field_fore, libncurses), Cint, (Ptr{FIELD}, chtype), arg1, arg2)
end

function set_field_back(arg1, arg2)
    ccall((:set_field_back, libncurses), Cint, (Ptr{FIELD}, chtype), arg1, arg2)
end

function set_field_pad(arg1, arg2)
    ccall((:set_field_pad, libncurses), Cint, (Ptr{FIELD}, Cint), arg1, arg2)
end

function field_pad(arg1)
    ccall((:field_pad, libncurses), Cint, (Ptr{FIELD},), arg1)
end

function set_field_buffer(arg1, arg2, arg3)
    ccall((:set_field_buffer, libncurses), Cint, (Ptr{FIELD}, Cint, Ptr{Cchar}), arg1, arg2, arg3)
end

function set_field_status(arg1, arg2)
    ccall((:set_field_status, libncurses), Cint, (Ptr{FIELD}, Bool), arg1, arg2)
end

function set_field_userptr(arg1, arg2)
    ccall((:set_field_userptr, libncurses), Cint, (Ptr{FIELD}, Ptr{Cvoid}), arg1, arg2)
end

function set_field_opts(arg1, arg2)
    ccall((:set_field_opts, libncurses), Cint, (Ptr{FIELD}, Field_Options), arg1, arg2)
end

function field_opts_on(arg1, arg2)
    ccall((:field_opts_on, libncurses), Cint, (Ptr{FIELD}, Field_Options), arg1, arg2)
end

function field_opts_off(arg1, arg2)
    ccall((:field_opts_off, libncurses), Cint, (Ptr{FIELD}, Field_Options), arg1, arg2)
end

function field_fore(arg1)
    ccall((:field_fore, libncurses), chtype, (Ptr{FIELD},), arg1)
end

function field_back(arg1)
    ccall((:field_back, libncurses), chtype, (Ptr{FIELD},), arg1)
end

function new_page(arg1)
    ccall((:new_page, libncurses), Bool, (Ptr{FIELD},), arg1)
end

function field_status(arg1)
    ccall((:field_status, libncurses), Bool, (Ptr{FIELD},), arg1)
end

function field_arg(arg1)
    ccall((:field_arg, libncurses), Ptr{Cvoid}, (Ptr{FIELD},), arg1)
end

function field_userptr(arg1)
    ccall((:field_userptr, libncurses), Ptr{Cvoid}, (Ptr{FIELD},), arg1)
end

function field_type(arg1)
    ccall((:field_type, libncurses), Ptr{FIELDTYPE}, (Ptr{FIELD},), arg1)
end

function field_buffer(arg1, arg2)
    ccall((:field_buffer, libncurses), Ptr{Cchar}, (Ptr{FIELD}, Cint), arg1, arg2)
end

function field_opts(arg1)
    ccall((:field_opts, libncurses), Field_Options, (Ptr{FIELD},), arg1)
end

function new_form(arg1)
    ccall((:new_form, libncurses), Ptr{FORM}, (Ptr{Ptr{FIELD}},), arg1)
end

function form_fields(arg1)
    ccall((:form_fields, libncurses), Ptr{Ptr{FIELD}}, (Ptr{FORM},), arg1)
end

function current_field(arg1)
    ccall((:current_field, libncurses), Ptr{FIELD}, (Ptr{FORM},), arg1)
end

function form_win(arg1)
    ccall((:form_win, libncurses), Ptr{WINDOW}, (Ptr{FORM},), arg1)
end

function form_sub(arg1)
    ccall((:form_sub, libncurses), Ptr{WINDOW}, (Ptr{FORM},), arg1)
end

function form_init(arg1)
    ccall((:form_init, libncurses), Form_Hook, (Ptr{FORM},), arg1)
end

function form_term(arg1)
    ccall((:form_term, libncurses), Form_Hook, (Ptr{FORM},), arg1)
end

function field_init(arg1)
    ccall((:field_init, libncurses), Form_Hook, (Ptr{FORM},), arg1)
end

function field_term(arg1)
    ccall((:field_term, libncurses), Form_Hook, (Ptr{FORM},), arg1)
end

function free_form(arg1)
    ccall((:free_form, libncurses), Cint, (Ptr{FORM},), arg1)
end

function set_form_fields(arg1, arg2)
    ccall((:set_form_fields, libncurses), Cint, (Ptr{FORM}, Ptr{Ptr{FIELD}}), arg1, arg2)
end

function field_count(arg1)
    ccall((:field_count, libncurses), Cint, (Ptr{FORM},), arg1)
end

function set_form_win(arg1, arg2)
    ccall((:set_form_win, libncurses), Cint, (Ptr{FORM}, Ptr{WINDOW}), arg1, arg2)
end

function set_form_sub(arg1, arg2)
    ccall((:set_form_sub, libncurses), Cint, (Ptr{FORM}, Ptr{WINDOW}), arg1, arg2)
end

function set_current_field(arg1, arg2)
    ccall((:set_current_field, libncurses), Cint, (Ptr{FORM}, Ptr{FIELD}), arg1, arg2)
end

function unfocus_current_field(arg1)
    ccall((:unfocus_current_field, libncurses), Cint, (Ptr{FORM},), arg1)
end

function field_index(arg1)
    ccall((:field_index, libncurses), Cint, (Ptr{FIELD},), arg1)
end

function set_form_page(arg1, arg2)
    ccall((:set_form_page, libncurses), Cint, (Ptr{FORM}, Cint), arg1, arg2)
end

function form_page(arg1)
    ccall((:form_page, libncurses), Cint, (Ptr{FORM},), arg1)
end

function scale_form(arg1, arg2, arg3)
    ccall((:scale_form, libncurses), Cint, (Ptr{FORM}, Ptr{Cint}, Ptr{Cint}), arg1, arg2, arg3)
end

function set_form_init(arg1, arg2)
    ccall((:set_form_init, libncurses), Cint, (Ptr{FORM}, Form_Hook), arg1, arg2)
end

function set_form_term(arg1, arg2)
    ccall((:set_form_term, libncurses), Cint, (Ptr{FORM}, Form_Hook), arg1, arg2)
end

function set_field_init(arg1, arg2)
    ccall((:set_field_init, libncurses), Cint, (Ptr{FORM}, Form_Hook), arg1, arg2)
end

function set_field_term(arg1, arg2)
    ccall((:set_field_term, libncurses), Cint, (Ptr{FORM}, Form_Hook), arg1, arg2)
end

function post_form(arg1)
    ccall((:post_form, libncurses), Cint, (Ptr{FORM},), arg1)
end

function unpost_form(arg1)
    ccall((:unpost_form, libncurses), Cint, (Ptr{FORM},), arg1)
end

function pos_form_cursor(arg1)
    ccall((:pos_form_cursor, libncurses), Cint, (Ptr{FORM},), arg1)
end

function form_driver(arg1, arg2)
    ccall((:form_driver, libncurses), Cint, (Ptr{FORM}, Cint), arg1, arg2)
end

function set_form_userptr(arg1, arg2)
    ccall((:set_form_userptr, libncurses), Cint, (Ptr{FORM}, Ptr{Cvoid}), arg1, arg2)
end

function set_form_opts(arg1, arg2)
    ccall((:set_form_opts, libncurses), Cint, (Ptr{FORM}, Form_Options), arg1, arg2)
end

function form_opts_on(arg1, arg2)
    ccall((:form_opts_on, libncurses), Cint, (Ptr{FORM}, Form_Options), arg1, arg2)
end

function form_opts_off(arg1, arg2)
    ccall((:form_opts_off, libncurses), Cint, (Ptr{FORM}, Form_Options), arg1, arg2)
end

function form_request_by_name(arg1)
    ccall((:form_request_by_name, libncurses), Cint, (Ptr{Cchar},), arg1)
end

function form_request_name(arg1)
    ccall((:form_request_name, libncurses), Ptr{Cchar}, (Cint,), arg1)
end

function form_userptr(arg1)
    ccall((:form_userptr, libncurses), Ptr{Cvoid}, (Ptr{FORM},), arg1)
end

function form_opts(arg1)
    ccall((:form_opts, libncurses), Form_Options, (Ptr{FORM},), arg1)
end

function data_ahead(arg1)
    ccall((:data_ahead, libncurses), Bool, (Ptr{FORM},), arg1)
end

function data_behind(arg1)
    ccall((:data_behind, libncurses), Bool, (Ptr{FORM},), arg1)
end

function new_form_sp(arg1, arg2)
    ccall((:new_form_sp, libncurses), Ptr{FORM}, (Ptr{SCREEN}, Ptr{Ptr{FIELD}}), arg1, arg2)
end

const Menu_Options = Cint

const Item_Options = Cint

struct TEXT
    str::Ptr{Cchar}
    length::Cushort
end

# typedef void ( * Menu_Hook ) ( struct tagMENU * )
const Menu_Hook = Ptr{Cvoid}

struct tagMENU
    height::Cshort
    width::Cshort
    rows::Cshort
    cols::Cshort
    frows::Cshort
    fcols::Cshort
    arows::Cshort
    namelen::Cshort
    desclen::Cshort
    marklen::Cshort
    itemlen::Cshort
    spc_desc::Cshort
    spc_cols::Cshort
    spc_rows::Cshort
    pattern::Ptr{Cchar}
    pindex::Cshort
    win::Ptr{WINDOW}
    sub::Ptr{WINDOW}
    userwin::Ptr{WINDOW}
    usersub::Ptr{WINDOW}
    items::Ptr{Ptr{Cvoid}} # items::Ptr{Ptr{ITEM}}
    nitems::Cshort
    curitem::Ptr{Cvoid} # curitem::Ptr{ITEM}
    toprow::Cshort
    fore::chtype
    back::chtype
    grey::chtype
    pad::Cuchar
    menuinit::Menu_Hook
    menuterm::Menu_Hook
    iteminit::Menu_Hook
    itemterm::Menu_Hook
    userptr::Ptr{Cvoid}
    mark::Ptr{Cchar}
    opt::Menu_Options
    status::Cushort
end

function Base.getproperty(x::tagMENU, f::Symbol)
    f === :items && return Ptr{Ptr{ITEM}}(getfield(x, f))
    f === :curitem && return Ptr{ITEM}(getfield(x, f))
    return getfield(x, f)
end

struct tagITEM
    name::TEXT
    description::TEXT
    imenu::Ptr{tagMENU}
    userptr::Ptr{Cvoid}
    opt::Item_Options
    index::Cshort
    y::Cshort
    x::Cshort
    value::Bool
    left::Ptr{tagITEM}
    right::Ptr{tagITEM}
    up::Ptr{tagITEM}
    down::Ptr{tagITEM}
end

const ITEM = tagITEM

const MENU = tagMENU

function menu_items(arg1)
    ccall((:menu_items, libncurses), Ptr{Ptr{ITEM}}, (Ptr{MENU},), arg1)
end

function current_item(arg1)
    ccall((:current_item, libncurses), Ptr{ITEM}, (Ptr{MENU},), arg1)
end

function new_item(arg1, arg2)
    ccall((:new_item, libncurses), Ptr{ITEM}, (Ptr{Cchar}, Ptr{Cchar}), arg1, arg2)
end

function new_menu(arg1)
    ccall((:new_menu, libncurses), Ptr{MENU}, (Ptr{Ptr{ITEM}},), arg1)
end

function item_opts(arg1)
    ccall((:item_opts, libncurses), Item_Options, (Ptr{ITEM},), arg1)
end

function menu_opts(arg1)
    ccall((:menu_opts, libncurses), Menu_Options, (Ptr{MENU},), arg1)
end

function item_init(arg1)
    ccall((:item_init, libncurses), Menu_Hook, (Ptr{MENU},), arg1)
end

function item_term(arg1)
    ccall((:item_term, libncurses), Menu_Hook, (Ptr{MENU},), arg1)
end

function menu_init(arg1)
    ccall((:menu_init, libncurses), Menu_Hook, (Ptr{MENU},), arg1)
end

function menu_term(arg1)
    ccall((:menu_term, libncurses), Menu_Hook, (Ptr{MENU},), arg1)
end

function menu_sub(arg1)
    ccall((:menu_sub, libncurses), Ptr{WINDOW}, (Ptr{MENU},), arg1)
end

function menu_win(arg1)
    ccall((:menu_win, libncurses), Ptr{WINDOW}, (Ptr{MENU},), arg1)
end

function item_description(arg1)
    ccall((:item_description, libncurses), Ptr{Cchar}, (Ptr{ITEM},), arg1)
end

function item_name(arg1)
    ccall((:item_name, libncurses), Ptr{Cchar}, (Ptr{ITEM},), arg1)
end

function menu_mark(arg1)
    ccall((:menu_mark, libncurses), Ptr{Cchar}, (Ptr{MENU},), arg1)
end

function menu_request_name(arg1)
    ccall((:menu_request_name, libncurses), Ptr{Cchar}, (Cint,), arg1)
end

function menu_pattern(arg1)
    ccall((:menu_pattern, libncurses), Ptr{Cchar}, (Ptr{MENU},), arg1)
end

function menu_userptr(arg1)
    ccall((:menu_userptr, libncurses), Ptr{Cvoid}, (Ptr{MENU},), arg1)
end

function item_userptr(arg1)
    ccall((:item_userptr, libncurses), Ptr{Cvoid}, (Ptr{ITEM},), arg1)
end

function menu_back(arg1)
    ccall((:menu_back, libncurses), chtype, (Ptr{MENU},), arg1)
end

function menu_fore(arg1)
    ccall((:menu_fore, libncurses), chtype, (Ptr{MENU},), arg1)
end

function menu_grey(arg1)
    ccall((:menu_grey, libncurses), chtype, (Ptr{MENU},), arg1)
end

function free_item(arg1)
    ccall((:free_item, libncurses), Cint, (Ptr{ITEM},), arg1)
end

function free_menu(arg1)
    ccall((:free_menu, libncurses), Cint, (Ptr{MENU},), arg1)
end

function item_count(arg1)
    ccall((:item_count, libncurses), Cint, (Ptr{MENU},), arg1)
end

function item_index(arg1)
    ccall((:item_index, libncurses), Cint, (Ptr{ITEM},), arg1)
end

function item_opts_off(arg1, arg2)
    ccall((:item_opts_off, libncurses), Cint, (Ptr{ITEM}, Item_Options), arg1, arg2)
end

function item_opts_on(arg1, arg2)
    ccall((:item_opts_on, libncurses), Cint, (Ptr{ITEM}, Item_Options), arg1, arg2)
end

function menu_driver(arg1, arg2)
    ccall((:menu_driver, libncurses), Cint, (Ptr{MENU}, Cint), arg1, arg2)
end

function menu_opts_off(arg1, arg2)
    ccall((:menu_opts_off, libncurses), Cint, (Ptr{MENU}, Menu_Options), arg1, arg2)
end

function menu_opts_on(arg1, arg2)
    ccall((:menu_opts_on, libncurses), Cint, (Ptr{MENU}, Menu_Options), arg1, arg2)
end

function menu_pad(arg1)
    ccall((:menu_pad, libncurses), Cint, (Ptr{MENU},), arg1)
end

function pos_menu_cursor(arg1)
    ccall((:pos_menu_cursor, libncurses), Cint, (Ptr{MENU},), arg1)
end

function post_menu(arg1)
    ccall((:post_menu, libncurses), Cint, (Ptr{MENU},), arg1)
end

function scale_menu(arg1, arg2, arg3)
    ccall((:scale_menu, libncurses), Cint, (Ptr{MENU}, Ptr{Cint}, Ptr{Cint}), arg1, arg2, arg3)
end

function set_current_item(menu, item)
    ccall((:set_current_item, libncurses), Cint, (Ptr{MENU}, Ptr{ITEM}), menu, item)
end

function set_item_init(arg1, arg2)
    ccall((:set_item_init, libncurses), Cint, (Ptr{MENU}, Menu_Hook), arg1, arg2)
end

function set_item_opts(arg1, arg2)
    ccall((:set_item_opts, libncurses), Cint, (Ptr{ITEM}, Item_Options), arg1, arg2)
end

function set_item_term(arg1, arg2)
    ccall((:set_item_term, libncurses), Cint, (Ptr{MENU}, Menu_Hook), arg1, arg2)
end

function set_item_userptr(arg1, arg2)
    ccall((:set_item_userptr, libncurses), Cint, (Ptr{ITEM}, Ptr{Cvoid}), arg1, arg2)
end

function set_item_value(arg1, arg2)
    ccall((:set_item_value, libncurses), Cint, (Ptr{ITEM}, Bool), arg1, arg2)
end

function set_menu_back(arg1, arg2)
    ccall((:set_menu_back, libncurses), Cint, (Ptr{MENU}, chtype), arg1, arg2)
end

function set_menu_fore(arg1, arg2)
    ccall((:set_menu_fore, libncurses), Cint, (Ptr{MENU}, chtype), arg1, arg2)
end

function set_menu_format(arg1, arg2, arg3)
    ccall((:set_menu_format, libncurses), Cint, (Ptr{MENU}, Cint, Cint), arg1, arg2, arg3)
end

function set_menu_grey(arg1, arg2)
    ccall((:set_menu_grey, libncurses), Cint, (Ptr{MENU}, chtype), arg1, arg2)
end

function set_menu_init(arg1, arg2)
    ccall((:set_menu_init, libncurses), Cint, (Ptr{MENU}, Menu_Hook), arg1, arg2)
end

function set_menu_items(arg1, arg2)
    ccall((:set_menu_items, libncurses), Cint, (Ptr{MENU}, Ptr{Ptr{ITEM}}), arg1, arg2)
end

function set_menu_mark(arg1, arg2)
    ccall((:set_menu_mark, libncurses), Cint, (Ptr{MENU}, Ptr{Cchar}), arg1, arg2)
end

function set_menu_opts(arg1, arg2)
    ccall((:set_menu_opts, libncurses), Cint, (Ptr{MENU}, Menu_Options), arg1, arg2)
end

function set_menu_pad(arg1, arg2)
    ccall((:set_menu_pad, libncurses), Cint, (Ptr{MENU}, Cint), arg1, arg2)
end

function set_menu_pattern(arg1, arg2)
    ccall((:set_menu_pattern, libncurses), Cint, (Ptr{MENU}, Ptr{Cchar}), arg1, arg2)
end

function set_menu_sub(arg1, arg2)
    ccall((:set_menu_sub, libncurses), Cint, (Ptr{MENU}, Ptr{WINDOW}), arg1, arg2)
end

function set_menu_term(arg1, arg2)
    ccall((:set_menu_term, libncurses), Cint, (Ptr{MENU}, Menu_Hook), arg1, arg2)
end

function set_menu_userptr(arg1, arg2)
    ccall((:set_menu_userptr, libncurses), Cint, (Ptr{MENU}, Ptr{Cvoid}), arg1, arg2)
end

function set_menu_win(arg1, arg2)
    ccall((:set_menu_win, libncurses), Cint, (Ptr{MENU}, Ptr{WINDOW}), arg1, arg2)
end

function set_top_row(arg1, arg2)
    ccall((:set_top_row, libncurses), Cint, (Ptr{MENU}, Cint), arg1, arg2)
end

function top_row(arg1)
    ccall((:top_row, libncurses), Cint, (Ptr{MENU},), arg1)
end

function unpost_menu(arg1)
    ccall((:unpost_menu, libncurses), Cint, (Ptr{MENU},), arg1)
end

function menu_request_by_name(arg1)
    ccall((:menu_request_by_name, libncurses), Cint, (Ptr{Cchar},), arg1)
end

function set_menu_spacing(arg1, arg2, arg3, arg4)
    ccall((:set_menu_spacing, libncurses), Cint, (Ptr{MENU}, Cint, Cint, Cint), arg1, arg2, arg3, arg4)
end

function menu_spacing(arg1, arg2, arg3, arg4)
    ccall((:menu_spacing, libncurses), Cint, (Ptr{MENU}, Ptr{Cint}, Ptr{Cint}, Ptr{Cint}), arg1, arg2, arg3, arg4)
end

function item_value(arg1)
    ccall((:item_value, libncurses), Bool, (Ptr{ITEM},), arg1)
end

function item_visible(arg1)
    ccall((:item_visible, libncurses), Bool, (Ptr{ITEM},), arg1)
end

function menu_format(arg1, arg2, arg3)
    ccall((:menu_format, libncurses), Cvoid, (Ptr{MENU}, Ptr{Cint}, Ptr{Cint}), arg1, arg2, arg3)
end

function new_menu_sp(arg1, arg2)
    ccall((:new_menu_sp, libncurses), Ptr{MENU}, (Ptr{SCREEN}, Ptr{Ptr{ITEM}}), arg1, arg2)
end

struct panel
    win::Ptr{WINDOW}
    below::Ptr{panel}
    above::Ptr{panel}
    user::Ptr{Cvoid}
end

const PANEL = panel

function panel_window(arg1)
    ccall((:panel_window, libncurses), Ptr{WINDOW}, (Ptr{PANEL},), arg1)
end

function update_panels()
    ccall((:update_panels, libncurses), Cvoid, ())
end

function hide_panel(arg1)
    ccall((:hide_panel, libncurses), Cint, (Ptr{PANEL},), arg1)
end

function show_panel(arg1)
    ccall((:show_panel, libncurses), Cint, (Ptr{PANEL},), arg1)
end

function del_panel(arg1)
    ccall((:del_panel, libncurses), Cint, (Ptr{PANEL},), arg1)
end

function top_panel(arg1)
    ccall((:top_panel, libncurses), Cint, (Ptr{PANEL},), arg1)
end

function bottom_panel(arg1)
    ccall((:bottom_panel, libncurses), Cint, (Ptr{PANEL},), arg1)
end

function new_panel(arg1)
    ccall((:new_panel, libncurses), Ptr{PANEL}, (Ptr{WINDOW},), arg1)
end

function panel_above(arg1)
    ccall((:panel_above, libncurses), Ptr{PANEL}, (Ptr{PANEL},), arg1)
end

function panel_below(arg1)
    ccall((:panel_below, libncurses), Ptr{PANEL}, (Ptr{PANEL},), arg1)
end

function set_panel_userptr(arg1, arg2)
    ccall((:set_panel_userptr, libncurses), Cint, (Ptr{PANEL}, Ptr{Cvoid}), arg1, arg2)
end

function panel_userptr(arg1)
    ccall((:panel_userptr, libncurses), Ptr{Cvoid}, (Ptr{PANEL},), arg1)
end

function move_panel(arg1, arg2, arg3)
    ccall((:move_panel, libncurses), Cint, (Ptr{PANEL}, Cint, Cint), arg1, arg2, arg3)
end

function replace_panel(arg1, arg2)
    ccall((:replace_panel, libncurses), Cint, (Ptr{PANEL}, Ptr{WINDOW}), arg1, arg2)
end

function panel_hidden(arg1)
    ccall((:panel_hidden, libncurses), Cint, (Ptr{PANEL},), arg1)
end

function ground_panel(arg1)
    ccall((:ground_panel, libncurses), Ptr{PANEL}, (Ptr{SCREEN},), arg1)
end

function ceiling_panel(arg1)
    ccall((:ceiling_panel, libncurses), Ptr{PANEL}, (Ptr{SCREEN},), arg1)
end

function update_panels_sp(arg1)
    ccall((:update_panels_sp, libncurses), Cvoid, (Ptr{SCREEN},), arg1)
end

struct termtype
    term_names::Ptr{Cchar}
    str_table::Ptr{Cchar}
    Booleans::Ptr{Cchar}
    Numbers::Ptr{Cshort}
    Strings::Ptr{Ptr{Cchar}}
    ext_str_table::Ptr{Cchar}
    ext_Names::Ptr{Ptr{Cchar}}
    num_Booleans::Cushort
    num_Numbers::Cushort
    num_Strings::Cushort
    ext_Booleans::Cushort
    ext_Numbers::Cushort
    ext_Strings::Cushort
end

const TERMTYPE = termtype

struct term
    type::TERMTYPE
end

const TERMINAL = term

function _nc_fallback(arg1)
    ccall((:_nc_fallback, libncurses), Ptr{TERMTYPE}, (Ptr{Cchar},), arg1)
end

function _nc_read_entry(arg1, arg2, arg3)
    ccall((:_nc_read_entry, libncurses), Cint, (Ptr{Cchar}, Ptr{Cchar}, Ptr{TERMTYPE}), arg1, arg2, arg3)
end

function set_curterm(arg1)
    ccall((:set_curterm, libncurses), Ptr{TERMINAL}, (Ptr{TERMINAL},), arg1)
end

function del_curterm(arg1)
    ccall((:del_curterm, libncurses), Cint, (Ptr{TERMINAL},), arg1)
end

function restartterm(arg1, arg2, arg3)
    ccall((:restartterm, libncurses), Cint, (Ptr{Cchar}, Cint, Ptr{Cint}), arg1, arg2, arg3)
end

function tgetstr(arg1, arg2)
    ccall((:tgetstr, libncurses), Ptr{Cchar}, (Ptr{Cchar}, Ptr{Ptr{Cchar}}), arg1, arg2)
end

function tgoto(arg1, arg2, arg3)
    ccall((:tgoto, libncurses), Ptr{Cchar}, (Ptr{Cchar}, Cint, Cint), arg1, arg2, arg3)
end

function tgetent(arg1, arg2)
    ccall((:tgetent, libncurses), Cint, (Ptr{Cchar}, Ptr{Cchar}), arg1, arg2)
end

function tgetflag(arg1)
    ccall((:tgetflag, libncurses), Cint, (Ptr{Cchar},), arg1)
end

function tgetnum(arg1)
    ccall((:tgetnum, libncurses), Cint, (Ptr{Cchar},), arg1)
end

function tputs(arg1, arg2, arg3)
    ccall((:tputs, libncurses), Cint, (Ptr{Cchar}, Cint, Ptr{Cvoid}), arg1, arg2, arg3)
end

function tigetstr_sp(arg1, arg2)
    ccall((:tigetstr_sp, libncurses), Ptr{Cchar}, (Ptr{SCREEN}, Ptr{Cchar}), arg1, arg2)
end

function putp_sp(arg1, arg2)
    ccall((:putp_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{Cchar}), arg1, arg2)
end

function tigetflag_sp(arg1, arg2)
    ccall((:tigetflag_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{Cchar}), arg1, arg2)
end

function tigetnum_sp(arg1, arg2)
    ccall((:tigetnum_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{Cchar}), arg1, arg2)
end

function tgetstr_sp(arg1, arg2, arg3)
    ccall((:tgetstr_sp, libncurses), Ptr{Cchar}, (Ptr{SCREEN}, Ptr{Cchar}, Ptr{Ptr{Cchar}}), arg1, arg2, arg3)
end

function tgoto_sp(arg1, arg2, arg3, arg4)
    ccall((:tgoto_sp, libncurses), Ptr{Cchar}, (Ptr{SCREEN}, Ptr{Cchar}, Cint, Cint), arg1, arg2, arg3, arg4)
end

function tgetent_sp(arg1, arg2, arg3)
    ccall((:tgetent_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{Cchar}, Ptr{Cchar}), arg1, arg2, arg3)
end

function tgetflag_sp(arg1, arg2)
    ccall((:tgetflag_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{Cchar}), arg1, arg2)
end

function tgetnum_sp(arg1, arg2)
    ccall((:tgetnum_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{Cchar}), arg1, arg2)
end

function tputs_sp(arg1, arg2, arg3, arg4)
    ccall((:tputs_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{Cchar}, Cint, NCURSES_OUTC_sp), arg1, arg2, arg3, arg4)
end

function set_curterm_sp(arg1, arg2)
    ccall((:set_curterm_sp, libncurses), Ptr{TERMINAL}, (Ptr{SCREEN}, Ptr{TERMINAL}), arg1, arg2)
end

function del_curterm_sp(arg1, arg2)
    ccall((:del_curterm_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{TERMINAL}), arg1, arg2)
end

function restartterm_sp(arg1, arg2, arg3, arg4)
    ccall((:restartterm_sp, libncurses), Cint, (Ptr{SCREEN}, Ptr{Cchar}, Cint, Ptr{Cint}), arg1, arg2, arg3, arg4)
end

function exit_terminfo(arg1)
    ccall((:exit_terminfo, libncurses), Cvoid, (Cint,), arg1)
end

function _nc_copy_termtype(arg1, arg2)
    ccall((:_nc_copy_termtype, libncurses), Cvoid, (Ptr{TERMTYPE}, Ptr{TERMTYPE}), arg1, arg2)
end

function _nc_init_acs()
    ccall((:_nc_init_acs, libncurses), Cvoid, ())
end

function _nc_free_termtype(arg1)
    ccall((:_nc_free_termtype, libncurses), Cvoid, (Ptr{TERMTYPE},), arg1)
end

struct token
    tk_name::Ptr{Cchar}
    tk_valnumber::Cint
    tk_valstring::Ptr{Cchar}
end

struct tinfo_fkeys
    offset::Cuint
    code::chtype
end

const HashValue = Cshort

struct name_table_entry
    nte_name::Ptr{Cchar}
    nte_type::Cint
    nte_index::HashValue
    nte_link::HashValue
end

struct HashData
    table_size::Cuint
    table_data::Ptr{HashValue}
    hash_of::Ptr{Cvoid}
    compare_names::Ptr{Cvoid}
end

struct alias
    from::Ptr{Cchar}
    to::Ptr{Cchar}
    source::Ptr{Cchar}
end

struct user_table_entry
    ute_name::Ptr{Cchar}
    ute_type::Cint
    ute_argc::Cuint
    ute_args::Cuint
    ute_index::HashValue
    ute_link::HashValue
end

const CURSES = 1

const NCURSES_VERSION_MAJOR = 6

const NCURSES_VERSION_MINOR = 4

const NCURSES_VERSION_PATCH = 20221231

const NCURSES_VERSION = "6.4"

const NCURSES_MOUSE_VERSION = 2

const NCURSES_ATTR_T = Cint

# Skipping MacroDefinition: NCURSES_CONST const

# Skipping MacroDefinition: NCURSES_INLINE inline

const NCURSES_COLOR_T = Cshort

const NCURSES_PAIRS_T = Cshort

const NCURSES_OPAQUE = 0

const NCURSES_OPAQUE_FORM = 0

const NCURSES_OPAQUE_MENU = 0

const NCURSES_OPAQUE_PANEL = 0

const NCURSES_WATTR_MACROS = 0

const NCURSES_REENTRANT = 0

const NCURSES_INTEROP_FUNCS = 1

const NCURSES_SIZE_T = Cshort

const NCURSES_TPARM_VARARGS = 1

const NCURSES_WCWIDTH_GRAPHICS = 1

const NCURSES_WIDECHAR = 0

const TRUE = 1

const FALSE = 0

const NCURSES_ATTR_SHIFT = 8

const A_ATTRIBUTES = NCURSES_BITS(~(Cuint(1) - Cuint(1)), 0)

const WA_ATTRIBUTES = A_ATTRIBUTES

const A_NORMAL = Cuint(1) - Cuint(1)

const WA_NORMAL = A_NORMAL

const A_STANDOUT = NCURSES_BITS(Cuint(1), 8)

const WA_STANDOUT = A_STANDOUT

const A_UNDERLINE = NCURSES_BITS(Cuint(1), 9)

const WA_UNDERLINE = A_UNDERLINE

const A_REVERSE = NCURSES_BITS(Cuint(1), 10)

const WA_REVERSE = A_REVERSE

const A_BLINK = NCURSES_BITS(Cuint(1), 11)

const WA_BLINK = A_BLINK

const A_DIM = NCURSES_BITS(Cuint(1), 12)

const WA_DIM = A_DIM

const A_BOLD = NCURSES_BITS(Cuint(1), 13)

const WA_BOLD = A_BOLD

const A_ALTCHARSET = NCURSES_BITS(Cuint(1), 14)

const WA_ALTCHARSET = A_ALTCHARSET

const A_INVIS = NCURSES_BITS(Cuint(1), 15)

const WA_INVIS = A_INVIS

const A_PROTECT = NCURSES_BITS(Cuint(1), 16)

const WA_PROTECT = A_PROTECT

const A_HORIZONTAL = NCURSES_BITS(Cuint(1), 17)

const WA_HORIZONTAL = A_HORIZONTAL

const A_LEFT = NCURSES_BITS(Cuint(1), 18)

const WA_LEFT = A_LEFT

const A_LOW = NCURSES_BITS(Cuint(1), 19)

const WA_LOW = A_LOW

const A_RIGHT = NCURSES_BITS(Cuint(1), 20)

const WA_RIGHT = A_RIGHT

const A_TOP = NCURSES_BITS(Cuint(1), 21)

const WA_TOP = A_TOP

const A_VERTICAL = NCURSES_BITS(Cuint(1), 22)

const WA_VERTICAL = A_VERTICAL

const A_ITALIC = NCURSES_BITS(Cuint(1), 23)

const WA_ITALIC = A_ITALIC

const COLOR_BLACK = 0

const COLOR_RED = 1

const COLOR_GREEN = 2

const COLOR_YELLOW = 3

const COLOR_BLUE = 4

const COLOR_MAGENTA = 5

const COLOR_CYAN = 6

const COLOR_WHITE = 7

const ACS_ULCORNER = NCURSES_ACS(Cchar('l'))

const ACS_LLCORNER = NCURSES_ACS(Cchar('m'))

const ACS_URCORNER = NCURSES_ACS(Cchar('k'))

const ACS_LRCORNER = NCURSES_ACS(Cchar('j'))

const ACS_LTEE = NCURSES_ACS(Cchar('t'))

const ACS_RTEE = NCURSES_ACS(Cchar('u'))

const ACS_BTEE = NCURSES_ACS(Cchar('v'))

const ACS_TTEE = NCURSES_ACS(Cchar('w'))

const ACS_HLINE = NCURSES_ACS(Cchar('q'))

const ACS_VLINE = NCURSES_ACS(Cchar('x'))

const ACS_PLUS = NCURSES_ACS(Cchar('n'))

const ACS_S1 = NCURSES_ACS(Cchar('o'))

const ACS_S9 = NCURSES_ACS(Cchar('s'))

const ACS_DIAMOND = NCURSES_ACS(Cchar('`'))

const ACS_CKBOARD = NCURSES_ACS(Cchar('a'))

const ACS_DEGREE = NCURSES_ACS(Cchar('f'))

const ACS_PLMINUS = NCURSES_ACS(Cchar('g'))

const ACS_BULLET = NCURSES_ACS(Cchar('~'))

const ACS_LARROW = NCURSES_ACS(Cchar(','))

const ACS_RARROW = NCURSES_ACS(Cchar('+'))

const ACS_DARROW = NCURSES_ACS(Cchar('.'))

const ACS_UARROW = NCURSES_ACS(Cchar('-'))

const ACS_BOARD = NCURSES_ACS(Cchar('h'))

const ACS_LANTERN = NCURSES_ACS(Cchar('i'))

const ACS_BLOCK = NCURSES_ACS(Cchar('0'))

const ACS_S3 = NCURSES_ACS(Cchar('p'))

const ACS_S7 = NCURSES_ACS(Cchar('r'))

const ACS_LEQUAL = NCURSES_ACS(Cchar('y'))

const ACS_GEQUAL = NCURSES_ACS(Cchar('z'))

const ACS_PI = NCURSES_ACS(Cchar('{'))

const ACS_NEQUAL = NCURSES_ACS(Cchar('|'))

const ACS_STERLING = NCURSES_ACS(Cchar('}'))

const ACS_BSSB = ACS_ULCORNER

const ACS_SSBB = ACS_LLCORNER

const ACS_BBSS = ACS_URCORNER

const ACS_SBBS = ACS_LRCORNER

const ACS_SBSS = ACS_RTEE

const ACS_SSSB = ACS_LTEE

const ACS_SSBS = ACS_BTEE

const ACS_BSSS = ACS_TTEE

const ACS_BSBS = ACS_HLINE

const ACS_SBSB = ACS_VLINE

const ACS_SSSS = ACS_PLUS

const ERR = -1

const OK = 0

const _SUBWIN = 0x01

const _ENDLINE = 0x02

const _FULLWIN = 0x04

const _SCROLLWIN = 0x08

const _ISPAD = 0x10

const _HASMOVED = 0x20

const _WRAPPED = 0x40

const _NOCHANGE = -1

const _NEWINDEX = -1

const NCURSES_EXT_FUNCS = 20221231

const NCURSES_SP_FUNCS = 20221231

const A_CHARTEXT = NCURSES_BITS(Cuint(1), 0) - Cuint(1)

const A_COLOR = NCURSES_BITS(Cuint(1) << 8 - Cuint(1), 0)

const KEY_CODE_YES = 0x0100

const KEY_MIN = 0x0101

const KEY_BREAK = 0x0101

const KEY_SRESET = 0x0158

const KEY_RESET = 0x0159

const KEY_DOWN = 0x0102

const KEY_UP = 0x0103

const KEY_LEFT = 0x0104

const KEY_RIGHT = 0x0105

const KEY_HOME = 0x0106

const KEY_BACKSPACE = 0x0107

const KEY_F0 = 0x0108

const KEY_DL = 0x0148

const KEY_IL = 0x0149

const KEY_DC = 0x014a

const KEY_IC = 0x014b

const KEY_EIC = 0x014c

const KEY_CLEAR = 0x014d

const KEY_EOS = 0x014e

const KEY_EOL = 0x014f

const KEY_SF = 0x0150

const KEY_SR = 0x0151

const KEY_NPAGE = 0x0152

const KEY_PPAGE = 0x0153

const KEY_STAB = 0x0154

const KEY_CTAB = 0x0155

const KEY_CATAB = 0x0156

const KEY_ENTER = 0x0157

const KEY_PRINT = 0x015a

const KEY_LL = 0x015b

const KEY_A1 = 0x015c

const KEY_A3 = 0x015d

const KEY_B2 = 0x015e

const KEY_C1 = 0x015f

const KEY_C3 = 0x0160

const KEY_BTAB = 0x0161

const KEY_BEG = 0x0162

const KEY_CANCEL = 0x0163

const KEY_CLOSE = 0x0164

const KEY_COMMAND = 0x0165

const KEY_COPY = 0x0166

const KEY_CREATE = 0x0167

const KEY_END = 0x0168

const KEY_EXIT = 0x0169

const KEY_FIND = 0x016a

const KEY_HELP = 0x016b

const KEY_MARK = 0x016c

const KEY_MESSAGE = 0x016d

const KEY_MOVE = 0x016e

const KEY_NEXT = 0x016f

const KEY_OPEN = 0x0170

const KEY_OPTIONS = 0x0171

const KEY_PREVIOUS = 0x0172

const KEY_REDO = 0x0173

const KEY_REFERENCE = 0x0174

const KEY_REFRESH = 0x0175

const KEY_REPLACE = 0x0176

const KEY_RESTART = 0x0177

const KEY_RESUME = 0x0178

const KEY_SAVE = 0x0179

const KEY_SBEG = 0x017a

const KEY_SCANCEL = 0x017b

const KEY_SCOMMAND = 0x017c

const KEY_SCOPY = 0x017d

const KEY_SCREATE = 0x017e

const KEY_SDC = 0x017f

const KEY_SDL = 0x0180

const KEY_SELECT = 0x0181

const KEY_SEND = 0x0182

const KEY_SEOL = 0x0183

const KEY_SEXIT = 0x0184

const KEY_SFIND = 0x0185

const KEY_SHELP = 0x0186

const KEY_SHOME = 0x0187

const KEY_SIC = 0x0188

const KEY_SLEFT = 0x0189

const KEY_SMESSAGE = 0x018a

const KEY_SMOVE = 0x018b

const KEY_SNEXT = 0x018c

const KEY_SOPTIONS = 0x018d

const KEY_SPREVIOUS = 0x018e

const KEY_SPRINT = 0x018f

const KEY_SREDO = 0x0190

const KEY_SREPLACE = 0x0191

const KEY_SRIGHT = 0x0192

const KEY_SRSUME = 0x0193

const KEY_SSAVE = 0x0194

const KEY_SSUSPEND = 0x0195

const KEY_SUNDO = 0x0196

const KEY_SUSPEND = 0x0197

const KEY_UNDO = 0x0198

const KEY_MOUSE = 0x0199

const KEY_RESIZE = 0x019a

const KEY_MAX = 0x01ff

const _XOPEN_CURSES = 1

const NCURSES_BUTTON_RELEASED = Clong(1)

const NCURSES_BUTTON_PRESSED = Clong(2)

const NCURSES_BUTTON_CLICKED = Clong(4)

const NCURSES_DOUBLE_CLICKED = Clong(10)

const NCURSES_TRIPLE_CLICKED = Clong(20)

const NCURSES_RESERVED_EVENT = Clong(40)

const BUTTON1_RELEASED = NCURSES_MOUSE_MASK(1, NCURSES_BUTTON_RELEASED)

const BUTTON1_PRESSED = NCURSES_MOUSE_MASK(1, NCURSES_BUTTON_PRESSED)

const BUTTON1_CLICKED = NCURSES_MOUSE_MASK(1, NCURSES_BUTTON_CLICKED)

const BUTTON1_DOUBLE_CLICKED = NCURSES_MOUSE_MASK(1, NCURSES_DOUBLE_CLICKED)

const BUTTON1_TRIPLE_CLICKED = NCURSES_MOUSE_MASK(1, NCURSES_TRIPLE_CLICKED)

const BUTTON2_RELEASED = NCURSES_MOUSE_MASK(2, NCURSES_BUTTON_RELEASED)

const BUTTON2_PRESSED = NCURSES_MOUSE_MASK(2, NCURSES_BUTTON_PRESSED)

const BUTTON2_CLICKED = NCURSES_MOUSE_MASK(2, NCURSES_BUTTON_CLICKED)

const BUTTON2_DOUBLE_CLICKED = NCURSES_MOUSE_MASK(2, NCURSES_DOUBLE_CLICKED)

const BUTTON2_TRIPLE_CLICKED = NCURSES_MOUSE_MASK(2, NCURSES_TRIPLE_CLICKED)

const BUTTON3_RELEASED = NCURSES_MOUSE_MASK(3, NCURSES_BUTTON_RELEASED)

const BUTTON3_PRESSED = NCURSES_MOUSE_MASK(3, NCURSES_BUTTON_PRESSED)

const BUTTON3_CLICKED = NCURSES_MOUSE_MASK(3, NCURSES_BUTTON_CLICKED)

const BUTTON3_DOUBLE_CLICKED = NCURSES_MOUSE_MASK(3, NCURSES_DOUBLE_CLICKED)

const BUTTON3_TRIPLE_CLICKED = NCURSES_MOUSE_MASK(3, NCURSES_TRIPLE_CLICKED)

const BUTTON4_RELEASED = NCURSES_MOUSE_MASK(4, NCURSES_BUTTON_RELEASED)

const BUTTON4_PRESSED = NCURSES_MOUSE_MASK(4, NCURSES_BUTTON_PRESSED)

const BUTTON4_CLICKED = NCURSES_MOUSE_MASK(4, NCURSES_BUTTON_CLICKED)

const BUTTON4_DOUBLE_CLICKED = NCURSES_MOUSE_MASK(4, NCURSES_DOUBLE_CLICKED)

const BUTTON4_TRIPLE_CLICKED = NCURSES_MOUSE_MASK(4, NCURSES_TRIPLE_CLICKED)

const BUTTON5_RELEASED = NCURSES_MOUSE_MASK(5, NCURSES_BUTTON_RELEASED)

const BUTTON5_PRESSED = NCURSES_MOUSE_MASK(5, NCURSES_BUTTON_PRESSED)

const BUTTON5_CLICKED = NCURSES_MOUSE_MASK(5, NCURSES_BUTTON_CLICKED)

const BUTTON5_DOUBLE_CLICKED = NCURSES_MOUSE_MASK(5, NCURSES_DOUBLE_CLICKED)

const BUTTON5_TRIPLE_CLICKED = NCURSES_MOUSE_MASK(5, NCURSES_TRIPLE_CLICKED)

const BUTTON_CTRL = NCURSES_MOUSE_MASK(6, Clong(1))

const BUTTON_SHIFT = NCURSES_MOUSE_MASK(6, Clong(2))

const BUTTON_ALT = NCURSES_MOUSE_MASK(6, Clong(4))

const REPORT_MOUSE_POSITION = NCURSES_MOUSE_MASK(6, Clong(10))

const ALL_MOUSE_EVENTS = REPORT_MOUSE_POSITION - 1

const _tracech_t = _tracechtype

const _tracech_t2 = _tracechtype2

const TRACE_DISABLE = 0x0000

const TRACE_TIMES = 0x0001

const TRACE_TPUTS = 0x0002

const TRACE_UPDATE = 0x0004

const TRACE_MOVE = 0x0008

const TRACE_CHARPUT = 0x0010

const TRACE_ORDINARY = 0x001f

const TRACE_CALLS = 0x0020

const TRACE_VIRTPUT = 0x0040

const TRACE_IEVENT = 0x0080

const TRACE_BITS = 0x0100

const TRACE_ICALLS = 0x0200

const TRACE_CCALLS = 0x0400

const TRACE_DATABASE = 0x0800

const TRACE_ATTRS = 0x1000

const TRACE_SHIFT = 13

const TRACE_MAXIMUM = 1 << TRACE_SHIFT - 1

const E_OK = 0

const E_SYSTEM_ERROR = -1

const E_BAD_ARGUMENT = -2

const E_POSTED = -3

const E_CONNECTED = -4

const E_BAD_STATE = -5

const E_NO_ROOM = -6

const E_NOT_POSTED = -7

const E_UNKNOWN_COMMAND = -8

const E_NO_MATCH = -9

const E_NOT_SELECTABLE = -10

const E_NOT_CONNECTED = -11

const E_REQUEST_DENIED = -12

const E_INVALID_FIELD = -13

const E_CURRENT = -14

const NO_JUSTIFICATION = 0

const JUSTIFY_LEFT = 1

const JUSTIFY_CENTER = 2

const JUSTIFY_RIGHT = 3

const O_VISIBLE = Cuint(0x0001)

const O_ACTIVE = Cuint(0x0002)

const O_PUBLIC = Cuint(0x0004)

const O_EDIT = Cuint(0x0008)

const O_WRAP = Cuint(0x0010)

const O_BLANK = Cuint(0x0020)

const O_AUTOSKIP = Cuint(0x0040)

const O_NULLOK = Cuint(0x0080)

const O_PASSOK = Cuint(0x0100)

const O_STATIC = Cuint(0x0200)

const O_DYNAMIC_JUSTIFY = Cuint(0x0400)

const O_NO_LEFT_STRIP = Cuint(0x0800)

const O_EDGE_INSERT_STAY = Cuint(0x1000)

const O_INPUT_LIMIT = Cuint(0x2000)

const O_NL_OVERLOAD = Cuint(0x0001)

const O_BS_OVERLOAD = Cuint(0x0002)

const REQ_NEXT_PAGE = KEY_MAX + 1

const REQ_PREV_PAGE = KEY_MAX + 2

const REQ_FIRST_PAGE = KEY_MAX + 3

const REQ_LAST_PAGE = KEY_MAX + 4

const REQ_NEXT_FIELD = KEY_MAX + 5

const REQ_PREV_FIELD = KEY_MAX + 6

const REQ_FIRST_FIELD = KEY_MAX + 7

const REQ_LAST_FIELD = KEY_MAX + 8

const REQ_SNEXT_FIELD = KEY_MAX + 9

const REQ_SPREV_FIELD = KEY_MAX + 10

const REQ_SFIRST_FIELD = KEY_MAX + 11

const REQ_SLAST_FIELD = KEY_MAX + 12

const REQ_LEFT_FIELD = KEY_MAX + 13

const REQ_RIGHT_FIELD = KEY_MAX + 14

const REQ_UP_FIELD = KEY_MAX + 15

const REQ_DOWN_FIELD = KEY_MAX + 16

const REQ_NEXT_CHAR = KEY_MAX + 17

const REQ_PREV_CHAR = KEY_MAX + 18

const REQ_NEXT_LINE = KEY_MAX + 19

const REQ_PREV_LINE = KEY_MAX + 20

const REQ_NEXT_WORD = KEY_MAX + 21

const REQ_PREV_WORD = KEY_MAX + 22

const REQ_BEG_FIELD = KEY_MAX + 23

const REQ_END_FIELD = KEY_MAX + 24

const REQ_BEG_LINE = KEY_MAX + 25

const REQ_END_LINE = KEY_MAX + 26

const REQ_LEFT_CHAR = KEY_MAX + 27

const REQ_RIGHT_CHAR = KEY_MAX + 28

const REQ_UP_CHAR = KEY_MAX + 29

const REQ_DOWN_CHAR = KEY_MAX + 30

const REQ_NEW_LINE = KEY_MAX + 31

const REQ_INS_CHAR = KEY_MAX + 32

const REQ_INS_LINE = KEY_MAX + 33

const REQ_DEL_CHAR = KEY_MAX + 34

const REQ_DEL_PREV = KEY_MAX + 35

const REQ_DEL_LINE = KEY_MAX + 36

const REQ_DEL_WORD = KEY_MAX + 37

const REQ_CLR_EOL = KEY_MAX + 38

const REQ_CLR_EOF = KEY_MAX + 39

const REQ_CLR_FIELD = KEY_MAX + 40

const REQ_OVL_MODE = KEY_MAX + 41

const REQ_INS_MODE = KEY_MAX + 42

const REQ_SCR_FLINE = KEY_MAX + 43

const REQ_SCR_BLINE = KEY_MAX + 44

const REQ_SCR_FPAGE = KEY_MAX + 45

const REQ_SCR_BPAGE = KEY_MAX + 46

const REQ_SCR_FHPAGE = KEY_MAX + 47

const REQ_SCR_BHPAGE = KEY_MAX + 48

const REQ_SCR_FCHAR = KEY_MAX + 49

const REQ_SCR_BCHAR = KEY_MAX + 50

const REQ_SCR_HFLINE = KEY_MAX + 51

const REQ_SCR_HBLINE = KEY_MAX + 52

const REQ_SCR_HFHALF = KEY_MAX + 53

const REQ_SCR_HBHALF = KEY_MAX + 54

const REQ_VALIDATION = KEY_MAX + 55

const REQ_NEXT_CHOICE = KEY_MAX + 56

const REQ_PREV_CHOICE = KEY_MAX + 57

const MIN_FORM_COMMAND = KEY_MAX + 1

const MAX_FORM_COMMAND = KEY_MAX + 57

const MAX_COMMAND = KEY_MAX + 128

const O_ONEVALUE = 0x01

const O_SHOWDESC = 0x02

const O_ROWMAJOR = 0x04

const O_IGNORECASE = 0x08

const O_SHOWMATCH = 0x10

const O_NONCYCLIC = 0x20

const O_MOUSE_MENU = 0x40

const O_SELECTABLE = 0x01

const REQ_LEFT_ITEM = KEY_MAX + 1

const REQ_RIGHT_ITEM = KEY_MAX + 2

const REQ_UP_ITEM = KEY_MAX + 3

const REQ_DOWN_ITEM = KEY_MAX + 4

const REQ_SCR_ULINE = KEY_MAX + 5

const REQ_SCR_DLINE = KEY_MAX + 6

const REQ_SCR_DPAGE = KEY_MAX + 7

const REQ_SCR_UPAGE = KEY_MAX + 8

const REQ_FIRST_ITEM = KEY_MAX + 9

const REQ_LAST_ITEM = KEY_MAX + 10

const REQ_NEXT_ITEM = KEY_MAX + 11

const REQ_PREV_ITEM = KEY_MAX + 12

const REQ_TOGGLE_ITEM = KEY_MAX + 13

const REQ_CLEAR_PATTERN = KEY_MAX + 14

const REQ_BACK_PATTERN = KEY_MAX + 15

const REQ_NEXT_MATCH = KEY_MAX + 16

const REQ_PREV_MATCH = KEY_MAX + 17

const MIN_MENU_COMMAND = KEY_MAX + 1

const MAX_MENU_COMMAND = KEY_MAX + 17

const NC_TPARM_included = 1

const NCURSES_SBOOL = Cchar

const NCURSES_USE_DATABASE = 1

const NCURSES_USE_TERMCAP = 0

const NCURSES_XNAMES = 1

const TERMIOS = 1

# Skipping MacroDefinition: TTY struct termios

const NAMESIZE = 256

# Skipping MacroDefinition: CUR ( ( TERMTYPE * ) ( cur_term ) ) ->

# Skipping MacroDefinition: auto_left_margin CUR Booleans [ 0 ]

# Skipping MacroDefinition: auto_right_margin CUR Booleans [ 1 ]

# Skipping MacroDefinition: no_esc_ctlc CUR Booleans [ 2 ]

# Skipping MacroDefinition: ceol_standout_glitch CUR Booleans [ 3 ]

# Skipping MacroDefinition: eat_newline_glitch CUR Booleans [ 4 ]

# Skipping MacroDefinition: erase_overstrike CUR Booleans [ 5 ]

# Skipping MacroDefinition: generic_type CUR Booleans [ 6 ]

# Skipping MacroDefinition: hard_copy CUR Booleans [ 7 ]

# Skipping MacroDefinition: has_meta_key CUR Booleans [ 8 ]

# Skipping MacroDefinition: has_status_line CUR Booleans [ 9 ]

# Skipping MacroDefinition: insert_null_glitch CUR Booleans [ 10 ]

# Skipping MacroDefinition: memory_above CUR Booleans [ 11 ]

# Skipping MacroDefinition: memory_below CUR Booleans [ 12 ]

# Skipping MacroDefinition: move_insert_mode CUR Booleans [ 13 ]

# Skipping MacroDefinition: move_standout_mode CUR Booleans [ 14 ]

# Skipping MacroDefinition: over_strike CUR Booleans [ 15 ]

# Skipping MacroDefinition: status_line_esc_ok CUR Booleans [ 16 ]

# Skipping MacroDefinition: dest_tabs_magic_smso CUR Booleans [ 17 ]

# Skipping MacroDefinition: tilde_glitch CUR Booleans [ 18 ]

# Skipping MacroDefinition: transparent_underline CUR Booleans [ 19 ]

# Skipping MacroDefinition: xon_xoff CUR Booleans [ 20 ]

# Skipping MacroDefinition: needs_xon_xoff CUR Booleans [ 21 ]

# Skipping MacroDefinition: prtr_silent CUR Booleans [ 22 ]

# Skipping MacroDefinition: hard_cursor CUR Booleans [ 23 ]

# Skipping MacroDefinition: non_rev_rmcup CUR Booleans [ 24 ]

# Skipping MacroDefinition: no_pad_char CUR Booleans [ 25 ]

# Skipping MacroDefinition: non_dest_scroll_region CUR Booleans [ 26 ]

# Skipping MacroDefinition: can_change CUR Booleans [ 27 ]

# Skipping MacroDefinition: back_color_erase CUR Booleans [ 28 ]

# Skipping MacroDefinition: hue_lightness_saturation CUR Booleans [ 29 ]

# Skipping MacroDefinition: col_addr_glitch CUR Booleans [ 30 ]

# Skipping MacroDefinition: cr_cancels_micro_mode CUR Booleans [ 31 ]

# Skipping MacroDefinition: has_print_wheel CUR Booleans [ 32 ]

# Skipping MacroDefinition: row_addr_glitch CUR Booleans [ 33 ]

# Skipping MacroDefinition: semi_auto_right_margin CUR Booleans [ 34 ]

# Skipping MacroDefinition: cpi_changes_res CUR Booleans [ 35 ]

# Skipping MacroDefinition: lpi_changes_res CUR Booleans [ 36 ]

# Skipping MacroDefinition: columns CUR Numbers [ 0 ]

# Skipping MacroDefinition: init_tabs CUR Numbers [ 1 ]

# Skipping MacroDefinition: lines CUR Numbers [ 2 ]

# Skipping MacroDefinition: lines_of_memory CUR Numbers [ 3 ]

# Skipping MacroDefinition: magic_cookie_glitch CUR Numbers [ 4 ]

# Skipping MacroDefinition: padding_baud_rate CUR Numbers [ 5 ]

# Skipping MacroDefinition: virtual_terminal CUR Numbers [ 6 ]

# Skipping MacroDefinition: width_status_line CUR Numbers [ 7 ]

# Skipping MacroDefinition: num_labels CUR Numbers [ 8 ]

# Skipping MacroDefinition: label_height CUR Numbers [ 9 ]

# Skipping MacroDefinition: label_width CUR Numbers [ 10 ]

# Skipping MacroDefinition: max_attributes CUR Numbers [ 11 ]

# Skipping MacroDefinition: maximum_windows CUR Numbers [ 12 ]

# Skipping MacroDefinition: max_colors CUR Numbers [ 13 ]

# Skipping MacroDefinition: max_pairs CUR Numbers [ 14 ]

# Skipping MacroDefinition: no_color_video CUR Numbers [ 15 ]

# Skipping MacroDefinition: buffer_capacity CUR Numbers [ 16 ]

# Skipping MacroDefinition: dot_vert_spacing CUR Numbers [ 17 ]

# Skipping MacroDefinition: dot_horz_spacing CUR Numbers [ 18 ]

# Skipping MacroDefinition: max_micro_address CUR Numbers [ 19 ]

# Skipping MacroDefinition: max_micro_jump CUR Numbers [ 20 ]

# Skipping MacroDefinition: micro_col_size CUR Numbers [ 21 ]

# Skipping MacroDefinition: micro_line_size CUR Numbers [ 22 ]

# Skipping MacroDefinition: number_of_pins CUR Numbers [ 23 ]

# Skipping MacroDefinition: output_res_char CUR Numbers [ 24 ]

# Skipping MacroDefinition: output_res_line CUR Numbers [ 25 ]

# Skipping MacroDefinition: output_res_horz_inch CUR Numbers [ 26 ]

# Skipping MacroDefinition: output_res_vert_inch CUR Numbers [ 27 ]

# Skipping MacroDefinition: print_rate CUR Numbers [ 28 ]

# Skipping MacroDefinition: wide_char_size CUR Numbers [ 29 ]

# Skipping MacroDefinition: buttons CUR Numbers [ 30 ]

# Skipping MacroDefinition: bit_image_entwining CUR Numbers [ 31 ]

# Skipping MacroDefinition: bit_image_type CUR Numbers [ 32 ]

# Skipping MacroDefinition: back_tab CUR Strings [ 0 ]

# Skipping MacroDefinition: bell CUR Strings [ 1 ]

# Skipping MacroDefinition: carriage_return CUR Strings [ 2 ]

# Skipping MacroDefinition: change_scroll_region CUR Strings [ 3 ]

# Skipping MacroDefinition: clear_all_tabs CUR Strings [ 4 ]

# Skipping MacroDefinition: clear_screen CUR Strings [ 5 ]

# Skipping MacroDefinition: clr_eol CUR Strings [ 6 ]

# Skipping MacroDefinition: clr_eos CUR Strings [ 7 ]

# Skipping MacroDefinition: column_address CUR Strings [ 8 ]

# Skipping MacroDefinition: command_character CUR Strings [ 9 ]

# Skipping MacroDefinition: cursor_address CUR Strings [ 10 ]

# Skipping MacroDefinition: cursor_down CUR Strings [ 11 ]

# Skipping MacroDefinition: cursor_home CUR Strings [ 12 ]

# Skipping MacroDefinition: cursor_invisible CUR Strings [ 13 ]

# Skipping MacroDefinition: cursor_left CUR Strings [ 14 ]

# Skipping MacroDefinition: cursor_mem_address CUR Strings [ 15 ]

# Skipping MacroDefinition: cursor_normal CUR Strings [ 16 ]

# Skipping MacroDefinition: cursor_right CUR Strings [ 17 ]

# Skipping MacroDefinition: cursor_to_ll CUR Strings [ 18 ]

# Skipping MacroDefinition: cursor_up CUR Strings [ 19 ]

# Skipping MacroDefinition: cursor_visible CUR Strings [ 20 ]

# Skipping MacroDefinition: delete_character CUR Strings [ 21 ]

# Skipping MacroDefinition: delete_line CUR Strings [ 22 ]

# Skipping MacroDefinition: dis_status_line CUR Strings [ 23 ]

# Skipping MacroDefinition: down_half_line CUR Strings [ 24 ]

# Skipping MacroDefinition: enter_alt_charset_mode CUR Strings [ 25 ]

# Skipping MacroDefinition: enter_blink_mode CUR Strings [ 26 ]

# Skipping MacroDefinition: enter_bold_mode CUR Strings [ 27 ]

# Skipping MacroDefinition: enter_ca_mode CUR Strings [ 28 ]

# Skipping MacroDefinition: enter_delete_mode CUR Strings [ 29 ]

# Skipping MacroDefinition: enter_dim_mode CUR Strings [ 30 ]

# Skipping MacroDefinition: enter_insert_mode CUR Strings [ 31 ]

# Skipping MacroDefinition: enter_secure_mode CUR Strings [ 32 ]

# Skipping MacroDefinition: enter_protected_mode CUR Strings [ 33 ]

# Skipping MacroDefinition: enter_reverse_mode CUR Strings [ 34 ]

# Skipping MacroDefinition: enter_standout_mode CUR Strings [ 35 ]

# Skipping MacroDefinition: enter_underline_mode CUR Strings [ 36 ]

# Skipping MacroDefinition: erase_chars CUR Strings [ 37 ]

# Skipping MacroDefinition: exit_alt_charset_mode CUR Strings [ 38 ]

# Skipping MacroDefinition: exit_attribute_mode CUR Strings [ 39 ]

# Skipping MacroDefinition: exit_ca_mode CUR Strings [ 40 ]

# Skipping MacroDefinition: exit_delete_mode CUR Strings [ 41 ]

# Skipping MacroDefinition: exit_insert_mode CUR Strings [ 42 ]

# Skipping MacroDefinition: exit_standout_mode CUR Strings [ 43 ]

# Skipping MacroDefinition: exit_underline_mode CUR Strings [ 44 ]

# Skipping MacroDefinition: flash_screen CUR Strings [ 45 ]

# Skipping MacroDefinition: form_feed CUR Strings [ 46 ]

# Skipping MacroDefinition: from_status_line CUR Strings [ 47 ]

# Skipping MacroDefinition: init_1string CUR Strings [ 48 ]

# Skipping MacroDefinition: init_2string CUR Strings [ 49 ]

# Skipping MacroDefinition: init_3string CUR Strings [ 50 ]

# Skipping MacroDefinition: init_file CUR Strings [ 51 ]

# Skipping MacroDefinition: insert_character CUR Strings [ 52 ]

# Skipping MacroDefinition: insert_line CUR Strings [ 53 ]

# Skipping MacroDefinition: insert_padding CUR Strings [ 54 ]

# Skipping MacroDefinition: key_backspace CUR Strings [ 55 ]

# Skipping MacroDefinition: key_catab CUR Strings [ 56 ]

# Skipping MacroDefinition: key_clear CUR Strings [ 57 ]

# Skipping MacroDefinition: key_ctab CUR Strings [ 58 ]

# Skipping MacroDefinition: key_dc CUR Strings [ 59 ]

# Skipping MacroDefinition: key_dl CUR Strings [ 60 ]

# Skipping MacroDefinition: key_down CUR Strings [ 61 ]

# Skipping MacroDefinition: key_eic CUR Strings [ 62 ]

# Skipping MacroDefinition: key_eol CUR Strings [ 63 ]

# Skipping MacroDefinition: key_eos CUR Strings [ 64 ]

# Skipping MacroDefinition: key_f0 CUR Strings [ 65 ]

# Skipping MacroDefinition: key_f1 CUR Strings [ 66 ]

# Skipping MacroDefinition: key_f10 CUR Strings [ 67 ]

# Skipping MacroDefinition: key_f2 CUR Strings [ 68 ]

# Skipping MacroDefinition: key_f3 CUR Strings [ 69 ]

# Skipping MacroDefinition: key_f4 CUR Strings [ 70 ]

# Skipping MacroDefinition: key_f5 CUR Strings [ 71 ]

# Skipping MacroDefinition: key_f6 CUR Strings [ 72 ]

# Skipping MacroDefinition: key_f7 CUR Strings [ 73 ]

# Skipping MacroDefinition: key_f8 CUR Strings [ 74 ]

# Skipping MacroDefinition: key_f9 CUR Strings [ 75 ]

# Skipping MacroDefinition: key_home CUR Strings [ 76 ]

# Skipping MacroDefinition: key_ic CUR Strings [ 77 ]

# Skipping MacroDefinition: key_il CUR Strings [ 78 ]

# Skipping MacroDefinition: key_left CUR Strings [ 79 ]

# Skipping MacroDefinition: key_ll CUR Strings [ 80 ]

# Skipping MacroDefinition: key_npage CUR Strings [ 81 ]

# Skipping MacroDefinition: key_ppage CUR Strings [ 82 ]

# Skipping MacroDefinition: key_right CUR Strings [ 83 ]

# Skipping MacroDefinition: key_sf CUR Strings [ 84 ]

# Skipping MacroDefinition: key_sr CUR Strings [ 85 ]

# Skipping MacroDefinition: key_stab CUR Strings [ 86 ]

# Skipping MacroDefinition: key_up CUR Strings [ 87 ]

# Skipping MacroDefinition: keypad_local CUR Strings [ 88 ]

# Skipping MacroDefinition: keypad_xmit CUR Strings [ 89 ]

# Skipping MacroDefinition: lab_f0 CUR Strings [ 90 ]

# Skipping MacroDefinition: lab_f1 CUR Strings [ 91 ]

# Skipping MacroDefinition: lab_f10 CUR Strings [ 92 ]

# Skipping MacroDefinition: lab_f2 CUR Strings [ 93 ]

# Skipping MacroDefinition: lab_f3 CUR Strings [ 94 ]

# Skipping MacroDefinition: lab_f4 CUR Strings [ 95 ]

# Skipping MacroDefinition: lab_f5 CUR Strings [ 96 ]

# Skipping MacroDefinition: lab_f6 CUR Strings [ 97 ]

# Skipping MacroDefinition: lab_f7 CUR Strings [ 98 ]

# Skipping MacroDefinition: lab_f8 CUR Strings [ 99 ]

# Skipping MacroDefinition: lab_f9 CUR Strings [ 100 ]

# Skipping MacroDefinition: meta_off CUR Strings [ 101 ]

# Skipping MacroDefinition: meta_on CUR Strings [ 102 ]

# Skipping MacroDefinition: newline CUR Strings [ 103 ]

# Skipping MacroDefinition: pad_char CUR Strings [ 104 ]

# Skipping MacroDefinition: parm_dch CUR Strings [ 105 ]

# Skipping MacroDefinition: parm_delete_line CUR Strings [ 106 ]

# Skipping MacroDefinition: parm_down_cursor CUR Strings [ 107 ]

# Skipping MacroDefinition: parm_ich CUR Strings [ 108 ]

# Skipping MacroDefinition: parm_index CUR Strings [ 109 ]

# Skipping MacroDefinition: parm_insert_line CUR Strings [ 110 ]

# Skipping MacroDefinition: parm_left_cursor CUR Strings [ 111 ]

# Skipping MacroDefinition: parm_right_cursor CUR Strings [ 112 ]

# Skipping MacroDefinition: parm_rindex CUR Strings [ 113 ]

# Skipping MacroDefinition: parm_up_cursor CUR Strings [ 114 ]

# Skipping MacroDefinition: pkey_key CUR Strings [ 115 ]

# Skipping MacroDefinition: pkey_local CUR Strings [ 116 ]

# Skipping MacroDefinition: pkey_xmit CUR Strings [ 117 ]

# Skipping MacroDefinition: print_screen CUR Strings [ 118 ]

# Skipping MacroDefinition: prtr_off CUR Strings [ 119 ]

# Skipping MacroDefinition: prtr_on CUR Strings [ 120 ]

# Skipping MacroDefinition: repeat_char CUR Strings [ 121 ]

# Skipping MacroDefinition: reset_1string CUR Strings [ 122 ]

# Skipping MacroDefinition: reset_2string CUR Strings [ 123 ]

# Skipping MacroDefinition: reset_3string CUR Strings [ 124 ]

# Skipping MacroDefinition: reset_file CUR Strings [ 125 ]

# Skipping MacroDefinition: restore_cursor CUR Strings [ 126 ]

# Skipping MacroDefinition: row_address CUR Strings [ 127 ]

# Skipping MacroDefinition: save_cursor CUR Strings [ 128 ]

# Skipping MacroDefinition: scroll_forward CUR Strings [ 129 ]

# Skipping MacroDefinition: scroll_reverse CUR Strings [ 130 ]

# Skipping MacroDefinition: set_attributes CUR Strings [ 131 ]

# Skipping MacroDefinition: set_tab CUR Strings [ 132 ]

# Skipping MacroDefinition: set_window CUR Strings [ 133 ]

# Skipping MacroDefinition: tab CUR Strings [ 134 ]

# Skipping MacroDefinition: to_status_line CUR Strings [ 135 ]

# Skipping MacroDefinition: underline_char CUR Strings [ 136 ]

# Skipping MacroDefinition: up_half_line CUR Strings [ 137 ]

# Skipping MacroDefinition: init_prog CUR Strings [ 138 ]

# Skipping MacroDefinition: key_a1 CUR Strings [ 139 ]

# Skipping MacroDefinition: key_a3 CUR Strings [ 140 ]

# Skipping MacroDefinition: key_b2 CUR Strings [ 141 ]

# Skipping MacroDefinition: key_c1 CUR Strings [ 142 ]

# Skipping MacroDefinition: key_c3 CUR Strings [ 143 ]

# Skipping MacroDefinition: prtr_non CUR Strings [ 144 ]

# Skipping MacroDefinition: char_padding CUR Strings [ 145 ]

# Skipping MacroDefinition: acs_chars CUR Strings [ 146 ]

# Skipping MacroDefinition: plab_norm CUR Strings [ 147 ]

# Skipping MacroDefinition: key_btab CUR Strings [ 148 ]

# Skipping MacroDefinition: enter_xon_mode CUR Strings [ 149 ]

# Skipping MacroDefinition: exit_xon_mode CUR Strings [ 150 ]

# Skipping MacroDefinition: enter_am_mode CUR Strings [ 151 ]

# Skipping MacroDefinition: exit_am_mode CUR Strings [ 152 ]

# Skipping MacroDefinition: xon_character CUR Strings [ 153 ]

# Skipping MacroDefinition: xoff_character CUR Strings [ 154 ]

# Skipping MacroDefinition: ena_acs CUR Strings [ 155 ]

# Skipping MacroDefinition: label_on CUR Strings [ 156 ]

# Skipping MacroDefinition: label_off CUR Strings [ 157 ]

# Skipping MacroDefinition: key_beg CUR Strings [ 158 ]

# Skipping MacroDefinition: key_cancel CUR Strings [ 159 ]

# Skipping MacroDefinition: key_close CUR Strings [ 160 ]

# Skipping MacroDefinition: key_command CUR Strings [ 161 ]

# Skipping MacroDefinition: key_copy CUR Strings [ 162 ]

# Skipping MacroDefinition: key_create CUR Strings [ 163 ]

# Skipping MacroDefinition: key_end CUR Strings [ 164 ]

# Skipping MacroDefinition: key_enter CUR Strings [ 165 ]

# Skipping MacroDefinition: key_exit CUR Strings [ 166 ]

# Skipping MacroDefinition: key_find CUR Strings [ 167 ]

# Skipping MacroDefinition: key_help CUR Strings [ 168 ]

# Skipping MacroDefinition: key_mark CUR Strings [ 169 ]

# Skipping MacroDefinition: key_message CUR Strings [ 170 ]

# Skipping MacroDefinition: key_move CUR Strings [ 171 ]

# Skipping MacroDefinition: key_next CUR Strings [ 172 ]

# Skipping MacroDefinition: key_open CUR Strings [ 173 ]

# Skipping MacroDefinition: key_options CUR Strings [ 174 ]

# Skipping MacroDefinition: key_previous CUR Strings [ 175 ]

# Skipping MacroDefinition: key_print CUR Strings [ 176 ]

# Skipping MacroDefinition: key_redo CUR Strings [ 177 ]

# Skipping MacroDefinition: key_reference CUR Strings [ 178 ]

# Skipping MacroDefinition: key_refresh CUR Strings [ 179 ]

# Skipping MacroDefinition: key_replace CUR Strings [ 180 ]

# Skipping MacroDefinition: key_restart CUR Strings [ 181 ]

# Skipping MacroDefinition: key_resume CUR Strings [ 182 ]

# Skipping MacroDefinition: key_save CUR Strings [ 183 ]

# Skipping MacroDefinition: key_suspend CUR Strings [ 184 ]

# Skipping MacroDefinition: key_undo CUR Strings [ 185 ]

# Skipping MacroDefinition: key_sbeg CUR Strings [ 186 ]

# Skipping MacroDefinition: key_scancel CUR Strings [ 187 ]

# Skipping MacroDefinition: key_scommand CUR Strings [ 188 ]

# Skipping MacroDefinition: key_scopy CUR Strings [ 189 ]

# Skipping MacroDefinition: key_screate CUR Strings [ 190 ]

# Skipping MacroDefinition: key_sdc CUR Strings [ 191 ]

# Skipping MacroDefinition: key_sdl CUR Strings [ 192 ]

# Skipping MacroDefinition: key_select CUR Strings [ 193 ]

# Skipping MacroDefinition: key_send CUR Strings [ 194 ]

# Skipping MacroDefinition: key_seol CUR Strings [ 195 ]

# Skipping MacroDefinition: key_sexit CUR Strings [ 196 ]

# Skipping MacroDefinition: key_sfind CUR Strings [ 197 ]

# Skipping MacroDefinition: key_shelp CUR Strings [ 198 ]

# Skipping MacroDefinition: key_shome CUR Strings [ 199 ]

# Skipping MacroDefinition: key_sic CUR Strings [ 200 ]

# Skipping MacroDefinition: key_sleft CUR Strings [ 201 ]

# Skipping MacroDefinition: key_smessage CUR Strings [ 202 ]

# Skipping MacroDefinition: key_smove CUR Strings [ 203 ]

# Skipping MacroDefinition: key_snext CUR Strings [ 204 ]

# Skipping MacroDefinition: key_soptions CUR Strings [ 205 ]

# Skipping MacroDefinition: key_sprevious CUR Strings [ 206 ]

# Skipping MacroDefinition: key_sprint CUR Strings [ 207 ]

# Skipping MacroDefinition: key_sredo CUR Strings [ 208 ]

# Skipping MacroDefinition: key_sreplace CUR Strings [ 209 ]

# Skipping MacroDefinition: key_sright CUR Strings [ 210 ]

# Skipping MacroDefinition: key_srsume CUR Strings [ 211 ]

# Skipping MacroDefinition: key_ssave CUR Strings [ 212 ]

# Skipping MacroDefinition: key_ssuspend CUR Strings [ 213 ]

# Skipping MacroDefinition: key_sundo CUR Strings [ 214 ]

# Skipping MacroDefinition: req_for_input CUR Strings [ 215 ]

# Skipping MacroDefinition: key_f11 CUR Strings [ 216 ]

# Skipping MacroDefinition: key_f12 CUR Strings [ 217 ]

# Skipping MacroDefinition: key_f13 CUR Strings [ 218 ]

# Skipping MacroDefinition: key_f14 CUR Strings [ 219 ]

# Skipping MacroDefinition: key_f15 CUR Strings [ 220 ]

# Skipping MacroDefinition: key_f16 CUR Strings [ 221 ]

# Skipping MacroDefinition: key_f17 CUR Strings [ 222 ]

# Skipping MacroDefinition: key_f18 CUR Strings [ 223 ]

# Skipping MacroDefinition: key_f19 CUR Strings [ 224 ]

# Skipping MacroDefinition: key_f20 CUR Strings [ 225 ]

# Skipping MacroDefinition: key_f21 CUR Strings [ 226 ]

# Skipping MacroDefinition: key_f22 CUR Strings [ 227 ]

# Skipping MacroDefinition: key_f23 CUR Strings [ 228 ]

# Skipping MacroDefinition: key_f24 CUR Strings [ 229 ]

# Skipping MacroDefinition: key_f25 CUR Strings [ 230 ]

# Skipping MacroDefinition: key_f26 CUR Strings [ 231 ]

# Skipping MacroDefinition: key_f27 CUR Strings [ 232 ]

# Skipping MacroDefinition: key_f28 CUR Strings [ 233 ]

# Skipping MacroDefinition: key_f29 CUR Strings [ 234 ]

# Skipping MacroDefinition: key_f30 CUR Strings [ 235 ]

# Skipping MacroDefinition: key_f31 CUR Strings [ 236 ]

# Skipping MacroDefinition: key_f32 CUR Strings [ 237 ]

# Skipping MacroDefinition: key_f33 CUR Strings [ 238 ]

# Skipping MacroDefinition: key_f34 CUR Strings [ 239 ]

# Skipping MacroDefinition: key_f35 CUR Strings [ 240 ]

# Skipping MacroDefinition: key_f36 CUR Strings [ 241 ]

# Skipping MacroDefinition: key_f37 CUR Strings [ 242 ]

# Skipping MacroDefinition: key_f38 CUR Strings [ 243 ]

# Skipping MacroDefinition: key_f39 CUR Strings [ 244 ]

# Skipping MacroDefinition: key_f40 CUR Strings [ 245 ]

# Skipping MacroDefinition: key_f41 CUR Strings [ 246 ]

# Skipping MacroDefinition: key_f42 CUR Strings [ 247 ]

# Skipping MacroDefinition: key_f43 CUR Strings [ 248 ]

# Skipping MacroDefinition: key_f44 CUR Strings [ 249 ]

# Skipping MacroDefinition: key_f45 CUR Strings [ 250 ]

# Skipping MacroDefinition: key_f46 CUR Strings [ 251 ]

# Skipping MacroDefinition: key_f47 CUR Strings [ 252 ]

# Skipping MacroDefinition: key_f48 CUR Strings [ 253 ]

# Skipping MacroDefinition: key_f49 CUR Strings [ 254 ]

# Skipping MacroDefinition: key_f50 CUR Strings [ 255 ]

# Skipping MacroDefinition: key_f51 CUR Strings [ 256 ]

# Skipping MacroDefinition: key_f52 CUR Strings [ 257 ]

# Skipping MacroDefinition: key_f53 CUR Strings [ 258 ]

# Skipping MacroDefinition: key_f54 CUR Strings [ 259 ]

# Skipping MacroDefinition: key_f55 CUR Strings [ 260 ]

# Skipping MacroDefinition: key_f56 CUR Strings [ 261 ]

# Skipping MacroDefinition: key_f57 CUR Strings [ 262 ]

# Skipping MacroDefinition: key_f58 CUR Strings [ 263 ]

# Skipping MacroDefinition: key_f59 CUR Strings [ 264 ]

# Skipping MacroDefinition: key_f60 CUR Strings [ 265 ]

# Skipping MacroDefinition: key_f61 CUR Strings [ 266 ]

# Skipping MacroDefinition: key_f62 CUR Strings [ 267 ]

# Skipping MacroDefinition: key_f63 CUR Strings [ 268 ]

# Skipping MacroDefinition: clr_bol CUR Strings [ 269 ]

# Skipping MacroDefinition: clear_margins CUR Strings [ 270 ]

# Skipping MacroDefinition: set_left_margin CUR Strings [ 271 ]

# Skipping MacroDefinition: set_right_margin CUR Strings [ 272 ]

# Skipping MacroDefinition: label_format CUR Strings [ 273 ]

# Skipping MacroDefinition: set_clock CUR Strings [ 274 ]

# Skipping MacroDefinition: display_clock CUR Strings [ 275 ]

# Skipping MacroDefinition: remove_clock CUR Strings [ 276 ]

# Skipping MacroDefinition: create_window CUR Strings [ 277 ]

# Skipping MacroDefinition: goto_window CUR Strings [ 278 ]

# Skipping MacroDefinition: hangup CUR Strings [ 279 ]

# Skipping MacroDefinition: dial_phone CUR Strings [ 280 ]

# Skipping MacroDefinition: quick_dial CUR Strings [ 281 ]

# Skipping MacroDefinition: tone CUR Strings [ 282 ]

# Skipping MacroDefinition: pulse CUR Strings [ 283 ]

# Skipping MacroDefinition: flash_hook CUR Strings [ 284 ]

# Skipping MacroDefinition: fixed_pause CUR Strings [ 285 ]

# Skipping MacroDefinition: wait_tone CUR Strings [ 286 ]

# Skipping MacroDefinition: user0 CUR Strings [ 287 ]

# Skipping MacroDefinition: user1 CUR Strings [ 288 ]

# Skipping MacroDefinition: user2 CUR Strings [ 289 ]

# Skipping MacroDefinition: user3 CUR Strings [ 290 ]

# Skipping MacroDefinition: user4 CUR Strings [ 291 ]

# Skipping MacroDefinition: user5 CUR Strings [ 292 ]

# Skipping MacroDefinition: user6 CUR Strings [ 293 ]

# Skipping MacroDefinition: user7 CUR Strings [ 294 ]

# Skipping MacroDefinition: user8 CUR Strings [ 295 ]

# Skipping MacroDefinition: user9 CUR Strings [ 296 ]

# Skipping MacroDefinition: orig_pair CUR Strings [ 297 ]

# Skipping MacroDefinition: orig_colors CUR Strings [ 298 ]

# Skipping MacroDefinition: initialize_color CUR Strings [ 299 ]

# Skipping MacroDefinition: initialize_pair CUR Strings [ 300 ]

# Skipping MacroDefinition: set_color_pair CUR Strings [ 301 ]

# Skipping MacroDefinition: set_foreground CUR Strings [ 302 ]

# Skipping MacroDefinition: set_background CUR Strings [ 303 ]

# Skipping MacroDefinition: change_char_pitch CUR Strings [ 304 ]

# Skipping MacroDefinition: change_line_pitch CUR Strings [ 305 ]

# Skipping MacroDefinition: change_res_horz CUR Strings [ 306 ]

# Skipping MacroDefinition: change_res_vert CUR Strings [ 307 ]

# Skipping MacroDefinition: define_char CUR Strings [ 308 ]

# Skipping MacroDefinition: enter_doublewide_mode CUR Strings [ 309 ]

# Skipping MacroDefinition: enter_draft_quality CUR Strings [ 310 ]

# Skipping MacroDefinition: enter_italics_mode CUR Strings [ 311 ]

# Skipping MacroDefinition: enter_leftward_mode CUR Strings [ 312 ]

# Skipping MacroDefinition: enter_micro_mode CUR Strings [ 313 ]

# Skipping MacroDefinition: enter_near_letter_quality CUR Strings [ 314 ]

# Skipping MacroDefinition: enter_normal_quality CUR Strings [ 315 ]

# Skipping MacroDefinition: enter_shadow_mode CUR Strings [ 316 ]

# Skipping MacroDefinition: enter_subscript_mode CUR Strings [ 317 ]

# Skipping MacroDefinition: enter_superscript_mode CUR Strings [ 318 ]

# Skipping MacroDefinition: enter_upward_mode CUR Strings [ 319 ]

# Skipping MacroDefinition: exit_doublewide_mode CUR Strings [ 320 ]

# Skipping MacroDefinition: exit_italics_mode CUR Strings [ 321 ]

# Skipping MacroDefinition: exit_leftward_mode CUR Strings [ 322 ]

# Skipping MacroDefinition: exit_micro_mode CUR Strings [ 323 ]

# Skipping MacroDefinition: exit_shadow_mode CUR Strings [ 324 ]

# Skipping MacroDefinition: exit_subscript_mode CUR Strings [ 325 ]

# Skipping MacroDefinition: exit_superscript_mode CUR Strings [ 326 ]

# Skipping MacroDefinition: exit_upward_mode CUR Strings [ 327 ]

# Skipping MacroDefinition: micro_column_address CUR Strings [ 328 ]

# Skipping MacroDefinition: micro_down CUR Strings [ 329 ]

# Skipping MacroDefinition: micro_left CUR Strings [ 330 ]

# Skipping MacroDefinition: micro_right CUR Strings [ 331 ]

# Skipping MacroDefinition: micro_row_address CUR Strings [ 332 ]

# Skipping MacroDefinition: micro_up CUR Strings [ 333 ]

# Skipping MacroDefinition: order_of_pins CUR Strings [ 334 ]

# Skipping MacroDefinition: parm_down_micro CUR Strings [ 335 ]

# Skipping MacroDefinition: parm_left_micro CUR Strings [ 336 ]

# Skipping MacroDefinition: parm_right_micro CUR Strings [ 337 ]

# Skipping MacroDefinition: parm_up_micro CUR Strings [ 338 ]

# Skipping MacroDefinition: select_char_set CUR Strings [ 339 ]

# Skipping MacroDefinition: set_bottom_margin CUR Strings [ 340 ]

# Skipping MacroDefinition: set_bottom_margin_parm CUR Strings [ 341 ]

# Skipping MacroDefinition: set_left_margin_parm CUR Strings [ 342 ]

# Skipping MacroDefinition: set_right_margin_parm CUR Strings [ 343 ]

# Skipping MacroDefinition: set_top_margin CUR Strings [ 344 ]

# Skipping MacroDefinition: set_top_margin_parm CUR Strings [ 345 ]

# Skipping MacroDefinition: start_bit_image CUR Strings [ 346 ]

# Skipping MacroDefinition: start_char_set_def CUR Strings [ 347 ]

# Skipping MacroDefinition: stop_bit_image CUR Strings [ 348 ]

# Skipping MacroDefinition: stop_char_set_def CUR Strings [ 349 ]

# Skipping MacroDefinition: subscript_characters CUR Strings [ 350 ]

# Skipping MacroDefinition: superscript_characters CUR Strings [ 351 ]

# Skipping MacroDefinition: these_cause_cr CUR Strings [ 352 ]

# Skipping MacroDefinition: zero_motion CUR Strings [ 353 ]

# Skipping MacroDefinition: char_set_names CUR Strings [ 354 ]

# Skipping MacroDefinition: key_mouse CUR Strings [ 355 ]

# Skipping MacroDefinition: mouse_info CUR Strings [ 356 ]

# Skipping MacroDefinition: req_mouse_pos CUR Strings [ 357 ]

# Skipping MacroDefinition: get_mouse CUR Strings [ 358 ]

# Skipping MacroDefinition: set_a_foreground CUR Strings [ 359 ]

# Skipping MacroDefinition: set_a_background CUR Strings [ 360 ]

# Skipping MacroDefinition: pkey_plab CUR Strings [ 361 ]

# Skipping MacroDefinition: device_type CUR Strings [ 362 ]

# Skipping MacroDefinition: code_set_init CUR Strings [ 363 ]

# Skipping MacroDefinition: set0_des_seq CUR Strings [ 364 ]

# Skipping MacroDefinition: set1_des_seq CUR Strings [ 365 ]

# Skipping MacroDefinition: set2_des_seq CUR Strings [ 366 ]

# Skipping MacroDefinition: set3_des_seq CUR Strings [ 367 ]

# Skipping MacroDefinition: set_lr_margin CUR Strings [ 368 ]

# Skipping MacroDefinition: set_tb_margin CUR Strings [ 369 ]

# Skipping MacroDefinition: bit_image_repeat CUR Strings [ 370 ]

# Skipping MacroDefinition: bit_image_newline CUR Strings [ 371 ]

# Skipping MacroDefinition: bit_image_carriage_return CUR Strings [ 372 ]

# Skipping MacroDefinition: color_names CUR Strings [ 373 ]

# Skipping MacroDefinition: define_bit_image_region CUR Strings [ 374 ]

# Skipping MacroDefinition: end_bit_image_region CUR Strings [ 375 ]

# Skipping MacroDefinition: set_color_band CUR Strings [ 376 ]

# Skipping MacroDefinition: set_page_length CUR Strings [ 377 ]

# Skipping MacroDefinition: display_pc_char CUR Strings [ 378 ]

# Skipping MacroDefinition: enter_pc_charset_mode CUR Strings [ 379 ]

# Skipping MacroDefinition: exit_pc_charset_mode CUR Strings [ 380 ]

# Skipping MacroDefinition: enter_scancode_mode CUR Strings [ 381 ]

# Skipping MacroDefinition: exit_scancode_mode CUR Strings [ 382 ]

# Skipping MacroDefinition: pc_term_options CUR Strings [ 383 ]

# Skipping MacroDefinition: scancode_escape CUR Strings [ 384 ]

# Skipping MacroDefinition: alt_scancode_esc CUR Strings [ 385 ]

# Skipping MacroDefinition: enter_horizontal_hl_mode CUR Strings [ 386 ]

# Skipping MacroDefinition: enter_left_hl_mode CUR Strings [ 387 ]

# Skipping MacroDefinition: enter_low_hl_mode CUR Strings [ 388 ]

# Skipping MacroDefinition: enter_right_hl_mode CUR Strings [ 389 ]

# Skipping MacroDefinition: enter_top_hl_mode CUR Strings [ 390 ]

# Skipping MacroDefinition: enter_vertical_hl_mode CUR Strings [ 391 ]

# Skipping MacroDefinition: set_a_attributes CUR Strings [ 392 ]

# Skipping MacroDefinition: set_pglen_inch CUR Strings [ 393 ]

const BOOLWRITE = 37

const NUMWRITE = 33

const STRWRITE = 394

const BOOLCOUNT = 44

const NUMCOUNT = 39

const STRCOUNT = 414

const acs_chars_index = 146

const NCURSES_OSPEED = Cshort

const MAGIC = 0x011a

const MAGIC2 = 0x021e

const MAX_NAME_SIZE = 512

const MAX_ENTRY_SIZE1 = 4096

const MAX_ENTRY_SIZE2 = 32768

const MAX_ENTRY_SIZE = MAX_ENTRY_SIZE1

const MAX_ALIAS = 14

const PRIVATE_INFO = "%s/.terminfo"

const MAX_DEBUG_LEVEL = 15

const BOOLEAN = 0

const NUMBER = 1

const STRING = 2

const CANCEL = 3

const NAMES = 4

const UNDEF = 5

const NO_PUSHBACK = -1

# Skipping MacroDefinition: NOTFOUND ( ( struct name_table_entry * ) 0 )

const ABSENT_NUMERIC = -1

# Skipping MacroDefinition: ABSENT_STRING ( char * ) 0

const CANCELLED_NUMERIC = -2

# Skipping MacroDefinition: CANCELLED_STRING ( char * ) ( - 1 )

const MAX_TERMCAP_LENGTH = 1023

const MAX_TERMINFO_LENGTH = 4096

const TERMINFO = "/usr/share/terminfo"

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


end # module
