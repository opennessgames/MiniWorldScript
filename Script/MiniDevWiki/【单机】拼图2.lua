--[[
Author: xixi_
Date: 2022-08-18 18:13:59
LastEditors: xixi_
LastEditTime: 2026-02-18 14:03:58
FilePath: /MiniWorldScript/Script/MiniDevWiki/拼图2.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

--方块id:部件，空白、刷新
local ids={3988,3987,3986,3985,3992,3991,3990,3989,3996,3995,3994,3993,4000,3999,3998,3984}
local ids2={3984,3983}
--音效id:刷新、移动、拼图完成
local mid={10948,10946,10947}
--游戏设定:拼图尺寸，空白位置
local w,h=4,4
local nlc,nl=16,0
--地图设定:拼图起点
local x0,y0,z0=0,7,0
-------------------------------
local cs={}
local i,j,k=0,0,0
local uid=0

--
local function check()
	local r,id=0,0
	for i=1,#ids do
		r,id=Block:getBlockID(x0+(i-1)%w,y0,z0-math.floor((i-1)/w))
		if id~=ids[i] then
			Player:playMusic(uid,mid[2],100,1,false)
			return
		end
	end
	Player:playMusic(uid,mid[3],100,1,false)
end

--玩家点击方块
Go=function(e)
	local x,y,z=math.floor(e['x']),math.floor(e['y']),math.floor(e['z'])
	local id=e['blockid']
	uid=e['eventobjid']
	local r2,item=Player:getCurToolID(uid)
	local dl=(z0-z)*w+(x-x0)+1
	local dn=math.abs(dl-nl)
	if item==ids2[2] then--刷新
		cs={}
		nl=nlc
		math.randomseed(os.time())
		local r,m=0,0
		for i=1,#ids-1 do
			r=math.random(1,#ids-i)
			m=0
			while r>0 do
				m=m+1
				if cs[m]==nil then
					r=r-1
				end
			end
			cs[m]=ids[i]
			Block:setBlockAll(x0+(m-1)%w,y0,z0-math.floor((m-1)/w),ids[i],2)
		end
		Block:setBlockAll(x0+w-1,y0,z0-h+1,ids2[1],0)
		Chat:sendSystemMsg("已重新生成")
		Player:playMusic(uid,mid[1],100,1,false)
	elseif (x>=x0)and(x<x0+w)and(y==y0)and(z<=z0)and(z>z0-h)and((dn==1)or(dn==w)) then--移动
		Block:setBlockAll(x0+(nl-1)%w,y0,z0-math.floor((nl-1)/w),id,2)
		Block:setBlockAll(x0+(dl-1)%w,y0,z0-math.floor((dl-1)/w),ids2[1],2)
		nl=dl
		check()
	end
end
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=],Go)