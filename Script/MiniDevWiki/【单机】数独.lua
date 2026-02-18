--[[
Author: xixi_
Date: 2022-08-18 18:13:13
LastEditors: xixi_
LastEditTime: 2026-02-18 14:06:48
FilePath: /MiniWorldScript/Script/MiniDevWiki/数独.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

----------------
----预置方法----
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
---------------------------------------------------------------------------
---------------------------------------------------------------------------
local num={}
--填充是否有效
local function isRowLegal(i,v)
	local row,i1=math.floor(i/9),0
	for i1=0,8 do
		if (v==num[row*9+i1])and(i~=row*9+i1) then
			return false
		end
	end
	return true
end
local function isColLegal(i,v)
	local col,i1=i%9,0
	for i1=0,8 do
		if (v==num[i1*9+col])and(i~=i1*9+col) then
			return false
		end
	end
	return true
end
local function isSubLegal(i,v)
	local row=math.floor(i/9)
	local col=i%9
	local x1=math.floor(row/3)*3
	local y1=math.floor(col/3)*3
	local i1,i2=0,0
	for i1=0,2 do
		for i2=0,2 do
			if (v==num[(x1+i1)*9+y1+i2])and(i~=(x1+i1)*9+y1+i2) then
				return false
			end
		end
	end
	return true
end
local function isLegal(i,v)
	if (not(isRowLegal(i,v)))or(not(isColLegal(i,v)))or(not(isSubLegal(i,v))) then
		return false
	end
	return true
end
--递归填充数字
local function setN(i)
	if i==81 then
		return true
	elseif num[i]~=0 then
		return setN(i+1)
	else
		local randOrder,i1={},0
		for i1=0,9 do
			randOrder[i1]=i1
		end
		for i1=1,9 do
			local r=math.random(0,9)
			local t1=randOrder[r]
			randOrder[r]=randOrder[i1]
			randOrder[i1]=t1
		end
		for i1=1,9 do
			if isLegal(i,randOrder[i1]) then
				num[i]=randOrder[i1]
				if setN(i+1) then
					return true
				end
			end
		end
	end
	num[i]=0
	return false
end
--获取随机数独
local function getNum()
	math.randomseed(os.time())
	local i1=0
	for i1=0,80 do
		num[i1]=0
	end
	setN(0)
	return num
end
---------------------------------------------------------------------------
---------------------------------------------------------------------------
--方块id:黑1-9，灰1-9，红1-9，橡皮、橡皮选中、重新生成、答案
local ids_b={3990,3989,3988,3987,3986,3985,3984,3983,3982}
local ids_g={3972,3971,3970,3969,3968,3967,3966,3965,3964}
local ids_r={3981,3980,3979,3978,3977,3976,3975,3974,3973}
local ids2={3963,3962,3961,3960}
--音效id:重新生成、选中/填写/擦除、出错、查看答案/填写完成
local mid={10948,10946,10949,10947}
--地图设定:起点坐标
local x0,y0,z0=1,8,1
--游戏设定:显示概率
local p,pel=0.3,100000
--------------------------------------------
local nums,cl={},{}--9×9
local now,xn,yn,zn=0,0,0,0--当前选中 1-9:1-9 10:橡皮
local uid=0
local j1,j2=0,0
local ed=0


--检查填入数字
local function check()
	local co=0
	for j1=0,80 do
		if num[j1]~=0 then
			if isLegal(j1,num[j1]) then
				co=co+1
				if cl[j1]==0 then
					Block:setBlockAll(x0+j1%9,y0,z0+math.floor(j1/9),ids_g[num[j1]],2)
				else
					Block:setBlockAll(x0+j1%9,y0,z0+math.floor(j1/9),ids_b[num[j1]],2)
				end
			else
				Block:setBlockAll(x0+j1%9,y0,z0+math.floor(j1/9),ids_r[num[j1]],2)
			end
		end
	end
	if co==81 then
		Player:playMusic(uid,mid[4],100,1,false)
	end
end

--玩家点击方块
Go=function(e)
	local x,y,z=math.floor(e['x']),math.floor(e['y']),math.floor(e['z'])
	local id=e['blockid']
	uid=e['eventobjid']
	local r2,item=Player:getCurToolID(uid)
	local n,ch=isInside(item,ids_b),isInside(id,ids_b)
	local loc=(z-z0)*9+(x-x0)
	local r3,id2=Block:getBlockID(x,y+1,z)
	if (item==ids2[3])or(id==ids2[3]) then--重新生成
		getNum()
		for j1=0,80 do
			nums[j1]=num[j1]
		end
		cl={}
		for j1=0,80 do
			j2=math.random(1,pel)
			if j2<=p*pel then
				cl[j1]=nums[j1]
				--num[j1]=0---
				Block:setBlockAll(x0+j1%9,y0,z0+math.floor(j1/9),ids_b[nums[j1]],2)
			else
				cl[j1]=0
				num[j1]=0---
				Block:setBlockAll(x0+j1%9,y0,z0+math.floor(j1/9),0,2)
			end
		end
		ed=1
		Player:playMusic(uid,mid[1],100,1,false)
	elseif ((item==ids2[4])or(id==ids2[4]))and(#nums>0) then--显示答案
		if ed==0 then
			return
		end
		for j1=0,80 do
			num[j1]=nums[j1]
			if cl[j1]==0 then
				Block:setBlockAll(x0+j1%9,y0,z0+math.floor(j1/9),ids_g[nums[j1]],2)
			else
				Block:setBlockAll(x0+j1%9,y0,z0+math.floor(j1/9),ids_b[nums[j1]],2)
			end
		end
		Player:playMusic(uid,mid[4],100,1,false)
	elseif (y==y0-1)and(x-x0>-1)and(x-x0<9)and(z-z0>-1)and(z-z0<9)and(id2==0) then--填写
		if ed==0 then
			return
		end
		if n~=-1 then--填入手持数字
			if isLegal(loc,n) then
				Player:playMusic(uid,mid[2],100,1,false)
			else
				Player:playMusic(uid,mid[3],100,1,false)
			end
			num[loc]=n---
			check()---
		elseif (now>0)and(now<10) then--填入选中数字
			if isLegal(loc,now) then
				Player:playMusic(uid,mid[2],100,1,false)
			else
				Player:playMusic(uid,mid[3],100,1,false)
			end
			num[loc]=now---
			check()---
		end
	elseif ((x-x0>-1)and(x-x0<9)and(z-z0>-1)and(z-z0<9))and(((y==y0)and(cl[loc]==0))or((y==y0-1)and(isInside(id2,ids_g)~=-1))) then--擦除
		if ed==0 then
			return
		end
		if (item==ids2[1])or(now==10) then
			num[loc]=0---
			Block:setBlockAll(x,y0,z,0,0)
			Player:playMusic(uid,mid[2],100,1,false)
			check()---
		end
	elseif (not((y==y0)and(x-x0>-1)and(x-x0<9)and(z-z0>-1)and(z-z0<9)))and(ch~=-1) then--选中数字
		if now==10 then
			Block:setBlockAll(xn,yn,zn,ids2[1],2)
		elseif now~=0 then
			Block:setBlockAll(xn,yn,zn,ids_b[now],2)
		end
		xn=x
		yn=y
		zn=z
		now=ch
		Block:setBlockAll(xn,yn,zn,ids_r[now],2)
		Player:playMusic(uid,mid[2],100,1,false)
	elseif id==ids2[1] then--选中橡皮
		if (now~=0)and(now~=10) then
			Block:setBlockAll(xn,yn,zn,ids_b[now],2)
		end
		xn=x
		yn=y
		zn=z
		now=10
		Block:setBlockAll(xn,yn,zn,ids2[2],2)
		Player:playMusic(uid,mid[2],100,1,false)
	end
end
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=],Go)