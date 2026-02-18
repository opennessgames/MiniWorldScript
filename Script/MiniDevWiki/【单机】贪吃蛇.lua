--[[
Author: xixi_
Date: 2022-08-18 18:12:54
LastEditors: xixi_
LastEditTime: 2026-02-18 14:07:15
FilePath: /MiniWorldScript/Script/MiniDevWiki/贪吃蛇.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

--屏幕宽高与起点坐标
local w,h=50,50
local spos={-30,60,50}
--左下右上重启继续:按钮坐标
local pos={-1,31,0,0,30,0,1,31,0,0,32,0,-1,30,0,1,30,0}
--蛇身、水果、墙壁、继续、暂停、网格
local ids={4000,3999,1,3993,3992,3989}
----------------------------------------------------------------
local now=0--当前游戏状态:0暂停 1进行中 2结束
local drct,score,speed,spi=0,0,3,0--方向，分数，速度
local sn,fr={},{0,0}--蛇身位置，水果坐标
local next=0--蛇头下一步位置
local snh={}--蛇头坐标
local i,j,k=0,0,0

----------------
----预置方法-----
----------------
--获取某元素在表中的位置
local function isInside(value,tab)
	for a,v in ipairs(tab) do
		if v==value then
			return a
		end
	end
	return -1
end
--位置与坐标
local function ltp(l)
	return {math.floor(l/w),l%w}
end
local function ptl(p)
	return p[1]*w+p[2]
end


--生成墙壁，清空屏幕，添加网格
local function Clr()
	for i=-1,w do
		Block:setBlockAll(spos[1]+i,spos[2]+1,spos[3],ids[3],2)
		Block:setBlockAll(spos[1]+i,spos[2]-h,spos[3],ids[3],2)
		for j=0,h-1 do
			Block:setBlockAll(spos[1]+i,spos[2]-j,spos[3],0,2)
			Block:setBlockAll(spos[1]+i,spos[2]-j,spos[3]+1,ids[6],3)
		end
	end
	for i=-1,h do
		Block:setBlockAll(spos[1]-1,spos[2]-i,spos[3],ids[3],2)
		Block:setBlockAll(spos[1]+w,spos[2]-i,spos[3],ids[3],2)
	end
end

--在空白处随机生成一个水果
local function Frt()
	math.randomseed(os.time())
	local r=math.random(1,w*h-(#sn))
	for i=0,w*h-1 do
		if isInside(i,sn)==-1 then
			r=r-1
		end
		if r==0 then
			fr[1]=math.floor(i/w)
			fr[2]=i%w
			Block:setBlockAll(spos[1]+fr[2],spos[2]-fr[1],spos[3],ids[2],2)
			return
		end
	end
end

--初始化
local function St()
	score=0
	now=0
	drct=3
	Clr()
	sn={math.floor(h/2*w)+math.floor(w/2)}
	Block:setBlockAll(spos[1]+sn[1]%w,spos[2]-math.floor(sn[1]/w),spos[3],ids[1],2)
	Frt()
	Block:setBlockAll(pos[16],pos[17],pos[18],ids[4],2)
	Chat:sendSystemMsg("点击播放按钮开始游戏")
end

--玩家点击按钮
Go=function(e)
	local x,y,z=math.floor(e['x']),math.floor(e['y']),math.floor(e['z'])
	if (x==pos[1])and(y==pos[2])and(z==pos[3])and(now==1)and(drct~=3) then--向左
		drct=1
	elseif (x==pos[4])and(y==pos[5])and(z==pos[6])and(now==1)and(drct~=4) then--向下
		drct=2
	elseif (x==pos[7])and(y==pos[8])and(z==pos[9])and(now==1)and(drct~=1) then--向右
		drct=3
	elseif (x==pos[10])and(y==pos[11])and(z==pos[12])and(now==1)and(drct~=2) then--向上
		drct=4
	elseif (x==pos[13])and(y==pos[14])and(z==pos[15]) then--重启游戏
		St()
	elseif (x==pos[16])and(y==pos[17])and(z==pos[18])and(now~=2) then--暂停继续
		if now==0 then
			now=1
			Block:setBlockAll(pos[16],pos[17],pos[18],ids[5],2)
		elseif now==1 then
			now=0
			Block:setBlockAll(pos[16],pos[17],pos[18],ids[4],2)
		end
	end
end
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=],Go)

--初始化
St()
--游戏结束
local function Gmov()
	Chat:sendSystemMsg("游戏结束，最终得分："..score)
	now=2
end

--贪吃蛇移动
return function()
	if now==1 then
		if spi==speed then
			spi=0
			------------------------------------------------------
			--获取蛇头下一步相对坐标与位置
			snh=ltp(sn[#sn])
			if drct==1 then
				snh[2]=snh[2]-1
			elseif drct==2 then
				snh[1]=snh[1]+1
			elseif drct==3 then
				snh[2]=snh[2]+1
			elseif drct==4 then
				snh[1]=snh[1]-1
			end
			next=ptl(snh)
			--检查蛇头下一步是否撞墙或撞到蛇身
			k=isInside(next,sn)
			if (snh[1]<0)or(snh[1]>=h)or(snh[2]<0)or(snh[2]>=w)or((k~=-1)and(k~=1)) then
				Gmov()
				return
			end
			--检查蛇头下一步是否与水果重合
			if (snh[1]==fr[1])and(snh[2]==fr[2]) then
				sn[#sn+1]=next
				Block:setBlockAll(spos[1]+fr[2],spos[2]-fr[1],spos[3],ids[1],2)
				score=score+1
				Chat:sendSystemMsg("游戏得分："..score)
				Frt()
				return
			end
			--正常情况，前行
			Block:setBlockAll(spos[1]+ltp(sn[1])[2],spos[2]-ltp(sn[1])[1],spos[3],0,2)
			Block:setBlockAll(spos[1]+snh[2],spos[2]-snh[1],spos[3],ids[1],2)
			for i=1,#sn-1 do
				sn[i]=sn[i+1]
			end
			sn[#sn]=next
			------------------------------------------------------
		else
			spi=spi+1
		end
	end
end
