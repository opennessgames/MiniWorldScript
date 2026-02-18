--[[
Author: xixi_
Date: 2022-08-18 18:15:21
LastEditors: xixi_
LastEditTime: 2026-02-18 14:02:51
FilePath: /MiniWorldScript/Script/MiniDevWiki/迷宫.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

local mox={}--迷宫数据
local w,h=51,51--迷宫宽高(奇数)
local w0,h0=24,24--生成起点(偶数)

local i,j,k=0,0,0--循环

local x0,y0,z0=0,7,0--生成坐标
local hh=1--迷宫高度
local id=539--迷宫墙id
--生成迷宫
local x,y=0,0--当前格
local rec={}--已遍历记录
local st=0--当前步数
local last={}--当前路径
local function isRed(pos)--pos是否可行
	i=1
	while (i<=#rec)and(rec[i]~=pos)
	do
		i=i+1
	end
	if i==#rec+1 then
		return true
	else
		return false
	end
end
local function getDr()--获取剩余方向
	local dr={}
	local c=0
	if (y~=2)and(isRed((y-3)*w+x)) then--上0
		c=c+1
		dr[c]=0
	end
	if (x~=2)and(isRed((y-1)*w+x-2)) then--左1
		c=c+1
		dr[c]=1
	end
	if (y~=h-1)and(isRed((y+1)*w+x)) then--下2
		c=c+1
		dr[c]=2
	end
	if (x~=w-1)and(isRed((y-1)*w+x+2)) then--右3
		c=c+1
		dr[c]=3
	end
	return c,dr
end
--+--+--
local function mCreat()--初始化
	for i=1,h do
		mox[i]={}
		for j=1,w do
			if (i%2==0)and(j%2==0) then
				mox[i][j]=0
			else
				mox[i][j]=1
			end
		end
	end
	x=w0
	y=h0
	rec[#rec+1]=(y-1)*w+x
	st=1
	last[st]={y,x}
end
local function delMo()--递归生成
	--math.randomseed(tostring(os.time()*math.random(1,9999999999)):reverse():sub(1,7))
	--math.randomseed(os.time()*math.random(1,9999999999))
	local c,dr=getDr()
	if c~=0 then
		c=dr[math.random(1,c)]
		if c==0 then
			mox[y-1][x]=0
			y=y-2
		elseif c==1 then
			mox[y][x-1]=0
			x=x-2
		elseif c==2 then
			mox[y+1][x]=0
			y=y+2
		elseif c==3 then
			mox[y][x+1]=0
			x=x+2
		end
		rec[#rec+1]=(y-1)*w+x
		st=st+1
		last[st]={y,x}
		delMo()
	elseif st~=1 then
		st=st-1
		y=last[st][1]
		x=last[st][2]
		delMo()
	end
end
--
local ep=0
------
Go=function(e)
	local x,y,z=math.floor(e['x']),math.floor(e['y']),math.floor(e['z'])
	if (x==x0+h-2)and(y==y0-1)and(z==z0-w+2) then
		mox={}
		x=0
		y=0
		rec={}
		st=0
		last={}
		ep=0
	end
end
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=],Go)
------
return function()
	if ep==0 then
		mCreat()
		delMo()
		ep=ep+1
	elseif (ep>0)and(ep<=h) then
		for i=0,w-1 do
			if mox[ep][i+1]==1 then
				for j=0,hh-1 do
					Block:replaceBlock(id,x0+ep-1,y0+j,z0-i,0)
				end
			else
				for j=0,hh-1 do
					Block:replaceBlock(0,x0+ep-1,y0+j,z0-i,0)
				end
			end
		end
		Chat:sendSystemMsg("Crafting:"..ep.."/"..h)
		ep=ep+1
	elseif ep==h+1 then
		Player:setPosition(0,x0+1,y0,z0-1)
		Actor:addBuff(0,1002,1,9999999)
		Chat:sendSystemMsg("End")
		ep=-1
	end
end