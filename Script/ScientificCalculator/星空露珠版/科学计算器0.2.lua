--[[
Author: xixi_
Date: 2021-7-19 ??:??:??
LastEditors: xixi_
LastEditTime: 2026-02-18 14:27:52
FilePath: /MiniWorldScript/Script/ScientificCalculator/科学计算器0.2.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

  --[[  
普通  - 48     科学   -45
0-23. 
1-1. 2-6. 3-9. 
4-11. 5-13. 6-15. 
7-17. 8-19. 9-21
+ 25. - 27. × 29. ÷ 31. = 33. 
C 37. 

(  - 87.  ) - 85. %-101. x！-81. x^-1 -83.
x^3 -91. x^y-93. √-95. 3√-97. y√x-77.
x^2-89. ln-71. e-79. π-51. rad-99.

log-73. tan-59. cos-57. sin- 55.   

 lnv-53.
e^x-69. 10^x-75. tan^-1-67. cos^-1-65.
sin^-1-63. 
lnv^-1-61.
deg- .
. 43.
显示 输入 104   输出106
等号

print(unpack(A))
]]
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
  6.网络时间因触发器计时器变化一秒,导致误差1秒          √

"-----------------------------------------"
0.5  2021.7.20星期二
   1.加入"("")"运算,
   2.优化算法
   3.加入提示
   
 


]]
--[[函数名	描述	示例	结果
pi	圆周率	math.pi	3.1415926535898abs	
取绝对值	math.abs(-2012)	2012
ceil	向上取整	math.ceil(9.1)	10
floor	向下取整	math.floor(9.9)	9
max	取参数最大值	math.max(2,4,6,8)	8
min	取参数最小值	math.min(2,4,6,8)	2
pow	计算x的y次幂	math.pow(2,16)	65536
sqrt	开平方	math.sqrt(65536)	256
mod	取模	math.mod(65535,2)	1
modf	取整数和小数部分	math.modf(20.12)	20   0.12
randomseed	设随机数种子	math.randomseed(os.time())	 
random	取随机数	math.random(5,90)	5~90
rad	角度转弧度	math.rad(180)	3.1415926535898
deg	弧度转角度	math.deg(math.pi)	180
exp	e的x次方	math.exp(4)	54.598150033144
log	计算x的自然对数	math.log(54.598150033144)	4
log10	计算10为底，x的对数	math.log10(1000)	3
frexp	将参数拆成x * (2 ^ y)的形式	math.frexp(160)	0.625    8l
dexp	计算x * (2 ^ y)	math.ldexp(0.625,8)	160
sin	正弦	math.sin(math.rad(30))	0.5
cos	余弦	math.cos(math.rad(60))	0.5
tan	正切	math.tan(math.rad(45))	1
asin	反正弦	math.deg(math.asin(0.5))	30
acos	反余弦	math.deg(math.acos(0.5))	60
atan	反正切	math.deg(math.atan(1))	45
]]
--音效id:移出、正确、错误、拼图完成
local mid={10946,10945,10949,10947}

 T={"星期日","星期一","星期二","星期三","星期四","星期五","星期六",}
--界面端
 A={
  ["6985055414249172898_48"]="普通",["6985055414249172898_45"]="科学",
  ["6985055414249172898_53"]="lnv",["6985055414249172898_61"]="lnv-",
  ["6985055414249172898_104"]="输入",["6985055414249172898_106"]="输出",
  ["6985055414249172898_37"]="清除", ["6985055414249172898_33"]="=",
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
    ["6985055414249172898_25"]="+",["6985055414249172898_27"]="-",
    ["6985055414249172898_29"]="×",["6985055414249172898_31"]="÷",
  
    }
  --科学运算
   D={
    ["6985055414249172898_87"]="(",["6985055414249172898_85"]=")",
    ["6985055414249172898_101"]="%",["6985055414249172898_81"]="x!",["6985055414249172898_51"]="π",
    ["6985055414249172898_79"]="e",["6985055414249172898_83"]="x^-1",["6985055414249172898_89"]="x^2",
    ["6985055414249172898_91"]="x^3",["6985055414249172898_93"]="x^y",["6985055414249172898_95"]="√",
    ["6985055414249172898_97"]="3√",["6985055414249172898_77"]="y√x",["6985055414249172898_99"]="rad",
    ["6985055414249172898_71"]="ln(",["6985055414249172898_69"]="e^(",["6985055414249172898_73"]="log(",
    ["6985055414249172898_75"]="10^(",["6985055414249172898_55"]="sin(",["6985055414249172898_57"]="cos(",
    ["6985055414249172898_59"]="tan(",["6985055414249172898_63"]="asin(",["6985055414249172898_65"]="acos(",
    ["6985055414249172898_67"]="atan(",["6985055414249172898_110"]="deg",

    }
