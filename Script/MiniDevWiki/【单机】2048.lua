--[[
Author: xixi_
Date: 2022-08-18 18:12:39
LastEditors: xixi_
LastEditTime: 2026-02-18 14:02:11
FilePath: /MiniWorldScript/Script/MiniDevWiki/2048.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

--左下右上与方块
local lbrt={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,13,9,5,1,14,10,6,2,15,11,7,3,16,12,8,4,4,3,2,1,8,7,6,5,12,11,10,9,16,15,14,13,1,5,9,13,2,6,10,14,3,7,11,15,4,8,12,16,}
local num={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,}
--方块id与按钮坐标
local id={3999,3998,3997,3996,3995,3994,3993,3992,3991,4000,3990,3989,}
local pos={0,11,2,0,10,1,0,11,0,0,12,1,0,10,7,}
local spos={0,15,7,0,15,6,0,15,5,0,15,4,0,14,7,0,14,6,0,14,5,0,14,4,0,13,7,0,13,6,0,13,5,0,13,4,0,12,7,0,12,6,0,12,5,0,12,4,}
--当前方向、是否正在进行、是否结束
local drct,ising,isend,has=0,0,0,0
local i,j,k=0,0,0
local score=0

--2048
local function Check()
	for i=1,16 do
		if num[i]==11 then
			isend=99999
		end
	end
	if isend==99999 then
		Chat:sendSystemMsg("恭喜！2048！")
		has=2
	end
end
--刷新
local function Re()
	for i=1,16 do
		if num[i]==0 then
			Block:replaceBlock(0,spos[i*3-2],spos[i*3-1],spos[i*3],0)
		else
			Block:replaceBlock(id[num[i]],spos[i*3-2],spos[i*3-1],spos[i*3],0)
		end
	end
	Chat:sendSystemMsg("游戏分数："..score)
	if has==1 then
		Check()
	end
end
--随机生成1个2/4
local function Add()
	math.randomseed(os.time())
	local z=0
	for i=1,16 do
		if num[i]==0 then
			z=z+1
		end
	end
	if z>0 then
		local r=math.random(1,z)
		for j=1,16 do
			if num[j]==0 then
				r=r-1
			end
			if r==0 then
				math.randomseed(os.time())
				num[j]=math.random(1,10)
				if num[j]<3 then
					num[j]=2
					score=score+4
				else
					num[j]=1
					score=score+2
				end
				r=-1
			end
		end
	end
	Re()
end
--四个数字的合并
local function Fin(num1,num2,num3,num4)
	local numr={0,0,0,0,}
	local m=1
	if num1~=0 then
		numr[m]=num1
		m=m+1
	elseif (num2~=0)or(num3~=0)or(num4~=0) then
		isend=1
	end
	if num2~=0 then
		numr[m]=num2
		m=m+1
	elseif (num3~=0)or(num4~=0) then
		isend=1
	end
	if num3~=0 then
		numr[m]=num3
		m=m+1
	elseif (num4~=0) then
		isend=1
	end
	if num4~=0 then
		numr[m]=num4
		m=m+1
	end
	if (numr[1]==numr[2])and(numr[1]~=0)and(numr[1]~=11) then
		numr[1]=numr[1]+1
		score=score+math.pow(2,numr[1])
		isend=1
		if (numr[3]==numr[4])and(numr[3]~=0)and(numr[3]~=11) then
			numr[2]=numr[3]+1
			score=score+math.pow(2,numr[2])
			isend=1
			numr[3]=0
			numr[4]=0
			return numr
		else
			numr[2]=numr[3]
			numr[3]=numr[4]
			numr[4]=0
			return numr
		end
	elseif (numr[2]==numr[3])and(numr[2]~=0)and(numr[2]~=11) then
		numr[2]=numr[2]+1
		score=score+math.pow(2,numr[2])
		isend=1
		numr[3]=numr[4]
		numr[4]=0
		return numr
	elseif (numr[3]==numr[4])and(numr[3]~=0)and(numr[3]~=11) then
		numr[3]=numr[3]+1
		score=score+math.pow(2,numr[3])
		isend=1
		numr[4]=0
		return numr
	else
		return numr
	end
end
--滑动
local function Move()
	isend=0
	if has==0 then
		isend=1
		has=1
	end
	for i=1,4 do
		local wn=(drct-1)*16+i*4
		local nw=Fin(num[lbrt[wn-3]],num[lbrt[wn-2]],num[lbrt[wn-1]],num[lbrt[wn]])
		for j=1,4 do
			num[lbrt[wn+j-4]]=nw[j]
		end
	end
	if isend==0 then
		Chat:sendSystemMsg("无法移动！当前分数："..score)
	else
		Add()
	end
end
--玩家点击按钮
Go=function(e)
	local x,y,z=math.floor(e['x']),math.floor(e['y']),math.floor(e['z'])
	if (x==pos[1])and(y==pos[2])and(z==pos[3]) then
		drct=1
		Move()
	elseif (x==pos[4])and(y==pos[5])and(z==pos[6]) then
		drct=2
		Move()
	elseif (x==pos[7])and(y==pos[8])and(z==pos[9]) then
		drct=3
		Move()
	elseif (x==pos[10])and(y==pos[11])and(z==pos[12]) then
		drct=4
		Move()
	elseif (x==pos[13])and(y==pos[14])and(z==pos[15]) then
		for i=1,16 do
			num[i]=0
		end
		has=0
		score=0
		Re()
	end
end
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=],Go)