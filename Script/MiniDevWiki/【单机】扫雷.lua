--[[
Author: xixi_
Date: 2022-08-18 18:13:38
LastEditors: xixi_
LastEditTime: 2026-02-18 14:05:49
FilePath: /MiniWorldScript/Script/MiniDevWiki/扫雷.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

--方块id:0-8，空白、炸弹、覆盖、标记、疑问、边框
local ids={3997,3996,3994,3993,3992,3991,3990,3989,3988}
local ids2={3997,3998,3983,3987,3986,682}
--游戏设定:屏幕宽高、地雷个数、重启时间
local w,h,num,wait=30,20,50,60
--地图设定:屏幕起点坐标(向右前方)
local x0,y0,z0=0,7,0
----------------------------------------
local loc={}--地雷位置
local now=1--游戏状态:0进行中 1游戏结束
local i,j,k=0,0,0
local wi=0--游戏重启计时


local locx={{-1,-1},{-1,0},{-1,1},{0,-1},{0,1},{1,-1},{1,0},{1,1}}

----------------
----预置方法----
----------------
--判断两个表是否一样
local function isSame(t1,t2)
	local m=0
	for m=1,#t1 do
		if t1[m]~=t2[m] then
			return false
		end
	end
	return true
end
--获取某元素在表中的位置
local function isInside(value,tab)
	for a,v in ipairs(tab) do
		if v==value then
			return a
		end
	end
	return -1
end
local function isInside2(value,tab)
	for a,v in ipairs(tab) do
		if isSame(v,value) then
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


--游戏结束
local function Gmov(m)
	now=1
	Chat:sendSystemMsg(m..math.floor(wait*50/1000).."秒后重新开始")
end


--检查剩余
local function Check()
	for k=1,w*h do
		local p=ltp(k-1)
		local r,id=Block:getBlockID(x0+p[2],y0+1,z0+p[1])
		if ((id==ids2[3])or(id==ids2[4])or(id==ids2[5]))and(isInside(k,loc)==-1) then
			return
		end
	end
	Gmov("游戏胜利！")
end

--递归清除
local clrx={}
local function getclr(x,y,z)
	for i=1,8 do
		if isInside2({x+locx[i][1],y,z+locx[i][2]},clrx)==-1 then
			clrx[#clrx+1]={x+locx[i][1],y,z+locx[i][2]}
			local r,id=Block:getBlockID(x+locx[i][1],y,z+locx[i][2])
			if id==ids2[1] then
				getclr(x+locx[i][1],y,z+locx[i][2])
			end
		end
	end
end
local function Clr()
	for j=1,#clrx do
		Block:setBlockAll(clrx[j][1],clrx[j][2]+1,clrx[j][3],0,0)
	end
	Check()
end


--玩家点击方块
Go=function(e)
	if now==0 then
		local x,y,z=math.floor(e['x']),math.floor(e['y']),math.floor(e['z'])
		local id=e['blockid']
		local r,item=Player:getCurToolID(e['eventobjid'])
		if item==ids2[4] then--用标记点击方块(覆盖:标记 标记:疑问 疑问:覆盖)
			if id==ids2[3] then
				Block:setBlockAll(x,y,z,ids2[4],2)
			elseif id==ids2[4] then
				Block:setBlockAll(x,y,z,ids2[5],2)
			elseif id==ids2[5] then
				Block:setBlockAll(x,y,z,ids2[3],2)
			end
		else--用其它点击方块(覆盖:清除)
			if id==ids2[3] then
				Block:setBlockAll(x,y,z,0,2)
				local r2,id2=Block:getBlockID(x,y-1,z)
				if id2==ids2[2] then--炸弹:游戏结束
					Gmov("游戏结束！")
				elseif id2==ids2[1] then--空白:递归清除
					clrx={}
					getclr(x,y-1,z)
					Clr()
				else--数字:检查剩余
					Check()
				end
			end
		end
	end
end
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=],Go)

--------------------------------
--------------------------------

--生成地雷
local function getloc()
	loc={}
	math.randomseed(os.time())
	local r,m=0,0
	for i=1,num do
		r=math.random(1,w*h+1-i)
		m=0
		while r>0 do
			m=m+1
			if isInside(m,loc)==-1 then
				r=r-1
			end
		end
		loc[#loc+1]=m
	end
end
--获取数字
local function islm(x,y)
	if isInside(x*w+y+1,loc)==-1 then
		return false
	else
		return true
	end
end
local function getnum(p)
	local n=0
	for k=1,8 do
		if not(((p[2]==0)and(locx[k][2]==-1))or((p[2]==w-1)and(locx[k][2]==1))) then
			if islm(p[1]+locx[k][1],p[2]+locx[k][2]) then
				n=n+1
			end
		end
	end
	return n
end

--生成游戏
return function()
	if now==1 then
		if wi==wait then
			------------------------
			for i=1,w+2 do
				Block:setBlockAll(x0-2+i,y0,z0-1,ids2[6],2)
				Block:setBlockAll(x0-2+i,y0,z0+h,ids2[6],2)
			end
			for i=1,h+2 do
				Block:setBlockAll(x0-1,y0,z0-2+i,ids2[6],2)
				Block:setBlockAll(x0+w,y0,z0-2+i,ids2[6],2)
			end
			getloc()
			for i=0,w*h-1 do
				local p=ltp(i)
				Block:setBlockAll(x0+p[2],y0+1,z0+p[1],ids2[3],2)
				if isInside(i+1,loc)~=-1 then
					Block:setBlockAll(x0+p[2],y0,z0+p[1],ids2[2],2)
				else
					Block:setBlockAll(x0+p[2],y0,z0+p[1],ids[getnum(p)+1],2)
				end
			end
			------------------------
			Chat:sendSystemMsg("游戏已重新生成！")
			now=0
			wi=0
		else
			wi=wi+1
		end
	end
end