T1={"","错误101:运算公式出现错误","错误102:运算式除数为零","错误103:按键错误","错误104:公式不完整","错误102:括号中运算式除数为零","错误102:运算为零或不成立",}
local A0=[=[6985055414249172898]=]--"界面",
local A1=[=[6985055414249172898_48]=]--"普通",
local A2=[=[6985055414249172898_45]=]--"科学",
local A3=[=[6985055414249172898_53]=]--"lnv",
local A4=[=[6985055414249172898_61]=]--"lnv^-1", 
local A31=[=[6985055414249172898_99]=]--"rad",
local A41=[=[6985055414249172898_110]=]--"deg" 
local A5=[=[6985055414249172898_37]=]--"清除",
local A10=[=[6985055414249172898_104]=]--"输入",
local A20=[=[6985055414249172898_106]=]--"输出",
local A30=[=[6985055414249172898_107]=]--"时间", 
local A40=[=[6985055414249172898_108]=]--"作者",
local A50=[=[6985055414249172898_109]=]--"错误提示", 
  
  

 --UI界面测试版
  a,b,c,n,s,t1={},{},nil,{},{},{}
  t=""
  n1,a1,k,p,f,d,o,t2,l,o0,s0,s1,j=0,0,1,0,0,0,1,1,0,1,0,"","",0
  n[k]=1
  a[k]={}
  a[k][n[k]]=0
  b[k]={}
  b[k][n[k]]=0
  

local function add4() --清除
  a,b,c,n,s,t1={},{},nil,{},{},{}
  t=""
  n1,a1,k,p,f,d,t2,l,s1,o0,j=0,0,1,0,0,0,1,0,"",0,0
  n[k]=1
  a[k]={}
  a[k][n[k]]=0
  b[k]={}
  b[k][n[k]]=0
  end


local function add3()
   s[k]=0
if k==1 then 
print("k="..k.."n[k]="..n[k])
print("a[k]=")
print(unpack(a[k]))
print("b[k]=")
print(unpack(b[k]))
   s[k]=0
if n[k]==1 then s[k]=a[k][n[k]]  t=t.."=" 
else
if b[k][n[k]]~=0 and a[k][n[k]]==nil then t=t.."0"  t1[t2]=t t2=t2+1 end
t=t.."="
 for i=1,n[k] do
  if b[k][i]==1  then
    if (b[k][i+1]~=3 and b[k][i+1]~=4)  then s[k]=a[k][i]+a[k][i+1] a[k][i+1]=s[k]  a[k][i]=0 b[k][i]=0
    elseif b[k][i+1]==3  then if a[k][i+2]~=nil  then s[k]=a[k][i+1]*a[k][i+2]   a[k][i+1]=a[k][i]   a[k][i+2]=s[k]  b[k][i+1]=b[k][i] a[k][i]=0  b[k][i]=0  else  s[k]=0   a[k][i+1]=a[k][i]   a[k][i+2]=s[k]  b[k][i+1]=b[k][i] b[k][i]=0 end
    elseif b[k][i+1]==4  then if (a[k][i+2]~=0 and a[k][i+2]~=nil) then s[k]=a[k][i+1]/a[k][i+2] a[k][i+1]=a[k][i]   a[k][i+2]=s[k]  b[k][i+1]=1 a[k][i]=0  b[k][i]=0  else  o=3 add4() s0=0 Player:playMusic(v,mid[3],150,1,false) end end
  elseif b[k][i]==2 then
   if (b[k][i+1]~=3 and b[k][i+1]~=4)  then s[k]=a[k][i]-a[k][i+1] a[k][i+1]=s[k]  a[k][i]=0 b[k][i]=0 
    elseif b[k][i+1]==3  then if a[k][i+1]~=nil  then s[k]=a[k][i+1]*a[k][i+2]   a[k][i+1]=a[k][i]   a[k][i+2]=s[k]  b[k][i+1]=b[k][i] a[k][i]=0  b[k][i]=0  else  s[k]=0   a[k][i+1]=a[k][i]   a[k][i+2]=s[k]  b[k][i+1]=b[k][i] b[k][i]=0 end
    elseif b[k][i+1]==4  then if (a[k][i+2]~=0 and a[k][i+2]~=nil) then s[k]=a[k][i+1]/a[k][i+2] a[k][i+1]=a[k][i]   a[k][i+2]=s[k]  b[k][i+1]=2 a[k][i]=0  b[k][i]=0  else  o=3 add4() s0=0 Player:playMusic(v,mid[3],150,1,false) end end
  elseif b[k][i]==3  then s[k]=a[k][i]*a[k][i+1] a[k][i+1]=s[k] a[k][i]=0 b[k][i]=0 
  elseif b[k][i]==4  then if (a[k][i+1]~=0 and a[k][i+1]~=nil)  then s[k]=a[k][i]/a[k][i+1]  a[k][i+1]=s[k] a[k][i]=0 b[k][i]=0  else o=3 add4() s0=0 Player:playMusic(v,mid[3],150,1,false) end 
  end
 end
