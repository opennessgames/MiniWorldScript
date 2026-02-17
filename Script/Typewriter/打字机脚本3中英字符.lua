--[[
Author: xixi_
Date: 2021-8-23 19:40:10
LastEditors: xixi_
LastEditTime: 2026-02-17 14:51:26
FilePath: /MiniWorldScript/script/Typewriter/打字机脚本3中英字符.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]] 

--len获取中英混合UTF8字符串的真实字符数量
--sub截取中英混合的UTF8字符串，endIndex可缺省
local function subyt(str,index)
	local curByte=string.byte(str,index)
	local byteCount=1;
	if curByte == nil then
		byteCount=0
	elseif curByte>0 and curByte <= 127 then
		byteCount=1
	elseif curByte>=192 and curByte<=223 then
		byteCount=2
	elseif curByte>=224 and curByte<=239 then
		byteCount=3
	elseif curByte>=240 and curByte<=247 then
		byteCount=4
	end
	return byteCount;
end
local function subin(str,index)
	local curIndex=0;
	local i=1;
	local lastCount=1;
	repeat 
		lastCount=subyt(str,i)
		i=i+lastCount;
		curIndex=curIndex+1;
	until(curIndex >= index);
	return i-lastCount;
end
_G.len=function(str)
	local curIndex=0;
	local i=1;
	local lastCount=1;
	repeat 
		lastCount=subyt(str,i)
		i=i+lastCount;
		curIndex=curIndex+1;
	until(lastCount == 0);
	return curIndex-1;
end
_G.sub=function(str,startIndex,endIndex)
	if startIndex<0 then
		startIndex=len(str)+startIndex+1;
	end
	if endIndex ~= nil and endIndex<0 then
		endIndex=len(str)+endIndex+1;
	end
	if endIndex == nil then 
		return string.sub(str,subin(str,startIndex));
	else
		return string.sub(str,subin(str,startIndex),subin(str,endIndex+1)-1);
	end
end