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
