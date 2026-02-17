--[[
Author: xixi_
Date: 2022-6-38 ??:??:??
LastEditors: xixi_
LastEditTime: 2026-02-17 15:28:53
FilePath: /MiniWorldScript/Script/LittleMathematician/小小数学家.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

--宋元顺三年六月三十日八年级末期做
--熙柠制作
--凌晨1：33分误以为老六突击检查，差点出bug
--[[调用的库
1.math.random(m,n)--随机取值
2.math.abs(val)--取绝对值
3.string.sub(str,m,n)--字符串截取

2022.7.1
做完了领取连对按钮24:55
2022.7.2
加入平方差公式a^2-b^2=(a-b)(a+b) or (a+b)(a-b)
加入三角函数
加入解方程
加入整除模式
2022.7.3
加入自定义题库
]]--
local aa,bb,dd,ki,ih,qc,fk,jx,daz,dac,zcl,ld,dj=0,0,11,0,0,0,0,0,0,0,0,0,0,0
ws,da,lookan=0.001,"",0
local mid = {10946,10945,10949}
local A0=CurEventParam.SelectUIID
local A41 = "7114970169243672182_31"
local sqn={0,15,30,45,60,75,90,105,120,135,150,165,180,360}
local qcs={1,4,16,36,49,64,100,121,144,169,196,225,256}
local tk={"12×3+15×4","600÷(10+120÷6)","[175-(49+26)]×23","(1.5-0.6)×(3-1.8)","a/(a^2-4)-1/(2a-4)","(10-5-(-4))/(10+5)"}
local tkan={"96","20","2300","1.08","1/(2(x+2))","3/5"}
--local gs={-ki/((-ih*cc)+(ki*dv)),ki/(ih*di)+cc/(dv*di)}
--键盘按钮
N={
  ["7114970169243672182_139"]=1,["7114970169243672182_141"]=2,["7114970169243672182_143"]=3,
  ["7114970169243672182_145"]=4,["7114970169243672182_147"]=5,["7114970169243672182_149"]=6,
  ["7114970169243672182_151"]=7,["7114970169243672182_153"]=8,["7114970169243672182_155"]=9,
  ["7114970169243672182_157"]=0,["7114970169243672182_159"]=".",
  ["7114970169243672182_161"]="-",
  ["7114970169243672182_163"]="a",["7114970169243672182_165"]="b",["7114970169243672182_167"]="c",
  ["7114970169243672182_169"]="←",
  ["7114970169243672182_171"]="(",["7114970169243672182_173"]=")",["7114970169243672182_175"]="/",["7114970169243672182_177"]="+",
}
--按钮及文本
A={
  ["7114970169243672182_179"]="连对奖励",["7114970169243672182_79"]="暂停",
  ["7114970169243672182_22"]="结束",["7114970169243672182_182"]="看答案",
  ["7114970169243672182_83"]="退出",["7114970169243672182_186"]="确定答案",
  ["7114970169243672182_132"]="式子",["7114970169243672182_120"]="玩家答案",["7114970169243672182_74"]="正确答案",
}
--图片按钮
B={
  ["7114970169243672182_6"]="欢迎页继续按钮",["7114970169243672182_14"]="普通选择按钮",["7114970169243672182_18"]="中等选择按钮",
  ["7114970169243672182_22"]="困难选择按钮",["7114970169243672182_24"]="有理数框框",["7114970169243672182_25"]="有理数勾勾",
  ["7114970169243672182_"]="混合模式框框",["7114970169243672182_56"]="混合模式勾勾",["7114970169243672182_56"]="难度页继续",
  ["7114970169243672182_43"]="查看答案滑块",["7114970169243672182_49"]="罚站按钮滑块",["7114970169243672182_55"]="取消计时滑块",
  ["7114970169243672182_65"]="取消小数限制滑块",["7114970169243672182_75"]="算法限制滑块",["7114970169243672182_197"]="整除模式",["7114970169243672182_67"]="返回难度界面",
  ["7114970169243672182_69"]="其他设置继续按钮",["7114970169243672182_102"]="年级设置返回按钮",["7114970169243672182_103"]="年级设置继续按钮"
}

local function add22()
  local ki,ih,qc=math.random(aa,bb),math.random(aa,bb),math.random(1,dd)
  Player:notifyGameInfo2Self(v,"出题!")
  Player:playMusic(v,mid[1],100,1,flase)
  Trigger.UI:showElement(v, A0,A16)
  print(qc)
  local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", "请输入正确答案")
  if qc==1 then
    local sz="计算:"..ki.."+"..ih.."=?"
    fk=tostring(ki+ih)
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_132", sz)
    print(sz)
   elseif qc==2 then
    local sz="计算:"..ki.."-"..ih.."=?"
    fk=tostring(ki-ih)
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_132", sz)
    print(sz)
   elseif qc==3 then
    local sz="计算:"..ki.."×"..ih.."=?"
    fk=tostring(ki*ih)
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_132", sz)
    print(sz)
   elseif qc==4 then
    if dw==1 then
      local sz="计算:"..ki.."÷"..ih.."=?"
      fk=ki/ih
      result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_132", sz)
      num = fk--仅针对除不尽的
      num = num*100/1
      num = num/100
      num = num - num%ws
      fk=num
      fk=tostring(fk)
      print("截取结果"..num)
      print(sz)
     else
      local ih_temp=math.random(1,5)
      local ih=math.random(aa,bb)
      local ki=ih_temp*ih
      local sz="计算"..ki.."÷"..ih.."=?"
      fk=ki/ih
      fk=tostring(fk)
      local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_132", sz)
    end
   elseif qc==5 then
    local ki=qcs[math.random(1,15)]
    print(ki)
    local sz="展开:a^2-"..ki.."^2"
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_132", sz)
    fk="(a-"..math.sqrt(ki)..")(a+"..math.sqrt(ki)..")"
    fk2="(a+"..math.sqrt(ki)..")(a-"..math.sqrt(ki)..")"
    print(sz)
   elseif qc==6 then
    local ki=math.random(1,14)
    local sz="求值:cos("..sqn[ki]..")=?"
    fk=math.cos(math.rad(sqn[ki]))
    num = fk--仅针对无理数
    num = num*100/1
    num = num/100
    num = num - num%ws
    fk=num
    fk=tostring(fk)
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_132", sz)
    print("截取结果"..num)
   elseif qc==7 then
    local ki=math.random(1,14)
    local sz="求值:tan("..sqn[ki]..")=?"
    fk=math.tan(math.rad(sqn[ki]))
    num = fk--仅针对无理数
    num = num*100/1
    num = num/100
    num = num - num%ws
    fk=num
    fk=tostring(fk)
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_132", sz)
    print("截取结果"..num)
   elseif qc==8 then
    local ki=math.random(1,14)
    local sz="求值:sin("..sqn[ki]..")=?"
    fk=math.sin(math.rad(sqn[ki]))
    num = fk--仅针对无理数
    num = num*100/1
    num = num/100
    num = num - num%ws
    fk=num
    fk=tostring(fk)
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_132", sz)
    print("截取结果"..num)
   elseif qc==9 then
    local cc,dv=math.random(aa,bb),math.random(aa,bb)
    local sz="解方程:"..ki.."/"..ih.."x="..cc.."/("..dv.."x+1),x=?"
    Player:notifyGameInfo2Self(v,"匹配公式中~")
    fk=-ki/((-ih*cc)+(ki*dv))
    num = fk--仅针对无理数
    num = num*100/1
    num = num/100
    num = num - num%0.001
    fk=num
    fk=tostring(fk)
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_132", sz)
    print("截取结果"..num)
   elseif qc==10 then
    local cc,dv,di=math.random(aa,bb),math.random(aa,bb),math.random(aa,bb)
    local sz="解方程:"..ki.."/"..ih.."x+"..cc.."/"..dv.."x="..di..",x=?"
    Player:notifyGameInfo2Self(v,"匹配公式中~")
    fk=ki/(ih*di)+cc/(dv*di)
    num = fk--仅针对无理数
    num = num*100/1
    num = num/100
    num = num - num%0.001
    fk=num
    fk=tostring(fk)
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_132", sz)
    print("截取结果"..num)
   elseif qc==11 then
    local tknum=math.random(1,6)
    local sz="计算:"..tk[tknum].."=？"
    Player:notifyGameInfo2Self(v,"匹配公式中~")
    fk=tkan[tknum]
    print("题库")
    print(fk)
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_132", sz)
  end
end

local function EC(event)
  local V0=event.btnelenemt
  local v=eventobjid
  local A0=[=[7114970169243672182]=]
  local A4=[=[7114970169243672182_7]=]
  local A5=[=[7114970169243672182_1]=]
  local A6=[=[7114970169243672182_14]=]
  local A7=[=[7114970169243672182_25]=]
  local A8=[=[7114970169243672182_28]=]
  local A9=[=[7114970169243672182_31]=]
  local A10=[=[7114970169243672182_42]=]
  local A11=[=[7114970169243672182_48]=]
  local A12=[=[7114970169243672182_54]=]
  local A13=[=[7114970169243672182_64]=]
  local A14=[=[7114970169243672182_74]=]
  local A15=[=[7114970169243672182_76]=]
  local A16=[=[7114970169243672182_104]=]
  local A18=[=[7114970169243672182_196]=]
  if B[V0]=="欢迎页继续按钮" then
    Trigger.UI:hideElement(v, A0,A5)
    Trigger.UI:showElement(v, A0,A4)
    Player:playMusic(v,mid[2],100,1,false)
   elseif B[V0]=="普通选择按钮" then
    Trigger.UI:hideElement(v, A0,A7)
    Player:playMusic(v,mid[2],100,1,false)
    local ms = "若要继续，请先设置难度                   第一步：设置难度(已设置普通模式)"
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_11",ms)
    aa,bb=1,70
    jx=1
    print(aa,bb)
   elseif B[V0]=="中等选择按钮" then
    Trigger.UI:hideElement(v, A0,A7)
    Player:playMusic(v,mid[2],100,1,flase)
    local ms = "若要继续，请先设置难度                   第一步：设置难度(已设置中等模式)"
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_11", ms)
    aa,bb=71,150
    jx=1
    print(aa,bb)
   elseif B[V0]=="困难选择按钮" then
    Trigger.UI:hideElement(v, A0,A7)
    Player:playMusic(v,mid[2],100,1,flase)
    local ms = "若要继续，请先设置难度                   第一步：设置难度(已设置困难模式)"
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_11", ms)
    aa,bb=151,300
    jx=1
    print(aa,bb)
   elseif B[V0]=="有理数框框" then
    local aa,bb=-math.abs(bb),math.abs(aa)
    print(aa,bb)
    Player:playMusic(v,mid[2],100,1,flase)
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_11", ms)
    Trigger.UI:showElement(v, A0,A7)
   elseif B[V0]=="有理数勾勾" then
    local aa,bb=math.abs(aa),math.abs(bb)
    print(aa,bb)
    Player:playMusic(v,mid[2],100,1,flase)
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_11", ms)
    Trigger.UI:hideElement(v, A0,A7)
   elseif B[V0]=="混合模式框框" then
    Player:playMusic(v,mid[2],100,1,flase)
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_11", ms)
    Trigger.UI:showElement(v, A0,A8)
   elseif B[V0]=="混合模式勾勾" then
    Player:playMusic(v,mid[2],100,1,flase)
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_11", ms)
    Trigger.UI:hideElement(v, A0,A8)
   elseif B[V0]=="难度页继续" then
    if jx==1 then
      Trigger.UI:hideElement(v, A0,A4)
      Trigger.UI:showElement(v, A0,A9)
      Player:playMusic(v,mid[2],100,1,flase)
      local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_11", ms)
     else
      Player:playMusic(v,mid[3],100,1,flase)
      Player:notifyGameInfo2Self(v,"请选择任意一种难度方可继续！！！")
    end
   elseif B[V0]=="查看答案滑块" then
    if zt1==1 then
      local result = Customui:setPosition(v, A0, event.btnelenemt, 57,0)
      local result = Customui:setColor(v, A0, A10, "0x00F00")
      Player:playMusic(v,mid[2],100,1,flase)
      zt1=0
      lookan=5
     else
      zt1=1
      lookan=0
      local result = Customui:setPosition(v, A0, event.btnelenemt, 0,0)
      local result = Customui:setColor(v, A0, A10, "0xFFFFFF")
      Player:playMusic(v,mid[2],100,1,flase)
    end
   elseif B[V0]=="罚站按钮滑块" then
    if zt2==1 then
      local result = Customui:setPosition(v, A0, event.btnelenemt, 57,0)
      local result = Customui:setColor(v, A0, A11, "0x00F00")
      Player:playMusic(v,mid[2],100,1,flase)
      zt2=0
     else
      zt2=1
      local result = Customui:setPosition(v, A0, event.btnelenemt, 0,0)
      local result = Customui:setColor(v, A0, A11, "0xFFFFFF")
      Player:playMusic(v,mid[2],100,1,flase)
    end
   elseif B[V0]=="取消计时滑块" then
    if zt3==1 then
      local result = Customui:setPosition(v, A0, event.btnelenemt, 57,0)
      local result = Customui:setColor(v, A0, A12, "0x00F00")
      Player:playMusic(v,mid[2],100,1,flase)
      zt3=0
     else
      zt3=1
      local result = Customui:setPosition(v, A0, event.btnelenemt, 0,0)
      local result = Customui:setColor(v, A0, A12, "0xFFFFFF")
      Player:playMusic(v,mid[2],100,1,flase)
    end
   elseif B[V0]=="取消小数限制滑块" then
    if zt4==1 then
      local result = Customui:setPosition(v, A0, event.btnelenemt, 57,0)
      local result = Customui:setColor(v, A0, A13, "0x00F00")
      Player:playMusic(v,mid[2],100,1,flase)
      zt4=0
      ws=0.1
      local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_128", "除法除不尽或无理数输入小数点后1位")
     else
      zt4=1
      ws=0.001
      local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_128", "除法除不尽或无理数输入小数点后3位")
      local result = Customui:setPosition(v, A0, event.btnelenemt, 0,0)
      local result = Customui:setColor(v, A0, A13, "0xFFFFFF")
      Player:playMusic(v,mid[2],100,1,flase)
    end
   elseif B[V0]=="算法限制滑块" then
    if zt5==1 then
      local result = Customui:setPosition(v, A0, event.btnelenemt, 57,0)
      local result = Customui:setColor(v, A0, A14, "0x00F00")
      Player:playMusic(v,mid[2],100,1,flase)
      zt5,dd=0,2
      print(dd)
     else
      zt5,dd=1,11
      print(dd)
      local result = Customui:setPosition(v, A0, event.btnelenemt, 0,0)
      local result = Customui:setColor(v, A0, A14, "0xFFFFFF")
      Player:playMusic(v,mid[2],100,1,flase)
    end
   elseif B[V0]=="整除模式" then
    if zt6==1 then
      local result = Customui:setPosition(v, A0, event.btnelenemt, 57,0)
      local result = Customui:setColor(v, A0, A18, "0x00F00")
      Player:playMusic(v,mid[2],100,1,flase)
      zt6,dw=0,0
      print(dd)
     else
      zt6,dw=1,1
      print(dd)
      local result = Customui:setPosition(v, A0, event.btnelenemt, 0,0)
      local result = Customui:setColor(v, A0, A18, "0xFFFFFF")
      Player:playMusic(v,mid[2],100,1,flase)
    end
   elseif B[V0]=="返回难度界面" then
    Trigger.UI:hideElement(v, A0,A9)
    Trigger.UI:showElement(v, A0,A4)
    Player:playMusic(v,mid[2],100,1,flase)
    local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_11", ms)
   elseif B[V0]=="其他设置继续按钮" then
    Trigger.UI:hideElement(v, A0,A9)
    Trigger.UI:showElement(v, A0,A15)
    Player:playMusic(v,mid[2],100,1,flase)
   elseif B[V0]=="年级设置继续按钮" then
    Trigger.UI:hideElement(v, A0,A15)
    mbld=math.random(2,9)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_180", "连对奖励("..ld.."/"..(mbld+1)..")")
    add22() Player:playMusic(v,mid[2],100,1,false)
    Trigger.UI:showElement(v, A0,A16)
    Player:playMusic(v,mid[2],100,1,flase)
   elseif B[V0]=="年级设置返回按钮" then
    Trigger.UI:hideElement(v, A0,A15)
    Trigger.UI:showElement(v, A0,A9)
    Player:playMusic(v,mid[2],100,1,flase)
  end
end
ScriptSupportEvent:registerEvent([=[UI.Button.Click]=], EC)
local function EN(event)
  local V1=event.btnelenemt
  local v=eventobjid
  print(V1)
  -- Player:notifyGameInfo2Self(v,N[V1])
  if N[V1]==1 then
    da=da.."1"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]==2 then
    da=da.."2"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]==3 then
    da=da.."3"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]==4 then
    da=da.."4"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]==5 then
    da=da.."5"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]==6 then
    da=da.."6"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]==7 then
    da=da.."7"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]==8 then
    da=da.."8"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]==9 then
    da=da.."9"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]==0 then
    da=da.."0"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]=="." then
    if da=="" or da=="-" then
      da=da.."0."
      Player:playMusic(v,mid[1],100,1,flase)
      local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
     else
      da=da.."."
      Player:playMusic(v,mid[1],100,1,flase)
      local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
    end
   elseif N[V1]=="-" then
    da=da.."-"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]=="a" then
    da=da.."a"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]=="b" then
    da=da.."b"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]=="c" then
    da=da.."c"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]=="←" then
    da=string.sub(da,1,#da-1) --返回str中m-n位的内容
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]=="(" then
    da=da.."("
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]==")" then
    da=da..")"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]=="/" then
    da=da.."/"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
   elseif N[V1]=="+" then
    da=da.."+"
    Player:playMusic(v,mid[1],100,1,flase)
    local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
    --[[if da~="" then
        da=da.."."
        print(da)
        local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_134", da)
      end]]
  end
