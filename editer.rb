#!/usr/bin/env ruby
require "curses"

def set_escdelay(ms)
  Curses.ESCDELAY = ms
rescue NotImplementedError
end

def print_key_info(win,y,x,key)
  win.setpos(y,x)
  win.addch(key)
end

Curses.init_screen
Curses.raw
set_escdelay(25)

begin
  Curses.setpos(0,0)
  Curses.addstr("Press Ctrl + c")
  Curses.refresh

  win = Curses::Window.new(Curses.lines - 2,Curses.cols,2,0)
  win.scrollok(true)
  win.keypad(true)

  x = 0
  y = 0

  loop do
    key = nil
    win.setpos(y,x)
    key = win.getch
    if key == Curses::KEY_CTRL_C
      break
    end

    #if key != 10 && key != 127
    #  print_key_info(win,y,x,key)
    #end

    case key
    when 127
      win.setpos(y,x - 1)
      win.delch
      x -= 1
    when 10
      x = 0
      y += 1
    else
      print_key_info(win,y,x,key)
      x += 1
    end
=begin
    if x < win.maxx - 1 && key != 127
      x += 1
      if y > win.maxy - 1 || key == 10
        x  = 0
        y += 1
      #else
      #  win.scrl(1)
      end
    elsif key == 127
      win.delch
      x -= 1
    end
=end

  end
ensure
  Curses.close_screen
end
