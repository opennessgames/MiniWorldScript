--[[
Author: xixi_
Date: 2021-8-23 19:40:10
LastEditors: xixi_
LastEditTime: 2026-02-17 14:51:36
FilePath: /MiniWorldScript/script/Typewriter/打字机脚本4打字机.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]] 

--坐标：
local x0,y0,z0=-64,7,63--打字起点
------------------
--数据：
local size,wid,max=16,8,64--打字边长，每行字数，最多个数
local zt=0--当前状态：0空 n正在打第n个字
local str,ln="",0--需要打的字符串，字符串总长
------------------
--传入汉字和序号：在该序号位置打印汉字
local HX={["0"]="0000",["1"]="0001",["2"]="0010",["3"]="0011",["4"]="0100",["5"]="0101",["6"]="0110",["7"]="0111",["8"]="1000",["9"]="1001",["a"]="1010",["b"]="1011",["c"]="1100",["d"]="1101",["e"]="1110",["f"]="1111"}
local function prt(s,n)
	local sh=_G.b[s]
	if sh==nil then
		sh=_G.t[s]
		if sh==nil then
			sh="000000000000000000000000000000000000000000000000000000000000"
		end
	end
	local x1,z1=(n-1)%wid,math.floor((n-1)/wid)
	local x2,z2=x0+x1*size,z0-z1*size
	local i,j,ss=0,0,""
	for i=1,_G.len(sh) do
		ss=HX[_G.sub(sh,i,i)]
		for j=1,4 do
			x1=(i-1)%4*4+j-1
			z1=math.floor((i-1)/4)
			if _G.sub(ss,j,j)=="1" then
				Block:setBlockAll(x2+x1,y0,z2-z1,1,0)
			else
				Block:destroyBlock(x2+x1,y0,z2-z1,false)
			end
		end
	end
end
------------------
--玩家发送聊天消息
local function smg(e)
	local p,s=e.eventobjid,e.content
	if zt==0 then
		str=s
		ln=_G.len(s)
		if ln>max then
			str=_G.sub(s,1,max)
			ln=max
		end
		zt=1
	end
end
ScriptSupportEvent:registerEvent('Player.NewInputContent',smg)
--游戏运行中
local function run()
	if zt>0 and zt<ln+1 then
		prt(_G.sub(str,zt,zt),zt)
		zt=zt+1
	elseif zt~=0 then
		zt=0
	end
end
ScriptSupportEvent:registerEvent('Game.Run',run)