end
--[[  if B[vdd]==B[vdd] then
  dn=da..B[vdd]
local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_83", t)
Chat:sendSystemMsg("参数:")
result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_83", t)
local result = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_84", "压栈中~"..s1)
local result = Customui:setText(v,A0,A50,T1[o])
 elseif B[vdd]=="欢迎页继续按钮" then 
 Trigger.UI:hideElement(v, A0, B[vdd])
  Player:playMusic(v,mid[2],100,1,false)
   end
end]]--
--注册监听器，任按钮被点击时执行funcevent函数
--第一个参数是监听的事件，第二个参数funcevent即事件发生时执行的函数
ScriptSupportEvent:registerEvent([=[UI.Button.Click]=], EN)
local function EY(event)
  local V2=event.btnelenemt
  local v=eventobjid
  local A0=[=[7114970169243672182]=]
  local A17=[=[7114970169243672182_181]=]
  print(A[V2])
  if A[V2]=="看答案" then
    if lookan~=0 then
      lookan=lookan-1
      local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_183", "查看答案("..lookan.."/5)")
      print(v)
      Player:notifyGameInfo2Self(v,"正确答案为"..fk)
     else
      Player:playMusic(v,mid[3],100,1,flase)
      Player:notifyGameInfo2Self(v,"没有次数了或者你没设置")
    end
   elseif A[V2]=="确定答案" then
    print(fk)
    if da==fk or da==fk2 and da~="" then
      ld=ld+1
      local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_180", "连对奖励("..ld.."/"..(mbld+1)..")")
      Player:notifyGameInfo2Self(v,"回答正确,加1分")
      Player:playMusic(v,mid[2],100,1,flase)
      da=""
      daz=daz+1
      local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_113", "题数:("..daz+dac.."/35)")
      local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_116", "正确题数:("..daz.."/35)")
      num1 = daz/(dac+daz)
      num1 = num1*100/1
      num1 = num1/100
      num1 = num1 - num1%0.0001
      num1=num1*100
      local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_122", "正确率:"..num1.."%")
      add22() Player:playMusic(v,mid[2],100,1,false)
      if ld==mbld+1 then
        Trigger.UI:showElement(v, A0,A17)
        Player:playMusic(eventobjid,mid[2],100,1,false)
        Player:notifyGameInfo2Self(v,"连对奖励已触发，快去领取吧！")
      end
     else
      ld=0
      mbld=math.random(2,9)
      Trigger.UI:hideElement(v, A0,A17)
      local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_180", "连对奖励("..ld.."/"..(mbld+1)..")")
      Player:notifyGameInfo2Self(v,"回答错误或没有输入,剪1分")
      Player:playMusic(v,mid[3],100,1,flase)
      da=""
      dac=dac+1
      local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_119", "错误题数:("..dac.."/35)")
      local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_113", "题数:("..daz+dac.."/35)")
      num1 = daz/(dac+daz)
      num1 = num1*100/1
      num1 = num1/100
      num1 = num1 - num1%0.0001
      num1=num1*100
      local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_122", "正确率:"..num1.."%")
      add22() Player:playMusic(v,mid[3],100,1,false)
      lan=5-(5-lookan)
      lans=math.random(1,lan)
      lookan=lookan-lans
      local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_183", "查看答案("..lookan.."/5)")
      Player:notifyGameInfo2Self(v,"并剪"..lan.."次#G查看答案#n机会，继续加油！")
    end
   elseif A[V2]=="连对奖励" then
    if ld<=mbld then
      Player:playMusic(eventobjid,mid[3],100,1,false)
      Player:notifyGameInfo2Self(v,"连对次数不够")
     else if lookan~=5 then
        Trigger.UI:hideElement(v, A0,A17)
        dj=dj+1
        lan=5-lookan
        lans=math.random(1,lan)
        lookan=lookan+lans
        Player:notifyGameInfo2Self(v,"获得奖励：查看答案次数+"..lans.."！")
        local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_125", "额外奖励次数:"..dj)
        local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_183", "查看答案("..lookan.."/5)")
        Player:playMusic(eventobjid,mid[2],100,1,false)
        ld=0
        mbld=math.random(2,9)
        local esult = Customui:setText(eventobjid, "7114970169243672182", "7114970169243672182_180", "连对奖励("..ld.."/"..(mbld+1)..")")
       else
        Player:playMusic(eventobjid,mid[3],100,1,false)
        Player:notifyGameInfo2Self(v,"领取失败,次数不能等于5")
      end
    end
  end
