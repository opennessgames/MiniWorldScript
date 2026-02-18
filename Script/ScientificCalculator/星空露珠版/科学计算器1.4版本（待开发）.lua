--[[
Author: xixi_
Date: 2021-7-19 ??:??:??
LastEditors: xixi_
LastEditTime: 2026-02-18 14:28:54
FilePath: /MiniWorldScript/Script/ScientificCalculator/科学计算器1.4版本（待开发）.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

--[[
科学计算器
作者:韩永旗
迷你号:247312290
"-----------------------------------------"
0.1 创建科学计算UI界面
0.2 创建UI界面触发器
0.3 创建按钮
0.4  2021.7.19.星期一
功能
1.支持小数混和"+-×÷"混和运算
2.支持一键清除
3.防止连续错误输出

bug
  1.等号"="后,"="没有清空,赋值,导致进入新一轮叠加运算   √
  2.等号"="后,"+,-,×,÷"没有赋值，清空,导致不能连续运算   √
  3.等号"="后,"0123456789"".",导致没有清空，赋值    √
  4.没有一个一个退格清除键
  5.没有加入错误提醒                                √
  6.网络时间因触发器计时器变化一秒,导致误差1秒

"-----------------------------------------"
0.5  2021.7.20星期二
   1.加入"("")"运算,
   2.优化算法
   3.加入提示
]]

 T={"星期日","星期一","星期二","星期三","星期四","星期五","星期六",}
--界面端
 A={
  ["6985055414249172898_48"]="普通",["6985055414249172898_45"]="科学",
  ["6985055414249172898_53"]="lnv",["6985055414249172898_61"]="lnv^-1",
  ["6985055414249172898_104"]="输入",["6985055414249172898_106"]="输出",
  ["6985055414249172898_37"]="清除",
  }
   
--数字端
 B={
  ["6985055414249172898_1"]=1,["6985055414249172898_6"]=2,["6985055414249172898_9"]=3,
  ["6985055414249172898_11"]=4,["6985055414249172898_13"]=5,["6985055414249172898_15"]=6,
  ["6985055414249172898_17"]=7,["6985055414249172898_19"]=8,["6985055414249172898_21"]=9,
  ["6985055414249172898_23"]=0,["6985055414249172898_43"]=".",
  }
  
  --运算符号
   C={
    ["6985055414249172898_25"]="+",["6985055414249172898_27"]="-",["6985055414249172898_29"]="×",
    ["6985055414249172898_31"]="÷",
    ["6985055414249172898_33"]="=",
    }
  --科学运算
   D={["6985055414249172898_87"]="(",["6985055414249172898_85"]=")",
    ["6985055414249172898_101"]="%",["6985055414249172898_81"]="x! ",["6985055414249172898_51"]="π",
    ["6985055414249172898_79"]="e",["6985055414249172898_83"]="x^-1",["6985055414249172898_89"]="x^2",
    ["6985055414249172898_91"]="x^3",["6985055414249172898_93"]="x^y",["6985055414249172898_95"]="√",
    ["6985055414249172898_97"]="3√",["6985055414249172898_77"]="y√x",["6985055414249172898_99"]="rad",
    ["6985055414249172898_71"]="ln",["6985055414249172898_69"]="e^x",["6985055414249172898_73"]="log",
    ["6985055414249172898_75"]="10^x",["6985055414249172898_55"]="sin",["6985055414249172898_57"]="cos",
    ["6985055414249172898_59"]="tan",["6985055414249172898_63"]="sin^-1",["6985055414249172898_65"]="cos^-1",
    ["6985055414249172898_67"]="tan^-1",["6985055414249172898_99"]="deg",

    }
T1={"","错误101:运算公式出现错误","错误102:运算式除数为零","错误103:按键错误","错误104:公式不完整",}
 --UI界面测试版
 local a,b,c={},{},{}
 local t="0"
 local res=""
 local t1=""
 local l,p,n,k,f,y=0,0,1,0,0,0
 local a={0,0,0,0,0,0,0,0,0}
 local b={0,0,0,0,0,0,0,0,0}
 local c={}
 local s=0
 local s0=0
 local o=1
local result = VarLib2:setGlobalVarByName(3,"字体大小",70-#t/4)
local result = VarLib2:setGlobalVarByName(4,"输入",t)
local result = VarLib2:setGlobalVarByName(4,"输出",s)  
local result = VarLib2:setGlobalVarByName(4,"错误提示",T1[o])
local timeTable = os.date("*t", timeInterval)
local result = VarLib2:setGlobalVarByName(4,"时间", timeTable.year .. "年" .. timeTable.month .. "月" .. timeTable.day .. "日"..T[timeTable.wday] .. timeTable.hour .. ":" .. timeTable.min .. ":" .. timeTable.sec)

local function add4()
  a,b,c={},{},{}
  t="0"
  s,l,p,n,k,f=0,0,0,1,0,0
  a={0,0,0,0,0,0,0,0,0,}
  b={0,0,0,0,0,0,0,0,0,}
  c={}
  s=0
end
local function add5()
local result = VarLib2:setGlobalVarByName(3,"字体大小",70-#t/4)
 local result = VarLib2:setGlobalVarByName(4,"输入",t)
 local result = VarLib2:setGlobalVarByName(4,"错误提示",T1[o])
 local result = VarLib2:setGlobalVarByName(4,"输出",s)
end

local function add3()
 s=0
if n==1 then s=a[n]  t=t.."="
else
if b[n]~=0 and a[n]==0 then t=t.."0"  end
t=t.."="
 for i= 1,n do
  if b[i]==1  then
    if b[i+1]==1 or b[i+1]==2 or b[i+1]==0 then s=a[i]+a[i+1] a[i+1]=s 
    elseif b[i+1]==3 and b[i+1]~=0  then s=a[i+1]*a[i+2]   a[i+1]=a[i]   a[i+2]=s  b[i+1]=b[i]
    elseif b[i+1]==4 and b[i+1]~=0 then if a[i+2]~=0 then s=a[i+1]/a[i+2] a[i+1]=a[i]   a[i+2]=s  b[i+1]=1 else  o=3  y=0 local result = VarLib2:setGlobalVarByName(4,"错误提示",T1[o]) add4() add5() return    end end
  elseif b[i]==2 then
   if b[i+1]==1 or b[i+1]==2 or b[i+1]==0  then s=a[i]-a[i+1] a[i+1]=s
    elseif b[i+1]==3 and b[i+1]~=0  then s=a[i+1]*a[i+2] a[i+1]=a[i]   a[i+2]=s  b[i+1]=b[i]
    elseif b[i+1]==4 and b[i+1]~=0  then if a[i+2]~=0 then s=a[i+1]/a[i+2] a[i+1]=a[i]   a[i+2]=s  b[i+1]=2 else  o=3  y=0 local result = VarLib2:setGlobalVarByName(4,"错误提示",T1[o]) add4() add5() return    end end
  elseif b[i]==3  then s=a[i]*a[i+1] a[i+1]=s 
  elseif b[i]==4  then if a[i+1]~=0 then s=a[i]/a[i+1]  a[i+1]=s else o=3  y=0  local result = VarLib2:setGlobalVarByName(4,"错误提示",T1[o])  add4() add5() return  end 
  end
 end
end
s0=s
local result = VarLib2:setGlobalVarByName(3,"字体大小",70-#t/4)
local result = VarLib2:setGlobalVarByName(4,"输出",s)
local result = VarLib2:setGlobalVarByName(4,"错误提示",T1[o])
end

local function add1()
    if B[v0]=="." then
    local res=string.sub(t,-1)
    local t1=string.sub(t,1,#t-1)
   if a[n]==0 then if res==0 and p==0  then t=t else t=t.."0"  end   end
    if p==0 then a[n]=a[n]+0.0 p=1 t=t..B[v0]  else o=4  add5()  end
  elseif B[v0]~="." and B[v0]~=nil then 
    local res=string.sub(t,-1)
    local t1=string.sub(t,1,#t-1)
     if a[n]==0  and p==0 and res=="0" then if B[v0]==0 then t=t else t=t1..B[v0] end
     else t=t..B[v0] end
       f=0 l=0 
    if p==0 then a[n]=10*a[n]+B[v0]     else  a[n]=a[n]+B[v0]*10^(-p)  p=p+1    end
  end        
end 

local function add2()
   if C[v0]=="=" then 
    if k~=0 then o=4  add5() y=0 s0=0 
    else  y=1 add3()  end  end
  if C[v0]=="("and(f==1 or a[1]==0) then k=k+1 f=1  t=t..C[v0]
  elseif C[v0]==")" and f==0  then k=k-1 p=0 t=t..C[v0] 
  end     

  if l==1 then  o=4 add5() 
  elseif l==0 then    o=1
    if C[v0]=="+" and f==0 then b[n]=1 n=n+1 l=1 f=1 p=0 t=t..C[v0] a[n]=0
    elseif C[v0]=="-" and f==0 then b[n]=2 n=n+1 l=1 f=1 p=0 t=t..C[v0] a[n]=0
    elseif C[v0]=="×" and f==0 then b[n]=3 n=n+1 l=1 f=1 p=0 t=t..C[v0] a[n]=0
    elseif C[v0]=="÷" and f==0 then b[n]=4 n=n+1 l=1 f=1 p=0 t=t..C[v0] a[n]=0
    end 
  end
 end  
   --显示器
local function M(event)
local timeTable = os.date("*t", timeInterval)
--print(timeTable)
local result = VarLib2:setGlobalVarByName(3,"字体大小",70-#t/4)
local result = VarLib2:setGlobalVarByName(4,"输入",t)
local result = VarLib2:setGlobalVarByName(4,"错误提示",T1[o])
local result = VarLib2:setGlobalVarByName(4,"输出",s)
local result = VarLib2:setGlobalVarByName(4,"时间", timeTable.year .. "年" .. timeTable.month .. "月" .. timeTable.day .. "日"..T[timeTable.wday] .. timeTable.hour .. ":" .. timeTable.min .. ":" .. timeTable.sec)
end
ScriptSupportEvent:registerEvent([=[minitimer.change]=],M)
 
   --点击按钮   
local function E(param)
 v0=param.btnelenemt
Player:playMusic(uid,10786,150,1,false)
    if B[v0]~=nil then      if y==1 then add4() y=0 s0=0 end add1(B[v0])   
    elseif C[v0]~=nil then  if y==1 then add4() y=0 a[1]=s0 t=s0 end add2(C[v0])  
    elseif D[v0]~=nil then   result=Player:notifyGameInfo2Self(v0,"此功能作者正在努力开发中")
    elseif A[v0]=="清除" then    add4() s0=0 y=0 t="0" s=0  o=1
    end  
  --Chat:sendSystemMsg(t)
local result = VarLib2:setGlobalVarByName(3,"字体大小",70-#t/4)
local result = VarLib2:setGlobalVarByName(4,"输入",t)
local result = VarLib2:setGlobalVarByName(4,"输出",s)  
local result = VarLib2:setGlobalVarByName(4,"错误提示",T1[o])  
end
ScriptSupportEvent:registerEvent_NoError([=[UI.Button.Click]=], E)      
