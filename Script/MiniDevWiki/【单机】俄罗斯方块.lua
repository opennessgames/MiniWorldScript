--[[
Author: xixi_
Date: 2022-08-18 18:15:12
LastEditors: xixi_
LastEditTime: 2026-02-18 14:03:26
FilePath: /MiniWorldScript/Script/MiniDevWiki/俄罗斯方块.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

--I L J O S Z T
local ll={{{1,5,9,13},{0,4,8,9},{1,5,9,8},{0,1,4,5},{1,2,4,5},{0,1,5,6},{1,4,5,6}},{{0,1,2,3},{2,4,5,6},{0,1,2,6},{0,1,4,5},{0,4,5,9},{1,4,5,8},{4,1,5,9}},{{1,5,9,13},{0,1,5,9},{0,1,4,8},{0,1,4,5},{1,2,4,5},{0,1,5,6},{0,1,2,5}},{{0,1,2,3},{0,1,2,4},{0,4,5,6},{0,1,4,5},{0,4,5,9},{1,4,5,8},{1,5,6,9}}}
local px,py=4,1
local stx,sty=4,1
local nowd=1

local scr={}
local w,h=10,20
local x0,y0,z0=0,10,28
local ids={0,668,669}
local now,next=0,0
local ispaused=false

--重玩，暂停，上，下，左，右
local btn={1,18,-10,2,18,-10,9,19,-10,9,17,-10,8,18,-10,10,18,-10}
local score=0
local isding=true
--暂停播放，0-9
local bids={3999,3998}
local dgid={3984,3992,3991,3990,3989,3988,3987,3983,3986,3985}
local dgpos={1,29,9}
local bd=2

local speed,spi=10,0
local step=0
local i,j,k,u,v,ii,ij,ik,il=0,0,0,0,0,0,0,0,0

--刷新
local function re()
	for i=1,h do
		for j=1,w do
		Block:replaceBlock(ids[scr[i][j]+1],x0+j,z0-i,y0,0)
		end
	end
end
--判断x,y是否可行
local function isok(nx,ny,d)
	local bl=true
	local x,y=0,0
	for k=1,4 do
		x=ll[d][now][k]%4
		y=(ll[d][now][k]-x)/4
		if (ny+y>h)or(nx+x<1)or(nx+x>w)or(scr[ny+y][nx+x]==2) then
			bl=false
		end
	end
	return bl
end
--从x,y移动到x,y
local function move(mx,my,nx,ny,d)
	if isok(nx,ny,d) then
		local x,y=0,0
		for k=1,4 do
			x=ll[nowd][now][k]%4
			y=(ll[nowd][now][k]-x)/4
			scr[my+y][mx+x]=0
		end
		for k=1,4 do
			x=ll[d][now][k]%4
			y=(ll[d][now][k]-x)/4
			scr[ny+y][nx+x]=1
		end
		px=nx
		py=ny
		nowd=d
		return true
	else
		return false
	end
end
--消除某行
local function clrow(nr)
	if nr==1 then
		for ij=1,w do
			scr[nr][ij]=0
		end
	else
		for ij=1,w do
			for ik=nr-1,1,-1 do
				scr[ik+1][ij]=scr[ik][ij]
			end
			scr[1][ij]=0
		end
	end
end
--游戏得分
local function setsco()
	local nm=0
	for il=1,10 do
		nm=math.floor(score/math.pow(10,10-il))%10
		Block:replaceBlock(dgid[nm+1],dgpos[1]+il-1,dgpos[2],dgpos[3],bd)
	end
end
--消除得分
local function check()
	local cl={}
	local co=1
	local is=true
	for v=1,h do
		is=true
		for ii=1,w do
			if scr[v][ii]~=2 then
				is=false
			end
		end
		if is then
			cl[co]=v
			co=co+1
		end
	end
	score=score+math.pow(4,co-1)+(co-1)*10
	setsco()
	for ii=1,(co-1) do
		clrow(cl[ii])
	end
end
--改变颜色，落地
local function change(nx,ny)
	local x,y=0,0
	for k=1,4 do
		x=ll[nowd][now][k]%4
		y=(ll[nowd][now][k]-x)/4
		scr[ny+y][nx+x]=2
	end
	check()
end
--玩家点击按钮
Click=function(e)
	local x,y,z=math.floor(e['x']),math.floor(e['y']),math.floor(e['z'])
	if (x==btn[1])and(y==btn[2])and(z==btn[3]) then--重玩
		step=0
		ispaused=false
		Block:replaceBlock(bids[1],btn[4],btn[5],btn[6],bd)
	elseif (x==btn[4])and(y==btn[5])and(z==btn[6]) then--暂停
		if (step~=3)and(step~=0) then
			if ispaused then
				ispaused=false
				step=1
				Block:replaceBlock(bids[1],x,y,z,bd)
			else
				ispaused=true
				step=2
				Block:replaceBlock(bids[2],x,y,z,bd)
			end
		end
	elseif (x==btn[7])and(y==btn[8])and(z==btn[9]) then--上
		if not(ispaused) then
			local d=nowd+1
			if d>4 then
				d=1
			end
			if isok(px,py,d) then
				move(px,py,px,py,d)
			end
		end
	elseif (x==btn[10])and(y==btn[11])and(z==btn[12]) then--下
		if not(ispaused) then
			u=0
			while(isok(px,py+u,nowd))
			do
				u=u+1
			end
			move(px,py,px,py+u-1,nowd)
		end
	elseif (x==btn[13])and(y==btn[14])and(z==btn[15]) then--左
		if not(ispaused) then
			if isok(px-1,py,nowd) then
				move(px,py,px-1,py,nowd)
			end
		end
	elseif (x==btn[16])and(y==btn[17])and(z==btn[18]) then--右
		if not(ispaused) then
			if isok(px+1,py,nowd) then
				move(px,py,px+1,py,nowd)
			end
		end
	end
end
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=],Click)

--游戏结束
local function gameover()
	step=3
	ispaused=true
	Block:replaceBlock(bids[2],btn[4],btn[5],btn[6],bd)
	Chat:sendSystemMsg("游戏结束！得分"..score)
	Chat:sendSystemMsg("游戏结束！最终得分："..score)
end
--生成下一个
local function getnext()
	math.randomseed(os.time())
	now=next
	next=math.random(1,7)
	if now==0 then
		now=math.random(1,7)
	end
	nowd=math.random(1,4)
	px=stx
	py=sty
	local bl=false
	local x,y=0,0
	for k=1,4 do
		x=ll[nowd][now][k]%4
		y=(ll[nowd][now][k]-x)/4
		if scr[py+y][px+x]~=2 then
			scr[py+y][px+x]=1
		else
			bl=true
		end
	end
	if bl then
		gameover()
	end
end

return function()
	if step==0 then
		for i=1,h do
			scr[i]={}
			for j=1,w do
				scr[i][j]=0
			end
		end
		score=0
		setsco()
		getnext()
		re()
		step=1
	elseif step==1 then
		if spi==speed then
			if isding then
				if (not(move(px,py,px,py+1,nowd))) then
					change(px,py)
					isding=false
				end
			else
				getnext()
				isding=true
			end
			spi=0
		else
			spi=spi+1
		end
		re()
	end
end