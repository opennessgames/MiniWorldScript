--[[
Author: xixi_
Date: 2022-08-18 18:13:22
LastEditors: xixi_
LastEditTime: 2026-02-18 14:06:18
FilePath: /MiniWorldScript/Script/MiniDevWiki/连连看.lua
Copyright (c) 2020-2026 by xixi_ , All Rights Reserved.
--]]

--方块id:水果，高亮、连线、刷新、重玩
local ids={3998,3997,3996,3995,3994,3993,3992,3991,3990,3989}
local ids2={4000,3999,3987,3985}
--音效id:选中、消除
local mid={10946,10945}
--游戏设定:屏幕宽高，大于2且至少有一个偶数
local w,h=17,12
--地图设定:屏幕起点
local x0,y0,z0=0,7,0
------------------------------------
local now,ni=0,0--游戏状态0:生成水果 1:正常进行 2:消除连线
local frs={}--当前水果
local i,j,k=0,0,0
local chl,chid=0,0--当前选中
local cha,chb=0,0--消除
local line={}--路径
local uid=0--玩家id

----------------
----预置方法----
----------------
--判断两个表是否一样
local function isSame(t1,t2)
	local m=0
	for m=1,#t1 do
		if t1[m]~=t2[m] then
			return false
		end
	end
	return true
end
--获取某元素在表中的位置
local function isInside(value,tab)
	for a,v in ipairs(tab) do
		if v==value then
			return a
		end
	end
	return -1
end
local function isInside2(value,tab)
	for a,v in ipairs(tab) do
		if isSame(v,value) then
			return a
		end
	end
	return -1
end
--位置与坐标
local function ltp(l)
	return {math.floor(l/w),l%w}
end
local function ptl(p)
	return p[1]*w+p[2]
end


--两点之间是否为空(直线)
local function isEmp(a,b)
	if a[1]==b[1] then
		if a[2]>b[2] then
			for k=b[2],a[2] do
				if (frs[ptl({a[1],k})+1]~=nil)and(ptl({a[1],k})~=cha)and(ptl({a[1],k})~=chb) then
					return false
				end
			end
		else
			for k=a[2],b[2] do
				if (frs[ptl({a[1],k})+1]~=nil)and(ptl({a[1],k})~=cha)and(ptl({a[1],k})~=chb) then
					return false
				end
			end
		end
	else
		if a[1]>b[1] then
			for k=b[1],a[1] do
				if (frs[ptl({k,a[2]})+1]~=nil)and(ptl({k,a[2]})~=cha)and(ptl({k,a[2]})~=chb) then
					return false
				end
			end
		else
			for k=a[1],b[1] do
				if (frs[ptl({k,a[2]})+1]~=nil)and(ptl({k,a[2]})~=cha)and(ptl({k,a[2]})~=chb) then
					return false
				end
			end
		end
	end
	return true
end
--添加连线
local function addLine(a,b)
	local l=0
	if a[1]==b[1] then
		if a[2]>b[2] then
			for k=b[2],a[2] do
				l=ptl({a[1],k})
				if (l~=cha)and(l~=chb) then
					line[l]=0
				end
			end
		else
			for k=a[2],b[2] do
				l=ptl({a[1],k})
				if (l~=cha)and(l~=chb) then
					line[l]=0
				end
			end
		end
	else
		if a[1]>b[1] then
			for k=b[1],a[1] do
				l=ptl({k,a[2]})
				if (l~=cha)and(l~=chb) then
					line[l]=0
				end
			end
		else
			for k=a[1],b[1] do
				l=ptl({k,a[2]})
				if (l~=cha)and(l~=chb) then
					line[l]=0
				end
			end
		end
	end
	return true
end

--判断是否可消除
local function check(a,b)
	line={}
	local pa,pb=ltp(a),ltp(b)
	if ((pa[1]==pb[1])and(math.abs(pa[2]-pb[2])==1))or((pa[2]==pb[2])and(math.abs(pa[1]-pb[1])==1)) then--相邻
		return true
	elseif pa[1]==pb[1] then--同行
		if isEmp(pa,pb) then
			addLine(pa,pb)
			return true
		end
		for j=1,h do
			if (isEmp(pa,{j-1,pa[2]}))and(isEmp({j-1,pa[2]},{j-1,pb[2]}))and(isEmp({j-1,pb[2]},pb)) then
				addLine(pa,{j-1,pa[2]})
				addLine({j-1,pa[2]},{j-1,pb[2]})
				addLine({j-1,pb[2]},pb)
				return true
			end
		end
	elseif pa[2]==pb[2] then--同列
		if isEmp(pa,pb) then
			addLine(pa,pb)
			return true
		end
		for j=1,w do
			if (isEmp(pa,{pa[1],j-1}))and(isEmp({pa[1],j-1},{pb[1],j-1}))and(isEmp({pb[1],j-1},pb)) then
				addLine(pa,{pa[1],j-1})
				addLine({pa[1],j-1},{pb[1],j-1})
				addLine({pb[1],j-1},pb)
				return true
			end
		end
	else--对角
		for j=1,h do
			if (isEmp(pa,{j-1,pa[2]}))and(isEmp({j-1,pa[2]},{j-1,pb[2]}))and(isEmp({j-1,pb[2]},pb)) then
				addLine(pa,{j-1,pa[2]})
				addLine({j-1,pa[2]},{j-1,pb[2]})
				addLine({j-1,pb[2]},pb)
				return true
			end
		end
		for j=1,w do
			if (isEmp(pa,{pa[1],j-1}))and(isEmp({pa[1],j-1},{pb[1],j-1}))and(isEmp({pb[1],j-1},pb)) then
				addLine(pa,{pa[1],j-1})
				addLine({pa[1],j-1},{pb[1],j-1})
				addLine({pb[1],j-1},pb)
				return true
			end
		end
	end
	return false
