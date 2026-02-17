--[[
Author: xixi_
Date: 2023-02-26 00:44:??
LastEditors: xixi_
LastEditTime: 2026-02-17 18:39:51
FilePath: /MiniWorldScript/Script/2048/2048游戏2.0++.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

--2048小游戏
--作者熙柠


local ui={"7130763705674965405","7130763705674965405_",}--页面id,前缀
local ui0={}
local NumTexeid={
  [[7130763705674965405_10]],[[7130763705674965405_12]],[[7130763705674965405_14]],[[7130763705674965405_16]],
  [[7130763705674965405_18]],[[7130763705674965405_20]],[[7130763705674965405_22]],[[7130763705674965405_25]],
  [[7130763705674965405_27]],[[7130763705674965405_29]],[[7130763705674965405_31]],[[7130763705674965405_33]],
  [[7130763705674965405_35]],[[7130763705674965405_37]],[[7130763705674965405_39]],[[7130763705674965405_41]],
}
local NumId={
  [[7130763705674965405_9]],[[7130763705674965405_11]],[[7130763705674965405_13]],[[7130763705674965405_15]],
  [[7130763705674965405_17]],[[7130763705674965405_19]],[[7130763705674965405_21]],[[7130763705674965405_24]],
  [[7130763705674965405_26]],[[7130763705674965405_28]],[[7130763705674965405_30]],[[7130763705674965405_32]],
  [[7130763705674965405_34]],[[7130763705674965405_36]],[[7130763705674965405_38]],[[7130763705674965405_40]],
}

--[[  "2*n+8,2*n+9",42,43,45,47,
          51,
          "6*n+47",
          95,96,97,98,99,          
          ]]
local p0=42
--音效
local mid={10948,10946,10949,10947,10379}
local num={}
local lbrt={1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,
  13,9,5,1,14,10,6,2,15,11,7,3,16,12,8,4,4,
  3,2,1,8,7,6,5,12,11,10,9,16,15,14,13,1,5,
  9,13,2,6,10,14,3,7,11,15,4,8,12,16,}
local P={}
local P0={}
local maxnum=0
local maxscore=0
local P2048={}
--原件颜色 原件位置,x,y,大小
local A={ {"0xFFEFD7",40,10,120,2},
  {"0xFFE57F",40,10,120,4},
  {"0xFFFF00",40,10,120,8},
  {"0xFF6E40",20,20,100,16},
  {"0xF57F17",20,20,100,32},
  {"0xFF1744",20,20,100,64},
  {"0xD500F9",10,25,80,128},
  {"0x3D5AFE",10,25,80,256},
  {"0x00E5FF",10,25,80,512},
  {"0x76FF03",10,35,60,1024},
  {"0xE77B17",10,35,60,2048},
  {"0xE040FB",10,35,60,4096},
  {"0xF50057",10,35,60,8192},
  {"0x64DD17",10,45,45,16384},
  {"0xF57F17",10,45,45,32768},
  {"0x3D5AFE",10,45,45,65536},
}
--当前方向、是否正在进行、是否结束
local drct,ising,isend,has=0,0,0,0
local i,j,k=0,0,0
local score=0
--界面
local function add0(p,i)
  if num[i]==0 then
    Trigger.UI:hideElement(p, ui[1],NumId[i]) print(i)
   else
    Trigger.UI:showElement(p, ui[1],NumId[i])
    Trigger.UI:setColor(p, ui[1],NumId[i],A[num[i]][1])
    Trigger.UI:setText(p, ui[1],NumTexeid[i],A[num[i]][5])
    Trigger.UI:setPosition(p, ui[1],NumTexeid[i],A[num[i]][2],A[num[i]][3])
    Trigger.UI:setFontSize(p, ui[1],NumTexeid[i],A[num[i]][4])
  end
end
--当前分数
local function add1(p)
  local maxnum=nil
  for k,v in ipairs(num) do
    if maxnum==nil then maxnum=v
     elseif maxnum<v then maxnum=v
    end
  end
  local maxscore=score
  if maxnum<P[p][4] then else P[p][4]=maxnum end
  if maxscore<P[p][5] then else P[p][5]=maxscore end
  Trigger.UI:setColor(p, ui[1],ui[2]..42,A[maxnum][1])
  Trigger.UI:setText(p, ui[1],ui[2]..43,A[maxnum][5])
  Trigger.UI:setPosition(p, ui[1],ui[2]..43,A[maxnum][2],A[maxnum][3])
  Trigger.UI:setFontSize(p, ui[1],ui[2]..43,A[maxnum][4])
  Trigger.UI:setText(p, ui[1],ui[2]..45,maxscore)
  Trigger.UI:setText(p, ui[1],ui[2]..47,P[p][5])
end
--排行榜
local function add2 (p)
  Trigger.UI:showElement(p, ui[1],ui[2]..51)
  P0={}
  for k,v in ipairs(P2048) do
    local result,iconid = Customui:getRoleIcon(v)
    if iconid ~=nil then P[v][1][3]=iconid end
    P0[#P0+1]={P[v][1][3],P[v][1][2],P[v][1][1],P[v][4],P[v][5],P[v][3]}
  end
  P0[#P0+1]={"role_4","迷你队长",1000,10,10000,666}
  table.sort(P0 ,function(a, b) if a[4] > b[4] then return a[4] > b[4] elseif a[4] == b[4] then return a[5]>b[5] end end)
  print(P0)
  for i,v in ipairs(P0) do
    if i<=10 then
      if i>#P0 then Trigger.UI:hideElement(p, ui[1],ui[2]..(10*i+p0))
       else
        Trigger.UI:showElement(p, ui[1],ui[2]..(10*i+p0))
        Trigger.UI:setText(p, ui[1],ui[2]..(10*i+p0+1),i)
        Trigger.UI:setTexture(p, ui[1],ui[2]..(10*i+p0+2), P0[i][1])
        Trigger.UI:setText(p, ui[1],ui[2]..(10*i+p0+3),P0[i][2])
        Trigger.UI:setText(p, ui[1],ui[2]..(10*i+p0+4),P0[i][3])
        Trigger.UI:setText(p, ui[1],ui[2]..(10*i+p0+5),A[P0[i][4]][5])
        Trigger.UI:setText(p, ui[1],ui[2]..(10*i+p0+6),P0[i][5])
        Trigger.UI:setText(p, ui[1],ui[2]..(10*i+p0+7),P0[i][6])
      end
    end
    if v[3]==p then
      Trigger.UI:setText(p, ui[1],ui[2]..(10*11+p0+1),i)
      Trigger.UI:setTexture(p, ui[1],ui[2]..(10*11+p0+2), v[1])
      Trigger.UI:setText(p, ui[1],ui[2]..(10*11+p0+3),v[2])
      Trigger.UI:setText(p, ui[1],ui[2]..(10*11+p0+4),v[3])
      Trigger.UI:setText(p, ui[1],ui[2]..(10*11+p0+5),A[v[4]][5])
      Trigger.UI:setText(p, ui[1],ui[2]..(10*11+p0+6),v[5])
      Trigger.UI:setText(p, ui[1],ui[2]..(10*11+p0+7),v[6])
    end
  end
end

local function Check(p)
  for i=1,16 do
    if num[i]==11 then
      isend=99999
    end
  end
  if isend==99999 then Game:msgBox("恭喜！2048！") has=2
    Player:playMusic(p,mid[5],100,1,false)
    Chat:sendSystemMsg("恭喜！玩家"..P[p][1][2].."2048！")
  end
end
--刷新
local function Re(p)
  for i=1,16 do
    add0(p,i)
  end
  if has==1 then
    Check(p)
  end
end
--随机生成1个2/4
local function Add(p)
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
  Re(p)
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
local function Move(p,drct)
  isend=0
  score=P[p][3]
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
    Player:playMusic(p,mid[3],100,1,false)
   else Player:playMusic(p,mid[2],100,1,false) Add(p)
  end
  P[p][3]=score add1(p)
end
--初始化
local function setnum(p)
  P[p][2],P[p][3]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,},0
  num,score=P[p][2],P[p][3]
  Add(p) P[p][3]=score add1(p)
end
--点击按钮
function funcevent(event)
  local p,uid,uiid=event.eventobjid,event.CustomUI,event.btnelenemt
  if uid==ui[1] then num=P[p][2]
    if uiid==ui[2]..4 then Move(p,4)
     elseif uiid==ui[2]..5 then Move(p,2)
     elseif uiid==ui[2]..6 then Move(p,1)
     elseif uiid==ui[2]..7 then Move(p,3)
     elseif uiid==ui[2]..43 then Player:playMusic(p,mid[1],100,1,false) Chat:sendSystemMsg("2048已重新开始",p) setnum(p)
     elseif uiid==ui[2]..6 then Trigger.UI:hideElement(p, ui[1],ui[2]..1) Trigger.UI:showElement(p, ui[1],ui[2]..179)
     elseif uiid==ui[2]..174 then Trigger.UI:hideElement(p, ui[1],ui[2]..51)
     elseif uiid==ui[2]..175 then add2(p)
     elseif uiid==ui[2]..179 then Trigger.UI:hideElement(p, ui[1],ui[2]..179) Trigger.UI:showElement(p, ui[1],ui[2]..1)
    end
  end
end
ScriptSupportEvent:registerEvent([=[UI.Button.Click]=],funcevent)
--玩家进入游戏
local function E3(param)
  local p=param.eventobjid
  local result,name=Player:getNickname(p)
  threadpool:wait(2)
  Player:notifyGameInfo2Self(p,"欢迎玩家"..name.."来到2048游戏房间")
  Player:openUIView(p,ui[1])
  Trigger.UI:hideElement(p, ui[1],ui[2]..179)
  local result,iconid = Customui:getRoleIcon(p)
  if P[p]==nil then P2048[#P2048+1]=p P[p]={}
    P[p][1],P[p][3],P[p][4],P[p][5]={p,name,iconid},0,0,0
  end
  setnum(p)
end
ScriptSupportEvent:registerEvent_NoError([=[Game.AnyPlayer.EnterGame]=], E3)