end

ScriptSupportEvent:registerEvent([=[UI.Button.Click]=], EC)
local function EE(param)
  zt1,zt2,zt3,zt4,zt5,zt6=1,1,0,1,1,1
  local A0=CurEventParam.SelectUIID
  local A1 = "7114970169243672182_31"
  local A2 = "7114970169243672182_25"
  local A3 = "7114970169243672182_28"
  local A4 = "7114970169243672182_7"
  local A15="7114970169243672182_76"
  local A16="7114970169243672182_104"
  local A17="7114970169243672182_181"
  local v=param.eventobjid
  local result,name=Player:getNickname(v)
  Player:notifyGameInfo2Self(v,"欢迎玩家"..name.."来到房间")
  Chat:sendSystemMsg("tip:如果页面显示有问题，可以尝试重新进一次地图！！！--熙柠")
  Player:playMusic(v,mid[2],100,1,false)
  Trigger.UI:hideElement(v, A0, A0)
  Trigger.UI:hideElement(v, A0, A1)
  Trigger.UI:hideElement(v, A0, A2)
  Trigger.UI:hideElement(v, A0, A3)
  Trigger.UI:hideElement(v, A0, A4)
  Trigger.UI:hideElement(v, A0, A15)
  Trigger.UI:hideElement(v, A0, A16)
  Trigger.UI:hideElement(v, A0, A17)
  Trigger.Player:openUIView(v,A0)
end
ScriptSupportEvent:registerEvent_NoError([=[Game.AnyPlayer.EnterGame]=], EE)
ScriptSupportEvent:registerEvent([=[UI.Button.Click]=], EC)
ScriptSupportEvent:registerEvent([=[UI.Button.Click]=], EY)