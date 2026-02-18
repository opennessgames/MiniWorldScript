--[[
Author: xixi_
Date: 202?-??-?? ??:??:??
LastEditors: xixi_
LastEditTime: 2026-02-18 14:36:19
FilePath: /MiniWorldScript/Script/Calc1/简易计算器.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

--方块id:0-9，+-*/=
local ids1={4000,3999,3998,3997,3996,3995,3994,3993,3992,3991}
local ids2={3990,3989,3988,3986,3987,3985}
local mid={10948,10946,10949,10947}
--------------------------------------------
local num,a,b,c,s=0,0,0,0,0
local d=3
local j,i,a1,b1=0,0,0,0

--清除
local function clear ()
 for i=1,d do 
  Block:setBlockAll(0,17,i,4000,0)
 end
 for i=1,d do
  Block:setBlockAll(0,15,i,4000,0)
 end
for i=1,4 do
  Block:setBlockAll(0,13,i,4000,0)
 end
for i=0,3 do
  Block:setBlockAll(0,13,-i,0,0)
end
Block:setBlockAll(0,13,7,0,0)
Block:setBlockAll(0,13,6,0,0)
 Block:setBlockAll(0,13,5,0,0)
 a,b,c,s=0,0,0,0
 a1,b1,num,j=0,0,0,0,0
Block:setBlockAll(0,14,0,0,0)
Block:setBlockAll(0,16,0,0,0)
Chat:sendSystemMsg("已清除")
Chat:sendSystemMsg("——————————————————")
end
--赋值
local function adda()
  a=10*a+c
  for i=a1, 1,-1 do
    local result,id3=Block:getBlockID(0,17,i)
    Block:setBlockAll(0,17,i+1,id3,0)
    end
  Block:setBlockAll(0,17,1,4000-c,0)
end
--赋值
local function addb()
  b=10*b+c
  for i=b1, 1,-1 do
    local result,id4=Block:getBlockID(0,15,i)
    Block:setBlockAll(0,15,i+1,id4,0)
    end
  Block:setBlockAll(0,15,1,4000-c,0)
end
local function adds ()
 if  s<0   then
  s=-s
  Block:setBlockAll(0,13,4+d,3989,0)   --负值
  end
local s1 , s2 = math.modf(s )
for i=1,d+3  do
  t1=math.floor(s1%10)
  s1 = math.floor(s1/10)
  Block:setBlockAll(0,13,i,4000-t1,0)--取整数
end
if  0<s2   then
  Block:setBlockAll(0,13,0,3969,0)  --小数点
for i=1,3  do
  s2 = s2*10
  t2=math.floor(s2%10)
  Block:setBlockAll(0,13,-i,4000-t2,0)--取小数
end
end
end
  --等号
local function sum ()
Chat:sendSystemMsg("——————————————————")
Chat:sendSystemMsg("数值等于")
Chat:sendSystemMsg(a)
   if (j==1) or(j==0) then
     s=a+b
Chat:sendSystemMsg("+")
   elseif j==2 then
     s=a-b
Chat:sendSystemMsg("-")
   elseif j==3 then
     s=a/b
--s=string.format("%.2f",s)
Chat:sendSystemMsg("/")
   elseif j==4 then
     s=a*b
Chat:sendSystemMsg("*")
   end
Chat:sendSystemMsg(b)
--Chat:sendSystemMsg("数值等于"..s)
Chat:sendSystemMsg("=")
-- r=string.format("%.2f",s)
Chat:sendSystemMsg(s)
a=s
b=0
a1=3
b1=0
j=0
adds()
end
--检查填入数字


--玩家点击方块
Go=function(e)
	local x,y,z=math.floor(e['x']),math.floor(e['y']),math.floor(e['z'])
	local id=e['blockid']
uid=e['eventobjid']
--获取玩家昵称，参数为玩家id或玩家迷你号，0是房主
 --  local result,name=Block:getBlockname(id)
--在聊天框显示
--Chat:sendSystemMsg("房主的昵称为：")

--local r3,item:getitemName (id)
   if (y>=8)and(y<=11)and(z>=1)and(z<=4)and(x==0) then--键盘
	    if id==ids2[5] then--清除
a1, b1=4, 4
Player:playMusic(uid,mid[2],100,1,false)

		   clear()
		elseif id==ids2[6] then  --等号
  Block:setBlockAll(0,14,0,ids2[6],0)
Player:playMusic(uid,mid[1],100,1,false)

           sum()

	    elseif  (id ==ids1[1])or(id==ids1[2])or(id==ids1[3])or(id==ids1[4])or(id==ids1[5])or(id==ids1[6])or(id==ids1[7])or(id==ids1[8])or(id==ids1[9])or(id==ids1[10])  then--获取数值
		     num=4000-id
        c=num
             if  a1<d and j==0  then     
               a1=a1+1
--Chat:sendSystemMsg(num)
Player:playMusic(uid,mid[1],100,1,false)
		
               adda()
              elseif  j>0 and b1<d then
               b1=b1+1
--Chat:sendSystemMsg(num)
Player:playMusic(uid,mid[2],100,1,false)
		
              addb()
   else   
Chat:sendSystemMsg(d.. "位计算器")
Player:playMusic(uid,mid[3],100,1,false)

		      end
 
        elseif  j==0  then
             if id ==ids2[1] then
               j=1
--Chat:sendSystemMsg("+")
             elseif id ==ids2[2]  then 
               j=2
--Chat:sendSystemMsg("-")
             elseif id ==ids2[3]  and a~=0 then 
               j=3
--Chat:sendSystemMsg("/")
             elseif id ==ids2[4]  then 
               j=4
--Chat:sendSystemMsg("*")
             end
            Block:setBlockAll(0,16,0,id,0)
for i=1,3 do
  Block:setBlockAll(0,15,i,4000,0)
 end
Player:playMusic(uid,mid[4],100,1,false)

            
        end
    end
end
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=],Go)