s[k]=a[k][n[k]]
s0=s[k] 
s1=s0

end
elseif k>1 then 
print("k="..k.."n[k]="..n[k])
print("a[k]")
print(unpack(a[k]))
print("b[k]")
print(unpack(b[k]))
 for i= 1,n[k] do
  if b[k][i]==1  then
    if (b[k][i+1]~=3 and b[k][i+1]~=4)  then s[k]=a[k][i]+a[k][i+1] a[k][i+1]=s[k]  a[k][i]=0 b[k][i]=0
    elseif b[k][i+1]==3  then if a[k][i+2]~=nil  then s[k]=a[k][i+1]*a[k][i+2]   a[k][i+1]=a[k][i]   a[k][i+2]=s[k]  b[k][i+1]=b[k][i] a[k][i]=0  b[k][i]=0  else  s[k]=0   a[k][i+1]=a[k][i]   a[k][i+2]=s[k]  b[k][i+1]=b[k][i] b[k][i]=0 end
    elseif b[k][i+1]==4  then if (a[k][i+2]~=0 and a[k][i+2]~=nil) then s[k]=a[k][i+1]/a[k][i+2] a[k][i+1]=a[k][i]   a[k][i+2]=s[k]  b[k][i+1]=1 a[k][i]=0  b[k][i]=0  else  o=6 add4() Player:playMusic(v,mid[3],150,1,false) end end
  elseif b[k][i]==2 then
   if (b[k][i+1]~=3 and b[k][i+1]~=4)  then s[k]=a[k][i]-a[k][i+1] a[k][i+1]=s[k]  a[k][i]=0 b[k][i]=0 
    elseif b[k][i+1]==3  then if a[k][i+1]~=nil  then s[k]=a[k][i+1]*a[k][i+2]   a[k][i+1]=a[k][i]   a[k][i+2]=s[k]  b[k][i+1]=b[k][i] a[k][i]=0  b[k][i]=0  else  s[k]=0   a[k][i+1]=a[k][i]   a[k][i+2]=s[k]  b[k][i+1]=b[k][i] b[k][i]=0 end
    elseif b[k][i+1]==4  then if (a[k][i+2]~=0 and a[k][i+2]~=nil) then s[k]=a[k][i+1]/a[k][i+2] a[k][i+1]=a[k][i]   a[k][i+2]=s[k]  b[k][i+1]=2 a[k][i]=0  b[k][i]=0  else  o=6 add4() Player:playMusic(v,mid[3],150,1,false) end end
  elseif b[k][i]==3  then s[k]=a[k][i]*a[k][i+1] a[k][i+1]=s[k] a[k][i]=0 b[k][i]=0 
  elseif b[k][i]==4  then if (a[k][i+1]~=0 and a[k][i+1]~=nil)  then s[k]=a[k][i]/a[k][i+1]  a[k][i+1]=s[k] a[k][i]=0 b[k][i]=0  else o=6 add4() Player:playMusic(v,mid[3],150,1,false) end 
  end
 end
