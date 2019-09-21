pico-8 cartridge // http://www.pico-8.com
version 18
__lua__
-- paddle
padx=52
pady=122
padw=24
padh=4

-- ball
ballx=64
bally=64
ballsize=3
ballxdir=5
ballydir=-3

score=0
lives=3

function movepaddle()
	if btn (0) then
		padx-=3
	elseif btn(1) then
		padx+=3
	end
end

function moveball()
 ballx+=ballxdir
 bally+=ballydir
end

function lostdeadball()
 if bally>128 then
  if lives>0 then
   sfx(3)
   bally=24
   lives-=1
  else
   ballydir=0
   ballxdir=0
   bally=64
   sfx(4)
  end
 end
end

function bounceball()
	-- left
	if ballx < ballsize then
		ballxdir=-ballxdir
		sfx(0)
	end
	-- right
	if ballx > 128-ballsize then
		ballxdir=-ballxdir
		sfx(0)
	end
	-- top
	if bally < ballsize then
		ballydir=-ballydir
		sfx(0)
	end
end

function bouncepaddle()
	if ballx>=padx and
		ballx<=padx+padw and
		bally>pady-padh-2 then
		sfx(0)
  score+=10
		ballydir=-ballydir
	end
end

function _update()
	movepaddle()
 bounceball() 
 bouncepaddle()
 moveball()
 lostdeadball()
 
end

function _draw()
	-- clear screen
	rectfill(0,0, 128,128, 3)
	-- draw lifes
	for i=1,lives do
	 spr(001,04+i*8,4)
	end
	-- draw score
	print(score,100,6,15)
	-- draw paddle
	rectfill(padx,pady, padx+padw,pady+padh, 15)
 -- draw ball
 circfill(ballx,bally,ballsize,15)
end
__gfx__
000000000ee0ee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000eeeeeee00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700eeeeeee00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000770000eeeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000eee0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100003607000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002d0602206019060110600a060060600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002105000000000002105000000000002105021050000002405000000230500000021050000001f05000000210500000000000000000000000000000000000000000000000000000000000000000000000
