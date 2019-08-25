pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
function _init()
 game_over=false
 make_cave()
 make_player()
end

function _update()
 if (not game_over) then
  update_cave()
  move_player()
  check_hit()
 end
end

function _draw()
 cls()
 draw_cave()
 draw_player()

 if (game_over) then
 	print("game over!",44,44,7)
  print("your score: "..player.score,34,54,7)
 else
  print("score: "..player.score,2,2,7)
 end
end
-->8
function make_player()
 player={}
 player.x=24
 player.y=60
 player.dy=0
 player.rise=1
 player.fall=2
 player.dead=3
 player.speed=2
 player.score=0
end

function draw_player()
 if (game_over) then
  spr(player.dead,player.x,player.y)
 elseif (player.dy<0) then
  spr(player.rise,player.x,player.y)
 else
  spr(player.fall,player.x,player.y)
 end
end 

function move_player()
 gravity=0.2
 player.dy+=gravity
 
 if(btnp(2)) then
  player.dy=-3
 end
 
 player.y+=player.dy

 player.score+=player.speed
end

function check_hit()
 for i=player.x,player.x+7 do
  if (cave[i+1].top>player.y
   or cave[i+1].btm<player.y+7) then
   game_over=true
  end
 end
end
-->8
function make_cave()
 cave={{["top"]=5,["btm"]=119}}
 top=45 --lowest ceiling
 btm=85 --highest ceiling
end

function update_cave()
 if(#cave>player.speed) then
  for i=1, player.speed do
   del(cave,cave[1])
  end
 end
 
 while (#cave<128) do
  local col={}
  local up=flr(rnd(7)-3)
  local dwn=flr(rnd(7)-3)
  col.top=mid(3,cave[#cave].top+up,top)
  col.btm=mid(btm,cave[#cave].btm+dwn,124)
  add(cave,col)
 end
end

function draw_cave()
 top_color=1
 btm_color=1
 for i=1,#cave do
  line(i-1,0,i-1,cave[i].top,top_color)
  line(i-1,127,i-1,cave[i].btm,btm_color)
 end
end
__gfx__
0000000000aaaa0000aaaa0000888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000aaaaaa00aaaaaa008888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700aaa0a0aaaaa0a0aa88808088000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aaaaaaaaaaaaaaaa88888888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000aaa000aaaaa00aaa88080888000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000aaa0aa00aa00aa008808080000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000aaaa0000aaaa0000888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
