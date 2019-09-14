pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
function _init()
 game_over=false
 win=false
 g=0.025 --gravity
 make_player()
 make_ground()
end

function _update()
 if (not gave_over) then
  move_player()
  check_land()
 else
  if (btnp(5)) _init()
 end
end

function _draw()
	cls()
	draw_stars()
	draw_ground()
	draw_player()
	
	if (game_over) then
	 if (win) then
	  print("victory!", 48,48,11)
	 end
	 print("press ❎ to play again",20,70,5)
 end
end



function draw_stars()
 srand(6)
 for i=1,70 do
  pset(rndb(0,127),rndb(0,127),rndb(5,7))
 end
 srand(time())
end


-->8
function make_player()
 p={}
 p.x=60
 p.y=8
 p.dx=0
 p.dy=0
 p.sprite=1
 p.alive=true
 p.thrust=0.075
end

function draw_player()
 spr(p.sprite,p.x,p.y)
 if (game_over and win) then
  spr(4,p.x,p.y-8)
 elseif (game_over) then
  spr(5,p.x,p.y)
 end
end

function move_player()
 p.dy+=g --add graity
 
 thrust()
 --move
 p.x+=p.dx 
 p.y+=p.dy

 stay_on_screen()
end

function thrust()
 if (btn(0)) p.dx-=p.thrust
 if (btn(1)) p.dx+=p.thrust
 if (btn(2)) p.dy-=p.thrust
 
 --sound
 if (btnp(0) or btn(1) or btn(2)) sfx(0)
end 

function stay_on_screen()
 if (p.x<0) then --left side
  p.x=4
  p.dx=0
 end
 if (p.x>119) then --right side
  p.x=115
  p.dx=0
 end
 if (p.y<0) then --top side
  p.y=4
  p.dy=0
 end
end

function rndb(low,high)
 return flr(rnd(high-low+1)+low)
end
-->8
function make_ground()
 gnd={}
 local top=96 --highest point
 local btm=120 --lowest point
 
 --landing pad
 pad={}
 pad.width=15
 pad.x=rndb(0,126-pad.width)
 pad.y=rndb(top,btm)
 pad.sprite=2
 
 --create ground at pad
 for i=pad.x,pad.x+pad.width do
  gnd[i]=pad.y
 end
 
 --create ground at right
 for i=pad.x+pad.width+1,127 do
  local h=rndb(gnd[i-1]-3,gnd[i-1]+3)
  gnd[i]=mid(top,h,btm)
 end

 --create ground at left
 for i=pad.x-1,0,-1 do
  local h=rndb(gnd[i+1]-3,gnd[i+3]+3)
  gnd[i]=mid(top,h,btm)
 end 
end

function draw_ground()
 for i=0,127 do
  line(i,gnd[i],i,127,5)
 end
 spr(pad.sprite,pad.x,pad.y,2,1)
end
-->8
function check_land()
 l_x=flr(p.x) --left side of ship
 r_x=flr(p.x+7) --right side of ship
 b_y=flr(p.y+7) --bottom of ship

 over_pad=l_x>=pad.x and r_x<=pad.x+pad.width
 on_pad=b_y>=pad.y-1
 slow=p.dy<1

 if (over_pad and on_pad and slow) then
  end_game(true)
 elseif (over_pad and on_pad) then
  end_game(false)
 else
  for i=l_x,r_x do
   if (gnd[i]<=b_y) end_game(false)
  end
 end
end

function end_game(won)
 game_over=true
 win=won
 
 if (win) then
  sfx(1)
 else
  sfx(2)
 end
end 
__gfx__
0000000000cccc006771111111111777000000000088880000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000ccc67c06777777777777777000000000899998000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000ccc6cc0006777777777770000000000899aa99800000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000cccc000000000000000000000c600089aaaa9800000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000cccc00000000000000000000cc600089aaaa9800000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000c1cc1c000000000000000000ccc6000899aa99800000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000cc01c0cc0000000000000000000060000899998000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000c000c00c0000000000000000000060000088880000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000600001362000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000c00001907019030160701603010070100301807018030000001507017070170300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400003f670366602e65027640226401e6301a6301663013620106200d6200a6200761005610036100261001610006100061000600000000000000000000000000000000000000000000000000000000000000