end

--玩家点击方块
Go=function(e)
	if now==1 then
		local x,y,z=math.floor(e['x']),math.floor(e['y']),math.floor(e['z'])
		local id=e['blockid']
		local r,item=Player:getCurToolID(e['eventobjid'])
		local loc=ptl({z-z0,x-x0})
		local p=ltp(chl)
		uid=e['eventobjid']
		if item==ids2[3] then--重新排序
			chid=0
			chl=0
			Block:setBlockAll(x0+p[2],y0+1,z0+p[1],0,0)
			local locs,idss,co,m={},{},0,0
			for i=1,w*h do
				if frs[i]~=nil then
					co=co+1
					locs[co]=i
					idss[co]=frs[i]
				end
			end
			frs={}
			math.randomseed(os.time())
--
			for i=1,co do
				r=math.random(1,co-i+1)
				m=0
				while r>0 do
					m=m+1
					if locs[m]~=nil then
						r=r-1
					end
				end
				frs[locs[m]]=idss[i]
				p=ltp(locs[m]-1)
				Block:setBlockAll(x0+p[2],y0,z0+p[1],idss[i],2)
				locs[m]=nil
			end
--
		elseif item==ids2[4] then--重玩
			chid=0
			chl=0
			Block:setBlockAll(x0+p[2],y0+1,z0+p[1],0,0)
			frs={}
			now=0
		elseif (y==y0)and(loc>-1)and(loc<w*h) then--选中
			if chid~=id then--第一个
				Block:setBlockAll(x0+p[2],y0+1,z0+p[1],0,0)
				chid=id
				chl=loc
				Block:setBlockAll(x,y+1,z,ids2[1],0)
				Player:playMusic(e["eventobjid"],mid[1],100,1,false)
			elseif chl~=loc then--第二个
				cha=chl
				chb=loc
				if check(loc,chl) then
					Block:setBlockAll(x0+cha%w,y0+1,z0+math.floor(cha/w),ids2[2],0)
					Block:setBlockAll(x0+chb%w,y0+1,z0+math.floor(chb/w),ids2[2],0)
					Player:playMusic(e["eventobjid"],mid[1],100,1,false)
					for i=1,w*h do
						if line[i]~=nil then
							Block:setBlockAll(x0+i%w,y0+1,z0+math.floor(i/w),ids2[2],0)
						end
					end
					chid=0
					chl=0
					now=2
				else
					Block:setBlockAll(x0+p[2],y0+1,z0+p[1],0,0)
					chid=id
					chl=loc
					Block:setBlockAll(x,y+1,z,ids2[1],0)
					Player:playMusic(e["eventobjid"],mid[1],100,1,false)
				end
			end
		end
	end
end
ScriptSupportEvent:registerEvent([=[Player.ClickBlock]=],Go)


--
return function()
	if now==0 then--生成水果
		if ni<w*h-(w+h)*2+4 then
			math.randomseed(os.time())
			local r,m,mm,p,id=0,0,0,{},0
			for i=1,2 do
				r=math.random(1,w*h-(w+h)*2+4-ni)
				m=0
				while r>0 do
					m=m+1
					mm=m+(w+1)+(math.ceil(m/(w-2))-1)*2
					if frs[mm]==nil then
						r=r-1
					end
				end
				p=ltp(mm-1)
				id=ids[math.floor(ni/2)%#ids+1]
				Block:setBlockAll(x0+p[2],y0,z0+p[1],id,2)
				frs[mm]=id
				ni=ni+1
			end
			Chat:sendSystemMsg("正在生成:"..ni.."/"..(w*h-(w+h)*2+4))
		else
			ni=0
			now=1
			Chat:sendSystemMsg("游戏已重新生成！")
		end
	elseif now==2 then--消除连线
		if ni==10 then
			Block:setBlockAll(x0+cha%w,y0,z0+math.floor(cha/w),0,0)
			Block:setBlockAll(x0+chb%w,y0,z0+math.floor(chb/w),0,0)
			Block:setBlockAll(x0+cha%w,y0+1,z0+math.floor(cha/w),0,0)
			Block:setBlockAll(x0+chb%w,y0+1,z0+math.floor(chb/w),0,0)
			frs[cha+1]=nil
			frs[chb+1]=nil
			for i=1,w*h do
				if line[i]~=nil then
					Block:setBlockAll(x0+i%w,y0+1,z0+math.floor(i/w),0,0)
				end
			end
			ni=0
			now=1
			Player:playMusic(uid,mid[2],100,1,false)
		else
			ni=ni+1
		end
	end
end