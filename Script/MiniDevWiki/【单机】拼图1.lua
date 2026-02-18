--[[
Author: xixi_
Date: 2022-08-18 18:13:49
LastEditors: xixi_
LastEditTime: 2026-02-18 14:04:26
FilePath: /MiniWorldScript/Script/MiniDevWiki/拼图1.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

--方块id:部件，白、绿、红、空白
local ids={3988,3987,3986,3985,3992,3991,3990,3989,3996,3995,3994,3993,4000,3999,3998,3997}
local ids2={667,680,681,3984}
--音效id:移出、正确、错误、拼图完成
local mid={10946,10945,10949,10947}
--游戏设定:部件数量
local num=16
--地图设定:放置坐标，反馈坐标
local pos={{2,7,0},{3,7,0},{4,7,0},{5,7,0},{2,7,-1},{3,7,-1},{4,7,-1},{5,7,-1},{2,7,-2},{3,7,-2},{4,7,-2},{5,7,-2},{2,7,-3},{3,7,-3},{4,7,-3},{5,7,-3}}
local pos2={{2,10,1},{3,10,1},{4,10,1},{5,10,1},{2,9,1},{3,9,1},{4,9,1},{5,9,1},{2,8,1},{3,8,1},{4,8,1},{5,8,1},{2,7,1},{3,7,1},{4,7,1},{5,7,1}}
----------------
local co=0--计数

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


--玩家点击方块
Go=function(e)
	local x,y,z=math.floor(e['x']),math.floor(e['y']),math.floor(e['z'])
	local id=e['blockid']
	local r,item=Player:getCurToolID(e['eventobjid'])
	local a,b,c=isInside2({x,y,z},pos),isInside(item,ids),isInside(id,ids)
	if a~=-1 then
		if id~=ids2[4] then
			Block:setBlockAll(x,y,z,ids2[4],0)
			Player:gainItems(e['eventobjid'],id,1,1)
			Block:setBlockAll(pos2[a][1],pos2[a][2],pos2[a][3],ids2[1],0)
			Player:playMusic(e["eventobjid"],mid[1],100,1,false)
			if a==c then
				co=co-1
			end
		elseif b~=-1 then
			Player:onCurToolUsed(e['eventobjid'],1)
			Block:setBlockAll(x,y,z,item,2)
			if b==a then
				Block:setBlockAll(pos2[a][1],pos2[a][2],pos2[a][3],ids2[2],0)
				co=co+1
				if co==num then
					Player:playMusic(e["eventobjid"],mid[4],100,1,false)
				else
					Player:playMusic(e["eventobjid"],mid[2],100,1,false)
				end
			else
				Block:setBlockAll(pos2[a][1],pos2[a][2],pos2[a][3],ids2[3],0)
				Player:playMusic(e["eventobjid"],mid[3],100,1,false)
			end
		end
	end
end
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=],Go)