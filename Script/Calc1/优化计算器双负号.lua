--[[
Author: xixi_
Date: 202?-??-?? ??:??:??
LastEditors: xixi_
LastEditTime: 2026-02-18 14:36:43
FilePath: /MiniWorldScript/Script/Calc1/优化计算器双负号.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

-- 作者:韩永旗
-- 迷你号247312290
-- 作品[HEX]简易计算机
--修复:双重负号，七位运算,数字琴
--方块id:0-9，+-*/，清除，等号, 音乐
local ids1={4000,3999,3998,3997,3996,3995,3994,3993,3992,3991}
local ids2={3990,3989,3988,3986,3987,3985}
local mid={10948,10946,10949,10947}
--------------------------------------------
local num,a,b,c,d,s=0,0,0,0,7,0
local m1,n1,m2,n2,mt,nt,s1,s2,st=0,0,0,0,0,0,0,0,0
local k,j,i,a1,b1,at,bt=0,0,0,0,0,0,0

--清除
local function clear ()
 for i=1,7 do 
  Block:setBlockAll(0,17,i,0,0)
  Block:setBlockAll(0,15,i,0,0)
  Block:setBlockAll(0,13,i,0,0)
  Block:setBlockAll(0,17,-i,0,0)
  Block:setBlockAll(0,15,-i,0,0)
  Block:setBlockAll(0,13,-i,0,0)
  Block:setBlockAll(0,13+i,0,0,0)
 end
 Block:setBlockAll(0,13,0,0,0)
 Block:setBlockAll(0,17,1,ids1[1],0)
 Block:setBlockAll(0,15,1,ids1[1],0)
 Block:setBlockAll(0,13,1,ids1[1],0)
 
i=7
local result,ida=Block:getBlockID(0,17,i)
repeat
   Block:setBlockAll(0,17,i,0,0)
    i = i + 1
   local result,ida=Block:getBlockID(0,17,i)
   local result,ida1=Block:getBlockID(0,17,i+1)
until( ida==0 and ida1==0)
i=7
local result,idb=Block:getBlockID(0,15,i)
repeat
   Block:setBlockAll(0,17,i,0,0)
     i = i + 1
   local result,idb=Block:getBlockID(0,15,i) 
   local result,idb1=Block:getBlockID(0,15,i+1)
until( idb==0 and idb1==0)
i=7
local result,ids=Block:getBlockID(0,13,i)  
repeat
   Block:setBlockAll(0,13,i,0,0)
    i = i + 1
   local result,ids=Block:getBlockID(0,13,i)
   local result,ids1=Block:getBlockID(0,13,i+1)  
until( ids==0 and ids1==0 )

end
--赋值
local function adda()
  --a=10*a+c
  --for i=a1, 1,-1 do
   -- local result,id3=Block:getBlockID(0,17,i)
   -- Block:setBlockAll(0,17,i+1,id3,0)
    --end
  --Block:setBlockAll(0,17,1,4000-c,0)
at=a
  if  at<0   then
  at=-at
  --Block:setBlockAll(0,13,4+d,3989,0)   --负值
  end
local m1,m2 = math.modf(at)
    i=0
 while m1>=1  do
    i=i+1
    mt=math.floor(m1%10)
    m1 = math.floor(m1/10)
    Block:setBlockAll(0,17,i,ids1[mt+1],0)--取整数
end
if a<0 then 
Block:setBlockAll(0,17,i+2,ids2[2],0)--取整数
end

if  0<m2   then
  Block:setBlockAll(0,17,0,3969,0)  --小数点
for i=1,6  do
  m2 = m2*10
  mt=math.floor(m2%10)
  Block:setBlockAll(0,17,-i,ids1[mt+1],0)--取小数
end
end
end
--赋值
local function addb()
 -- b=10*b+c
 -- for i=b1, 1,-1 do
   -- local result,id4=Block:getBlockID(0,15,i)
   -- Block:setBlockAll(0,15,i+1,id4,0)
   -- end
 -- Block:setBlockAll(0,15,1,4000-c,0)
bt=b
 if  bt<0   then
  bt=-bt
  --Block:setBlockAll(0,13,4+d,3989,0)   --负值
  end
 local n1,n2 = math.modf(bt)
    i=0
 while n1>=1  do
    i=i+1
    nt=math.floor(n1%10)
    n1 = math.floor(n1/10)
    Block:setBlockAll(0,15,i,ids1[nt+1],0)--取整数
 end
 if b<0 then 
 Block:setBlockAll(0,15,i+2,ids2[2],0)--取整数
 end

 if  0<n2   then
  Block:setBlockAll(0,15,0,3969,0)  --小数点
 for i=1,6  do
  n2 = n2*10
  nt=math.floor(n2%10)
  Block:setBlockAll(0,15,-i,ids1[nt+1],0)--取小数
 end
 end
end
local function adds ()
st=s
 if  st<0   then
  st=-st
  --Block:setBlockAll(0,13,4+d,3989,0)   --负值
  end
local s1 , s2 = math.modf(st )
--for i=1,d+3  do
  --t1=math.floor(s1%10)
  --s1 = math.floor(s1/10)
  --Block:setBlockAll(0,13,i,4000-t1,0)--取整数
--end
    i=0
 while s1>=1  do
    i=i+1
    st=math.floor(s1%10)
    s1 = math.floor(s1/10)
    Block:setBlockAll(0,13,i,ids1[st+1],0)--取整数
end
if s<0 then 
Block:setBlockAll(0,13,i+2,ids2[2],0)--取整数
end
if  0<s2   then
  Block:setBlockAll(0,13,0,3969,0)  --小数点
for i=1,6  do
  s2 = s2*10
  st=math.floor(s2%10)
  Block:setBlockAll(0,13,-i,ids1[st+1],0)--取小数
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
Chat:sendSystemMsg("——————————————————")
j=0
adds()
end
--检查填入数字

--玩家点击方块
Go=function(e)
	local x,y,z=math.floor(e['x']),math.floor(e['y']),math.floor(e['z'])
	local id=e['blockid']
    uid=e['eventobjid']

--local r3,item:getitemName (id)
     if (y>=8)and(y<=11)and(z>=1)and(z<=4)and(x==0) then--键盘
	    
        if id==ids2[5] then--清除
           Player:playMusic(uid,mid[2],100,1,false)
            num,a,b,c,d,s=0,0,0,0,4,0
            m1,n1,m2,n2,mt,nt,s1,s2,st=0,0,0,0,0,0,0,0,0
            k,j,i,a1,b1,at,bt=0,0,0,0,0,0,0
            clear()
            Chat:sendSystemMsg("已清除")
            Chat:sendSystemMsg("——————————————————")

           
		elseif id==ids2[6] and k==0  then  --等号
               if b==0 and j==3 then
                Player:playMusic(uid,mid[3],100,1,false)
                 Chat:sendSystemMsg("除数不能为零")
                 Chat:sendSystemMsg("否则系统出现故障")
               elseif j==0   then
     Player:playMusic(uid,mid[3],100,1,false)        
Chat:sendSystemMsg("请输入运算符号")
              else
               Block:setBlockAll(0,14,0,ids2[6],0)
               Player:playMusic(uid,mid[1],100,1,false)
               k,a1,b1=1,5,5
               sum()
--Chat:sendSystemMsg("请填入运算符号")

end
--Block:setBlockAll(0,14,0,ids2[6],0)
         --      Player:playMusic(uid,mid[1],100,1,false)
          --     k,a1,b1=1,5,5
       --        sum()
	    elseif  (id ==ids1[1])or(id==ids1[2])or(id==ids1[3])or(id==ids1[4])or(id==ids1[5])or(id==ids1[6])or(id==ids1[7])or(id==ids1[8])or(id==ids1[9])or(id==ids1[10])  then--获取数值
		        c=4000-id
             if k==1 and a1==5 and b1==5  then
               num,a,b,d,s=0,0,0,7,0
               m1,n1,m2,n2,mt,nt,s1,s2,st=0,0,0,0,0,0,0,0,0
               k,j,i,a1,b1,at,bt=0,0,0,0,0,0,0
               clear()              
             end
            
             if  a1<d and j==0  then
                a=10*a+c
                a1=a1+1
Chat:sendSystemMsg(c)
Player:playMusic(uid,mid[1],100,1,false)
		
               adda()
             elseif  j~=0 and b1<d then
               b=10*b+c
               b1=b1+1
Chat:sendSystemMsg(c)
Player:playMusic(uid,mid[2],100,1,false)
		       addb()
             else   
Chat:sendSystemMsg("目前支持"..d.. "位运算")
Player:playMusic(uid,mid[3],100,1,false)

		     end
 
        elseif  (id ==ids2[1])or(id==ids2[2])or(id==ids2[3])or(id==ids2[4]) then
             if k==1 and a1==5 then
                a,b,b1,k=s,0,0,0
                clear()
                adda()
             end
                              
             if id ==ids2[1] then
               j=1
Chat:sendSystemMsg("+")
Player:playMusic(uid,mid[4],100,1,false)
             elseif id ==ids2[2]  then 
               j=2
Player:playMusic(uid,mid[4],100,1,false)
Chat:sendSystemMsg("-")
             elseif id ==ids2[3]  then 
             --  if a~=0  then
                 j=3
Player:playMusic(uid,mid[4],100,1,false)
Chat:sendSystemMsg("/")
           --    else
-- Player:playMusic(uid,mid[3],100,1,false)

            --   Chat:sendSystemMsg("被除数不能为零")
            --   end

             elseif id ==ids2[4]  then 
               j=4
Player:playMusic(uid,mid[4],100,1,false)
Chat:sendSystemMsg("*")
             end
            Block:setBlockAll(0,16,0,ids2[j],0)
            
        end
--Player:playMusic(uid,mid[4],100,1,false)

            
        
      end
 end
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=],Go)