s[k]=a[k][n[k]]
a[k-1][n[k-1]]=s[k] 
end
if k==1 then
print(s[k])
else
print(s[k])
a[k],b[k],n[k]=nil,nil,nil 
k=k-1
end
print(unpack(s))
print("s1="..s1)
end
--[[
local function factorial(n1)  --阶乘
    if n1==0 then      
        return 1
    else  
        return n1*factorial(n1-1)
    end
 end
]]
local function add0()
  local a1=a[k][n[k]]
  if a1==0  then
    a1=1
    else
   for i=a[k][n[k]]-1,2,-1 do
    a1=a1*i
    print(a1)
    end
  end
  n1=a1  
end

local function add1() --输入
  if j==2 or j==3 then
   
   if B[v0]=="." then
    local res=string.sub(t,-1)
    local t1=string.sub(t,1,#t-1)
   if c==0 then if res==0 and p==0  then t=t else t=t.."0"  end   end
    if p==0 then c=c+0.0 p=1 t=t..B[v0]  else o=4  add5()  end
  elseif B[v0]~="." and B[v0]~=nil then 
    local res=string.sub(t,-1)
    local t1=string.sub(t,1,#t-1)
     if c==0  and p==0 and res=="0" then if B[v0]==0 then t=t else t=t1..B[v0] end
     else t=t..B[v0] end
       f=0 l=0 
    if p==0 then c=10*c+B[v0]     else  c=c+B[v0]*10^(-p)  p=p+1    end
  end
    
    elseif j==0 then
  o=1
    if B[v0]=="." then
    local res=string.sub(t,-1)
    local t0=string.sub(t,1,#t-1)
   if a[k][n[k]]==0 then if res==0 and p==0  then t=t else t=t.."0"  end   end
    if p==0 then a[k][n[k]]=a[k][n[k]]+0.0 p=1 t=t..B[v0] Player:playMusic(v,mid[1],150,1,false) else o=4  Player:playMusic(v,mid[3],150,1,false)  end
  elseif B[v0]~="." and B[v0]~=nil then 
    local res=string.sub(t,-1)
    local t0=string.sub(t,1,#t-1)
     if a[k][n[k]]==0  and p==0 and res=="0" then if B[v0]==0 then t=t else t=t0..B[v0] end
     else t=t..B[v0] end
       f=0 l=0 Player:playMusic(v,mid[1],150,1,false)
    if p==0 then a[k][n[k]]=10*a[k][n[k]]+B[v0]     else  a[k][n[k]]=a[k][n[k]]+B[v0]*10^(-p)  p=p+1    end
  end  
end
      print("a[k][n[k]]="..a[k][n[k]])
end

local function add2()--运算
   if l==0 then
     s1=""
       Player:playMusic(v,mid[1],150,1,false)  
    if C[v0]=="+" and f==0 then 
      b[k][n[k]]=1 n[k]=n[k]+1 a[k][n[k]]=0 l=1 f=1 p=0 j=0 t=t..C[v0] t1[t2]=t t2=t2+1
    elseif C[v0]=="-" and f==0 then
     b[k][n[k]]=2 n[k]=n[k]+1 a[k][n[k]]=0 l=1 f=1 p=0 j=0 t=t..C[v0] t1[t2]=t t2=t2+1
    elseif C[v0]=="×" and f==0 then 
    b[k][n[k]]=3 n[k]=n[k]+1 a[k][n[k]]=0 l=1 f=1 p=0 j=0 t=t..C[v0] t1[t2]=t t2=t2+1
    elseif C[v0]=="÷" and f==0 then
     b[k][n[k]]=4 n[k]=n[k]+1 a[k][n[k]]=0 l=1 f=1 p=0 j=0 t=t..C[v0] t1[t2]=t t2=t2+1
    end
   else o=4 Player:playMusic(v,mid[3],150,1,false)
   end 
end

 
local function add20()--多功能
 Player:playMusic(v,mid[1],150,1,false)
    if D[v0]==")" then 
     if j==2  then
       j=1 t=t..")"
       a[k][n[k]]=a[k][n[k]]^(c)
       c=nil
       l=0 f=0
       if n[k]==1 and k==1 then s1=a[k][n[k]] end
     elseif j==3 then
     j=1  t=t..")"
     a[k][n[k]]=a[k][n[k]]^(1/c)
     c=nil
     l=0 f=0
     if n[k]==1 and k==1 then s1=a[k][n[k]] end
     end
     if j==0 then
      if k>1 then
         t=t..D[v0] t1[t2]=t t2=t2+1 add3() l=0 f=0
      elseif k==1 and j==0 then
       o=5 Player:playMusic(v,mid[3],150,1,false)
       end
     end 
   end
          
   if D[v0]=="(" then 
      if l==1 or (l==0 and k==1 and n[k]==1 and ( a[k][n[k]]==0 or a[k][n[k]]==nil )) then 
        if ( a[k][n[k]]==0 or a[k][n[k]]==nil) and k==1 and b[k][n[k]]==nil then
          k=k+1  a[k],b[k],n[k]={},{},1  a[k][n[k]],b[k][n[k]]=0,0 f=1  t=t..D[v0] t1[t2]=t t2=t2+1 
         Player:playMusic(v,mid[1],150,1,false)
         else
         k=k+1  a[k],b[k],n[k]={},{},1  a[k][n[k]],b[k][n[k]]=0,0 f=1  t=t..D[v0] t1[t2]=t t2=t2+1 
       
         end
      else 
          o=5  Player:playMusic(v,mid[3],150,1,false)
      end
   end
   if j==0 then 
       if D[v0]=="π"  then if a[k][n[k]]==0 then a[k][n[k]]=math.pi t=t.."π" f=0 l=0 else a[k][n[k]]=a[k][n[k]]*math.pi t=t.."π" f=0 l=0 j=1 end
   elseif D[v0]=="e"  then if a[k][n[k]]==0 then a[k][n[k]]=math.exp(1) t=t.."e" f=0 l=0 else a[k][n[k]]=a[k][n[k]]*math.exp(1) t=t.."e" f=0 l=0 j=1 end
   elseif D[v0]=="√"  then if a[k][n[k]]>0  then a[k][n[k]]=math.sqrt(a[k][n[k]]) t=t.."^(1÷2)" f=0 l=0 j=1 else o=7 Player:playMusic(v,mid[3],150,1,false) end
   elseif D[v0]=="x!" then if a[k][n[k]]>=0  then  add0() a[k][n[k]]=n1 t=t.."!" e=0 l=0 j=1 else o=7 Player:playMusic(v,mid[3],150,1,false) end
   elseif D[v0]=="3√"  then if a[k][n[k]]~=0 then a[k][n[k]]=math.pow(a[k][n[k]],1/3) t=t.."^(1÷3)" f=0 l=0 j=1  else o=7 Player:playMusic(v,mid[3],150,1,false) end
   elseif D[v0]=="x^2" then  a[k][n[k]]=math.pow(a[k][n[k]],2)  t=t.."^(2)"  f=0 l=0  
   elseif D[v0]=="x^3" then  a[k][n[k]]=math.pow(a[k][n[k]],3)  t=t.."^(3)"  f=0 l=0  
   elseif D[v0]=="x^-1" then if a[k][n[k]]~=0 then a[k][n[k]]=1/a[k][n[k]] t=t.."^(-1)"  f=0 l=0 j=1 else o=7 Player:playMusic(v,mid[3],150,1,false) end
   elseif D[v0]=="%"   then  a[k][n[k]]=a[k][n[k]]/100 t=t.."%"  f=0 l=0  j=1
   elseif D[v0]=="x^y" then j=2 c=0 t=t.."^(" 
   elseif D[v0]=="y√x" then if  a[k][n[k]]>0  then j=3 c=0 t=t.."^(1÷" else o=7 Player:playMusic(v,mid[3],150,1,false) end
   elseif D[v0]=="deg" then s1=math.deg(a[k][n[k]])   
   local v=v
  local A0=[=[6985055414249172898]=]--"界面",
  local A31=[=[6985055414249172898_99]=]--"rad",
  local A41=[=[6985055414249172898_110]=]--"deg"
   Trigger.UI:showElement(v, A0, A31)
   Trigger.UI:hideElement(v, A0, A41)
   
   elseif D[v0]=="rad" then s1=math.rad(a[k][n[k]])
   
   local v=v
  local A0=[=[6985055414249172898]=]--"界面",
  local A31=[=[6985055414249172898_99]=]--"rad",
  local A41=[=[6985055414249172898_110]=]--"deg"
   Trigger.UI:showElement(v, A0, A41)
   Trigger.UI:hideElement(v, A0, A31)   
   
  
   else
       if D[v0]=="ln(" then if a[k][n[k]]>0 then t=D[v0]..t..")" a[k][n[k]]=math.log(a[k][n[k]]) f=0 l=0 j=1 else o=7 Player:playMusic(v,mid[3],150,1,false) end
   elseif D[v0]=="log("  then if a[k][n[k]]>0 then t=D[v0]..t..")" a[k][n[k]]=math.log10(a[k][n[k]]) f=0 l=0 j=1 else o=7 Player:playMusic(v,mid[3],150,1,false) end
   elseif D[v0]=="10^(" then t=D[v0]..t..")"  a[k][n[k]]=10^(a[k][n[k]]) l=0 f=0 j=1
   elseif D[v0]=="e^("  then t=D[v0]..t..")"  a[k][n[k]]=math.exp(a[k][n[k]]) l=0 f=0 j=1
   elseif D[v0]=="sin(" then t=D[v0]..t..")"  a[k][n[k]]=math.sin(math.rad(a[k][n[k]])) l=0 f=0 j=1
   elseif D[v0]=="cos(" then t=D[v0]..t..")"  a[k][n[k]]=math.cos(math.rad(a[k][n[k]])) l=0 f=0 j=1
   elseif D[v0]=="tan(" then t=D[v0]..t..")"  a[k][n[k]]=math.tan(math.rad(a[k][n[k]])) l=0 f=0 j=1
   elseif D[v0]=="asin(" then t=D[v0]..t..")" a[k][n[k]]=math.deg(math.asin(a[k][n[k]])) l=0 f=0 j=1
   elseif D[v0]=="acos(" then t=D[v0]..t..")" a[k][n[k]]=math.deg(math.acos(a[k][n[k]])) l=0 f=0 j=1
   elseif D[v0]=="atan(" then t=D[v0]..t..")" a[k][n[k]]=math.deg(math.atan(a[k][n[k]])) l=0 f=0 j=1
     end
   end  
 if n[k]==1 and k==1 then s1=a[k][n[k]] end
  
  end
end
--界面操作
local function add21()
  local v=v
  local A0=[=[6985055414249172898]=]--"界面",
  local A1=[=[6985055414249172898_48]=]--"普通",
  local A2=[=[6985055414249172898_45]=]--"科学",
  local A3=[=[6985055414249172898_53]=]--"lnv",
  local A4=[=[6985055414249172898_61]=]--"lnv^-1",  
  local A31=[=[6985055414249172898_99]=]--"rad",
  local A41=[=[6985055414249172898_110]=]--"deg"
       if A[v0]=="=" then        
         if A[v0]=="=" then 
           if k>1 then
              o=5   o0=0    Player:playMusic(v,mid[3],150,1,false)
      
           elseif o0==1 then
             add4() Player:playMusic(v,mid[1],150,1,false)
             a[k][n[k]]=s0 t=s0 t1[t2]=t t2=t2+1 s1=s0  
             o0=1          
           elseif o0==0 and n[k]==1 and k==1 then  s1=a[k][n[k]] s0=s1 o0=1 t=s1
           elseif k==1 and o0==0 then 
            add3() o0=1 t=t Player:playMusic(v,mid[1],150,1,false)
           end
             
         end                    
       elseif A[v0]=="清除" then    add4() o0=0 s0=0 Player:playMusic(v,mid[2],100,1,false)
       elseif A[v0]=="普通" then 
         Trigger.UI:hideElement(v, A0, A1)   
         Trigger.UI:showElement(v, A0, A2)
         Trigger.UI:hideElement(v, A0, A4)     
         Trigger.UI:showElement(v, A0, A3)
         Trigger.UI:showElement(v, A0, A31)
         Trigger.UI:hideElement(v, A0, A41)
       elseif A[v0]=="科学" then 
         Trigger.UI:hideElement(v, A0, A2)   
         Trigger.UI:showElement(v, A0, A1)
         Trigger.UI:hideElement(v, A0, A4)   
         Trigger.UI:hideElement(v, A0, A3)
         Trigger.UI:hideElement(v, A0, A31)
         Trigger.UI:hideElement(v, A0, A41)
       elseif A[v0]=="lnv" then 
         Trigger.UI:showElement(v, A0, A4)
         Trigger.UI:hideElement(v, A0, A3)   
       elseif A[v0]=="lnv-" then 
         Trigger.UI:showElement(v, A0, A3)
         Trigger.UI:hideElement(v, A0, A4)  
       end
  end
--字体大小
local function add6(t)
    local t=t
    if #t<=20 then  vi=100 return vi 
      else
      for i=1,100 do
          if math.floor(1150/i)*math.floor(150/i)-math.floor(1150/i)*4/3<=#t/2 then           
           vi=i
          return vi
           end
       end         
    end
  end
  --显示器
local function M()
local timeTable = os.date("*t", timeInterval)
local Tt=timeTable.year.."年"..timeTable.month.."月"..timeTable.day.."日"..T[timeTable.wday]..timeTable.hour..":"..timeTable.min..":"..timeTable.sec
local v=v
local o=o
local t=t
T1={"","错误101:运算公式出现错误","错误102:运算式除数为零","错误103:按键错误","错误104:公式不完整","错误102:括号中运算式除数为零","错误102:运算为零或不成立",}
local A0=[=[6985055414249172898]=]--"界面",
local A10=[=[6985055414249172898_104]=]--"输入",
local A20=[=[6985055414249172898_106]=]--"输出",
local A30=[=[6985055414249172898_107]=]--"时间", 
local A40=[=[6985055414249172898_108]=]--"作者",
local A50=[=[6985055414249172898_109]=]--"错误提示", 
Trigger.UI:setText(v,A0,A30,Tt)
Trigger.UI:setText(v,A0,A50,T1[o])
Trigger.UI:setText(v,A0,A20,s1)
    if add6(t) then  Trigger.UI:setFontSize(v, A0, A10, vi)   
    Trigger.UI:setText(v, A0, A10, t)
   end 
end
ScriptSupportEvent:registerEvent([=[minitimer.change]=],M)
 
 --玩家点击UI       
local function E(param)
   v=param.eventobjid
  v0=param.btnelenemt 
    if B[v0]~=nil then    print(B[v0]) 
       if o0==1 then add4() o0=0  s0=0 end add1(A[v0])  
    elseif C[v0]~=nil then print(C[v0])
     if o0==1 then add4() o0=0 a[k][n[k]]=s0 t=s0 t1[t2]=t t2=t2+1 s0=0  end add2(C[v0])
    elseif D[v0]~=nil then  print(D[v0])
     if o0==1 then add4() o0=0 a[k][n[k]]=s0 t=s0 s0=0 end add20(D[v0])
    elseif A[v0]~=nil  then print(A[v0])
       add21(A[v0])    
    end  
  --Chat:sendSystemMsg(t)
end
ScriptSupportEvent:registerEvent_NoError([=[UI.Button.Click]=], E)
--玩家进入游戏
local function E3(param)
    local v=param.eventobjid
    local result,name=Player:getNickname(v)
       Player:notifyGameInfo2Self(v,"欢迎玩家"..name.."来到房间")
       Player:openUIView(v,A0)
       Trigger.UI:hideElement(v, A0, A1)   
       Trigger.UI:showElement(v, A0, A2)
       Trigger.UI:hideElement(v, A0, A4)     
       Trigger.UI:showElement(v, A0, A3)
       Trigger.UI:showElement(v, A0, A31)
       Trigger.UI:hideElement(v, A0, A41)
 end  
ScriptSupportEvent:registerEvent_NoError([=[Game.AnyPlayer.EnterGame]=], E3)
