# Missing bits

NCURSES_BITS(mask, shift) = (NCURSES_CAST(chtype, (mask)) << ((shift) + NCURSES_ATTR_SHIFT))
NCURSES_CAST(type, value) = type(value)

function NCURSES_ACS(c)
    acs_map = cglobal((:acs_map, libncurses), Cuchar)
    return unsafe_load(acs_map, c + 1)
end

function NCURSES_MOUSE_MASK(b, m)
    if NCURSES_MOUSE_VERSION > 1
        ((m) << (((b) - 1) * 5))
    else
        ((m) << (((b) - 1) * 6))
    end
end

const ABSENT_BOOLEAN = Int8(-1)
const ABSENT_STRING = Ptr{Cchar}(0)
const CANCELLED_BOOLEAN = Int8(-2)
const CANCELLED_STRING = Ptr{Cchar}(-1)
