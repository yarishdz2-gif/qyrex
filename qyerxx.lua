--[[
  QyrexHub | Steal an Egg
  UI Qyrex + features Steal an Egg
]]

local Qyrex=(function()
local T=game:GetService"TweenService"local q=game:GetService"UserInputService"local ad=game:GetService"GuiService"local U=game:GetService"RunService"local C=game:GetService"HttpService"local D=game:GetService"Players"local E=D.LocalPlayer local f={}f.Flags={}f.Version="3.1"f.Windows={}local function l(b,c)local a={}if type(b)=="string"then a.Name=b elseif type(b)=="table"then for b,c in pairs(b)do a[b]=c end end for b,c in pairs(c or{})do if a[c]==nil and a[b]~=nil then a[c]=a[b]end end if a.Range then a.Min=a.Min or a.Range[1]a.Max=a.Max or a.Range[2]end return a end local function n(e,b,a,d,g)a._type=g a._frame=d a._listeners=a._listeners or{}local c=e and e.Window if b.Flag then f.Flags[b.Flag]=a if c then local a=b.Callback b.Callback=function(...)if type(a)=="function"then a(...)end c:_autoSave()end end end function a:Destroy()if a._destroyed then return end a._destroyed=true for b,a in ipairs(a._listeners)do a()end a._listeners={}if b.Flag and f.Flags[b.Flag]==a then f.Flags[b.Flag]=nil end if c then c._controlsDirty=true end if d then d:Destroy()end end return a end f.Theme={Background=Color3.fromRGB(6,10,16),Surface=Color3.fromRGB(10,16,24),Surface2=Color3.fromRGB(14,22,34),Surface3=Color3.fromRGB(22,34,52),Stroke=Color3.fromRGB(32,48,72),StrokeHover=Color3.fromRGB(34,180,220),Accent=Color3.fromRGB(34,211,238),AccentDark=Color3.fromRGB(8,28,40),Text=Color3.fromRGB(240,250,255),Muted=Color3.fromRGB(120,150,170),Warning=Color3.fromRGB(251,191,36),Success=Color3.fromRGB(52,211,153),Error=Color3.fromRGB(251,113,133)}f.Assets={Shadow="rbxassetid://6014261993",Glow="rbxassetid://8992230677",Logo="rbxassetid://83380517901735"}local A local function I()if A~=nil then return A end local b,a=pcall(function()local a=game:HttpGet"https://raw.githubusercontent.com/Footagesus/Icons/refs/heads/main/lucide/dist/Icons.lua"return loadstring(a)()end)if b and type(a)=="table"then A=a else A=false warn("[Qyrex] lucide icons unavailable: "..tostring(a))end return A end local ae={ValleySans={Regular="https://raw.githubusercontent.com/HelsinkiTypeStudio/valley-sans/main/fonts/ttf/ValleySans-Regular.ttf",Medium="https://raw.githubusercontent.com/HelsinkiTypeStudio/valley-sans/main/fonts/ttf/ValleySans-Medium.ttf",SemiBold="https://raw.githubusercontent.com/HelsinkiTypeStudio/valley-sans/main/fonts/ttf/ValleySans-SemiBold.ttf"}}local V={Regular={400,Enum.FontWeight.Regular},Medium={500,Enum.FontWeight.Medium},SemiBold={600,Enum.FontWeight.SemiBold},Bold={700,Enum.FontWeight.Bold}}function f:LoadFont(b)local e="function"b=l(b,{})if type(writefile)~=e or type(isfile)~=e or typeof(getcustomasset)~=e then warn"[Qyrex] custom fonts need writefile, isfile and getcustomasset"return false end local a=b.Name or"CustomFont"local g=b.Weights or ae[a]if type(g)~="table"then warn("[Qyrex] no font weights for "..a)return false end local d=b.Folder or"QyrexFonts"pcall(function()if type(isfolder)=="function"and type(makefolder)=="function"and not isfolder(d)then makefolder(d)end end)local h={}for b,e in pairs(g)do local c=V[b]if c then local f,g=d.."/"..a.."-"..b..".ttf",true if not isfile(f)then g=pcall(function()writefile(f,game:HttpGet(e))end)end if g then table.insert(h,{name=b,weight=c[1],style="normal",assetId=getcustomasset(f)})else warn("[Qyrex] could not download "..b.." weight of "..a)end end end if#h==0 then return false end local i=d.."/"..a..".json"local j=pcall(function()writefile(i,C:JSONEncode{name=a,faces=h})end)if not j then return false end local k=getcustomasset(i)local function c(a,c)local b=V[a]if b and g[a]then return Font.new(k,b[2])end return c end f.Fonts.Regular=c("Regular",f.Fonts.Regular)f.Fonts.Medium=c("Medium",c("Regular",f.Fonts.Medium))f.Fonts.Bold=c("SemiBold",c("Bold",f.Fonts.Bold))return true end function f:PreloadIcons()return I()~=false end local function af(a)if typeof(a)=="table"then return a.Image,a.RectOffset,a.RectSize end if type(a)~="string"then return nil end if a:find"^rbxassetid://"or a:find"^rbxasset://"or a:find"^http"then return a end local d=a:gsub("^lucide:","")local b=I()if not b then return nil end local c=b.Icons and b.Icons[d]or b[d]if type(c)=="table"then local a=c.Image if type(a)=="number"then a="rbxassetid://"..tostring(a)end local d=b.Spritesheets and b.Spritesheets[tostring(a)]or a return d,c.ImageRectPosition,c.ImageRectSize elseif type(c)=="string"then return c end warn("[Qyrex] unknown lucide icon: "..d)return nil end local J="rbxasset://fonts/families/BuilderSans.json"f.Fonts={Regular=Font.new(J,Enum.FontWeight.Regular),Medium=Font.new(J,Enum.FontWeight.Medium),Bold=Font.new(J,Enum.FontWeight.SemiBold)}local a=f.Theme local t=f.Assets local i=f.Fonts local m=q.TouchEnabled and not q.KeyboardEnabled f.Touch=m local K=m and 54 or 48 local v=m and 70 or 64 local L=m and 40 or 34 local s=m and 34 or 28 local W={}local function b(e,f,a,b,c)a=a or.2 if a<=0 then for a,b in pairs(f)do e[a]=b end return nil end b=b or Enum.EasingStyle.Quart c=c or Enum.EasingDirection.Out local g=a..b.Name..c.Name local d=W[g]if not d then d=TweenInfo.new(a,b,c)W[g]=d end local h=T:Create(e,d,f)h:Play()return h end local function c(d,b,c)local a=Instance.new(d)for b,c in pairs(b)do if b~="Parent"then a[b]=c end end if c then for c,b in ipairs(c)do b.Parent=a end end if b.Parent then a.Parent=b.Parent end return a end local function e(a,b)return c("UICorner",{CornerRadius=b or UDim.new(0,8),Parent=a})end local function h(b,d,e,f)return c("UIStroke",{Color=d or a.Stroke,Transparency=e or 0,Thickness=f or 1,ApplyStrokeMode=Enum.ApplyStrokeMode.Border,Parent=b})end local function o(a,b,d,e,f)return c("UIPadding",{PaddingLeft=UDim.new(0,b or 0),PaddingRight=UDim.new(0,d or 0),PaddingTop=UDim.new(0,e or 0),PaddingBottom=UDim.new(0,f or 0),Parent=a})end local function d(d)local b={BackgroundTransparency=1,TextColor3=a.Text,TextSize=14,FontFace=i.Medium,TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Center,TextTruncate=Enum.TextTruncate.AtEnd}for a,c in pairs(d)do b[a]=c end return c("TextLabel",b)end local function x(d,e,f,g,h)local b=c("ImageLabel",{AnchorPoint=Vector2.new(.5,.5),Position=f,Size=e,BackgroundTransparency=1,Image=t.Glow,ImageColor3=Color3.fromRGB(226,218,230),ImageTransparency=g,ZIndex=0,Parent=d})c("UIGradient",{Color=ColorSequence.new(Color3.fromRGB(255,255,255),a.Accent),Rotation=h or 90,Parent=b})return b end local function M(a)return c("Frame",{Position=UDim2.fromOffset(0,0),Size=UDim2.new(1,0,0,1),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=.93,BorderSizePixel=0,ZIndex=0,Parent=a})end local function u(a,c)local b,d,e=af(c)if not b then return end a.Image=b a.ImageRectOffset=d or Vector2.zero a.ImageRectSize=e or Vector2.zero end local function ag()local b pcall(function()if typeof(gethui)=="function"then b=gethui()end end)if typeof(b)=="Instance"then return b end local ok,pg=pcall(function()local plr=D.LocalPlayer or D:GetPlayers()[1]return plr and plr:FindFirstChildOfClass("PlayerGui")or plr:WaitForChild("PlayerGui",5)end)if ok and pg then return pg end local plr=D.LocalPlayer return plr and(plr:FindFirstChildOfClass("PlayerGui")or plr)or game:GetService("Players").LocalPlayer:FindFirstChildOfClass("PlayerGui")end local X,Y=nil,Vector2.zero local function r()local a=time()if X~=a then X=a Y=ad:GetGuiInset()end return q:GetMouseLocation()-Y end local function p(a)return a.UserInputType==Enum.UserInputType.MouseButton1 or a.UserInputType==Enum.UserInputType.Touch end local function N(a)return a.UserInputType==Enum.UserInputType.MouseMovement or a.UserInputType==Enum.UserInputType.Touch end local function y(d,e,f,g)local a=c("Frame",{AnchorPoint=Vector2.new(0,.5),Position=g,Size=UDim2.fromOffset(16,16),BackgroundTransparency=1,Parent=d})local b=c("ImageLabel",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,ImageColor3=f,ScaleType=Enum.ScaleType.Fit,Parent=a})u(b,e)return a,b end local function Z(j,g,k)local h=c("Frame",{AnchorPoint=Vector2.new(g,.5),Position=UDim2.new(g,k,.5,0),Size=UDim2.fromOffset(18,18),BackgroundTransparency=1,Parent=j})local e={}local f=c("ImageLabel",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),Size=UDim2.fromOffset(16,16),BackgroundTransparency=1,ImageColor3=a.Muted,ScaleType=Enum.ScaleType.Fit,Parent=h})u(f,"chevron-down")if f.Image~=""then function e:Set(c)b(f,{Rotation=c and 180 or 0,ImageColor3=c and a.Accent or a.Muted},.3,Enum.EasingStyle.Quint)end return e end f:Destroy()local function i(b,c)return d{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),Size=UDim2.fromOffset(18,18),Text="›",TextSize=22,TextXAlignment=Enum.TextXAlignment.Center,TextColor3=a.Muted,TextTransparency=c,Rotation=b,Parent=h}end local l=i(90,0)local m=i(270,1)function e:Set(c)b(l,{TextTransparency=c and 1 or 0},.2)b(m,{TextTransparency=c and 0 or 1,TextColor3=c and a.Accent or a.Muted},.2)end return e end local O={}local function ah(f)local g=r()local h=math.max(f.AbsoluteSize.X,f.AbsoluteSize.Y)*2.2 local d=table.remove(O)if not d then d=c("Frame",{AnchorPoint=Vector2.new(.5,.5),BackgroundColor3=a.Accent,BorderSizePixel=0})e(d,UDim.new(1,0))end d.Position=UDim2.fromOffset(g.X-f.AbsolutePosition.X,g.Y-f.AbsolutePosition.Y)d.Size=UDim2.fromOffset(0,0)d.BackgroundTransparency=.82 d.ZIndex=f.ZIndex+1 d.Parent=f b(d,{Size=UDim2.fromOffset(h,h),BackgroundTransparency=1},.55)task.delay(.55,function()d.Parent=nil if#O<4 then table.insert(O,d)else d:Destroy()end end)end local function w(c)if not c then return end b(c,{Color=a.Accent,Transparency=.2},.08)task.delay(.12,function()b(c,{Color=a.Stroke,Transparency=0},.35)end)end local function F(c,d)c.MouseEnter:Connect(function()b(d,{Color=a.StrokeHover},.12)end)c.MouseLeave:Connect(function()b(d,{Color=a.Stroke},.25)end)end local ai={[Enum.KeyCode.LeftControl]="LCtrl",[Enum.KeyCode.RightControl]="RCtrl",[Enum.KeyCode.LeftShift]="LShift",[Enum.KeyCode.RightShift]="RShift",[Enum.KeyCode.LeftAlt]="LAlt",[Enum.KeyCode.RightAlt]="RAlt",[Enum.KeyCode.Return]="Enter",[Enum.KeyCode.Escape]="Esc",[Enum.KeyCode.Backspace]="Backspace"}local function P(a)if a==nil then return"None"end return ai[a]or a.Name end local function k(a,...)if type(a)~="function"then return end local b,c=pcall(a,...)if not b then warn("[Qyrex] callback error: "..tostring(c))end end local function aa(e,f,a)local b=0 local c=tostring(a)local d=c:find"%."if d then b=#c-d end local g="%."..b.."f"return{snap=function(b)b=math.floor(b/a+.5)*a return math.clamp(b,e,f)end,format=function(a)return string.format(g,a)end}end local function B(f,g,i,k)local d={Size=UDim2.new(1,0,0,i),BackgroundColor3=a.Surface2,BorderSizePixel=0,LayoutOrder=f:_nextOrder(),Parent=f.List}if g=="TextButton"then d.AutoButtonColor=false d.Text=""end local b=c(g,d)b:SetAttribute("NoDrag",true)e(b)local j=h(b,a.Stroke)return b,j end local function G(b,f,g,c)local e,h if g then local j=(v-38)/2 e=d{Position=UDim2.fromOffset(14,j),Size=UDim2.new(1,-(14+c),0,18),Text=f,Parent=b}h=d{Position=UDim2.fromOffset(14,j+20),Size=UDim2.new(1,-(14+c),0,17),Text=g,TextSize=13,FontFace=i.Regular,TextColor3=a.Muted,Parent=b}else e=d{Position=UDim2.fromOffset(14,0),Size=UDim2.new(1,-(14+c),1,0),Text=f,Parent=b}end return e,h end local function z(h,a,i,j,c,k)a=l(a,i)local d=a.Desc and v or K local b,e=B(h,j or"Frame",d,a)F(b,e)local f,g if c then f,g=G(b,a.Name or k,a.Desc,c)end return a,b,e,d,f,g end local function H(a,b,c)if a then a.Size=UDim2.new(1,-(14+c),a.Size.Y.Scale,a.Size.Y.Offset)end if b then b.Size=UDim2.new(1,-(14+c),0,b.Size.Y.Offset)end end local j={}j.__index=j function j:_nextOrder()self._order+=1 return self._order end function j:Section(b)if type(b)=="table"then b=b.Name or b.Title or""end local f=c("Frame",{Size=UDim2.new(1,0,0,28),BackgroundTransparency=1,LayoutOrder=self:_nextOrder(),Parent=self.List})local e=d{Position=UDim2.fromOffset(2,8),Size=UDim2.new(0,0,0,16),AutomaticSize=Enum.AutomaticSize.X,Text=string.upper(b),TextSize=12,TextColor3=a.Muted,TextTruncate=Enum.TextTruncate.None,Parent=f}local g=c("Frame",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,0,0,16),Size=UDim2.new(1,-12,0,1),BackgroundColor3=a.Stroke,BorderSizePixel=0,Parent=f})e:GetPropertyChangedSignal"AbsoluteSize":Connect(function()g.Size=UDim2.new(1,-(e.AbsoluteSize.X+14),0,1)end)task.defer(function()g.Size=UDim2.new(1,-(e.AbsoluteSize.X+14),0,1)end)return n(self,{},{Set=function(b,a)e.Text=string.upper(a)end},f,"Section")end function j:Divider()local b=c("Frame",{Size=UDim2.new(1,0,0,1),BackgroundColor3=a.Stroke,BorderSizePixel=0,LayoutOrder=self:_nextOrder(),Parent=self.List})return n(self,{},{},b,"Divider")end function j:Label(b)b=l(b,{Name="Text",Title="Text"})local c=d{Size=UDim2.new(1,0,0,18),Text=b.Text or"",TextSize=13,FontFace=i.Regular,TextColor3=b.Color or a.Muted,LayoutOrder=self:_nextOrder(),Parent=self.List}o(c,2)local e={Set=function(b,a)c.Text=tostring(a)end,Get=function()return c.Text end}if type(b.Update)=="function"then local a,d=math.max(tonumber(b.UpdateRate)or 1,.05),true e._listeners=e._listeners or{}table.insert(e._listeners,function()d=false end)task.spawn(function()while d and c.Parent do local e,d=pcall(b.Update)if e and d~=nil then c.Text=tostring(d)elseif not e then warn("[Qyrex] label update error: "..tostring(d))end task.wait(a)end end)function e:SetUpdateRate(b)a=math.max(tonumber(b)or a,.05)end end return n(self,b,e,c,"Label")end function j:Paragraph(b)b=l(b,{Title="Name"})local e=B(self,"Frame",0,b)e.AutomaticSize=Enum.AutomaticSize.Y o(e,14,14,11,12)c("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,4),Parent=e})d{Size=UDim2.new(1,0,0,14),Text=b.Name or"",LayoutOrder=1,Parent=e}local f=d{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,Text=b.Content or"",TextSize=13,FontFace=i.Regular,TextColor3=a.Muted,TextWrapped=true,TextTruncate=Enum.TextTruncate.None,TextYAlignment=Enum.TextYAlignment.Top,LayoutOrder=2,Parent=e}return n(self,b,{Set=function(b,a)f.Text=a end},e,"Paragraph")end function j:Button(d)d=l(d,{Title="Name",Description="Desc"})local e=d.Style=="Primary"local h=d.Desc and v or K local c,f=B(self,"TextButton",h,d)c.ClipsDescendants=true if e then c.BackgroundColor3=a.Accent c.BackgroundTransparency=.12 f.Color=a.Accent f.Transparency=.4 c.MouseEnter:Connect(function()b(c,{BackgroundTransparency=0},.12)b(f,{Transparency=0},.12)end)c.MouseLeave:Connect(function()b(c,{BackgroundTransparency=.12},.25)b(f,{Transparency=.4},.25)end)else F(c,f)end local i,g=e and a.AccentDark or a.Text,0 if d.Icon then y(c,d.Icon,e and a.AccentDark or a.Accent,UDim2.new(0,14,.5,0))g=26 end local j=G(c,d.Name or"Button",d.Desc,30)if g>0 then for b,a in ipairs(c:GetChildren())do if a:IsA"TextLabel"then a.Position+=UDim2.fromOffset(g,0)a.Size-=UDim2.fromOffset(g,0)end end end if e then for b,a in ipairs(c:GetChildren())do if a:IsA"TextLabel"then a.TextColor3=i end end end y(c,"chevron-right",e and a.AccentDark or a.Muted,UDim2.new(1,-30,.5,0))c.MouseButton1Click:Connect(function()ah(c)k(d.Callback)end)return n(self,d,{SetText=function(b,a)j.Text=a end},c,"Button")end function j:Toggle(f)local i,o f,i,o=z(self,f,{Title="Name",Description="Desc",CurrentValue="Default",Value="Default"},"TextButton",56,"Toggle")local g=c("Frame",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-14,.5,0),Size=m and UDim2.fromOffset(44,24)or UDim2.fromOffset(36,20),BackgroundColor3=a.Surface3,BorderSizePixel=0,Parent=i})e(g,UDim.new(1,0))h(g,a.Stroke)local j=c("Frame",{AnchorPoint=Vector2.new(0,.5),Position=UDim2.new(0,3,.5,0),Size=m and UDim2.fromOffset(18,18)or UDim2.fromOffset(14,14),BackgroundColor3=a.Muted,BorderSizePixel=0,Parent=g})e(j,UDim.new(1,0))local q=c("ImageLabel",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),Size=UDim2.new(1,24,1,24),BackgroundTransparency=1,Image=t.Glow,ImageColor3=a.Accent,ImageTransparency=1,ZIndex=0,Parent=g})local d={Value=f.Default==true}local function p(h)local e=d.Value local f=h and.25 or 0 b(g,{BackgroundColor3=e and a.Accent or a.Surface3},f)b(q,{ImageTransparency=e and.75 or 1},f)local c=m and 18 or 14 b(j,{Position=e and UDim2.new(0,(m and 44 or 36)-3-c,.5,0)or UDim2.new(0,3,.5,0),BackgroundColor3=e and a.AccentDark or a.Muted},f,Enum.EasingStyle.Back)if h then b(j,{Size=UDim2.fromOffset(c+4,c-2)},.08)task.delay(.08,function()b(j,{Size=UDim2.fromOffset(c,c)},.2,Enum.EasingStyle.Back)end)end end local l=false function d:Set(a,b)a=a==true if a==d.Value then return end d.Value=a p(true)if not l then w(o)end if not b then k(f.Callback,a)end end function d:Get()return d.Value end p(false)i.MouseButton1Click:Connect(function()l=true d:Set(not d.Value)l=false end)local r=n(self,f,d,i,"Toggle")if d.Value then k(f.Callback,true)end return r end function j:Slider(g)local C="Frame"g=l(g,{Title="Name",Description="Desc",CurrentValue="Default",Value="Default",Increment="Step"})local o=g.Min or 0 local D=g.Max or 100 local V=g.Step or 1 local I=g.Suffix or""local J=aa(o,D,V)local y,Q=B(self,C,v,g)F(y,Q)d{Position=UDim2.fromOffset(14,12),Size=UDim2.new(1,-120,0,18),Text=g.Name or"Slider",Parent=y}local q=c(C,{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-10,0,9),Size=UDim2.fromOffset(40,24),BackgroundColor3=a.Surface,BorderSizePixel=0,ClipsDescendants=true,Parent=y})e(q,UDim.new(0,6))local K=h(q)local z=d{Size=UDim2.new(1,0,1,0),TextSize=13,TextColor3=a.Accent,TextXAlignment=Enum.TextXAlignment.Center,TextTruncate=Enum.TextTruncate.None,Parent=q}local j=c("TextBox",{Position=UDim2.fromOffset(9,0),Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,BackgroundTransparency=1,Text="",TextColor3=a.Text,TextSize=13,FontFace=i.Medium,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,Visible=false,Parent=q})c("UISizeConstraint",{MinSize=Vector2.new(14,0),Parent=j})local L=d{Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=I,TextSize=13,TextColor3=a.Accent,TextTruncate=Enum.TextTruncate.None,Visible=false,Parent=q}local E,G=c("TextButton",{Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Text="",AutoButtonColor=false,ZIndex=2,Parent=q}),false local function H(c)local a if G then a=9+j.AbsoluteSize.X/self.Window.Scale.Scale+L.TextBounds.X+9 L.Position=UDim2.fromOffset(9+j.AbsoluteSize.X/self.Window.Scale.Scale,0)else a=z.TextBounds.X+18 end a=math.max(a,36)if c then q.Size=UDim2.fromOffset(a,24)else b(q,{Size=UDim2.fromOffset(a,24)},.2)end end z:GetPropertyChangedSignal"TextBounds":Connect(function()if not G then H(false)end end)j:GetPropertyChangedSignal"AbsoluteSize":Connect(function()if G then H(false)end end)local u=c(C,{Position=UDim2.new(0,14,0,v-18),Size=UDim2.new(1,-28,0,5),BackgroundColor3=a.Surface3,BorderSizePixel=0,Parent=y})e(u,UDim.new(1,0))local R=c(C,{Size=UDim2.new(0,0,1,0),BackgroundColor3=a.Accent,BorderSizePixel=0,Parent=u})e(R,UDim.new(1,0))local x=c("ImageLabel",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(0,0,.5,0),Size=UDim2.fromOffset(28,28),BackgroundTransparency=1,Image=t.Glow,ImageColor3=a.Accent,ImageTransparency=.85,ZIndex=2,Parent=u})local A=c(C,{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(0,0,.5,0),Size=UDim2.fromOffset(12,12),BackgroundColor3=a.Accent,BorderSizePixel=0,ZIndex=3,Parent=u})e(A,UDim.new(1,0))local O=c("TextButton",{Position=UDim2.new(0,8,0,v-(m and 37 or 31)),Size=UDim2.new(1,-16,0,m and 40 or 28),BackgroundTransparency=1,Text="",AutoButtonColor=false,ZIndex=4,Parent=y})local f,s={Value=math.clamp(g.Default or o,o,D)},false E.MouseEnter:Connect(function()b(K,{Color=a.StrokeHover},.12)end)E.MouseLeave:Connect(function()if not j:IsFocused()then b(K,{Color=a.Stroke},.2)end end)E.MouseButton1Click:Connect(function()G=true j.Text=J.format(f.Value)z.Visible=false j.Visible=true L.Visible=I~=""E.Visible=false b(K,{Color=a.StrokeHover},.12)j:CaptureFocus()task.defer(H,false)end)j.FocusLost:Connect(function()local c=tonumber(j.Text)G=false j.Visible=false L.Visible=false z.Visible=true E.Visible=true b(K,{Color=a.Stroke},.2)if c then f:Set(c)end H(false)end)O.MouseEnter:Connect(function()if not s then b(x,{ImageTransparency=.78,Size=UDim2.fromOffset(34,34)},.15)end end)O.MouseLeave:Connect(function()if not s then b(x,{ImageTransparency=.85,Size=UDim2.fromOffset(28,28)},.2)end end)local S=J.snap local function M()return D-o==0 and 0 or(f.Value-o)/(D-o)end local function P(c,d,a)a=a or Enum.EasingStyle.Linear b(R,{Size=UDim2.new(c,0,1,0)},d,a)b(A,{Position=UDim2.new(c,0,.5,0)},d,a)b(x,{Position=UDim2.new(c,0,.5,0)},d,a)end local function T(a,b)P(M(),a,b)z.Text=J.format(f.Value)..I end local function W(b)local a=M()local c=math.max(u.AbsoluteSize.X,1)local d=(a>=b and 1 or-1)*(5/c)P(math.clamp(a+d,0,1),.22,Enum.EasingStyle.Quint)task.delay(.22,function()if not s then P(M(),.18,Enum.EasingStyle.Quint)end end)z.Text=J.format(f.Value)..I end local function X()b(A,{Size=UDim2.fromOffset(14,12)},.08)b(x,{Size=UDim2.fromOffset(32,32),ImageTransparency=.78},.12)task.delay(.1,function()b(A,{Size=UDim2.fromOffset(12,12)},.25,Enum.EasingStyle.Quint)b(x,{Size=UDim2.fromOffset(28,28),ImageTransparency=.85},.25)end)end function f:Set(a,b)a=S(tonumber(a)or o)if a==f.Value then return end local c=M()f.Value=a if s then T(.05)else W(c)X()w(Q)end if not b then k(g.Callback,a)end end function f:Get()return f.Value end local function U(a)local b=math.clamp((a-u.AbsolutePosition.X)/u.AbsoluteSize.X,0,1)f:Set(o+(D-o)*b)end O.InputBegan:Connect(function(a)if p(a)then s=true b(A,{Size=UDim2.fromOffset(16,16)},.15,Enum.EasingStyle.Back)b(x,{Size=UDim2.fromOffset(44,44),ImageTransparency=.7},.15)U(r().X)end end)self.Window:_listen("Changed",function(a)if s and N(a)then U(r().X)end end,f)self.Window:_listen("Ended",function(a)if s and p(a)then s=false b(A,{Size=UDim2.fromOffset(12,12)},.2)b(x,{Size=UDim2.fromOffset(28,28),ImageTransparency=.85},.2)end end,f)f.Value=S(f.Value)T(0)task.defer(H,true)return n(self,g,f,y,"Slider")end function j:Dropdown(f)local y="Frame"f=l(f,{Title="Name",Description="Desc",CurrentOption="Default",Value="Default",MultipleOptions="Multi",Values="Options"})if f.Multi and type(f.Default)~="table"and f.Default~=nil then f.Default={f.Default}elseif not f.Multi and type(f.Default)=="table"then f.Default=f.Default[1]end local r=f.Multi==true local o=f.Options or{}local p,O,v f,p,O,v=z(self,f,{},y)p.ClipsDescendants=true local I=c("TextButton",{Size=UDim2.new(1,0,0,v),BackgroundTransparency=1,Text="",AutoButtonColor=false,Parent=p})local S,T=G(I,f.Name or"Dropdown",f.Desc,180)local q=c(y,{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-10,.5,0),Size=UDim2.fromOffset(60,s),BackgroundColor3=a.Surface,BorderSizePixel=0,ClipsDescendants=true,Parent=I})e(q,UDim.new(0,6))local U=h(q)local J=d{Position=UDim2.fromOffset(10,0),Size=UDim2.new(1,-34,1,0),TextColor3=a.Muted,TextSize=13,TextTruncate=Enum.TextTruncate.None,ClipsDescendants=true,Parent=q}local V=Z(q,1,-6)local A,x=d{Size=UDim2.fromOffset(0,s),AutomaticSize=Enum.AutomaticSize.X,TextSize=13,Visible=false,Parent=q},""local function W()A.Text=x if A.TextBounds.X<=146 then return x end local a=x while#a>1 do a=a:sub(1,-2)A.Text=a..".."if A.TextBounds.X<=146 then return a..".."end end return".."end local function P(c)local a=math.clamp(J.TextBounds.X+10+34,60,190)H(S,T,a+20)if c then q.Size=UDim2.fromOffset(a,s)else b(q,{Size=UDim2.fromOffset(a,s)},.2)end end J:GetPropertyChangedSignal"TextBounds":Connect(function()P(false)end)local K=c(y,{Position=UDim2.new(0,10,0,v),Size=UDim2.new(1,-20,0,0),BackgroundTransparency=1,Parent=p})c("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,4),Parent=K})local g={Open=false}local j={}local m,B={},""local X=f.SearchAfter or 6 local t=c(y,{Size=UDim2.new(1,0,0,L),BackgroundColor3=a.Surface,BackgroundTransparency=1,BorderSizePixel=0,LayoutOrder=0,Visible=false,Parent=K})e(t,UDim.new(0,6))local Y=h(t,a.Stroke,1)local C=c("TextBox",{Position=UDim2.fromOffset(12,0),Size=UDim2.new(1,-20,1,0),BackgroundTransparency=1,Text="",PlaceholderText="Search",PlaceholderColor3=a.Muted,TextColor3=a.Text,TextSize=13,FontFace=i.Regular,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,TextTransparency=1,Parent=t})local function Q(a)return B==""or string.find(string.lower(tostring(a)),B,1,true)~=nil end if r then for b,a in ipairs(f.Default or{})do j[a]=true end elseif f.Default~=nil then j[f.Default]=true end local function D()if r then local a={}for c,b in ipairs(o)do if j[b]then table.insert(a,b)end end return a end for b,a in ipairs(o)do if j[a]then return a end end return nil end local function E()local c=D()if r then x=#c>0 and table.concat(c,", ")or"None"else x=c~=nil and tostring(c)or"None"end J.Text=W()for e,d in pairs(m)do local c=j[e]==true if d.On~=c then d.On=c b(d.Label,{TextColor3=c and a.Text or a.Muted},.15)if g.Open then b(d.Check,{ImageTransparency=c and 0 or 1},.15)b(d.CheckScale,{Scale=c and 1 or.6},c and.3 or.15,c and Enum.EasingStyle.Back or Enum.EasingStyle.Quint)end end end end local function aa()local a=0 for c,b in ipairs(o)do if Q(b)then a+=1 end end return a end local function M()for a,b in pairs(m)do b.Frame.Visible=Q(a)end end local function N()local a=aa()+(t.Visible and 1 or 0)return v+a*(L+4)+8 end local function F(c)g.Open=c t.Visible=#o>X if not c then B=""C.Text=""M()end b(p,{Size=UDim2.new(1,0,0,c and N()or v)},.3,Enum.EasingStyle.Quint)b(t,{BackgroundTransparency=c and 0 or 1},.2)b(Y,{Transparency=c and 0 or 1},.2)b(C,{TextTransparency=c and 0 or 1},.2)V:Set(c)b(U,{Color=c and a.StrokeHover or a.Stroke},.2)local function d(d)if not d.Stroke then d.Stroke=h(d.Frame,a.Stroke,1)end local e=c and d.On b(d.Check,{ImageTransparency=e and 0 or 1},.18)d.CheckScale.Scale=e and 1 or.6 b(d.Label,{TextTransparency=c and 0 or 1},.18)b(d.Stroke,{Transparency=c and 0 or 1},.18)b(d.Frame,{BackgroundTransparency=c and 0 or 1},.18)end if c then local a=(g._openGeneration or 0)+1 g._openGeneration=a task.spawn(function()local b=true for f,e in ipairs(o)do local c=m[e]if c and c.Frame.Visible then if not b then task.wait(.025)if g._openGeneration~=a or not g.Open then return end end b=false d(c)end end end)else local b=(g._openGeneration or 0)+1 g._openGeneration=b local a={}for d,c in ipairs(o)do local b=m[c]if b and b.Frame.Visible then table.insert(a,b)end end task.spawn(function()for c=#a,1,-1 do d(a[c])if c>1 then task.wait(.015)if g._openGeneration~=b or g.Open then return end end end end)end end local function R()local h={}for a,b in ipairs(o)do h[b]=a end for a,b in pairs(m)do if not h[a]then b.Frame:Destroy()m[a]=nil end end for n,g in ipairs(o)do local o=m[g]if o then o.Frame.LayoutOrder=n continue end local h=c("TextButton",{Size=UDim2.new(1,0,0,L),BackgroundColor3=a.Surface,BackgroundTransparency=1,Text="",AutoButtonColor=false,LayoutOrder=n,Parent=K})e(h,UDim.new(0,6))local i=c("ImageLabel",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-10,.5,0),Size=UDim2.fromOffset(14,14),BackgroundTransparency=1,ImageColor3=a.Accent,ImageTransparency=1,ScaleType=Enum.ScaleType.Fit,Parent=h})u(i,"check")local p=c("UIScale",{Scale=.6,Parent=i})local l=d{Position=UDim2.fromOffset(12,-1),Size=UDim2.new(1,-36,1,0),Text=tostring(g),TextSize=13,TextColor3=a.Muted,TextTransparency=1,Parent=h}h.MouseEnter:Connect(function()b(l,{TextColor3=a.Text},.15)local c=m[g]if c and c.Stroke then b(c.Stroke,{Color=a.StrokeHover},.12)end end)h.MouseLeave:Connect(function()b(l,{TextColor3=j[g]and a.Text or a.Muted},.2)local c=m[g]if c and c.Stroke then b(c.Stroke,{Color=a.Stroke},.2)end end)h.MouseButton1Click:Connect(function()if j[g]then j[g]=nil else if not r then j={}end j[g]=true end E()k(f.Callback,D())if not r and j[g]then F(false)end end)m[g]={Frame=h,Label=l,Check=i,CheckScale=p,Stroke=nil,On=nil}end M()if g.Open then p.Size=UDim2.new(1,0,0,N())end end function g:Set(a,b)j={}if r then for b,a in ipairs(type(a)=="table"and a or{a})do j[a]=true end elseif a~=nil then j[a]=true end E()w(O)if not b then k(f.Callback,D())end end function g:Get()return D()end function g:Refresh(a,b)o=a or{}if not b then j={}end R()E()if g.Open then F(true)end end function g:SetOpen(a)F(a==true)end I.MouseButton1Click:Connect(function()F(not g.Open)end)C:GetPropertyChangedSignal"Text":Connect(function()B=string.lower(C.Text)M()if g.Open then b(p,{Size=UDim2.new(1,0,0,N())},.2,Enum.EasingStyle.Quint)end end)R()E()task.defer(P,true)return n(self,f,g,p,"Dropdown")end function j:Input(f)local l,p,t,q,r f,l,p,t,q,r=z(self,f,{Title="Name",Description="Desc",PlaceholderText="Placeholder",CurrentValue="Default",Value="Default"},"Frame",160,"Input")local g=c("Frame",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-10,.5,0),Size=UDim2.fromOffset(170,30),BackgroundColor3=a.Surface,BorderSizePixel=0,Parent=l})e(g,UDim.new(0,6))local s=h(g)local m=f.Icon if m then y(g,m,a.Muted,UDim2.new(0,8,.5,0))end local d=c("TextBox",{Position=UDim2.fromOffset(m and 30 or 8,0),Size=UDim2.new(1,m and-38 or-16,1,0),BackgroundTransparency=1,Text=f.Default or"",PlaceholderText=f.Placeholder or"",PlaceholderColor3=a.Muted,TextColor3=a.Text,TextSize=14,FontFace=i.Regular,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,TextTruncate=Enum.TextTruncate.None,ClipsDescendants=true,Parent=g})g.ClipsDescendants=true local o=false local u=(m and 30 or 8)+8 local function j(f)local h=l.AbsoluteSize.X/self.Window.Scale.Scale local c=math.clamp(h-14-110-20,100,200)local i=d.Text local e=d.TextBounds.X if#i==0 then e=math.min(d.TextBounds.X,90)end local a=math.clamp(e+u+12,90,c)+(o and 8 or 0)a=math.min(a,c+8)H(q,r,a+20)if f then g.Size=UDim2.fromOffset(a,30)else b(g,{Size=UDim2.fromOffset(a,30)},.18)end end l:GetPropertyChangedSignal"AbsoluteSize":Connect(function()j(true)end)d:GetPropertyChangedSignal"Text":Connect(function()j(false)end)d:GetPropertyChangedSignal"TextBounds":Connect(function()j(false)end)task.defer(j,true)d.Focused:Connect(function()o=true b(s,{Color=a.StrokeHover},.15)j(false)end)d.FocusLost:Connect(function(c)o=false b(s,{Color=a.Stroke},.15)j(false)if f.Numeric then local a=tonumber(d.Text)if not a then d.Text=""return end end k(f.Callback,d.Text,c)end)return n(self,f,{Set=function(b,a)d.Text=tostring(a)w(p)end,Get=function()return d.Text end},l,"Input")end function j:Keybind(g)local o,p,u,q,r g,o,p,u,q,r=z(self,g,{Title="Name",Description="Desc",CurrentKeybind="Default",Value="Default"},"Frame",110,"Keybind")if type(g.Default)=="string"then g.Default=Enum.KeyCode[g.Default]end local i=c("TextButton",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-10,.5,0),Size=UDim2.fromOffset(44,s),BackgroundColor3=a.Surface,BorderSizePixel=0,Text="",AutoButtonColor=false,ClipsDescendants=true,Parent=o})e(i,UDim.new(0,6))local v=h(i)local j=d{Size=UDim2.new(1,0,1,0),TextSize=13,TextColor3=a.Muted,TextXAlignment=Enum.TextXAlignment.Center,TextTruncate=Enum.TextTruncate.None,Parent=i}local f={Value=g.Default,Listening=false}local function t(c)local a=math.max(j.TextBounds.X+20,m and 44 or 36)H(q,r,a+20)if c then i.Size=UDim2.fromOffset(a,s)else b(i,{Size=UDim2.fromOffset(a,s)},.2)end end j:GetPropertyChangedSignal"TextBounds":Connect(function()t(false)end)local function l()j.Text=f.Listening and"..."or P(f.Value)b(v,{Color=f.Listening and a.StrokeHover or a.Stroke},.15)b(j,{TextColor3=f.Listening and a.Accent or a.Muted},.15)end function f:Set(a,b)local c=f.Listening f.Value=a f.Listening=false l()if not c then w(p)end if not b then k(g.OnChanged,a)end end i.MouseButton1Click:Connect(function()f.Listening=not f.Listening l()end)self.Window:_listen("Began",function(a,b)if a.UserInputType~=Enum.UserInputType.Keyboard then return end if f.Listening then self.Window._consumedKey=a.KeyCode self.Window._consumedAt=os.clock()if a.KeyCode==Enum.KeyCode.Escape then f.Listening=false l()else f:Set(a.KeyCode)end return end if not b and f.Value~=nil and a.KeyCode==f.Value then k(g.Callback,a.KeyCode)end end,f)l()task.defer(t,true)function f:Get()return f.Value end return n(self,g,f,o,"Keybind")end function j:ColorPicker(j)local D,l,E,F="Default","Frame","TextButton","UIGradient"local m,K,u j,m,K,u=z(self,j,{Title="Name",Description="Desc",Color=D,CurrentValue=D,Value=D},l)m.ClipsDescendants=true local A=c(E,{Size=UDim2.new(1,0,0,u),BackgroundTransparency=1,Text="",AutoButtonColor=false,Parent=m})G(A,j.Name or"Color",j.Desc,90)local H=c(l,{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-34,.5,0),Size=UDim2.fromOffset(36,20),BorderSizePixel=0,Parent=A})e(H,UDim.new(0,6))h(H,a.Stroke)local S=Z(A,1,-12)local o=c(l,{Position=UDim2.fromOffset(14,u+2),Size=UDim2.new(1,-28,0,156),BackgroundTransparency=1,Visible=false,Parent=m})local g=c(E,{Size=UDim2.new(1,-30,0,110),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,Text="",AutoButtonColor=false,ClipsDescendants=true,Parent=o})e(g,UDim.new(0,6))local T=c(F,{Color=ColorSequence.new(Color3.new(1,1,1),Color3.new(1,0,0)),Parent=g})local U=c(l,{Size=UDim2.fromScale(1,1),BackgroundColor3=Color3.new(0,0,0),BorderSizePixel=0,Parent=g})c(F,{Transparency=NumberSequence.new{NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(1,0)},Rotation=90,Parent=U})local v=c(l,{AnchorPoint=Vector2.new(.5,.5),Size=UDim2.fromOffset(10,10),BackgroundTransparency=1,ZIndex=3,Parent=g})e(v,UDim.new(1,0))h(v,Color3.new(1,1,1),0,2)local q=c(E,{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,0,0,0),Size=UDim2.fromOffset(14,110),BorderSizePixel=0,Text="",AutoButtonColor=false,Parent=o})e(q,UDim.new(0,6))c(F,{Color=ColorSequence.new{ColorSequenceKeypoint.new(0,Color3.fromRGB(255,0,0)),ColorSequenceKeypoint.new(.16666666666666666,Color3.fromRGB(255,255,0)),ColorSequenceKeypoint.new(.3333333333333333,Color3.fromRGB(0,255,0)),ColorSequenceKeypoint.new(.5,Color3.fromRGB(0,255,255)),ColorSequenceKeypoint.new(.6666666666666666,Color3.fromRGB(0,0,255)),ColorSequenceKeypoint.new(.8333333333333334,Color3.fromRGB(255,0,255)),ColorSequenceKeypoint.new(1,Color3.fromRGB(255,0,0))},Rotation=90,Parent=q})local x=c(l,{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(.5,0,0,0),Size=UDim2.fromOffset(18,5),BackgroundColor3=Color3.new(1,1,1),BorderSizePixel=0,ZIndex=3,Parent=q})e(x,UDim.new(1,0))h(x,a.AccentDark,.4)local I=c(l,{Position=UDim2.fromOffset(6,122),Size=UDim2.fromOffset(118,28),BackgroundColor3=a.Surface,BorderSizePixel=0,Parent=o})e(I,UDim.new(0,6))local L=h(I)local s=c("TextBox",{Position=UDim2.fromOffset(14,0),Size=UDim2.new(1,-24,1,0),BackgroundTransparency=1,Text="",TextTruncate=Enum.TextTruncate.None,ClipsDescendants=false,TextColor3=a.Text,TextSize=13,FontFace=i.Regular,TextXAlignment=Enum.TextXAlignment.Left,ClearTextOnFocus=false,Parent=I})local V=d{Position=UDim2.fromOffset(134,122),Size=UDim2.new(1,-134,0,28),TextXAlignment=Enum.TextXAlignment.Right,TextSize=13,FontFace=i.Regular,TextColor3=a.Muted,Parent=o}local f={Open=false}local y,B,C=Color3.toHSV(j.Default or a.Accent)local t local function M(a)return string.format("#%02X%02X%02X",math.floor(a.R*255+.5),math.floor(a.G*255+.5),math.floor(a.B*255+.5))end local function O(c)local a=Color3.fromHSV(y,B,C)f.Value=a H.BackgroundColor3=a T.Color=ColorSequence.new(Color3.new(1,1,1),Color3.fromHSV(y,1,1))b(v,{Position=UDim2.fromScale(B,1-C)},c,Enum.EasingStyle.Linear)b(x,{Position=UDim2.new(.5,0,y,0)},c,Enum.EasingStyle.Linear)if not s:IsFocused()then s.Text=M(a)end V.Text=string.format("RGB %d, %d, %d",math.floor(a.R*255+.5),math.floor(a.G*255+.5),math.floor(a.B*255+.5))end local function J(a,b)O(a)if not b then k(j.Callback,f.Value)end end function f:Set(a,b)y,B,C=Color3.toHSV(a)J(.25,b)w(K)end function f:Get()return f.Value end local function P(a)f.Open=a b(m,{Size=UDim2.new(1,0,0,a and u+168 or u)},.35,Enum.EasingStyle.Quint)S:Set(a)if a then o.Visible=true else task.delay(.35,function()if not f.Open then o.Visible=false end end)end end function f:SetOpen(a)P(a==true)end A.MouseButton1Click:Connect(function()P(not f.Open)end)local function Q(a)B=math.clamp((a.X-g.AbsolutePosition.X)/g.AbsoluteSize.X,0,1)C=1-math.clamp((a.Y-g.AbsolutePosition.Y)/g.AbsoluteSize.Y,0,1)J(.04)end local function R(a)y=math.clamp((a.Y-q.AbsolutePosition.Y)/q.AbsoluteSize.Y,0,.999)J(.04)end g.InputBegan:Connect(function(a)if p(a)then t="sv"b(v,{Size=UDim2.fromOffset(14,14)},.15,Enum.EasingStyle.Back)Q(r())end end)q.InputBegan:Connect(function(a)if p(a)then t="hue"b(x,{Size=UDim2.fromOffset(20,7)},.15,Enum.EasingStyle.Back)R(r())end end)self.Window:_listen("Changed",function(b)if not t or not N(b)then return end local a=r()if t=="sv"then Q(a)else R(a)end end,f)self.Window:_listen("Ended",function(a)if t and p(a)then t=nil b(v,{Size=UDim2.fromOffset(10,10)},.2)b(x,{Size=UDim2.fromOffset(18,5)},.2)end end,f)s.Focused:Connect(function()b(L,{Color=a.StrokeHover},.15)end)s.FocusLost:Connect(function()b(L,{Color=a.Stroke},.15)local c,d,e=s.Text:match"^%s*#?(%x%x)(%x%x)(%x%x)%s*$"if c then f:Set(Color3.fromRGB(tonumber(c,16),tonumber(d,16),tonumber(e,16)))else s.Text=M(f.Value)end end)O(0)return n(self,j,f,m,"ColorPicker")end function j:Stepper(g)local o,t,J,u,v g,o,t,J,u,v=z(self,g,{Title="Name",Description="Desc",CurrentValue="Default",Value="Default",Increment="Step"},"Frame",150,"Stepper")local l=g.Min or 0 local q=g.Max or 100 local x=g.Step or 1 local K=g.Suffix or""local y=aa(l,q,x)local j=c("Frame",{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,-10,.5,0),Size=UDim2.fromOffset(0,s),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=a.Surface,BorderSizePixel=0,Parent=o})e(j,UDim.new(0,6))local A=h(j)c("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Center,Parent=j})local function B(e,f)local d=c("TextButton",{Size=UDim2.fromOffset(s,s),BackgroundTransparency=1,Text=e,TextColor3=a.Muted,TextSize=18,FontFace=i.Medium,AutoButtonColor=false,LayoutOrder=f,Parent=j})d.MouseEnter:Connect(function()b(d,{TextColor3=a.Accent},.12)end)d.MouseLeave:Connect(function()b(d,{TextColor3=a.Muted},.2)end)return d end local C=B("−",1)local m=d{Size=UDim2.new(0,30,1,0),TextSize=13,TextColor3=a.Accent,TextXAlignment=Enum.TextXAlignment.Center,TextTruncate=Enum.TextTruncate.None,LayoutOrder=2,Parent=j}local D=B("+",3)local function E(c)local a=math.max(m.TextBounds.X+12,30)if c then m.Size=UDim2.new(0,a,1,0)else b(m,{Size=UDim2.new(0,a,1,0)},.2)end end m:GetPropertyChangedSignal"TextBounds":Connect(function()E(false)end)j:GetPropertyChangedSignal"AbsoluteSize":Connect(function()H(u,v,j.AbsoluteSize.X/self.Window.Scale.Scale+20)end)local f={Value=math.clamp(g.Default or l,l,q)}local L,r=y.snap,false local function F()m.Text=y.format(f.Value)..K b(C,{TextTransparency=f.Value<=l and.6 or 0},.15)b(D,{TextTransparency=f.Value>=q and.6 or 0},.15)end function f:Set(a,b)a=L(tonumber(a)or l)if a==f.Value then return end f.Value=a F()if not r then w(t)end if not b then k(g.Callback,a)end end function f:Get()return f.Value end local function G(c)r=true f:Set(f.Value+c*x)r=false b(A,{Color=a.StrokeHover},.08)task.delay(.12,function()b(A,{Color=a.Stroke},.2)end)end local function I(b,c)local a=false b.InputBegan:Connect(function(b)if not p(b)then return end a=true G(c)task.delay(.4,function()while a do G(c)task.wait(.07)end end)end)b.InputEnded:Connect(function(b)if p(b)then a=false end end)b.MouseLeave:Connect(function()a=false end)end I(C,-1)I(D,1)F()task.defer(E,true)return n(self,g,f,o,"Stepper")end function j:Progress(f)f=l(f,{Title="Name",Description="Desc",CurrentValue="Default",Value="Default"})local h,s=B(self,"Frame",f.Desc and v+10 or K+10,f)F(h,s)local j=f.Desc and(v-38)/2-2 or 12 d{Position=UDim2.fromOffset(14,j),Size=UDim2.new(1,-110,0,18),Text=f.Name or"Progress",Parent=h}if f.Desc then d{Position=UDim2.fromOffset(14,j+20),Size=UDim2.new(1,-110,0,17),Text=f.Desc,TextSize=13,FontFace=i.Regular,TextColor3=a.Muted,Parent=h}end local o=d{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-14,0,j),Size=UDim2.fromOffset(90,18),TextXAlignment=Enum.TextXAlignment.Right,TextSize=13,TextColor3=a.Accent,Parent=h}local p=c("Frame",{Position=UDim2.new(0,14,1,-16),Size=UDim2.new(1,-28,0,5),BackgroundColor3=a.Surface3,BorderSizePixel=0,Parent=h})e(p,UDim.new(1,0))local m=c("Frame",{Size=UDim2.new(0,0,1,0),BackgroundColor3=f.Color or a.Accent,BorderSizePixel=0,Parent=p})e(m,UDim.new(1,0))local g={Value=math.clamp(f.Default or 0,0,1)}local q=f.Format local function r(c)local a=g.Value b(m,{Size=UDim2.new(a,0,1,0)},c,Enum.EasingStyle.Quint)if type(q)=="function"then o.Text=tostring(q(a))else o.Text=string.format("%d%%",math.floor(a*100+.5))end end function g:Set(a,b)a=math.clamp(tonumber(a)or 0,0,1)if a==g.Value then return end g.Value=a r(.35)if not b then k(f.Callback,a)end end function g:Get()return g.Value end function g:SetColor(a)m.BackgroundColor3=a end r(0)return n(self,f,g,h,"Progress")end function j:ConfigManager(d)d=l(d,{})local a=self.Window local b={}self:Section(d.Name or"Configs")local e=self:Input{Name="Config name",Placeholder=a.ConfigName,Callback=function(a,c)if c and#a>0 then b:Save(a)end end}local c=self:Dropdown{Name="Saved configs",Options=a:ListConfigs(),Default=a.ConfigName,Callback=function(a)if a then e:Set(a)end end}function b:Refresh()c:Refresh(a:ListConfigs(),true)end function b:Save(d)d=d or c:Get()or a.ConfigName local e,f=a:SaveConfig(d)b:Refresh()c:Set(d,true)a:Notify{Title=e and"Config saved"or"Save failed",Content=e and d or tostring(f),Type=e and"Success"or"Error",Duration=3}end function b:Load(b)b=b or c:Get()if not b then return end local d,e=a:LoadConfig(b)a:Notify{Title=d and"Config loaded"or"Load failed",Content=d and b or tostring(e),Type=d and"Success"or"Error",Duration=3}end function b:Delete(d)d=d or c:Get()if not d then return end local e,f=a:DeleteConfig(d)b:Refresh()a:Notify{Title=e and"Config deleted"or"Delete failed",Content=e and d or tostring(f),Type=e and"Info"or"Error",Duration=3}end self:Button{Name="Save",Desc="Writes every flagged element to the selected name",Icon="save",Style="Primary",Callback=function()local a=e:Get()b:Save(#a>0 and a or nil)end}self:Button{Name="Load",Icon="folder-open",Callback=function()b:Load()end}self:Button{Name="Delete",Icon="trash-2",Callback=function()local d=c:Get()if not d then return end a:Confirm{Title="Delete config",Content="Remove "..d.."? This cannot be undone.",Icon="trash-2",ConfirmText="Delete",Callback=function()b:Delete(d)end}end}self:Toggle{Name="Auto save",Desc="Save whenever a flagged element changes",Default=a._autoSaveEnabled,Callback=function(b)a._autoSaveEnabled=b end}return b end for a,b in pairs(table.clone(j))do if type(b)=="function"and a:sub(1,1)~="_"and a:sub(1,6)~="Create"then j["Create"..a]=b end end local function aj()local a pcall(function()if typeof(identifyexecutor)=="function"then a=(identifyexecutor())elseif typeof(getexecutorname)=="function"then a=getexecutorname()end end)if type(a)=="string"and#a>0 then return a end return U:IsStudio()and"Studio"or"Unknown"end local function ak()local b,a=pcall(function()return game:GetService"MarketplaceService":GetProductInfo(game.PlaceId)end)if b and type(a)=="table"and a.Name then return a.Name end return"Unknown game"end local al={US="United States",GB="United Kingdom",DE="Germany",FR="France",NL="Netherlands",SG="Singapore",JP="Japan",AU="Australia",BR="Brazil",IN="India",HK="Hong Kong",CA="Canada"}local function am(a)task.spawn(function()local b=request or http_request or syn and syn.request or http and http.request local c if type(b)=="function"then pcall(function()local a=b{Url="https://ipinfo.io/json",Method="GET"}local d=type(a)=="table"and(a.Body or a.body)or nil if type(d)=="string"then local a=C:JSONDecode(d)if type(a)=="table"and a.country then local b=al[a.country]or a.country c=a.city and a.city..", "..b or b end end end)end a(c or"Unavailable")end)end local an={Success=a.Success,Warning=a.Warning,Error=a.Error}local g={}g.__index=g function f.Window(ab,k)local G,p,H,L,I,A="QyrexUI","Frame","CanvasGroup","UIListLayout","AbsoluteSize","table"k=l(k,{Name="Title",LoadingSubtitle="Subtitle",ToggleUIKeybind="Keybind"})if type(k.Keybind)=="string"then k.Keybind=Enum.KeyCode[k.Keybind]end local V=k.Size or UDim2.fromOffset(640,480)local N=k.Keybind or Enum.KeyCode.RightControl local j=setmetatable({Tabs={},CurrentTab=nil,Open=true,Keybind=N,_connections={},_controls={},_inputListeners={Began={},Changed={},Ended={},Render={}},_frameSteps={},_destroyed=false},g)local function B(a)return function(...)for b,a in ipairs(j._inputListeners[a])do a(...)end end end local W=B"Render"table.insert(j._connections,U.RenderStepped:Connect(function(a)W(a)for c,b in ipairs(j._frameSteps)do b(a)end end))table.insert(j._connections,q.InputBegan:Connect(B"Began"))table.insert(j._connections,q.InputChanged:Connect(B"Changed"))table.insert(j._connections,q.InputEnded:Connect(B"Ended"))local s=c("ScreenGui",{Name=k.Name or G,IgnoreGuiInset=true,ResetOnSpawn=false,DisplayOrder=999,ZIndexBehavior=Enum.ZIndexBehavior.Sibling})j.Gui=s local z=c(p,{Name="Window",AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),Size=V,BackgroundTransparency=1,Parent=s})j.Root=z local O=c("UIScale",{Parent=z})j.Scale=O local Q=c("ImageLabel",{Position=UDim2.fromOffset(-25,-25),Size=UDim2.new(1,50,1,50),BackgroundTransparency=1,Image=t.Shadow,ImageColor3=Color3.new(0,0,0),ImageTransparency=.6,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),Parent=z})j.Shadow=Q local n=c(H,{Name="Body",Size=UDim2.fromScale(1,1),BackgroundColor3=a.Background,BorderSizePixel=0,Parent=z})j.Body=n e(n,UDim.new(0,10))j.BodyStroke=h(n,a.Stroke)M(n)x(n,UDim2.fromOffset(500,180),UDim2.new(.5,0,1,8),.86,270)x(n,UDim2.fromOffset(130,60),UDim2.new(0,-10,1,-10),.75,90)x(n,UDim2.fromOffset(520,240),UDim2.new(1,-14,0,10),.92,90)local C=c(p,{Name="Sidebar",Size=UDim2.new(0,170,1,0),BackgroundTransparency=1,Parent=n})c(p,{Position=UDim2.new(0,170,0,28),Size=UDim2.new(0,1,1,-56),BackgroundColor3=a.Stroke,BorderSizePixel=0,Parent=n})local J=c(p,{Name="Header",Size=UDim2.new(1,0,0,72),BackgroundTransparency=1,Parent=C})local X=c("ImageLabel",{Position=UDim2.fromOffset(22,27),Size=UDim2.fromOffset(30,28),BackgroundTransparency=1,Image="",ImageColor3=a.Accent,ScaleType=Enum.ScaleType.Fit,Parent=J})u(X,k.Icon or t.Logo)d{Position=UDim2.fromOffset(60,25),Size=UDim2.new(1,-70,0,20),Text=k.Title or"Qyrex",TextSize=20,Parent=J}d{Position=UDim2.fromOffset(60,45),Size=UDim2.new(1,-70,0,14),Text=k.Subtitle or"",TextSize=13,FontFace=i.Regular,TextColor3=a.Muted,Parent=J}local v=c("ScrollingFrame",{Name="Tabs",Position=UDim2.fromOffset(0,80),Size=UDim2.new(1,0,1,-116),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=0,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(),Parent=C})j.TabList=v o(v,16,16,4,4)c(L,{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,4),Parent=v})local D=c(p,{AnchorPoint=Vector2.new(0,.5),Position=UDim2.fromOffset(6,0),Size=UDim2.fromOffset(3,18),BackgroundColor3=a.Accent,BorderSizePixel=0,Visible=false,ZIndex=2,Parent=C})e(D,UDim.new(1,0))j.Indicator=D local R=v.CanvasPosition.Y table.insert(j._frameSteps,function()local b=v.CanvasPosition.Y if b==R or not j.CurrentTab or not j._introDone then return end R=b local a=j:_indicatorY(j.CurrentTab)local c=v.Position.Y.Offset local d=c+v.AbsoluteSize.Y/j.Scale.Scale D.Visible=a>c and a<d D.Position=UDim2.fromOffset(6,a)end)local S=c(p,{Position=UDim2.new(0,22,1,-36),Size=UDim2.new(1,-44,0,22),BackgroundTransparency=1,Parent=C})local y=c(p,{Size=UDim2.fromOffset(0,22),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=a.Surface,BorderSizePixel=0,Parent=S})e(y,UDim.new(0,5))h(y)o(y,7,7)local Y=d{Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=P(N),TextSize=11,TextColor3=a.Muted,TextTruncate=Enum.TextTruncate.None,Parent=y}j._keyChipLabel=Y local Z=d{Size=UDim2.new(1,0,1,0),Text=m and"or tap the pill"or"to hide",TextSize=12,FontFace=i.Regular,TextColor3=a.Muted,Parent=S}local function T()Z.Position=UDim2.fromOffset(y.AbsoluteSize.X/j.Scale.Scale+8,0)end y:GetPropertyChangedSignal(I):Connect(T)task.defer(T)local E=c(p,{Name="Content",Position=UDim2.fromOffset(171,0),Size=UDim2.new(1,-171,1,0),BackgroundTransparency=1,ClipsDescendants=true,Parent=n})j.Content=E j._outLayer=c(H,{Name="TransitionOut",Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Visible=false,ZIndex=2,Parent=E})j._inLayer=c(H,{Name="TransitionIn",Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Visible=false,ZIndex=3,Parent=E})local w=c("TextButton",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,-14,0,14),Size=UDim2.fromOffset(34,34),BackgroundColor3=a.Surface2,BackgroundTransparency=1,Text="×",TextColor3=a.Muted,TextSize=28,FontFace=i.Bold,AutoButtonColor=false,ZIndex=5,Parent=E})o(w,0,0,1,0)e(w,UDim.new(0,8))w.MouseEnter:Connect(function()b(w,{BackgroundTransparency=0,TextColor3=a.Text},.15)end)w.MouseLeave:Connect(function()b(w,{BackgroundTransparency=1,TextColor3=a.Muted},.2)end)w.MouseButton1Click:Connect(function()j:Toggle(false)end)local K=c(p,{Name="Notifications",AnchorPoint=Vector2.new(1,1),Position=UDim2.new(1,-20,1,-20),Size=UDim2.new(0,280,1,-40),BackgroundTransparency=1,Parent=s})local function aa()K.Size=UDim2.new(0,math.min(280,s.AbsoluteSize.X-40),1,-40)end table.insert(j._connections,s:GetPropertyChangedSignal(I):Connect(aa))c(L,{SortOrder=Enum.SortOrder.LayoutOrder,VerticalAlignment=Enum.VerticalAlignment.Bottom,Padding=UDim.new(0,4),Parent=K})j.NotifyHolder=K j._notifyOrder=0 j._toasts={}j.MaxNotifications=k.MaxNotifications or 4 j._controlsDirty=true table.insert(j._connections,n.DescendantAdded:Connect(function()j._controlsDirty=true end))table.insert(j._connections,n.DescendantRemoving:Connect(function()j._controlsDirty=true end))j:_enableDrag()j.MaxSize=k.MaxSize j.KeepOnScreen=k.KeepOnScreen~=false j:_enableResize(k.MinSize or Vector2.new(480,360))local F=k.ConfigurationSaving if type(F)==A and F.Enabled~=false then j.ConfigFolder=F.FolderName or G j.ConfigName=F.FileName or"default"j._autoSaveEnabled=true else j.ConfigFolder=G j.ConfigName="default"j._autoSaveEnabled=false end table.insert(j._connections,q.InputBegan:Connect(function(a,b)if b then return end if a.UserInputType==Enum.UserInputType.Keyboard and a.KeyCode==j.Keybind then task.defer(function()local b=j._consumedKey==a.KeyCode and os.clock()-(j._consumedAt or 0)<.2 j._consumedKey=nil if not b and not j._destroyed then j:Toggle(not j.Open)end end)end end))pcall(function()if typeof(syn)=="table"and typeof(syn.protect_gui)=="function"then syn.protect_gui(s)end end)do local par=k.Parent or ag()local ok=pcall(function()s.Parent=par end)if not ok then pcall(function()local plr=D.LocalPlayer local pg=plr and plr:FindFirstChildOfClass("PlayerGui")if pg then s.Parent=pg end end)end end O.Scale=.9 n.GroupTransparency=1 Q.ImageTransparency=1 j.BodyStroke.Transparency=1 z.Visible=false j:_fitToScreen(true)table.insert(j._connections,s:GetPropertyChangedSignal(I):Connect(function()j:_fitToScreen()j:_clampToScreen()end))if k.OpenButton~=nil and k.OpenButton~=false or k.OpenButton==nil and m then j:_createOpenButton(type(k.OpenButton)==A and k.OpenButton or{})end j._introDone=false table.insert(f.Windows,j)if k.Home then j:_buildHome(type(k.Home)==A and k.Home or{})end local r=k.Loading if type(r)==A then k.LoadingDuration=r.Duration or k.LoadingDuration k.LoadingText=r.Text or r.Subtitle or k.LoadingText k.LoadingSteps=r.Steps or k.LoadingSteps k.LoadingTitle=r.Title or k.LoadingTitle r=r.Enabled~=false end if r==false then task.defer(function()j:_playIntro()end)else j:_showLoader(k)end return j end f.CreateWindow=f.Window function f:Notify(b)local a=f.Windows[#f.Windows]if a then return a:Notify(b)end end function f:Confirm(b)local a=f.Windows[#f.Windows]if a then return a:Confirm(b)end end function f:Dialog(b)local a=f.Windows[#f.Windows]if a then return a:Dialog(b)end end local function Q(a,c)local b,d=c.AbsolutePosition,c.AbsoluteSize return a.X>=b.X and a.X<=b.X+d.X and a.Y>=b.Y and a.Y<=b.Y+d.Y end local function ao(c,b,d)local a=c while a and a~=b and a:IsA"GuiObject"do if not a.Visible then return false end local c=a.Parent if c and c~=b and c:IsA"GuiObject"and(c.ClipsDescendants or c:IsA"ScrollingFrame")and not Q(d,c)then return false end a=c end return true end function g:_refreshControls()local a={}for c,b in ipairs(self.Body:GetDescendants())do if b:IsA"GuiButton"or b:IsA"TextBox"or b:GetAttribute"NoDrag"then table.insert(a,b)end end self._controls=a self._controlsDirty=false end function g:_overControl(a)if self._dialog then return true end if self._controlsDirty then self:_refreshControls()end for c,b in ipairs(self._controls)do if b.Parent and Q(a,b)and ao(b,self.Body,a)then return true end end return false end function g:_enableDrag()local a=false local c=Vector2.zero local b local function d()local a=self.Root return a.AbsolutePosition+a.AbsoluteSize*a.AnchorPoint-self.Gui.AbsolutePosition end table.insert(self._connections,q.InputBegan:Connect(function(e)if not p(e)then return end if not self.Open or not self.Root.Visible then return end local b=r()if not Q(b,self.Body)or self:_overControl(b)then return end a=true c=b-d()end))table.insert(self._connections,q.InputEnded:Connect(function(c)if not a then return end if p(c)then a,b=false,nil self:_clampToScreen()end end))table.insert(self._frameSteps,function(f)if not a then return end b=r()-c local g=d()local h=1-math.exp(-f*45)local e=g:Lerp(b,h)self.Root.Position=UDim2.fromOffset(e.X,e.Y)end)end local function ab(a,d,e)if not a.Visible and not e then return end a.Visible=false task.delay(d,function()if not a.Parent then return end local d=c("UIScale",{Scale=.94,Parent=a})a.Visible=true b(d,{Scale=1},.4,Enum.EasingStyle.Back)task.delay(.4,function()d:Destroy()end)end)end function g:_revealCards(a,c)if a._revealed then return end a._revealed=true local b=0 for d,a in ipairs(a.List:GetChildren())do if a:IsA"GuiObject"then ab(a,(c or 0)+b*.035)b+=1 end end end function g:_playIntro(c)if self._introDone then return end self._introDone=true task.delay(1,function()self._autoSaveReady=true end)local a,d,e,f=self.Root,self.Body,self.Shadow,self.Scale if self.CurrentTab then self:_revealCards(self.CurrentTab,c and.15 or.25)end a.Visible=true if c then f.Scale=self._fitScale or 1 a.Position=UDim2.fromScale(.5,.5)b(d,{GroupTransparency=0},.3)b(self.BodyStroke,{Transparency=0},.3)b(e,{ImageTransparency=.6},.3)else a.Position=UDim2.new(.5,0,.5,24)b(f,{Scale=self._fitScale or 1},.5,Enum.EasingStyle.Back)b(a,{Position=UDim2.fromScale(.5,.5)},.5,Enum.EasingStyle.Quint)b(d,{GroupTransparency=0},.35)b(self.BodyStroke,{Transparency=0},.35)end if not c then b(e,{ImageTransparency=.6},.5)end for a,b in ipairs(self.Tabs)do ab(b._button,.1+a*.05,true)end self.Indicator.Visible=false task.delay(.15+#self.Tabs*.05,function()if self.CurrentTab then self:_placeIndicator(self.CurrentTab)end end)end function g:_showLoader(g)local j="Frame"local m=g.LoadingDuration or 1.6 local w=self.Gui local f=c("CanvasGroup",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(.5,0,.5,16),Size=UDim2.fromOffset(300,132),BackgroundColor3=a.Background,BorderSizePixel=0,GroupTransparency=1,ZIndex=10,Parent=w})local y=e(f,UDim.new(0,12))local z=h(f,a.Stroke,1)M(f)x(f,UDim2.fromOffset(320,140),UDim2.new(1,-20,0,-20),.85,90)x(f,UDim2.fromOffset(240,100),UDim2.new(0,10,1,10),.9,270)local o=c("UIScale",{Scale=.92,Parent=f})local p=c("ImageLabel",{Position=UDim2.fromOffset(-25,-25),Size=UDim2.new(1,50,1,50),BackgroundTransparency=1,Image=t.Shadow,ImageColor3=Color3.new(0,0,0),ImageTransparency=1,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),ZIndex=0,Parent=f})local q=c(j,{Position=UDim2.fromOffset(24,26),Size=UDim2.fromOffset(40,40),BackgroundTransparency=1,Parent=f})local r=c("ImageLabel",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.fromScale(.5,.5),Size=UDim2.fromScale(.5,.5),Rotation=-14,BackgroundTransparency=1,ImageColor3=a.Accent,ImageTransparency=1,ScaleType=Enum.ScaleType.Fit,Parent=q})u(r,g.Icon or t.Logo)task.delay(.15,function()b(r,{Size=UDim2.fromScale(.85,.85),Rotation=0,ImageTransparency=0},.6,Enum.EasingStyle.Back)end)d{Position=UDim2.fromOffset(78,30),Size=UDim2.new(1,-100,0,22),Text=g.LoadingTitle or g.Title or"Qyrex",TextSize=20,Parent=f}local A=d{Position=UDim2.fromOffset(78,52),Size=UDim2.new(1,-100,0,16),Text=g.LoadingText or g.Subtitle or"Loading",TextSize=13,FontFace=i.Regular,TextColor3=a.Muted,Parent=f}local k=c(j,{Position=UDim2.new(0,24,1,-30),Size=UDim2.new(1,-48,0,4),BackgroundColor3=a.Surface3,BorderSizePixel=0,ClipsDescendants=true,Parent=f})e(k,UDim.new(1,0))local l=c(j,{Size=UDim2.fromScale(0,1),BackgroundColor3=a.Accent,BorderSizePixel=0,Parent=k})e(l,UDim.new(1,0))local n=c(j,{Position=UDim2.fromScale(-.4,0),Size=UDim2.fromScale(.4,1),BackgroundColor3=Color3.new(1,1,1),BackgroundTransparency=.6,BorderSizePixel=0,ZIndex=2,Parent=k})c("UIGradient",{Transparency=NumberSequence.new{NumberSequenceKeypoint.new(0,1),NumberSequenceKeypoint.new(.5,0),NumberSequenceKeypoint.new(1,1)},Parent=n})b(f,{GroupTransparency=0,Position=UDim2.fromScale(.5,.5)},.4,Enum.EasingStyle.Quint)b(o,{Scale=1},.5,Enum.EasingStyle.Back)b(p,{ImageTransparency=.6},.4)local s=T:Create(n,TweenInfo.new(1.1,Enum.EasingStyle.Sine,Enum.EasingDirection.InOut,-1),{Position=UDim2.fromScale(1,0)})s:Play()b(l,{Size=UDim2.fromScale(.85,1)},m*.8,Enum.EasingStyle.Quart)task.spawn(I)local v=g.LoadingSteps or{"Preparing interface","Loading icons","Almost there"}for a,b in ipairs(v)do task.delay(m*(a-1)/#v,function()if f.Parent then A.Text=b end end)end task.delay(m,function()b(l,{Size=UDim2.fromScale(1,1)},.25,Enum.EasingStyle.Quint)task.delay(.25,function()s:Cancel()for c,a in ipairs(f:GetChildren())do if a:IsA"TextLabel"then b(a,{TextTransparency=1},.15)end end for c,a in ipairs(q:GetChildren())do b(a,{ImageTransparency=1},.15)end b(k,{BackgroundTransparency=1},.15)b(l,{BackgroundTransparency=1},.15)b(n,{BackgroundTransparency=1},.1)local a=self._fitScale or 1 local c=self.Root.Size b(f,{Size=UDim2.fromOffset(c.X.Offset*a,c.Y.Offset*a),Position=UDim2.fromScale(.5,.5)},.5,Enum.EasingStyle.Quint)b(y,{CornerRadius=UDim.new(0,10)},.5,Enum.EasingStyle.Quint)b(o,{Scale=1},.5,Enum.EasingStyle.Quint)task.delay(.28,function()self:_playIntro(true)b(f,{GroupTransparency=1},.25)b(z,{Transparency=1},.2)b(p,{ImageTransparency=1},.2)end)task.delay(.6,function()f:Destroy()end)end)end)end function g:_fitToScreen(d)local a=self.Gui.AbsoluteSize if a.X==0 or a.Y==0 then return end local c=self.Root.Size local e=math.min(1,(a.X-24)/math.max(c.X.Offset,1),(a.Y-24)/math.max(c.Y.Offset,1))self._fitScale=math.max(e,.45)if self._introDone and self.Open then if d then self.Scale.Scale=self._fitScale else b(self.Scale,{Scale=self._fitScale},.2)end end end function g:_clampToScreen()if not self.KeepOnScreen then return end local a=self.Gui.AbsoluteSize local d=self.Root local c=d.AbsoluteSize/2 local e=d.AbsolutePosition+c-self.Gui.AbsolutePosition local f=Vector2.new(math.clamp(e.X,math.min(c.X,a.X/2),math.max(a.X-c.X,a.X/2)),math.clamp(e.Y,math.min(c.Y,a.Y/2),math.max(a.Y-c.Y,a.Y/2)))if(f-e).Magnitude>.5 then b(d,{Position=UDim2.fromOffset(f.X,f.Y)},.25,Enum.EasingStyle.Quint)end end function g:_createOpenButton(j)local f=self.Gui local b=c("TextButton",{AnchorPoint=Vector2.new(.5,0),Position=UDim2.new(.5,0,0,14),Size=UDim2.fromOffset(0,40),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=a.Background,BorderSizePixel=0,Text="",AutoButtonColor=false,ZIndex=30,Parent=f})e(b,UDim.new(1,0))h(b,a.Stroke)o(b,12,16)local l=c("ImageLabel",{AnchorPoint=Vector2.new(0,.5),Position=UDim2.new(0,0,.5,0),Size=UDim2.fromOffset(20,20),BackgroundTransparency=1,ImageColor3=a.Accent,ScaleType=Enum.ScaleType.Fit,ZIndex=31,Parent=b})u(l,j.Icon or t.Logo)d{Position=UDim2.fromOffset(28,0),Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=j.Title or"Qyrex",TextSize=13,TextTruncate=Enum.TextTruncate.None,ZIndex=31,Parent=b}self.OpenButton=b local g,i=false,false local k=Vector2.zero b.InputBegan:Connect(function(a)if p(a)then g,i=true,false k=r()-b.AbsolutePosition end end)table.insert(self._connections,q.InputChanged:Connect(function(a)if not g then return end if N(a)then local a=r()-k-f.AbsolutePosition if(a-(b.AbsolutePosition-f.AbsolutePosition)).Magnitude>3 then i=true end b.AnchorPoint=Vector2.new(0,0)b.Position=UDim2.fromOffset(math.clamp(a.X,0,math.max(f.AbsoluteSize.X-b.AbsoluteSize.X,0)),math.clamp(a.Y,0,math.max(f.AbsoluteSize.Y-b.AbsoluteSize.Y,0)))end end))table.insert(self._connections,q.InputEnded:Connect(function(a)if g and p(a)then g=false if not i then self:Toggle()end end end))end function g:_enableResize(i)local j=self.MaxSize or Vector2.new(math.huge,math.huge)local f=c("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(1,4,1,4),Size=UDim2.fromOffset(32,32),BackgroundTransparency=1,Active=true,ZIndex=20,Parent=self.Root})local g,d=c("ImageLabel",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(.5,-16,.5,-16),Size=UDim2.fromOffset(96,96),BackgroundTransparency=1,Image="rbxassetid://120997033468887",ImageColor3=a.Accent,ImageTransparency=.8,ZIndex=20,Parent=f}),false local h=self.Root.Size local k=Vector2.zero local e f.InputBegan:Connect(function(a)if p(a)then d=true h=self.Root.Size k=r()b(g,{ImageTransparency=.35},.1)end end)f.MouseEnter:Connect(function()if not d then b(g,{ImageTransparency=.35},.1)end end)f.MouseLeave:Connect(function()if not d then b(g,{ImageTransparency=.8},.17)end end)table.insert(self._connections,q.InputEnded:Connect(function(a)if d and p(a)then d=false b(g,{ImageTransparency=.8},.17)if e then self.Root.Size=UDim2.fromOffset(e.X,e.Y)e=nil end self:_fitToScreen()self:_clampToScreen()end end))table.insert(self._frameSteps,function(f)if not d then return end local b=(r()-k)/self.Scale.Scale e=Vector2.new(math.clamp(h.X.Offset+b.X*2,i.X,j.X),math.clamp(h.Y.Offset+b.Y*2,i.Y,j.Y))local c=Vector2.new(self.Root.Size.X.Offset,self.Root.Size.Y.Offset)local g=1-math.exp(-f*35)local a=c:Lerp(e,g)a=Vector2.new(math.floor(a.X+.5),math.floor(a.Y+.5))if a~=c then self.Root.Size=UDim2.fromOffset(a.X,a.Y)end end)end local function R(a,b)return a.ConfigFolder.."/"..b..".json"end local function S()local a="function"return type(writefile)==a and type(readfile)==a and type(isfile)==a end local function ap(a)if type(isfolder)=="function"and type(makefolder)=="function"and not isfolder(a)then makefolder(a)end end local function aq(c)local b=c._type local a=c:Get()if b=="Keybind"then return{Type=b,Value=a and a.Name or nil}elseif b=="ColorPicker"then return{Type=b,Value={a.R,a.G,a.B}}end return{Type=b,Value=a}end local function ar(b,e,c)local d=b._type local a=e.Value if d=="Keybind"then b:Set(a and Enum.KeyCode[a]or nil,c)elseif d=="ColorPicker"then if type(a)=="table"then b:Set(Color3.new(a[1],a[2],a[3]),c)end elseif a~=nil then b:Set(a,c)end end function g:SaveConfig(a)a=a or self.ConfigName if not S()then return false,"file API unavailable"end ap(self.ConfigFolder)local b={}for c,a in pairs(f.Flags)do if a._type and type(a.Get)=="function"then b[c]=aq(a)end end local c,d=pcall(function()writefile(R(self,a),C:JSONEncode(b))end)if c then self.ConfigName=a end return c,d end function g:LoadConfig(a,d)a=a or self.ConfigName if not S()then return false,"file API unavailable"end local b=R(self,a)if not isfile(b)then return false,"no config named "..a end local e,c=pcall(function()return C:JSONDecode(readfile(b))end)if not e or type(c)~="table"then return false,"config is not valid JSON"end local g=self._autoSaveEnabled self._autoSaveEnabled=false for c,b in pairs(c)do local a=f.Flags[c]if a and type(a.Set)=="function"and type(b)=="table"and b.Type==a._type then pcall(ar,a,b,d==true)end end self._autoSaveEnabled=g self._autoSaveReady=true self.ConfigName=a return true end function g:DeleteConfig(a)if not S()or type(delfile)~="function"then return false,"file API unavailable"end local b=R(self,a)if not isfile(b)then return false,"no config named "..a end delfile(b)return true end function g:ListConfigs()local a={}if type(listfiles)~="function"or type(isfolder)~="function"or not isfolder(self.ConfigFolder)then return a end for d,c in ipairs(listfiles(self.ConfigFolder))do local b=c:match"([^/\\]+)%.json$"if b then table.insert(a,b)end end table.sort(a)return a end function g:_autoSave()if not self._autoSaveEnabled or self._destroyed or not self._autoSaveReady then return end if self._autoSavePending then return end self._autoSavePending=true task.delay(.5,function()self._autoSavePending=false if not self._destroyed then self:SaveConfig(self.ConfigName)end end)end local function as(f,g,h)local b=c("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(.5,0,.5,-10),Size=UDim2.fromOffset(200,70),BackgroundTransparency=1,Parent=f})local e=c("ImageLabel",{AnchorPoint=Vector2.new(.5,0),Position=UDim2.new(.5,0,0,0),Size=UDim2.fromOffset(26,26),BackgroundTransparency=1,ImageColor3=a.Muted,ImageTransparency=.15,ScaleType=Enum.ScaleType.Fit,Parent=b})u(e,g)local j=d{Position=UDim2.fromOffset(0,36),Size=UDim2.new(1,0,0,16),Text=h,TextSize=13,FontFace=i.Regular,TextColor3=a.Muted,TextXAlignment=Enum.TextXAlignment.Center,Parent=b}return b,j,e end local function at(g,i,f,j)local b=c("Frame",{Size=UDim2.new(.5,-4,0,62),BackgroundColor3=a.Surface2,BorderSizePixel=0,LayoutOrder=i,Parent=g})e(b)h(b)b:SetAttribute("NoDrag",true)if f then y(b,f,a.Muted,UDim2.new(0,14,0,21))end d{Position=UDim2.fromOffset(f and 36 or 14,12),Size=UDim2.new(1,-(f and 50 or 28),0,16),Text=j,TextSize=12,TextColor3=a.Muted,Parent=b}return d{Position=UDim2.fromOffset(14,34),Size=UDim2.new(1,-28,0,18),Text="…",TextSize=15,Parent=b}end local function ac(c)local a={}local function d(b)for c,b in ipairs(b:GetChildren())do if b:IsA"TextLabel"or b:IsA"TextButton"or b:IsA"TextBox"then table.insert(a,{b,"TextTransparency",b.TextTransparency})elseif b:IsA"ImageLabel"or b:IsA"ImageButton"then table.insert(a,{b,"ImageTransparency",b.ImageTransparency})elseif b:IsA"UIStroke"then table.insert(a,{b,"Transparency",b.Transparency})elseif b:IsA"Frame"then table.insert(a,{b,"BackgroundTransparency",b.BackgroundTransparency})end d(b)end end if c:IsA"Frame"then table.insert(a,{c,"BackgroundTransparency",c.BackgroundTransparency})end d(c)for c,a in ipairs(a)do a[1][a[2]]=1 b(a[1],{[a[2]]=a[3]},.28)end end local function au(a,c)c=c or 0 a.GroupTransparency=1 a.Position=UDim2.fromOffset(0,c+14)a.Visible=true b(a,{GroupTransparency=0,Position=UDim2.fromOffset(0,c)},.32,Enum.EasingStyle.Quint)end function g:_buildHome(f)local g,n,p,w="Frame","UIListLayout","NoDrag","Executor"local m=self:Tab{Name=f.Name or"Home",Desc=f.Desc,Icon=f.Icon or"house"}local q=m.List local x=f.Pages or f.Tabs local r={}local s if type(x)=="table"and#x>0 then s=c(g,{Size=UDim2.new(1,0,0,32),BackgroundTransparency=1,LayoutOrder=1,Parent=q})c(n,{FillDirection=Enum.FillDirection.Horizontal,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,6),Parent=s})end local y=f.Greeting if y==nil then local a=tonumber(os.date"%H")or 12 local b=a<12 and"morning"or(a<18 and"afternoon"or"evening")y="Good "..b.."."end local j=c(g,{Size=UDim2.new(1,0,0,58),BackgroundColor3=a.Surface2,BorderSizePixel=0,LayoutOrder=2,Parent=q})j:SetAttribute(p,true)e(j)h(j)local z=c("ImageLabel",{Position=UDim2.fromOffset(12,11),Size=UDim2.fromOffset(36,36),BackgroundColor3=a.Surface,BorderSizePixel=0,Parent=j})e(z,UDim.new(0,8))h(z)task.spawn(function()local b,a=pcall(function()return D:GetUserThumbnailAsync(E.UserId,Enum.ThumbnailType.HeadShot,Enum.ThumbnailSize.Size100x100)end)if b and a then z.Image=a end end)d{Position=UDim2.fromOffset(58,11),Size=UDim2.new(1,-72,0,18),Text=(f.Welcome or"Hello, ")..E.DisplayName,TextSize=15,Parent=j}d{Position=UDim2.fromOffset(58,30),Size=UDim2.new(1,-72,0,16),Text=y,TextSize=13,FontFace=i.Regular,TextColor3=a.Muted,Parent=j}local t=c(g,{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=3,Parent=q})c(n,{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,8),Parent=t})if f.Sections~=false then local b=c(g,{Size=UDim2.new(1,0,0,24),BackgroundTransparency=1,LayoutOrder=1,Parent=t})local e=d{Position=UDim2.fromOffset(2,6),Size=UDim2.new(0,0,0,16),AutomaticSize=Enum.AutomaticSize.X,Text=string.upper(f.SectionName or"System info"),TextSize=12,TextColor3=a.Muted,TextTruncate=Enum.TextTruncate.None,Parent=b}local i=c(g,{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,0,0,14),Size=UDim2.new(1,-12,0,1),BackgroundColor3=a.Stroke,BorderSizePixel=0,Parent=b})local function h()i.Size=UDim2.new(1,-(e.AbsoluteSize.X+14),0,1)end e:GetPropertyChangedSignal"AbsoluteSize":Connect(h)task.defer(h)end local C=c(g,{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,LayoutOrder=2,Parent=t})c("UIGridLayout",{CellSize=UDim2.new(.5,-4,0,62),CellPadding=UDim2.fromOffset(8,8),SortOrder=Enum.SortOrder.LayoutOrder,Parent=C})local N=f.Stats or{"FPS","Ping",w,"Game","Region","Time"}local F={}for b,a in ipairs(N)do F[a]=true end local G=0 local function l(a,b,c)if not F[a]then return nil end G+=1 return at(C,G,b,c)end local H=l("FPS","activity","FPS")local I=l("Ping","wifi","Ping")local J=l(w,"terminal",w)local A=l("Game","gamepad-2","Game")local B=l("Region","globe","Server region")local K=l("Time","clock","Time of day")local L=l("Players","users","Players")local M=l("Uptime","timer","Session")if J then J.Text=aj()end if A then A.Text="Loading"task.spawn(function()A.Text=ak()end)end if B then B.Text="Loading"am(function(a)B.Text=a end)end local v=0 local O=os.clock()self:_listen("Render",function()v+=1 end)task.spawn(function()while not self._destroyed and m.List.Parent and m._page.Parent do if not self.Open or self.CurrentTab~=m then v=0 task.wait(1)continue end if H then H.Text=tostring(v)end v=0 if I then local a,b=pcall(function()return math.floor(E:GetNetworkPing()*1e3)end)I.Text=(a and b or 0).." ms"end if K then K.Text=os.date(f.TimeFormat or"%H:%M")end if L then L.Text=#D:GetPlayers().." / "..D.MaxPlayers end if M then local a=math.floor(os.clock()-O)M.Text=string.format("%d:%02d",math.floor(a/60),a%60)end task.wait(1)end end)table.insert(r,{Title=f.SectionName or"Details",Icon=f.TabIcon or"layout-grid",Frame=t})if s then for j,b in ipairs(x)do local f=c(g,{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Visible=false,LayoutOrder=3,Parent=q})c(n,{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,8),Parent=f})if type(b.Content)=="string"then local j=c(g,{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundColor3=a.Surface2,BorderSizePixel=0,LayoutOrder=1,Parent=f})j:SetAttribute(p,true)e(j)h(j)o(j,14,14,12,14)d{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,Text=b.Content,TextSize=13,FontFace=i.Regular,TextColor3=a.Muted,TextWrapped=true,TextTruncate=Enum.TextTruncate.None,TextYAlignment=Enum.TextYAlignment.Top,Parent=j}end if type(b.Entries)=="table"then for m,b in ipairs(b.Entries)do local j=c(g,{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundColor3=a.Surface2,BorderSizePixel=0,LayoutOrder=m,Parent=f})j:SetAttribute(p,true)e(j)h(j)o(j,14,14,12,14)c(n,{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,4),Parent=j})local l=c(g,{Size=UDim2.new(1,0,0,18),BackgroundTransparency=1,LayoutOrder=1,Parent=j})d{Size=UDim2.new(1,-70,1,0),Text=b.Title or b.Version or"Update",TextSize=14,Parent=l}if b.Date or b.Tag then local f=c(g,{AnchorPoint=Vector2.new(1,.5),Position=UDim2.new(1,0,.5,0),Size=UDim2.fromOffset(0,20),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=a.Surface,BorderSizePixel=0,Parent=l})e(f,UDim.new(0,5))h(f)o(f,8,8)d{Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=b.Tag or b.Date,TextSize=11,TextColor3=a.Muted,TextTruncate=Enum.TextTruncate.None,Parent=f}end local k=b.Content or b.Body if type(b.Changes)=="table"then k="• "..table.concat(b.Changes,"\n• ")end if k then d{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,Text=k,TextSize=13,FontFace=i.Regular,TextColor3=a.Muted,TextWrapped=true,TextTruncate=Enum.TextTruncate.None,TextYAlignment=Enum.TextYAlignment.Top,LayoutOrder=2,Parent=j}end end end if type(b.Build)=="function"then k(b.Build,f)for b,a in ipairs(f:GetChildren())do if a:IsA"GuiObject"then a:SetAttribute(p,true)end end end table.insert(r,{Title=b.Name or b.Title or"Page",Icon=b.Icon,Frame=f})end local f={}local function l(c,d)local e=self._homeIndex~=c self._homeIndex=c j.Visible=c==1 if c==1 and e and not d then ac(j)end for i,k in ipairs(r)do local g=i==c local j=k.Frame j.Visible=g if g and e and not d then for b,a in ipairs(j:GetChildren())do if a:IsA"GuiObject"then ac(a)end end end local h=f[i]if h then b(h.Frame,{BackgroundTransparency=g and 0 or 1},.15)b(h.Stroke,{Transparency=g and 0 or 1},.15)b(h.Label,{TextColor3=g and a.Text or a.Muted},.15)if h.Icon then b(h.Icon,{ImageColor3=g and a.Accent or a.Muted},.15)end end end end for i,k in ipairs(r)do local g=c("TextButton",{Size=UDim2.fromOffset(0,32),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=a.Surface2,BackgroundTransparency=1,Text="",AutoButtonColor=false,LayoutOrder=i,Parent=s})e(g,UDim.new(0,7))local m=h(g,a.Stroke,1)o(g,12,12)local j if k.Icon then j=c("ImageLabel",{AnchorPoint=Vector2.new(0,.5),Position=UDim2.new(0,0,.5,0),Size=UDim2.fromOffset(14,14),BackgroundTransparency=1,ImageColor3=a.Muted,ScaleType=Enum.ScaleType.Fit,Parent=g})u(j,k.Icon)end local n=d{Position=UDim2.fromOffset(j and 20 or 0,0),Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=k.Title,TextSize=13,TextColor3=a.Muted,TextTruncate=Enum.TextTruncate.None,Parent=g}f[i]={Frame=g,Stroke=m,Label=n,Icon=j}g.MouseEnter:Connect(function()if self._homeIndex~=i then b(g,{BackgroundTransparency=.4},.12)b(m,{Transparency=.5},.12)end end)g.MouseLeave:Connect(function()if self._homeIndex~=i then b(g,{BackgroundTransparency=1},.2)b(m,{Transparency=1},.2)end end)g.MouseButton1Click:Connect(function()l(i)end)end l(1)end m._order=10 self.Home=m return m end function g:Tab(g,t)g=l(g,{Title="Name",Description="Desc"})if t~=nil and g.Icon==nil then g.Icon=t end local f=setmetatable({Name=g.Name or"Tab",Window=self,_order=0},j)local k=c("TextButton",{Size=UDim2.new(1,0,0,38),BackgroundColor3=a.Surface2,BackgroundTransparency=1,Text="",AutoButtonColor=false,LayoutOrder=#self.Tabs+1,Parent=self.TabList})e(k)local q=h(k,a.Stroke,1)f._button=k local r=g.Icon~=nil if r then local b=c("ImageLabel",{AnchorPoint=Vector2.new(0,.5),Position=UDim2.new(0,12,.5,0),Size=UDim2.fromOffset(16,16),BackgroundTransparency=1,ImageColor3=a.Muted,ScaleType=Enum.ScaleType.Fit,Parent=k})u(b,g.Icon)f._icon=b end f._label=d{Position=UDim2.fromOffset(r and 36 or 14,0),Size=UDim2.new(1,-(r and 44 or 22),1,0),Text=f.Name,TextColor3=a.Muted,Parent=k}local m=c("Frame",{Name=f.Name,Size=UDim2.fromScale(1,1),BackgroundTransparency=1,Visible=false,Parent=self.Content})f._page=m d{Position=UDim2.fromOffset(24,20),Size=UDim2.new(1,-72,0,24),Text=f.Name,TextSize=22,Parent=m}if g.Desc then d{Position=UDim2.fromOffset(24,44),Size=UDim2.new(1,-72,0,16),Text=g.Desc,TextSize=13,FontFace=i.Regular,TextColor3=a.Muted,Parent=m}end local v=g.Desc and 70 or 58 local n=c("ScrollingFrame",{Position=UDim2.fromOffset(0,v),Size=UDim2.new(1,0,1,-v),BackgroundTransparency=1,BorderSizePixel=0,ScrollBarThickness=2,ScrollBarImageColor3=a.Accent,ScrollBarImageTransparency=.5,AutomaticCanvasSize=Enum.AutomaticSize.Y,CanvasSize=UDim2.new(),Parent=m})o(n,24,24,2,24)c("UIListLayout",{SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,8),Parent=n})f.List=n local s,p=as(m,g.Icon or"layout-grid",g.EmptyText or"Nothing here yet"),0 n.ChildAdded:Connect(function(a)if a:IsA"GuiObject"then p+=1 s.Visible=false end end)n.ChildRemoved:Connect(function(a)if a:IsA"GuiObject"then p=math.max(p-1,0)s.Visible=p<=0 end end)s.Visible=true k.MouseEnter:Connect(function()if self.CurrentTab~=f then b(k,{BackgroundTransparency=.4},.12)b(q,{Transparency=.5},.12)end end)k.MouseLeave:Connect(function()if self.CurrentTab~=f then b(k,{BackgroundTransparency=1},.2)b(q,{Transparency=1},.2)end end)k.MouseButton1Click:Connect(function()self:SelectTab(f)end)f._stroke=q if not self._introDone then k.Visible=false end table.insert(self.Tabs,f)if#self.Tabs==1 then task.defer(function()self:SelectTab(f)end)end return f end g.CreateTab=g.Tab function g:Dialog(j)local s="TextTransparency"j=l(j,{Text="Content",Message="Content"})if self._dialog then self._dialog.Close()end local f=18 local q=c("TextButton",{Size=UDim2.fromScale(1,1),BackgroundColor3=Color3.new(0,0,0),BackgroundTransparency=1,Text="",AutoButtonColor=false,ZIndex=40,Parent=self.Body})local g=c("Frame",{AnchorPoint=Vector2.new(.5,.5),Position=UDim2.new(.5,0,.5,10),Size=UDim2.fromOffset(300,120),BackgroundColor3=a.Background,BackgroundTransparency=1,BorderSizePixel=0,ZIndex=41,Parent=q})e(g,UDim.new(0,10))local u=h(g,a.Stroke,1)local v=c("UIScale",{Scale=.94,Parent=g})local m,t={},0 if j.Icon then local c,b=y(g,j.Icon,a.Accent,UDim2.new(0,f,0,f+9))b.ImageTransparency=1 c.ZIndex=42 b.ZIndex=42 table.insert(m,{b,"ImageTransparency",0})t=24 end local x=d{Position=UDim2.fromOffset(f+t,f),Size=UDim2.new(1,-(f*2+t),0,18),Text=j.Title or"Are you sure?",TextSize=15,TextTransparency=1,ZIndex=42,Parent=g}table.insert(m,{x,s,0})local n=0 if j.Content then local b=d{Position=UDim2.fromOffset(f,f+24),Size=UDim2.new(1,-f*2,0,0),AutomaticSize=Enum.AutomaticSize.Y,Text=j.Content,TextSize=13,FontFace=i.Regular,TextColor3=a.Muted,TextWrapped=true,TextTransparency=1,TextTruncate=Enum.TextTruncate.None,TextYAlignment=Enum.TextYAlignment.Top,ZIndex=42,Parent=g}table.insert(m,{b,s,0})n=math.max(b.TextBounds.Y,16)+6 b:GetPropertyChangedSignal"TextBounds":Connect(function()local a=math.max(b.TextBounds.Y,16)+6 if a~=n then n=a g.Size=UDim2.fromOffset(300,f+24+n+12+34+f)local b=g:FindFirstChild"ButtonRow"if b then b.Position=UDim2.fromOffset(f,f+24+n+12)end end end)end local w=c("Frame",{Name="ButtonRow",Position=UDim2.fromOffset(f,f+24+n+12),Size=UDim2.new(1,-f*2,0,34),BackgroundTransparency=1,ZIndex=42,Parent=g})c("UIListLayout",{FillDirection=Enum.FillDirection.Horizontal,HorizontalAlignment=Enum.HorizontalAlignment.Right,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,8),Parent=w})g.Size=UDim2.fromOffset(300,f+24+n+12+34+f)local p,r={},false function p.Close()if r then return end r=true if self._dialog==p then self._dialog=nil end b(q,{BackgroundTransparency=1},.18)b(g,{BackgroundTransparency=1,Position=UDim2.new(.5,0,.5,8)},.18,Enum.EasingStyle.Quint)b(v,{Scale=.96},.18,Enum.EasingStyle.Quint)b(u,{Transparency=1},.12)for c,a in ipairs(m)do b(a[1],{[a[2]]=1},.12)end task.delay(.2,function()q:Destroy()end)end for q,j in ipairs(j.Buttons or{})do local g=j.Variant=="Primary"local f=c("TextButton",{Size=UDim2.fromOffset(0,34),AutomaticSize=Enum.AutomaticSize.X,BackgroundColor3=g and a.Accent or a.Surface2,BackgroundTransparency=1,BorderSizePixel=0,Text="",AutoButtonColor=false,ClipsDescendants=true,LayoutOrder=q,ZIndex=43,Parent=w})e(f,UDim.new(0,7))local i=h(f,g and a.Accent or a.Stroke,1)o(f,14,14)local t=d{Size=UDim2.new(0,0,1,0),AutomaticSize=Enum.AutomaticSize.X,Text=j.Title or j.Name or"OK",TextSize=13,TextColor3=g and a.AccentDark or a.Text,TextXAlignment=Enum.TextXAlignment.Center,TextTransparency=1,ZIndex=44,Parent=f}local l=g and.12 or 0 local n=g and.4 or 0 table.insert(m,{f,"BackgroundTransparency",l})table.insert(m,{i,"Transparency",n})table.insert(m,{t,s,0})f.MouseEnter:Connect(function()if r then return end if g then b(f,{BackgroundTransparency=0},.12)b(i,{Transparency=0},.12)else b(i,{Color=a.StrokeHover},.12)end end)f.MouseLeave:Connect(function()if r then return end if g then b(f,{BackgroundTransparency=l},.2)b(i,{Transparency=n},.2)else b(i,{Color=a.Stroke},.2)end end)f.MouseButton1Click:Connect(function()p.Close()k(j.Callback)end)end if j.CloseOnBackdrop~=false then q.MouseButton1Click:Connect(function()p.Close()k(j.OnCancel)end)end self._dialog=p b(q,{BackgroundTransparency=.45},.25)b(g,{BackgroundTransparency=0,Position=UDim2.fromScale(.5,.5)},.3,Enum.EasingStyle.Quint)b(u,{Transparency=0},.25)b(v,{Scale=1},.4,Enum.EasingStyle.Back)for c,a in ipairs(m)do b(a[1],{[a[2]]=a[3]},.25)end return p end function g:Confirm(a)a=l(a,{Text="Content",Message="Content"})return self:Dialog{Title=a.Title or"Are you sure?",Content=a.Content,Icon=a.Icon,OnCancel=a.OnCancel,Buttons={{Title=a.CancelText or"Cancel",Callback=a.OnCancel},{Title=a.ConfirmText or"Confirm",Variant="Primary",Callback=a.Callback}}}end function g:_listen(e,c,a)local b=self._inputListeners[e]table.insert(b,c)local function d()for a,d in ipairs(b)do if d==c then table.remove(b,a)break end end end if a then a._listeners=a._listeners or{}table.insert(a._listeners,d)end return d end function g:_indicatorY(a)local b=self.TabList local c=self.Scale.Scale return(a._button.AbsolutePosition.Y-b.AbsolutePosition.Y+a._button.AbsoluteSize.Y/2)/c+b.Position.Y.Offset end function g:_placeIndicator(d)local a=self.Indicator local c=self:_indicatorY(d)if not a.Visible then a.Visible=true a.Position=UDim2.fromOffset(6,c)a.Size=UDim2.fromOffset(3,0)end b(a,{Position=UDim2.fromOffset(6,c),Size=UDim2.fromOffset(3,18)},.35,Enum.EasingStyle.Back)end function g:SelectTab(c)if self.CurrentTab==c then return end local d=self.CurrentTab self.CurrentTab=c self:_settleTransition()local f=(self._transitionGeneration or 0)+1 self._transitionGeneration=f if d then b(d._button,{BackgroundTransparency=1},.2)b(d._stroke,{Transparency=1},.2)b(d._label,{TextColor3=a.Muted},.2)if d._icon then b(d._icon,{ImageColor3=a.Muted},.2)end local c=self._outLayer d._page.Parent=c self._outPage=d._page c.GroupTransparency=0 c.Position=UDim2.fromOffset(0,0)c.Visible=true b(c,{GroupTransparency=1,Position=UDim2.fromOffset(0,-10)},.18)task.delay(.18,function()if self._transitionGeneration==f then self:_settleOut()end end)end b(c._button,{BackgroundTransparency=0},.2)b(c._stroke,{Transparency=0},.2)b(c._label,{TextColor3=a.Text},.2)if c._icon then b(c._icon,{ImageColor3=a.Accent},.2)end self:_placeIndicator(c)local e=c._page e.Position=UDim2.fromOffset(0,0)e.Visible=true e.Parent=self._inLayer self._inPage=e au(self._inLayer)task.delay(.32,function()if self._transitionGeneration==f then self:_settleIn()end end)end function g:_settleOut()local a=self._outPage if a then a.Parent=self.Content a.Visible=false self._outPage=nil end self._outLayer.Visible=false end function g:_settleIn()local a=self._inPage if a then a.Parent=self.Content a.Position=UDim2.fromOffset(0,0)self._inPage=nil end self._inLayer.Visible=false end function g:_settleTransition()self:_settleOut()self:_settleIn()end function g:Toggle(a)if not self._introDone then return end if a==nil then a=not self.Open end if a==self.Open then return end self.Open=a if a then self.Root.Visible=true b(self.Scale,{Scale=self._fitScale or 1},.4,Enum.EasingStyle.Back)b(self.Body,{GroupTransparency=0},.25)b(self.BodyStroke,{Transparency=0},.25)b(self.Shadow,{ImageTransparency=.6},.3)else b(self.Scale,{Scale=(self._fitScale or 1)*.94},.2,Enum.EasingStyle.Quint)b(self.Body,{GroupTransparency=1},.16)b(self.BodyStroke,{Transparency=1},.12)b(self.Shadow,{ImageTransparency=1},.16)task.delay(.2,function()if not self.Open then self.Root.Visible=false end end)end end function g:SetKeepOnScreen(a)self.KeepOnScreen=a~=false if self.KeepOnScreen then self:_clampToScreen()end end function g:SetKeybind(a)self.Keybind=a self._keyChipLabel.Text=P(a)end function g:Notify(f)local k="Frame"f=l(f,{Text="Content",Message="Content",Image="Icon"})local u=f.Duration or 4 local s=an[f.Type]or a.Text self._notifyOrder+=1 local j=c(k,{Size=UDim2.new(1,0,0,0),BackgroundTransparency=1,LayoutOrder=self._notifyOrder,Parent=self.NotifyHolder})local r=c(k,{Position=UDim2.fromOffset(320,0),Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Parent=j})local v=c("ImageLabel",{Position=UDim2.fromOffset(-20,-20),Size=UDim2.new(1,40,1,40),BackgroundTransparency=1,Image=t.Shadow,ImageColor3=Color3.new(0,0,0),ImageTransparency=1,ScaleType=Enum.ScaleType.Slice,SliceCenter=Rect.new(49,49,450,450),ZIndex=0,Parent=r})local g=c("CanvasGroup",{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundColor3=a.Background,BorderSizePixel=0,GroupTransparency=1,Parent=r})e(g,UDim.new(0,10))local B=h(g,a.Stroke)M(g)x(g,UDim2.fromOffset(260,120),UDim2.new(1,-10,0,-10),.86,90)local m=c(k,{Size=UDim2.new(1,0,0,0),AutomaticSize=Enum.AutomaticSize.Y,BackgroundTransparency=1,Parent=g})o(m,16,16,14,24)local n=0 if f.Icon then y(m,f.Icon,s==a.Text and a.Accent or s,UDim2.new(0,0,0,8))n=24 end d{Position=UDim2.fromOffset(n,0),Size=UDim2.new(1,-28-n,0,16),Text=f.Title or"Notification",TextSize=14,TextColor3=s,Parent=m}local p=c("TextButton",{AnchorPoint=Vector2.new(1,0),Position=UDim2.new(1,6,0,-5),Size=UDim2.fromOffset(24,24),BackgroundTransparency=1,Text="×",TextColor3=a.Muted,TextSize=22,FontFace=i.Bold,AutoButtonColor=false,Parent=m})p.MouseEnter:Connect(function()b(p,{TextColor3=a.Text},.15)end)p.MouseLeave:Connect(function()b(p,{TextColor3=a.Muted},.2)end)if f.Content then d{Position=UDim2.fromOffset(n,21),Size=UDim2.new(1,-n,0,0),AutomaticSize=Enum.AutomaticSize.Y,Text=f.Content,TextSize=13,FontFace=i.Regular,TextColor3=a.Muted,TextWrapped=true,TextTruncate=Enum.TextTruncate.None,TextYAlignment=Enum.TextYAlignment.Top,Parent=m}end local w=c(k,{AnchorPoint=Vector2.new(0,1),Position=UDim2.new(0,16,1,-8),Size=UDim2.new(1,-32,0,3),BackgroundColor3=a.Surface3,BorderSizePixel=0,Parent=g})e(w,UDim.new(1,0))local z=c(k,{Size=UDim2.fromScale(1,1),BackgroundColor3=a.Accent,BorderSizePixel=0,Parent=w})e(z,UDim.new(1,0))task.defer(function()if j.Parent then b(j,{Size=UDim2.new(1,0,0,g.AbsoluteSize.Y)},.3,Enum.EasingStyle.Quint)end end)b(r,{Position=UDim2.fromOffset(0,0)},.5,Enum.EasingStyle.Back)b(g,{GroupTransparency=0},.3)b(v,{ImageTransparency=.6},.4)b(z,{Size=UDim2.fromScale(0,1)},u,Enum.EasingStyle.Linear)local A=false local function q()if A then return end A=true for a,b in ipairs(self._toasts)do if b==q then table.remove(self._toasts,a)break end end b(r,{Position=UDim2.fromOffset(320,0)},.3,Enum.EasingStyle.Quint)b(g,{GroupTransparency=1},.2)b(B,{Transparency=1},.15)b(v,{ImageTransparency=1},.2)task.delay(.22,function()j.ClipsDescendants=true b(j,{Size=UDim2.new(1,0,0,-4)},.22,Enum.EasingStyle.Quint)task.delay(.24,function()j:Destroy()end)end)end task.delay(u,q)p.MouseButton1Click:Connect(q)table.insert(self._toasts,q)while#self._toasts>self.MaxNotifications do local a=table.remove(self._toasts,1)a()end return{Dismiss=q}end function g:Destroy()if self._destroyed then return end self._destroyed=true for a,b in ipairs(f.Windows)do if b==self then table.remove(f.Windows,a)break end end for b,a in ipairs(self._connections)do a:Disconnect()end self._connections={}b(self.Scale,{Scale=.9},.2)b(self.Body,{GroupTransparency=1},.2)b(self.BodyStroke,{Transparency=1},.12)b(self.Shadow,{ImageTransparency=1},.2)task.delay(.22,function()self.Gui:Destroy()end)end 

f.Themes={
Cyan={Background=Color3.fromRGB(6,10,16),Surface=Color3.fromRGB(10,16,24),Surface2=Color3.fromRGB(14,22,34),Surface3=Color3.fromRGB(22,34,52),Stroke=Color3.fromRGB(32,48,72),StrokeHover=Color3.fromRGB(34,180,220),Accent=Color3.fromRGB(34,211,238),AccentDark=Color3.fromRGB(8,28,40),Text=Color3.fromRGB(240,250,255),Muted=Color3.fromRGB(120,150,170),Warning=Color3.fromRGB(251,191,36),Success=Color3.fromRGB(52,211,153),Error=Color3.fromRGB(251,113,133)},
Indigo={Background=Color3.fromRGB(16,12,36),Surface=Color3.fromRGB(22,16,48),Surface2=Color3.fromRGB(30,22,62),Surface3=Color3.fromRGB(44,34,88),Stroke=Color3.fromRGB(58,46,120),StrokeHover=Color3.fromRGB(140,120,255),Accent=Color3.fromRGB(160,140,255),AccentDark=Color3.fromRGB(32,22,70),Text=Color3.fromRGB(248,246,255),Muted=Color3.fromRGB(155,148,200),Warning=Color3.fromRGB(251,191,36),Success=Color3.fromRGB(90,230,150),Error=Color3.fromRGB(255,120,140)},
Rose={Background=Color3.fromRGB(16,8,12),Surface=Color3.fromRGB(24,12,18),Surface2=Color3.fromRGB(34,16,26),Surface3=Color3.fromRGB(52,24,38),Stroke=Color3.fromRGB(70,32,50),StrokeHover=Color3.fromRGB(244,114,182),Accent=Color3.fromRGB(251,113,180),AccentDark=Color3.fromRGB(40,12,24),Text=Color3.fromRGB(255,240,248),Muted=Color3.fromRGB(180,140,160),Warning=Color3.fromRGB(251,191,36),Success=Color3.fromRGB(52,211,153),Error=Color3.fromRGB(251,113,133)},
Amethyst={Background=Color3.fromRGB(20,16,20),Surface=Color3.fromRGB(24,19,24),Surface2=Color3.fromRGB(28,22,28),Surface3=Color3.fromRGB(42,36,43),Stroke=Color3.fromRGB(40,32,41),StrokeHover=Color3.fromRGB(88,70,90),Accent=Color3.fromRGB(235,199,246),AccentDark=Color3.fromRGB(24,18,26),Text=Color3.fromRGB(233,229,234),Muted=Color3.fromRGB(125,115,126),Warning=Color3.fromRGB(240,176,108),Success=Color3.fromRGB(120,210,140),Error=Color3.fromRGB(240,120,120)},
Midnight={Background=Color3.fromRGB(10,14,32),Surface=Color3.fromRGB(14,20,48),Surface2=Color3.fromRGB(18,28,64),Surface3=Color3.fromRGB(28,42,90),Stroke=Color3.fromRGB(42,60,120),StrokeHover=Color3.fromRGB(96,140,255),Accent=Color3.fromRGB(96,165,250),AccentDark=Color3.fromRGB(16,28,56),Text=Color3.fromRGB(240,248,255),Muted=Color3.fromRGB(140,160,200),Warning=Color3.fromRGB(251,191,36),Success=Color3.fromRGB(52,211,153),Error=Color3.fromRGB(251,113,133)},
Emerald={Background=Color3.fromRGB(6,14,12),Surface=Color3.fromRGB(10,20,16),Surface2=Color3.fromRGB(14,28,22),Surface3=Color3.fromRGB(22,42,34),Stroke=Color3.fromRGB(30,56,44),StrokeHover=Color3.fromRGB(52,200,140),Accent=Color3.fromRGB(52,211,153),AccentDark=Color3.fromRGB(10,36,26),Text=Color3.fromRGB(236,253,245),Muted=Color3.fromRGB(120,160,140),Warning=Color3.fromRGB(251,191,36),Success=Color3.fromRGB(110,231,183),Error=Color3.fromRGB(251,113,133)},
Carmim={Background=Color3.fromRGB(12,8,8),Surface=Color3.fromRGB(18,12,12),Surface2=Color3.fromRGB(26,16,16),Surface3=Color3.fromRGB(42,24,24),Stroke=Color3.fromRGB(56,32,32),StrokeHover=Color3.fromRGB(220,70,80),Accent=Color3.fromRGB(248,80,90),AccentDark=Color3.fromRGB(36,12,14),Text=Color3.fromRGB(255,240,240),Muted=Color3.fromRGB(160,130,130),Warning=Color3.fromRGB(251,191,36),Success=Color3.fromRGB(52,211,153),Error=Color3.fromRGB(248,80,90)},
Dark={Background=Color3.fromRGB(8,8,8),Surface=Color3.fromRGB(14,14,14),Surface2=Color3.fromRGB(20,20,20),Surface3=Color3.fromRGB(32,32,32),Stroke=Color3.fromRGB(44,44,44),StrokeHover=Color3.fromRGB(100,100,100),Accent=Color3.fromRGB(250,250,250),AccentDark=Color3.fromRGB(18,18,18),Text=Color3.fromRGB(255,255,255),Muted=Color3.fromRGB(140,140,140),Warning=Color3.fromRGB(251,191,36),Success=Color3.fromRGB(52,211,153),Error=Color3.fromRGB(251,113,133)},
Amber={Background=Color3.fromRGB(16,12,6),Surface=Color3.fromRGB(24,18,8),Surface2=Color3.fromRGB(34,24,10),Surface3=Color3.fromRGB(52,36,14),Stroke=Color3.fromRGB(72,50,18),StrokeHover=Color3.fromRGB(245,160,50),Accent=Color3.fromRGB(251,191,36),AccentDark=Color3.fromRGB(40,28,8),Text=Color3.fromRGB(255,250,235),Muted=Color3.fromRGB(180,160,120),Warning=Color3.fromRGB(253,224,71),Success=Color3.fromRGB(52,211,153),Error=Color3.fromRGB(251,113,133)},
}
f.ThemeName="Cyan"
function f:ApplyTheme(name)
name=tostring(name or"")
local t=f.Themes[name]
if not t then return false end
f.ThemeName=name
for k,v in pairs(t)do f.Theme[k]=v end
return true
end
function f:ListThemes()local a={}for b in pairs(f.Themes)do table.insert(a,b)end table.sort(a)return a end

function f:GetFlag(a)local b=f.Flags[a]if b and type(b.Get)=="function"then return b:Get()end end
function f:SetFlag(a,c,d)local b=f.Flags[a]if b and type(b.Set)=="function"then b:Set(c,d)return true end return false end
function f:GetFlags()local a={}for b,c in pairs(f.Flags)do if c and type(c.Get)=="function"then a[b]=c:Get()end end return a end
function f:SetTheme(b)if type(b)=="string"then return f:ApplyTheme(b)end if type(b)~="table"then return end for c,d in pairs(b)do if f.Theme[c]~=nil then f.Theme[c]=d end end end
function f:GetTheme()local a={}for b,c in pairs(f.Theme)do a[b]=c end return a end
function f:GetWindows()return table.clone(f.Windows)end
function f:GetWindow(a)if type(a)=="number"then return f.Windows[a]end for b,c in ipairs(f.Windows)do if c.Gui and c.Gui.Name==a then return c end end end
function f:Unload()for a=#f.Windows,1,-1 do local b=f.Windows[a]if b and type(b.Destroy)=="function"then b:Destroy()end end f.Windows={}f.Flags={}end
function f:IsLoaded()return#f.Windows>0 end
function f:ToggleAll(a)for b,c in ipairs(f.Windows)do if type(c.Toggle)=="function"then c:Toggle(a)end end end
return f
end)()

if type(Qyrex) ~= "table" or type(Qyrex.CreateWindow) ~= "function" then
	error("[QyrexHub] Library no cargó")
end
pcall(function()
	Qyrex:ApplyTheme("Cyan")
end)


do
	local prev = _G.QyrexStealAnEgg
	if prev and type(prev.Unload) == "function" then pcall(prev.Unload) end
end

local HUB = { conns = {}, drawings = {}, highlights = {}, dead = false }
_G.QyrexStealAnEgg = HUB
_G.OxideStealAnEgg = HUB -- compat

local function track(conn) table.insert(HUB.conns, conn); return conn end
local function trackDrawing(d) if d then table.insert(HUB.drawings, d) end; return d end

-- Parent seguro
local function getGuiParent()
	local LP = game:GetService("Players").LocalPlayer
	local ok, h = pcall(function()
		if typeof(gethui) == "function" then return gethui() end
	end)
	if ok and typeof(h) == "Instance" then return h end
	return LP and LP:WaitForChild("PlayerGui", 10)
end

--------------------------------------------------------------------
-- SHIM: API estilo Oxide → Qyrex
--------------------------------------------------------------------
local Library = {}
local _windowRef

local function wrapControl(ctrl)
	if not ctrl then return nil end
	local proxy = {}
	setmetatable(proxy, {
		__index = function(_, k)
			if k == "Get" then
				return function()
					if type(ctrl.Get) == "function" then return ctrl:Get() end
					return nil
				end
			elseif k == "Set" or k == "SetValue" then
				return function(_, v, silent)
					if type(ctrl.Set) == "function" then return ctrl:Set(v, silent) end
				end
			elseif k == "SetOptions" then
				return function(_, opts)
					if type(ctrl.SetOptions) == "function" then return ctrl:SetOptions(opts) end
					if type(ctrl.SetValues) == "function" then return ctrl:SetValues(opts) end
				end
			end
			return ctrl[k]
		end,
	})
	return proxy
end

local function makeSectionHost(tab)
	-- SubTab becomes a section host on the same Qyrex tab
	local host = { _tab = tab }
	function host:AddToggle(opts)
		opts = opts or {}
		local c = tab:CreateToggle({
			Name = opts.Name or "Toggle",
			Desc = opts.Description or opts.Desc or "",
			Default = opts.Default == true,
			Flag = opts.Flag,
			Callback = opts.Callback,
		})
		return wrapControl(c)
	end
	function host:AddSlider(opts)
		opts = opts or {}
		local c = tab:CreateSlider({
			Name = opts.Name or "Slider",
			Desc = opts.Description or "",
			Min = opts.Min or 0,
			Max = opts.Max or 100,
			Step = opts.Increment or opts.Step or 1,
			Default = opts.Default or opts.Min or 0,
			Suffix = opts.Suffix or "",
			Flag = opts.Flag,
			Callback = opts.Callback,
		})
		return wrapControl(c)
	end
	function host:AddButton(opts)
		opts = opts or {}
		local c = tab:CreateButton({
			Name = opts.Name or "Button",
			Desc = opts.Description or "",
			Style = opts.Primary and "Primary" or nil,
			Icon = opts.Icon,
			Callback = opts.Callback,
		})
		return wrapControl(c)
	end
	function host:AddDropdown(opts)
		opts = opts or {}
		local options = opts.Options or opts.Items or {}
		local c = tab:CreateDropdown({
			Name = opts.Name or "Dropdown",
			Desc = opts.Description or "",
			Options = options,
			Default = opts.Default,
			Flag = opts.Flag,
			Callback = opts.Callback,
		})
		return wrapControl(c)
	end
	function host:AddMultiDropdown(opts)
		-- Qyrex may not have multi; approximate with dropdown
		opts = opts or {}
		local options = opts.Options or {}
		local c = tab:CreateDropdown({
			Name = (opts.Name or "Multi") .. " (multi)",
			Options = options,
			Default = type(opts.Default) == "table" and opts.Default[1] or opts.Default,
			Flag = opts.Flag,
			Callback = function(v)
				if opts.Callback then
					if type(v) == "table" then opts.Callback(v) else opts.Callback({ v }) end
				end
			end,
		})
		return wrapControl(c)
	end
	function host:AddInput(opts)
		opts = opts or {}
		local c = tab:CreateInput({
			Name = opts.Name or "Input",
			Placeholder = opts.Placeholder or "",
			Default = opts.Default or "",
			Flag = opts.Flag,
			Callback = opts.Callback,
		})
		return wrapControl(c)
	end
	function host:AddKeybind(opts)
		opts = opts or {}
		local c = tab:CreateKeybind({
			Name = opts.Name or "Keybind",
			Default = opts.Default or Enum.KeyCode.RightControl,
			Flag = opts.Flag,
			Callback = opts.OnPress or opts.Callback,
			OnChanged = opts.OnChanged,
		})
		return wrapControl(c)
	end
	function host:AddDivider()
		pcall(function() tab:CreateSection("—") end)
	end
	function host:AddParagraph(opts)
		opts = opts or {}
		pcall(function()
			tab:CreateParagraph({
				Name = opts.Title or opts.Name or "Info",
				Content = opts.Content or "",
			})
		end)
	end
	return host
end

function Library:CreateWindow(opts)
	opts = opts or {}
	local parent = getGuiParent()
	local win = Qyrex:CreateWindow({
		Title = opts.Name or "QyrexHub",
		Subtitle = "Steal an Egg",
		Size = UDim2.fromOffset(680, 500),
		Keybind = Enum.KeyCode.RightControl,
		Icon = "rbxassetid://83380517901735",
		Parent = parent,
		Loading = {
			Enabled = opts.LoadingAnimation ~= false,
			Duration = opts.LoadingDuration or 1.5,
			Title = opts.LoadingText or "QyrexHub",
			Text = "Steal an Egg · cargando...",
			Steps = { "UI", "Features", "Listo" },
		},
		ConfigurationSaving = {
			Enabled = true,
			FolderName = "QyrexHub_StealAnEgg",
			FileName = "config",
		},
	})
	_windowRef = win

	local proxy = {}
	function proxy:AddTab(t)
		t = t or {}
		local tab = win:CreateTab({
			Name = t.Name or "Tab",
			Icon = t.Icon or "layout",
			Desc = t.Subtitle or "",
		})
		local tabProxy = makeSectionHost(tab)
		function tabProxy:AddSubTab(name)
			pcall(function() tab:CreateSection(tostring(name)) end)
			return makeSectionHost(tab)
		end
		return tabProxy
	end
	function proxy:Notify(n)
		n = n or {}
		pcall(function()
			win:Notify({
				Title = n.Title or "QyrexHub",
				Content = n.Content or "",
				Type = n.Type or "Info",
				Duration = n.Duration or 2.5,
			})
		end)
	end
	function proxy:Toggle()
		pcall(function()
			if win.Toggle then win:Toggle(not win.Open) end
		end)
	end
	function proxy:Destroy()
		pcall(function() Qyrex:Unload() end)
	end
	return proxy
end

function Library:SaveConfig(name)
	-- Qyrex auto-save via flags if enabled
	return true
end
function Library:LoadConfig(name)
	return true
end
function Library:ListConfigs()
	return {}
end

local Window = Library:CreateWindow({
	Name = "QyrexHub | Steal an Egg",
	LoadingAnimation = true,
	LoadingText = "QyrexHub",
	LoadingDuration = 1.6,
})



-- ==============================================================================
-- CONFIG / FLAG PERSISTENCE
-- ==============================================================================
local HAS_CONFIG = type(Library.SaveConfig) == "function"
    and type(Library.LoadConfig) == "function"
    and type(Library.ListConfigs) == "function"
local CONFIG_NAME = "stealanegg"

local dropdownResync = {}
local function registerResync(handle, applyFn)
    if handle and applyFn then
        table.insert(dropdownResync, function() applyFn(handle:Get()) end)
    end
end
local function ResyncAll()
    for _, fn in ipairs(dropdownResync) do pcall(fn) end
end

-- ==============================================================================
-- SERVICES & LOCALS
-- ==============================================================================
local Players             = game:GetService("Players")
local RS                  = game:GetService("ReplicatedStorage")
local ReplicatedStorage   = RS
local RunService          = game:GetService("RunService")
local UserInputService    = game:GetService("UserInputService")
local Workspace           = game:GetService("Workspace")
local Lighting            = game:GetService("Lighting")
local TeleportService     = game:GetService("TeleportService")
local VirtualUser         = game:GetService("VirtualUser")

local LP          = Players.LocalPlayer
local LocalPlayer = LP
local function GetCamera()
    return Workspace.CurrentCamera or Workspace:FindFirstChildOfClass("Camera")
end

-- Instant ProximityPrompt Hold Eliminator (Ensures 0s hold on egg pickup)
pcall(function()
    local pps = game:GetService("ProximityPromptService")
    track(pps.PromptButtonHoldBegan:Connect(function(prompt, player)
        if player == LP and tostring(prompt) == "CarryAreaEgg" then
            prompt.HoldDuration = 0
        end
    end))
end)

-- Anti-Robux Purchase Prompt Shield: immediately dismisses accidental Robux purchase prompts
pcall(function()
    local coreGui = game:GetService("CoreGui")
    track(coreGui.ChildAdded:Connect(function(child)
        if child.Name == "PurchasePrompt" then
            task.wait(0.04)
            pcall(function()
                local cancel = child:FindFirstChild("CancelButton", true)
                if cancel and typeof(cancel) == "Instance" and cancel:IsA("GuiButton") then
                    pcall(function() cancel.MouseButton1Click:Fire() end)
                end
            end)
        end
    end))
end)

local function Notify(title, content, kind, dur)
    pcall(function()
        Window:Notify({ Title = title, Content = content, Type = kind or "Info", Duration = dur or 2.5 })
    end)
end

local function safeCallback(fn)
    return function(...)
        local ok, err = pcall(fn, ...)
        if not ok then
            pcall(Notify, "QyrexHub", "Error: " .. tostring(err), "Error", 4)
        end
    end
end

-- ==============================================================================
-- CLIENT AC NEUTRALIZER & UGI CONSTANT WIPER (Layer 1 + Layer 2)
-- ==============================================================================
local function bypassClientDetections()
    if typeof(filtergc) ~= "function" or typeof(debug) ~= "table" or typeof(debug.getupvalues) ~= "function" then
        return false, "no filtergc"
    end
    local ok, fn = pcall(function()
        return filtergc("function", {
            Constants = { "gmatch", "GetFullName" },
        }, true)
    end)
    if not ok or type(fn) ~= "function" then
        return false, "filter miss"
    end
    local setMeta = (typeof(setrawmetatable) == "function" and setrawmetatable)
        or (typeof(setmetatable) == "function" and setmetatable)
    if not setMeta then
        return false, "no setmeta"
    end
    local blocked = 0
    local okUv, ups = pcall(debug.getupvalues, fn)
    if not okUv or type(ups) ~= "table" then
        return false, "no upvalues"
    end
    for _, tbl in pairs(ups) do
        if typeof(tbl) == "table" then
            local okSet = pcall(setMeta, tbl, {
                __newindex = function() end,
            })
            if okSet then
                blocked = blocked + 1
            end
        end
    end
    return blocked > 0, blocked
end

pcall(bypassClientDetections)

-- ══════════════════════════════════════════════════════════════════════════════
-- CLIENT AC NEUTRALIZER — LAYER 2-5 (GC HEAP SCANS)
-- ══════════════════════════════════════════════════════════════════════════════
-- PHONE FIX - why mobile crashed right at "execute": each of these four passes
-- walks the ENTIRE GC heap, and running all four back-to-back *synchronously at
-- script load* froze the client for seconds. Desktop executors got through it
-- before the client noticed, phone executors got killed by the watchdog.
-- The identical work now runs in a single background task in small slices,
-- releasing the client between slices. Same neutralization, no startup freeze.
--
-- Shared heap scanner: walks the GC heap in small slices, yields to the client
-- between them, and frees refs as it goes so the whole heap is never pinned.
-- A step returning `true` stops the scan early.
local function ScanGCHeap(step, perChunk)
    local scan = getgc or (debug and debug.getgc)
    if type(scan) ~= "function" then return end
    local ok, objects = pcall(scan, true)
    if not ok or type(objects) ~= "table" then return end
    perChunk = perChunk or 400
    for i = 1, #objects do
        local obj = objects[i]
        objects[i] = nil
        local okStep, stop = pcall(step, obj)
        if okStep and stop == true then return end
        if i % perChunk == 0 then task.wait() end
    end
end

local AcSlices = {}
do

    -- Layer 2: Runtime AC Detection Table Freezer (neutralizes violation storage)
    function AcSlices.FreezeTables()
        local setmeta = setrawmetatable or setmetatable
        local getmeta = getrawmetatable or getmetatable
        if not setmeta then return end
        ScanGCHeap(function(obj)
            if typeof(obj) ~= "table" or (getmeta and getmeta(obj)) then return end
            local mainrun = false
            for _, v in pairs(obj) do
                if v == obj then
                    mainrun = true
                    break
                end
            end
            if not mainrun then return end
            for _, v in pairs(obj) do
                if typeof(v) == "number" and v >= 1 and v <= 3 and obj[v] == nil then
                    pcall(setmeta, obj, { __newindex = function() end })
                    break
                end
            end
        end)
    end

    -- Layer 2b: UGI Constant Wiper (neutralizes ReplicatedFirst.UGI watchdog)
    function AcSlices.WipeUGI()
        local getconstants = getconstants or (debug and debug.getconstants)
        local setconstant = setconstant or (debug and debug.setconstant)
        local islclosure = islclosure or function(Function)
            return not pcall(setfenv, getfenv(Function))
        end
        if not (getconstants and setconstant and debug and debug.info) then return end
        ScanGCHeap(function(Function)
            if typeof(Function) ~= "function" or not islclosure(Function) then return end
            local ok, Source = pcall(debug.info, Function, "s")
            if not ok or type(Source) ~= "string" then return end
            if not Source:find("ReplicatedFirst", 1, true) or not Source:find("UGI", 1, true) then return end
            local okC, Constants = pcall(getconstants, Function)
            if not okC or type(Constants) ~= "table" then return end
            for Index, Constant in next, Constants do
                if type(Constant) == "string" and Constant == "Humanoid" then
                    pcall(setconstant, Function, Index, "")
                end
            end
        end)
    end

    -- Layer 3: X-14 Stack Scrubber & Token Neutralizer
    function AcSlices.ScrubX14()
        local getconstants = getconstants or (debug and debug.getconstants)
        local islclosure = islclosure or function(fn) return not pcall(setfenv, getfenv(fn)) end
        local HookFn = hookfunction or replaceclosure or hookfunc
        if not (getconstants and HookFn and debug and debug.getstack and debug.setstack) then return end
        ScanGCHeap(function(fn)
            if typeof(fn) ~= "function" or not islclosure(fn) then return end
            local ok, consts = pcall(getconstants, fn)
            if not ok or type(consts) ~= "table" or not table.find(consts, "X-14") then return end
            local cb = nil
            pcall(function()
                cb = HookFn(fn, function(...)
                    local stack = debug.getstack(1)
                    if type(stack) == "table" then
                        for idx, val in pairs(stack) do
                            if val == "X-14" then
                                pcall(debug.setstack, 1, idx, nil)
                            end
                        end
                    end
                    if cb then return cb(...) end
                end)
            end)
        end)
    end

    -- Layer 4: Anti-Tamper State Table Sanitizer (19-upvalue detection)
    function AcSlices.SanitizeState()
        local islclosure = islclosure or function(v) return not pcall(setfenv, getfenv(v)) end
        local getupvalues = getupvalues or (debug and debug.getupvalues)
        local getupvalue = getupvalue or (debug and debug.getupvalue)
        local setupvalue = setupvalue or (debug and debug.setupvalue)
        local clonefunction = clonefunction or function(f) return function(...) return f(...) end end
        if not (getupvalues and getupvalue and setupvalue) then return end
        ScanGCHeap(function(v)
            if typeof(v) ~= "function" or not islclosure(v) then return end
            local ok, upvs = pcall(getupvalues, v)
            if not ok or type(upvs) ~= "table" or #upvs ~= 19 then return end
            local ok2, u2 = pcall(getupvalue, v, 2)
            if not ok2 or typeof(u2) ~= "function" then return end
            local old = clonefunction(u2)
            pcall(setupvalue, v, 2, function(a, b)
                if b and typeof(b) == "table" then
                    pcall(setmetatable, b, {})
                end
                return old(a, b)
            end)
        end)
    end
end

-- One background task, one pass at a time, so only a single heap snapshot is
-- ever alive. The menu now appears instantly instead of after the scans.
task.spawn(function()
    pcall(AcSlices.FreezeTables)
    task.wait()
    pcall(AcSlices.WipeUGI)
    task.wait()
    pcall(AcSlices.ScrubX14)
    task.wait()
    pcall(AcSlices.SanitizeState)
end)

-- ==============================================================================
-- CHARACTER & MOVEMENT HELPERS
-- ==============================================================================
local function findChar() return LP.Character end
local function findHum()
    local ch = LP.Character
    return ch and ch:FindFirstChildOfClass("Humanoid")
end
local function findHRP()
    local ch = LP.Character
    return ch and (ch:FindFirstChild("HumanoidRootPart") or ch.PrimaryPart or ch:FindFirstChildWhichIsA("BasePart"))
end

local GetCharacter = findChar
local GetHumanoid  = findHum
local GetHRP       = findHRP

local function GetRootCFrame()
    local hrp = findHRP()
    return hrp and hrp.CFrame
end

-- ==============================================================================
-- BAC TELEMETRY PACKET SPOOFER
-- ==============================================================================
local bxor = bit32.bxor
local unpack = table.unpack

local function isGuid(n)
    return #n==36 and n:sub(9,9)=="-" and n:sub(14,14)=="-" and n:sub(19,19)=="-" and n:sub(24,24)=="-" and n:gsub("-",""):match("^%x+$")~=nil
end

local remoteSet, anyRemote = {}, nil

local function scanRemotes()
    for _, s in ipairs(game:GetChildren()) do
        local ok, list = pcall(s.GetDescendants, s)
        if ok and list then
            for _, o in ipairs(list) do
                if o:IsA("RemoteEvent") and isGuid(o.Name) then
                    remoteSet[o] = true
                    anyRemote = anyRemote or o
                end
            end
        end
    end
end

scanRemotes()

local function parseCounter(v)
    if type(v) ~= "string" then return end
    local n = v:match("^X%-(%d+)$")
    return n and tonumber(n)
end

local function looksLikeState(t, r)
    if type(t) ~= "table" then return false end
    local hR, hM = false, false
    local ok = pcall(function()
        for _, v in pairs(t) do
            if v == r then hR = true
            elseif type(v) == "string" and v:match("^X%-%d+$") then hM = true end
        end
    end)
    return ok and hR and hM
end

local function findState(r)
    for l=2,24 do
        local _, fn = pcall(debug.info, l, "f")
        if type(fn) == "function" then
            local _, ups = pcall(debug.getupvalues, fn)
            if type(ups) == "table" then
                for _, v in pairs(ups) do
                    if looksLikeState(v, r) then return v end
                    if type(v) == "table" then
                        local nested
                        pcall(function()
                            for _, x in pairs(v) do
                                if looksLikeState(x, r) then nested = x; return end
                            end
                        end)
                        if nested then return nested end
                    end
                end
            end
        end
    end
end

local function mapState(st, a1, a2)
    local m = {}
    for k, v in pairs(st) do
        if type(v) == "string" then
            if v:match("^X%-%d+$") then m.marker = m.marker or k
            elseif a1 and v == a1 then m.arg1 = m.arg1 or k
            elseif a2 and v == a2 then m.arg2 = m.arg2 or k end
        end
    end
    return m
end

local model = nil

local function digits(n)
    n = n % 1000
    return math.floor(n/100), math.floor(n/10)%10, n%10
end

local function encode(m, c)
    local d1, d2, d3 = digits(c)
    return m.prefix .. string.char(bxor(d1, m.k1), bxor(d2, m.k2), bxor(d3, m.k3))
end

local function learn(r, a1, a2)
    local st = findState(r)
    if not st then return end
    local map = mapState(st, a1, a2)
    if not map.marker then return end
    local c = parseCounter(rawget(st, map.marker))
    if not c then return end
    local d1, d2, d3 = digits(c)
    local m = {
        state = st, map = map, remote = r,
        prefix = a1:sub(1, 9),
        k1 = bxor(a1:byte(10), d1),
        k2 = bxor(a1:byte(11), d2),
        k3 = bxor(a1:byte(12), d3),
        offset = c - os.time(),
        arg2 = a2
    }
    if encode(m, c) == a1 then return m end
end

local function liveCounter(m)
    if m.state and m.map.marker then
        local _, raw = pcall(rawget, m.state, m.map.marker)
        local c = parseCounter(raw)
        if c and math.abs((c - os.time()) - m.offset) <= 5 then
            return c
        end
    end
    return os.time() + m.offset
end

local function refreshArg2(m)
    if m.state and m.map.arg2 then
        local _, v = pcall(rawget, m.state, m.map.arg2)
        if type(v) == "string" then m.arg2 = v end
    end
    return m.arg2
end

local HookFn = hookfunction or replaceclosure or hookfunc or detour_function

if anyRemote and HookFn then
    local oldFire
    oldFire = HookFn(anyRemote.FireServer, function(self, ...)
        local args = table.pack(...)
        if not remoteSet[self] then
            return oldFire(self, unpack(args, 1, args.n))
        end

        local a1 = args[1]

        if type(a1) == "string" and #a1 == 12 then
            if not model then
                model = learn(self, a1, args[2])
            else
                local c = parseCounter(rawget(model.state, model.map.marker))
                if c and encode(model, c) ~= a1 then
                    local m = learn(self, a1, args[2])
                    if m then m.spoofed = model.spoofed; model = m end
                end
            end
            return oldFire(self, unpack(args, 1, args.n))
        end

        if model and type(a1) == "string" and #a1 == 4 then
            local c = liveCounter(model)
            args[1] = encode(model, c)
            args[2] = refreshArg2(model)
            model.spoofed = (model.spoofed or 0) + 1
            return oldFire(self, unpack(args, 1, math.max(args.n, 2)))
        end

        return oldFire(self, unpack(args, 1, args.n))
    end)
end

task.spawn(function()
    while not HUB.dead do
        task.wait(10)
        local alive = false
        for r in pairs(remoteSet) do
            if r:IsDescendantOf(game) then alive = true; break end
        end
        if not alive then
            table.clear(remoteSet)
            anyRemote = nil
            model = nil
            scanRemotes()
        end
    end
end)

-- Real-time Memory Evidence Scrubber for Character Integrity
-- PHONE FIX: the "not found yet" path used to re-scan the ENTIRE GC heap every
-- 0.2 s, forever. On a phone that is a continuous full-heap scan - the client
-- froze and the watchdog killed it right at "execute". Scans are now sliced, and
-- the retry backs off from 5 s up to 30 s. Once the table is found, the cheap
-- per-tick scrub still runs at 0.2 s exactly as before.
task.spawn(function()
    if not (getgc or (debug and debug.getgc)) then return end
    local st = nil
    local misses = 0

    local function findIntegrityTable()
        local found = nil
        ScanGCHeap(function(o)
            if found then return true end
            if type(o) ~= "table" then return end
            local hit = false
            pcall(function()
                hit = (rawget(o, "ValidationLocked") ~= nil and rawget(o, "Evidence") ~= nil)
                    or (rawget(o, "ThreatLevel") ~= nil and rawget(o, "LastObservedSample") ~= nil)
            end)
            if hit then
                found = o
                return true
            end
        end, 250)
        return found
    end

    track(LP.CharacterAdded:Connect(function()
        task.wait(1)
        st = findIntegrityTable()
    end))

    while not HUB.dead do
        if not st then
            st = findIntegrityTable()
            if not st then
                -- Back off between full heap scans: 5 s, 10 s, 20 s, then 30 s.
                misses = misses + 1
                local waitFor = math.min(5 * (2 ^ math.min(misses - 1, 3)), 30)
                local slept = 0
                while slept < waitFor and not HUB.dead do
                    task.wait(0.5)
                    slept = slept + 0.5
                end
            elseif misses > 0 then
                misses = 0
            end
        end

        if st then
            pcall(function()
                local ev = rawget(st, "Evidence")
                if type(ev) == "table" then
                    if (tonumber(ev.Speed)    or 0) > 0 then rawset(ev, "Speed", 0) end
                    if (tonumber(ev.Teleport) or 0) > 0 then rawset(ev, "Teleport", 0) end
                    if (tonumber(ev.Flight)   or 0) > 0 then rawset(ev, "Flight", 0) end
                end
                if rawget(st, "ThreatLevel") ~= "Trusted" then rawset(st, "ThreatLevel", "Trusted") end
                if rawget(st, "ValidationLocked") == true then rawset(st, "ValidationLocked", false) end
                if rawget(st, "FirstSuspiciousAt") ~= nil then rawset(st, "FirstSuspiciousAt", nil) end
                if rawget(st, "KickQueued") == true then rawset(st, "KickQueued", false) end
                if rawget(st, "TamperScore") ~= nil then rawset(st, "TamperScore", 0) end
                if rawget(st, "InvalidHeartbeatCount") ~= nil then rawset(st, "InvalidHeartbeatCount", 0) end

                local los = rawget(st, "LastObservedSample")
                if los ~= nil then
                    if rawget(st, "LastGameplayTrustedSample") == nil then rawset(st, "LastGameplayTrustedSample", los) end
                    if rawget(st, "LastValidatedSample") == nil then rawset(st, "LastValidatedSample", los) end
                    if rawget(st, "LastValidatedGroundedSample") == nil then rawset(st, "LastValidatedGroundedSample", los) end
                    if rawget(st, "LastConfirmedGroundSample") == nil then rawset(st, "LastConfirmedGroundSample", los) end
                    if rawget(st, "LastGoodSample") == nil then rawset(st, "LastGoodSample", los) end
                end
            end)
        end
        task.wait(0.2)
    end
end)

-- ==============================================================================
-- GAME NETWORKING & MODULE INTEGRATION
-- ==============================================================================
local EggState, PlotState, AreasData, RarityData, AssetsData, EggToolDisplay, AreaEggSlotIdentity
pcall(function() EggState = require(RS.Client.EggState) end)
pcall(function() PlotState = require(RS.Client.PlotState) end)
pcall(function() AreasData = require(RS.Data.Areas) end)
pcall(function() RarityData = require(RS.Data.Rarity) end)
pcall(function() AssetsData = require(RS.Data.Assets) end)
local SaveModule
pcall(function() SaveModule = require(RS.Shared.Save) end)
pcall(function() EggToolDisplay = require(RS.Shared.Eggs.EggToolDisplay) end)
pcall(function()
    AreaEggSlotIdentity = (RS:FindFirstChild("Shared") and RS.Shared:FindFirstChild("Util") and require(RS.Shared.Util.AreaEggSlotIdentity))
        or (RS:FindFirstChild("Util") and require(RS.Util.AreaEggSlotIdentity))
        or (RS:FindFirstChild("Shared") and RS.Shared:FindFirstChild("Utils") and require(RS.Shared.Utils.AreaEggSlotIdentity))
end)

local function GetNetRemote(name)
    local net = RS:FindFirstChild("Packages") and RS.Packages:FindFirstChild("Networking")
    return net and net:FindFirstChild(name)
end

local function GetLocalSlot()
    if PlotState and PlotState.ResolveLocalSlot then
        local ok, slot = pcall(PlotState.ResolveLocalSlot)
        if ok and slot then return slot end
    end
    return 1
end

local function GetLocalPlotCenter()
    local plotObj = PlotState and PlotState.ResolvePlot and PlotState.ResolvePlot()
    local pt = plotObj and plotObj.CenterPoint and (typeof(plotObj.CenterPoint) == "Vector3" and plotObj.CenterPoint or (plotObj.CenterPoint:IsA("BasePart") and plotObj.CenterPoint.Position))
    if pt then
        return Vector3.new(pt.X, math.max(pt.Y, 70.4), pt.Z), CFrame.new(pt.X, math.max(pt.Y, 70.4), pt.Z)
    end
    return Vector3.new(464.7, 70.4, -364.0), CFrame.new(464.7, 70.4, -364.0)
end

-- ==============================================================================
-- CLEAN ROAD & FLIGHT PATH NAVIGATION (Anti-Trap & Zero Kick Engine)
-- ==============================================================================
local MAIN_ROAD_Z = -364.5

local stealMovementMethod    = "Tween Glide" -- "Tween Glide", "Fly Glide", "Safe Walk"
local avoidTrapsEnabled       = true
-- Boss Arena (Abyss Overlord) state + helpers live in ONE table so the main chunk
-- stays under Luau's 200-local ceiling.
local Boss = { autoJoin = false, autoMastery = false, claimed = {}, arenaReady = false }

local function SafeTeleport(targetPos)
    local root = findHRP()
    if not root or not targetPos then return false end
    root.CFrame = CFrame.new(targetPos.X, math.max(targetPos.Y, 70.0), targetPos.Z)
    root.AssemblyLinearVelocity = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero
    return true
end

local function NeutralizeTraps()
    local debris = Workspace:FindFirstChild("__DEBRIS")
    if not debris then return end
    for _, d in ipairs(debris:GetChildren()) do
        if d.Name == "PlayerTrap" and d:GetAttribute("Owner") ~= LP.Name then
            if d:IsA("BasePart") then
                d.CanTouch = false
                d.CanQuery = false
            end
            for _, c in ipairs(d:GetChildren()) do
                if c:IsA("BasePart") then
                    c.CanTouch = false
                    c.CanQuery = false
                    if c.Name == "Hitbox" then
                        c.CFrame = CFrame.new(0, -999, 0)
                    end
                end
            end
            local tt = d:FindFirstChildWhichIsA("TouchTransmitter", true)
            if tt then pcall(function() tt:Destroy() end) end
        end
    end
end

local function MoveToPoint(target, speed, easeOut)
    local hrp = findHRP()
    if not hrp or not target then return false end

    local start = hrp.Position
    local dist = (target - start).Magnitude
    if dist < 1.0 then
        hrp.CFrame = CFrame.new(target.X, math.max(target.Y, 70.0), target.Z)
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        return true
    end

    speed = math.clamp(tonumber(speed) or tonumber(glideSpeed) or 750, 50, 750)

    local t0 = os.clock()
    local totalDist = dist
    while not HUB.dead do
        local dt = RunService.Heartbeat:Wait()
        local curPos = hrp.Position
        local toTarget = target - curPos
        local remain = toTarget.Magnitude
        if remain < 1.0 then break end
        local stepSpeed = speed
        if easeOut then
            local progress = 1 - math.clamp(remain / totalDist, 0, 1)
            stepSpeed = math.max(speed * (1 - progress * 0.8), 35)
        end
        local step = math.min(stepSpeed * dt, remain)
        local dir = toTarget.Unit
        local nextPos = curPos + dir * step
        hrp.CFrame = CFrame.lookAt(nextPos, nextPos + dir)
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        if os.clock() - t0 > (totalDist / 50 + 5) then break end
    end

    hrp.CFrame = CFrame.new(target.X, math.max(target.Y, 70.0), target.Z)
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
    return true
end

local function FlyToPoint(target, speed, easeOut)
    local hrp = findHRP()
    if not hrp or not target then return false end
    local start = hrp.Position
    local dist = (target - start).Magnitude
    if dist < 1.0 then
        hrp.CFrame = CFrame.new(target.X, math.max(target.Y, 70.0), target.Z)
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
        return true
    end

    speed = math.clamp(tonumber(speed) or tonumber(glideSpeed) or 750, 50, 750)
    local moveTime = math.max(dist / speed, 0.02)
    if easeOut then
        moveTime = moveTime * 1.25
    end

    local t0 = os.clock()
    local delta = target - start
    local dir = delta.Magnitude > 0.001 and delta.Unit or Vector3.new(1, 0, 0)

    while os.clock() - t0 < moveTime and not HUB.dead do
        local dt = RunService.Heartbeat:Wait()
        local linearAlpha = math.clamp((os.clock() - t0) / moveTime, 0, 1)

        local a = linearAlpha
        if easeOut then
            a = math.sin(linearAlpha * (math.pi / 2))
        end

        local cur = start:Lerp(target, a)
        hrp.CFrame = CFrame.lookAt(cur, cur + dir)

        local curSpeed = speed
        if easeOut then
            curSpeed = math.max(speed * (1 - linearAlpha * 0.8), 35)
        end
        hrp.AssemblyLinearVelocity = Vector3.new(dir.X * curSpeed, math.clamp(dir.Y * curSpeed, -15, 150), dir.Z * curSpeed)
        hrp.AssemblyAngularVelocity = Vector3.zero
    end

    hrp.CFrame = CFrame.new(target.X, math.max(target.Y, 70.0), target.Z)
    hrp.AssemblyLinearVelocity = Vector3.zero
    hrp.AssemblyAngularVelocity = Vector3.zero
    return true
end

local SAFE_BOUNDARY_X = 580 -- right before entering the safe zone
local SAFE_ZONE_SPEED = 245 -- 245 studs/s safe entry speed

local function TravelRoadPath(targetPos, speed, isApproach)
    local hrp = findHRP()
    if not hrp or not targetPos then return false end
    if avoidTrapsEnabled then pcall(NeutralizeTraps) end

    local startPos = hrp.Position
    local safeY = math.max(startPos.Y, targetPos.Y, 70.4)
    local isReturningToBase = (targetPos.X < 560)

    if isReturningToBase and startPos.X > SAFE_BOUNDARY_X then
        -- 1. Sprint to main road at full speed (750 studs/s)
        local p1 = Vector3.new(startPos.X, safeY, MAIN_ROAD_Z)
        MoveToPoint(p1, speed, false)

        -- 2. Sprint along main road at full speed until 20 studs BEFORE safe zone
        local pSafeApproach = Vector3.new(SAFE_BOUNDARY_X, safeY, MAIN_ROAD_Z)
        MoveToPoint(pSafeApproach, speed, false)

        -- 3. Slow down to 245 studs/s before entering the safe zone
        local pBaseRoad = Vector3.new(targetPos.X, safeY, MAIN_ROAD_Z)
        MoveToPoint(pBaseRoad, SAFE_ZONE_SPEED, false)

        -- 4. Enter base pen at 245 studs/s
        local pPen = targetPos + Vector3.new(0, 1.2, 0)
        MoveToPoint(pPen, SAFE_ZONE_SPEED, isApproach == true)
        return true
    else
        local p1 = Vector3.new(startPos.X, safeY, MAIN_ROAD_Z)
        local p2 = Vector3.new(targetPos.X, safeY, MAIN_ROAD_Z)
        local p3 = targetPos + Vector3.new(0, 1.2, 0)

        MoveToPoint(p1, speed, false)
        MoveToPoint(p2, speed, false)
        MoveToPoint(p3, speed, isApproach == true)
        return true
    end
end

local function TravelFlyDirect(targetPos, speed, isApproach)
    local hrp = findHRP()
    if not hrp or not targetPos then return false end
    if avoidTrapsEnabled then pcall(NeutralizeTraps) end

    local startPos = hrp.Position
    local isReturningToBase = (targetPos.X < 560)
    local flyAltitude = math.max(startPos.Y, targetPos.Y, 70.4) + 28

    if isReturningToBase and startPos.X > SAFE_BOUNDARY_X then
        -- Fly at full speed (750 studs/s) until right before safe zone
        local pSky1 = Vector3.new(startPos.X, flyAltitude, startPos.Z)
        local pSkySafe = Vector3.new(SAFE_BOUNDARY_X, flyAltitude, MAIN_ROAD_Z)
        FlyToPoint(pSky1, speed, false)
        FlyToPoint(pSkySafe, speed, false)

        -- Descend and slow down to 245 studs/s before entering safe zone
        local pGroundSafe = Vector3.new(SAFE_BOUNDARY_X, 70.4, MAIN_ROAD_Z)
        FlyToPoint(pGroundSafe, SAFE_ZONE_SPEED, false)

        local pBaseRoad = Vector3.new(targetPos.X, 70.4, MAIN_ROAD_Z)
        MoveToPoint(pBaseRoad, SAFE_ZONE_SPEED, false)

        local pPen = targetPos + Vector3.new(0, 1.2, 0)
        MoveToPoint(pPen, SAFE_ZONE_SPEED, isApproach == true)
        return true
    else
        local totalDist = (targetPos - startPos).Magnitude
        if totalDist < 25 then
            FlyToPoint(Vector3.new(targetPos.X, math.max(targetPos.Y, 70.0) + 1.2, targetPos.Z), speed, isApproach == true)
            return true
        end

        local pSky1 = Vector3.new(startPos.X, flyAltitude, startPos.Z)
        local pSky2 = Vector3.new(targetPos.X, flyAltitude, targetPos.Z)
        local pGround = Vector3.new(targetPos.X, math.max(targetPos.Y, 70.0) + 1.2, targetPos.Z)

        FlyToPoint(pSky1, speed, false)
        FlyToPoint(pSky2, speed, false)
        FlyToPoint(pGround, speed, isApproach == true)
        return true
    end
end

local function TravelSafeWalk(targetPos)
    local hum = findHum()
    local hrp = findHRP()
    if not hum or not hrp or not targetPos then return false end
    if avoidTrapsEnabled then pcall(NeutralizeTraps) end

    local startPos = hrp.Position
    local p1 = Vector3.new(startPos.X, startPos.Y, MAIN_ROAD_Z)
    local p2 = Vector3.new(targetPos.X, targetPos.Y, MAIN_ROAD_Z)
    local p3 = targetPos + Vector3.new(0, 1.2, 0)

    for _, pt in ipairs({ p1, p2, p3 }) do
        if HUB.dead then break end
        hum:MoveTo(pt)
        local t0 = os.clock()
        while (hrp.Position - pt).Magnitude > 4.5 and os.clock() - t0 < 5 and not HUB.dead do
            task.wait(0.05)
        end
    end
    return true
end

local function TravelToDestination(targetPos, speed, isApproach)
    if stealMovementMethod == "Fly Glide" then
        return TravelFlyDirect(targetPos, speed, isApproach)
    elseif stealMovementMethod == "Safe Walk" then
        return TravelSafeWalk(targetPos)
    else
        -- "Tween Glide" smoothly glides to the egg via the road
        return TravelRoadPath(targetPos, speed, isApproach)
    end
end

-- ==============================================================================
-- RARITY & AREA DICTIONARIES (Dynamic scoring for Rare Egg Hunter)
-- ==============================================================================
local RARITY_SCORE_MAP = {
    ["LightDark"]       = 1300, -- "Angels & Demons" biome rarity (new)
    ["Light & Dark"]    = 1300,
    ["Titan"]           = 1100,
    ["Divine"]          = 1000,
    ["Transcendent"]    = 1000,
    ["Superior"]        = 1000,
    ["Eternal"]         = 900,
    ["Limited"]         = 900,
    ["Secret"]          = 800,
    ["Exotic"]          = 800,
    ["Cosmic"]          = 700,
    ["Exclusive"]       = 700,
    ["Admin"]           = 700,
    ["Mythic"]          = 600,
    ["Mythical"]        = 600,
    ["Prismatic"]       = 600,
    ["Rainbow"]         = 600,
    ["Squishy God"]     = 600,
    ["BrainrotGod"]     = 600,
    ["Legendary"]       = 500,
    ["Epic"]            = 400,
    ["Rare"]            = 300,
    ["SuperRare"]       = 200,
    ["Celestial"]       = 200,
    ["Uncommon"]        = 200,
    ["Basic"]           = 100,
    ["Common"]          = 100,
}

local AREA_COORDINATES = {
    ["Base / Plot"]      = Vector3.new(491.7, 70.4, -364.4),
    ["Stands & Shops"]   = Vector3.new(539.5, 68.0, -364.5),
    ["Forest"]           = Vector3.new(596.0, 68.0, -328.0),
    ["Lake"]             = Vector3.new(744.0, 68.5, -408.0),
    ["Desert"]           = Vector3.new(948.0, 69.5, -323.0),
    ["Jungle"]           = Vector3.new(1188.0, 68.5, -408.0),
    ["Snow"]             = Vector3.new(1492.0, 69.0, -315.0),
    ["Volcano"]          = Vector3.new(1882.0, 68.0, -398.0),
    ["Abyss Ocean"]      = Vector3.new(2280.0, 68.0, -326.0),
    ["Prehistoric"]      = Vector3.new(2812.0, 69.0, -398.0),
    ["Cosmic"]           = Vector3.new(3390.0, 68.0, -324.0),
    ["Cherry Blossom"]   = Vector3.new(4028.0, 68.5, -396.0),
    ["Titan Temple"]     = Vector3.new(4796.0, 69.5, -328.0),
    ["Light Dark"]       = Vector3.new(5660.0, 70.0, -331.0), -- "Angels & Demons" biome
    ["Dragon Event"]     = Vector3.new(539.5, 68.0, -318.0),
}

local AREA_NAMES = {
    "Forest", "Lake", "Desert", "Jungle", "Snow", "Volcano",
    "Abyss Ocean", "Prehistoric", "Cosmic", "Cherry Blossom", "Titan Temple",
    "Light Dark", "Angels & Demons",
}

local RARITY_NAMES = {
    "Light & Dark", "Titan", "Divine", "Superior", "Eternal", "Limited",
    "Secret", "Exotic", "Cosmic", "Exclusive", "Mythic", "Rainbow",
    "Squishy God", "Celestial", "Legendary", "Epic", "Rare", "SuperRare",
    "Uncommon", "Common"
}

local MUTATION_FILTERS = {
    "Normal Only", "Mutated Only", "Parasite / Infested", "Rainbow Only", "Gold Only", "Silver Only", "Monstrous"
}

-- ==============================================================================
-- AUTOMATION STATE & PERSISTENT RETURN POSITION
-- ==============================================================================
local autoStealEnabled          = false
local rareEggHunter             = true
local stealBigEggsOnly          = false
local selectedStealRarities     = {}
local selectedStealAreas        = {}
local selectedMutationTypes     = {}
local stealDelay                = 1.5
local glideSpeed                = 750
local ignoredEggs               = {} -- [uid] = timestamp (prevents loops on failed eggs)

-- Saved Return Position (automatically captured on first steal activation)
local savedReturnCFrame         = nil

local autoHatchEnabled          = false
local autoPlantEnabled          = false
local hatchCheckDelay           = 2.0

local autoUpgradeBase           = false
local autoUpgradeTreadmill      = false
local autoTrainSpeed            = false
local autoBuyTrails             = false
local autoEquipBestPets         = false
local autoClaimRewards          = false

local autoSellPets              = false
local autoSellEggs              = false
local selectedSellPetRarities   = {}
local selectedSellEggRarities   = {}

-- When no rarity filter is picked, only sell low-tier items (the default list
-- from the working satchel seller) instead of everything in the inventory.
local DEFAULT_LOW_TIER_SELL = {
    ["Common"] = true, ["Uncommon"] = true, ["Rare"] = true,
    ["Epic"] = true, ["Legendary"] = true, ["Mythic"] = true,
}
local SELL_REQUEST_DELAY = 0.1
local function getSellRarityFilter(selected)
    if not selected or next(selected) == nil then return DEFAULT_LOW_TIER_SELL end
    return selected
end

local noKnockbackEnabled        = true
local batAuraEnabled            = false
local batAuraRadius             = 20
local batAuraDelay              = 0.2
local antiRagdollEnabled        = true

-- ==============================================================================
-- EGG STEALING, PLANTING & HATCHING CORE LOGIC (Strict Rarity Matching)
-- ==============================================================================
local function GetEggRarityInfo(egg)
    if not egg then return "Common", 100 end

    -- 1. Direct rarity property on egg
    if egg.Rarity then
        local r = egg.Rarity
        local name = type(r) == "table" and (r.DisplayName or r._id or r.Name) or tostring(r)
        local score = RARITY_SCORE_MAP[name] or (type(r) == "table" and tonumber(r.RarityNumber) and r.RarityNumber * 100) or 100
        return name, score
    end

    -- 2. Individual Animal / Egg Rarity from Assets Catalog (AssetCategory)
    local cat = egg.AssetCategory or egg.Category or egg.Name
    if cat and AssetsData then
        local assetsDir = AssetsData.Directory or AssetsData
        local aInfo = assetsDir[cat]
        if aInfo and aInfo.Rarity then
            local r = aInfo.Rarity
            local name = type(r) == "table" and (r.DisplayName or r._id or r.Name) or tostring(r)
            local score = RARITY_SCORE_MAP[name] or (type(r) == "table" and tonumber(r.RarityNumber) and r.RarityNumber * 100) or 100
            return name, score
        end
    end

    -- 3. Fallback to Area mapping if asset category wasn't found in catalog
    local areaData = AreasData and (AreasData.Directory or AreasData) and (AreasData.Directory or AreasData)[egg.AreaId]
    local rarity = areaData and areaData.Rarity
    local rarityId = (type(rarity) == "table" and (rarity._id or rarity.DisplayName or rarity.Name)) or (type(rarity) == "string" and rarity) or "Common"
    local raritiesTable = RarityData and (RarityData.Rarities or RarityData) or {}
    local rInfo = raritiesTable[rarityId] or {}
    local rarityDisplayName = (type(rInfo) == "table" and (rInfo.DisplayName or rInfo._id)) or (type(rarity) == "table" and rarity.DisplayName) or rarityId or "Common"
    local baseScore = RARITY_SCORE_MAP[rarityDisplayName] or RARITY_SCORE_MAP[rarityId] or (type(rarity) == "table" and tonumber(rarity.RarityNumber) and rarity.RarityNumber * 100) or 100
    return rarityDisplayName, baseScore
end

local function isRarityAllowed(rarityName, filter)
    if not filter or type(filter) ~= "table" then return true end
    local count = 0
    for _ in pairs(filter) do count = count + 1 end
    if count == 0 then return true end

    if filter[rarityName] == true then return true end
    local rLower = string.lower(tostring(rarityName))
    for k, v in pairs(filter) do
        if type(v) == "string" and string.lower(v) == rLower then
            return true
        elseif type(k) == "string" and string.lower(k) == rLower and v == true then
            return true
        end
    end
    return false
end

-- Resolve a user-facing area name to the real AreaId. Newer biomes are listed by
-- their DisplayName in the game (e.g. "Angels & Demons" -> "Light Dark"), so both
-- spellings select the same area in the steal filter.
local function ResolveAreaId(name)
    local dir = AreasData and AreasData.Directory
    if type(dir) ~= "table" then return tostring(name) end
    local lower = string.lower(tostring(name))
    for id, info in pairs(dir) do
        if string.lower(tostring(id)) == lower then return id end
        if type(info) == "table" and info.DisplayName
            and string.lower(tostring(info.DisplayName)) == lower then
            return id
        end
    end
    return tostring(name)
end

local function isAreaAllowed(areaId, filter)
    if not filter or type(filter) ~= "table" then return true end
    local count = 0
    for _ in pairs(filter) do count = count + 1 end
    if count == 0 then return true end

    if filter[areaId] == true then return true end
    local aLower = string.lower(tostring(areaId))
    for k, v in pairs(filter) do
        if type(v) == "string" and (string.lower(v) == aLower
            or string.lower(tostring(ResolveAreaId(v))) == aLower) then
            return true
        elseif type(k) == "string" and string.lower(k) == aLower and v == true then
            return true
        end
    end
    return false
end

local function isMutationAllowed(muts, record, filter)
    local isParasite = (record and record.HasParasite == true)
        or (type(muts) == "table" and (table.find(muts, "Parasite") or table.find(muts, "Monstrous")))
        or (record and (record.BaseMutation == "Parasite" or record.BaseMutation == "Monstrous"))

    if not filter or type(filter) ~= "table" then return true end
    local count = 0
    for _ in pairs(filter) do count = count + 1 end
    if count == 0 then return true end

    local hasMut = type(muts) == "table" and #muts > 0
    local allowed = false
    for _, opt in pairs(filter) do
        if type(opt) == "string" then
            if opt == "Normal Only" and not hasMut and not isParasite then
                allowed = true
            elseif opt == "Mutated Only" and (hasMut or isParasite) then
                allowed = true
            elseif (opt == "Parasite / Infested" or opt == "Monstrous") and isParasite then
                allowed = true
            elseif opt == "Silver Only" and type(muts) == "table" and table.find(muts, "Silver") then
                allowed = true
            elseif opt == "Gold Only" and type(muts) == "table" and (table.find(muts, "Gold") or table.find(muts, "Golden")) then
                allowed = true
            elseif opt == "Rainbow Only" and type(muts) == "table" and table.find(muts, "Rainbow") then
                allowed = true
            end
        end
    end
    return allowed
end

local function isBigEgg(record)
    if not record then return false end
    local scale = tonumber(record.AssetScale) or 1
    local nestScale = tonumber(record.NestScale) or 1
    return scale >= 1.35 or nestScale >= 1.0
end

local function GetMatchingFieldEggs(areasFilter, raritiesFilter, mutationsFilter)
    if not EggState or not EggState.ReadFieldEggs then return {} end
    local ok, snapshot = pcall(EggState.ReadFieldEggs)
    if not ok or not snapshot or not snapshot.Records then return {} end

    local matched = {}
    for _, record in ipairs(snapshot.Records) do
        if record.State == "Slot" and record.BoundsCFrame then
            local isIgnored = ignoredEggs[record.Uid] and (os.clock() - ignoredEggs[record.Uid] < 2.5)
            if not isIgnored and (not stealBigEggsOnly or isBigEgg(record)) then
                local areaOk = isAreaAllowed(record.AreaId, areasFilter)
                local rarityName, baseScore = GetEggRarityInfo(record)
                local rarityOk = isRarityAllowed(rarityName, raritiesFilter)
                local muts = record.Mutations or {}
                local mutOk = isMutationAllowed(muts, record, mutationsFilter)

                -- Strict filter check: only insert if all selected filters match!
                if areaOk and rarityOk and mutOk then
                    local mutBonus = 0
                    for _, m in ipairs(muts) do
                        if m == "Rainbow" then mutBonus = mutBonus + 35
                        elseif m == "Gold" or m == "Golden" then mutBonus = mutBonus + 20
                        elseif m == "Silver" then mutBonus = mutBonus + 10 end
                    end

                    if record.HasParasite == true or (type(muts) == "table" and (table.find(muts, "Parasite") or table.find(muts, "Monstrous"))) then
                        mutBonus = mutBonus + 800
                    end

                    if isBigEgg(record) then
                        mutBonus = mutBonus + 600
                    end

                    table.insert(matched, {
                        record = record,
                        rarity = rarityName,
                        score = baseScore + mutBonus
                    })
                end
            end
        end
    end

    -- Rare Egg Hunter: sort matched eggs by total score descending (Highest Rarity First)
    if #matched > 1 then
        table.sort(matched, function(a, b)
            return a.score > b.score
        end)
    end

    return matched
end

local function EnsureSavedReturnPosition()
    if not savedReturnCFrame then
        local hrp = findHRP()
        if hrp then
            savedReturnCFrame = hrp.CFrame
        end
    end
end

local function isPlayerCarryingEgg()
    local pg = LP:FindFirstChildOfClass("PlayerGui")
    local dropGui = pg and pg:FindFirstChild("DropHeldEgg")
    if dropGui and dropGui.Enabled == true then
        return true
    end

    local char = LP.Character
    if char then
        for _, t in ipairs(char:GetChildren()) do
            if t:IsA("Model") and (t.Name:lower():find("egg") or t:GetAttribute("Uid") or t:GetAttribute("AssetCategory")) then
                return true
            end
            if t:IsA("Tool") then
                if EggToolDisplay and EggToolDisplay.IsEggTool and EggToolDisplay.IsEggTool(t) then
                    return true
                end
                if t:GetAttribute("IsEgg") == true or t:GetAttribute("Uid") ~= nil or t:GetAttribute("AssetCategory") ~= nil then
                    return true
                end
                local tName = t.Name:lower()
                if tName:find("egg") or (tName ~= "bat" and tName ~= "defaulttool" and not tName:find("bat") and not tName:find("slap") and not tName:find("coil") and not tName:find("potion") and not tName:find("lantern")) then
                    return true
                end
            end
        end
    end
    local bp = LP:FindFirstChild("Backpack")
    if bp then
        for _, t in ipairs(bp:GetChildren()) do
            if t:IsA("Tool") and EggToolDisplay and EggToolDisplay.IsEggTool and EggToolDisplay.IsEggTool(t) then
                return true
            end
        end
    end
    return false
end

local function PlantAllCarriedEggsInPen()
    local plotObj = PlotState and PlotState.ResolvePlot and PlotState.ResolvePlot()
    local plotCenter = plotObj and plotObj.CenterPoint and plotObj.CenterPoint.Position or Vector3.new(464.7, 68.2, -364.0)

    local toolsToPlant = {}
    for _, t in ipairs(LP.Character:GetChildren()) do
        if t:IsA("Tool") and EggToolDisplay and EggToolDisplay.IsEggTool and EggToolDisplay.IsEggTool(t) then
            local uid = EggToolDisplay.GetToolUid(t)
            if uid then table.insert(toolsToPlant, uid) end
        end
    end
    for _, t in ipairs(LP.Backpack:GetChildren()) do
        if t:IsA("Tool") and EggToolDisplay and EggToolDisplay.IsEggTool and EggToolDisplay.IsEggTool(t) then
            local uid = EggToolDisplay.GetToolUid(t)
            if uid then table.insert(toolsToPlant, uid) end
        end
    end

    local plantedCount = 0
    for _, eggUid in ipairs(toolsToPlant) do
        for attempt = 1, 3 do
            local offset = CFrame.new(math.random(-6, 6), 0, math.random(-6, 6))
            local ok, res = pcall(function()
                if EggState and EggState.PlantEgg then
                    return EggState.PlantEgg(eggUid, offset)
                end
                return false
            end)
            if ok and res then
                plantedCount = plantedCount + 1
                break
            end
            task.wait(0.1)
        end
    end
    return plantedCount
end

local function StealSpecificEggRobust(targetItem)
    local record = targetItem.record or targetItem
    if not record or not record.Uid or not record.BoundsCFrame then return false end

    -- Verify the egg is still present in the latest snapshot before traveling
    if EggState and EggState.ReadFieldEggs then
        local ok, snap = pcall(EggState.ReadFieldEggs)
        if ok and snap and snap.Records then
            local stillThere = false
            for _, r in ipairs(snap.Records) do
                if r.Uid == record.Uid and r.State == "Slot" then
                    stillThere = true
                    record = r
                    break
                end
            end
            if not stillThere then
                return false
            end
        end
    end

    local hrp = findHRP()
    local hum = findHum()
    if not hrp then return false end

    EnsureSavedReturnPosition()

    local targetPos = record.BoundsCFrame.Position
    local speed = math.clamp(tonumber(glideSpeed) or 750, 50, 750)
    -- 1. Travel to egg nest: glide there via the road
    TravelToDestination(targetPos + Vector3.new(0, 1.2, 0), speed, true)
    if hrp then
        hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 1.2, 0))
        hrp.AssemblyLinearVelocity = Vector3.zero
        hrp.AssemblyAngularVelocity = Vector3.zero
    end
    task.wait(0.5)

    -- 2. Claim egg with instant stop & verification handshake
    local slotKey = nil
    if AreaEggSlotIdentity and AreaEggSlotIdentity.LooksLikeFirstAreaUid and AreaEggSlotIdentity.LooksLikeFirstAreaUid(record.Uid) then
        slotKey = AreaEggSlotIdentity.SlotKey(record.AreaId, record.NestId)
    end

    local net = RS:FindFirstChild("Packages") and RS.Packages:FindFirstChild("Networking")
    local carryRemote = net and net:FindFirstChild("RF/EggWorld/AskFieldEggCarry")
    if carryRemote then
        pcall(function() carryRemote:InvokeServer({ Uid = record.Uid, FirstAreaSlotKey = slotKey }) end)
    end
    pcall(function()
        if EggState and EggState.CarryFieldEgg then
            EggState.CarryFieldEgg(record.Uid, slotKey)
        end
    end)

    local prompt = nil
    for _, d in ipairs(Workspace:GetDescendants()) do
        if d:IsA("ProximityPrompt") and d.Name == "CarryAreaEgg" and d.Enabled then
            local act = (d.ActionText or ""):lower()
            local obj = (d.ObjectText or ""):lower()
            if not act:find("skip") and not act:find("robux") and not obj:find("skip") and not obj:find("robux") then
                local p = d.Parent
                if p:IsA("Attachment") then p = p.Parent end
                if p and (p.Position - hrp.Position).Magnitude < 14 then
                    prompt = d
                    break
                end
            end
        end
    end

    if prompt then
        prompt.HoldDuration = 0
        pcall(function() fireproximityprompt(prompt) end)
        pcall(function() fireproximityprompt(prompt, 0) end)
    end

    local safePlotCenter, _ = GetLocalPlotCenter()
    local safeCFrame = CFrame.new(safePlotCenter + Vector3.new(0, 1.2, 0))
    local tPickup = os.clock()
    local carried = false
    local maxWait = 1.5
    while os.clock() - tPickup < maxWait and not HUB.dead do
        if carried then
            break
        end
        if isPlayerCarryingEgg() then
            carried = true
            break
        end
        pcall(function()
            if EggState and EggState.CarryFieldEgg then
                EggState.CarryFieldEgg(record.Uid, slotKey)
            end
        end)
        if prompt then
            prompt.HoldDuration = 0
            pcall(function() fireproximityprompt(prompt) end)
        end
        task.wait(0.08)
    end

    if not carried then
        ignoredEggs[record.Uid] = os.clock()
        return false
    end

    -- 2.5 Guard-hit double pickup trick (user method: pickup -> get hit by guard -> pickup again -> glide back to avoid deliver error)
    do
        local guardHitEnabled = true -- pickup, let guard hit you, pick up again, then glide back (prevents deliver error)
        if guardHitEnabled and carried then
            local tGuardStart = os.clock()
            local startHealth = 100
            local hum0 = findHum()
            if hum0 then startHealth = hum0.Health end
            local wasHit = false
            -- Linger near egg to let guard hit us (up to 4s). Detect via health drop / ragdoll / egg drop.
            while os.clock() - tGuardStart < 4.0 and not HUB.dead do
                if not isPlayerCarryingEgg() then
                    wasHit = true
                    break
                end
                local h = findHum()
                if h then
                    local hs = h:GetState()
                    if h.Health < startHealth - 1.5 or hs == Enum.HumanoidStateType.Physics or hs == Enum.HumanoidStateType.Ragdoll or hs == Enum.HumanoidStateType.FallingDown then
                        wasHit = true
                        local tPost = os.clock()
                        while os.clock() - tPost < 0.85 and not HUB.dead do
                            if not isPlayerCarryingEgg() then break end
                            task.wait(0.05)
                        end
                        break
                    end
                end
                task.wait(0.05)
            end

            if wasHit or not isPlayerCarryingEgg() then
                task.wait(0.65)
                -- Wait until not ragdolled anymore before re-pickup (user: guard hit -> stand up -> then pick up & glide)
                do
                    local tRag = os.clock()
                    while os.clock() - tRag < 3.2 and not HUB.dead do
                        local h = findHum()
                        if not h then break end
                        local hs = h:GetState()
                        if hs ~= Enum.HumanoidStateType.Physics and hs ~= Enum.HumanoidStateType.Ragdoll and hs ~= Enum.HumanoidStateType.FallingDown then
                            break
                        end
                        pcall(function() h:ChangeState(Enum.HumanoidStateType.GettingUp) end)
                        task.wait(0.12)
                    end
                    task.wait(0.35)
                end
                local hrpNow = findHRP()
                if hrpNow and (hrpNow.Position - targetPos).Magnitude > 14 then
                    pcall(function()
                        hrpNow.CFrame = CFrame.new(targetPos + Vector3.new(0, 1.8, 0))
                        hrpNow.AssemblyLinearVelocity = Vector3.zero
                        hrpNow.AssemblyAngularVelocity = Vector3.zero
                    end)
                    task.wait(0.35)
                end
                -- Ensure fully standing before pickup attempt
                do
                    local tStand = os.clock()
                    while os.clock() - tStand < 1.5 and not HUB.dead do
                        local h = findHum()
                        if h and h:GetState() ~= Enum.HumanoidStateType.Physics and h:GetState() ~= Enum.HumanoidStateType.Ragdoll then break end
                        task.wait(0.08)
                    end
                end
                -- Wait for guard to be back to sleep/idle before re-pickup (prevents instant re-alert & deliver error)
                do
                    local tGuardSleep = os.clock()
                    while os.clock() - tGuardSleep < 4.5 and not HUB.dead do
                        local guardAsleep = false
                        pcall(function()
                            local areasRoot = Workspace:FindFirstChild("__OBJECTS") and Workspace.__OBJECTS:FindFirstChild("Areas") and Workspace.__OBJECTS.Areas:FindFirstChild("GuardAreas")
                            local guardModel = nil
                            if areasRoot and record.AreaId then
                                local areaFolder = areasRoot:FindFirstChild(record.AreaId)
                                if areaFolder then
                                    guardModel = areaFolder:FindFirstChild("Guard") or areaFolder:FindFirstChild("ForestGuardAuthored") or areaFolder:FindFirstChildWhichIsA("Model", true)
                                end
                            end
                            if not guardModel then
                                local nearest, nd = nil, 1e9
                                for _, m in ipairs(Workspace:GetDescendants()) do
                                    if m:IsA("Model") and m.Name:lower():find("guard") and m.PrimaryPart then
                                        local d = (m.PrimaryPart.Position - targetPos).Magnitude
                                        if d < nd and d < 90 then nd = d; nearest = m end
                                    end
                                end
                                guardModel = nearest
                            end
                            if guardModel then
                                local alert = guardModel:GetAttribute("Alert") or guardModel:GetAttribute("Alerted") or guardModel:GetAttribute("IsAlerted") or guardModel:GetAttribute("Chasing")
                                local sleeping = guardModel:GetAttribute("Sleeping") or guardModel:GetAttribute("IsSleeping") or guardModel:GetAttribute("Asleep") or guardModel:GetAttribute("Sleep")
                                local state = guardModel:GetAttribute("State")
                                if sleeping == true then guardAsleep = true
                                elseif alert == false or alert == nil then
                                    local hum = guardModel:FindFirstChildOfClass("Humanoid")
                                    local hrp = guardModel.PrimaryPart or guardModel:FindFirstChild("HumanoidRootPart") or guardModel:FindFirstChildWhichIsA("BasePart", true)
                                    local eggPoint = guardModel:FindFirstChild("EggPoint", true)
                                    if hrp and eggPoint then
                                        local distToHome = (hrp.Position - eggPoint.Position).Magnitude
                                        if distToHome < 7 and (not hum or hum.MoveDirection.Magnitude < 0.12) then
                                            guardAsleep = true
                                        elseif distToHome < 12 and os.clock() - tGuardSleep > 1.2 and (not hum or hum.MoveDirection.Magnitude < 0.15) then
                                            guardAsleep = true
                                        end
                                    elseif state and tostring(state):lower():find("sleep") then guardAsleep = true
                                    elseif alert == nil and sleeping == nil and state == nil then
                                        if os.clock() - tGuardSleep > 1.6 then guardAsleep = true end
                                    elseif alert == false then guardAsleep = true
                                    end
                                end
                                if not guardAsleep then
                                    local alertGui = guardModel:FindFirstChild("Alert", true)
                                    if alertGui and alertGui:IsA("BillboardGui") and alertGui.Enabled == false then guardAsleep = true end
                                end
                            else
                                if os.clock() - tGuardSleep > 1.4 then guardAsleep = true end
                            end
                        end)
                        if guardAsleep then break end
                        task.wait(0.14)
                    end
                    task.wait(0.08)
                end
                task.wait(0.08)
                pcall(function()
                    if carryRemote then carryRemote:InvokeServer({ Uid = record.Uid, FirstAreaSlotKey = slotKey }) end
                end)
                pcall(function()
                    if EggState and EggState.CarryFieldEgg then EggState.CarryFieldEgg(record.Uid, slotKey) end
                end)
                task.wait(0.08)
                local prompt2 = nil
                for _, d in ipairs(Workspace:GetDescendants()) do
                    if d:IsA("ProximityPrompt") and d.Name == "CarryAreaEgg" and d.Enabled then
                        local p = d.Parent
                        if p and p:IsA("Attachment") then p = p.Parent end
                        if p then
                            local dist = (p.Position - (findHRP() and findHRP().Position or targetPos)).Magnitude
                            if dist < 16 then
                                local act = (d.ActionText or ""):lower()
                                if not act:find("skip") and not act:find("robux") then
                                    prompt2 = d
                                    break
                                end
                            end
                        end
                    end
                end
                if prompt2 then
                    prompt2.HoldDuration = 0
                    pcall(function() fireproximityprompt(prompt2) end)
                    pcall(function() fireproximityprompt(prompt2, 0) end)
                else
                    for _, d in ipairs(Workspace:GetDescendants()) do
                        if d:IsA("ProximityPrompt") and d.Name == "CarryAreaEgg" and d.Enabled then
                            local p = d.Parent
                            if p and p:IsA("Attachment") then p = p.Parent end
                            if p and (p.Position - (findHRP() and findHRP().Position or targetPos)).Magnitude < 18 then
                                d.HoldDuration = 0
                                pcall(function() fireproximityprompt(d) end)
                                task.wait(0.08)
                                if isPlayerCarryingEgg() then break end
                            end
                        end
                    end
                end
                local tPickup2 = os.clock()
                while os.clock() - tPickup2 < 2.2 and not HUB.dead do
                    if isPlayerCarryingEgg() then carried = true break end
                    pcall(function()
                        if EggState and EggState.CarryFieldEgg then EggState.CarryFieldEgg(record.Uid, slotKey) end
                    end)
                    if prompt2 then pcall(function() fireproximityprompt(prompt2) end) end
                    task.wait(0.06)
                end
                if isPlayerCarryingEgg() then carried = true end
                -- Fast trigger back to safe area once egg re-attached
                if isPlayerCarryingEgg() then
                    task.wait(0.12)
                else
                    -- Extra fallback: one more prompt scan if still not carrying
                    task.wait(0.12)
                    for _, d in ipairs(Workspace:GetDescendants()) do
                        if d:IsA("ProximityPrompt") and d.Name == "CarryAreaEgg" and d.Enabled then
                            local p = d.Parent
                            if p and p:IsA("Attachment") then p = p.Parent end
                            if p and (p.Position - (findHRP() and findHRP().Position or targetPos)).Magnitude < 18 then
                                d.HoldDuration = 0
                                pcall(function() fireproximityprompt(d) end)
                            end
                        end
                    end
                    task.wait(0.12)
                    if isPlayerCarryingEgg() then carried = true end
                end
            end
        end
    end

    -- 3. Return to base: fast-then-slow glide (we always glide back)
    if speed > 250 then
        local hrpNow = findHRP()
        local curPos = hrpNow and hrpNow.Position or targetPos
        local toBase = safePlotCenter - curPos
        local distBase = toBase.Magnitude
        if distBase > 45 then
            local stagePos = safePlotCenter - toBase.Unit * 35
            stagePos = Vector3.new(stagePos.X, math.max(stagePos.Y, 70.4), stagePos.Z)
            TravelToDestination(stagePos, speed, false)
            local hrp2 = findHRP()
            if hrp2 then
                hrp2.AssemblyLinearVelocity = Vector3.zero
                hrp2.AssemblyAngularVelocity = Vector3.zero
            end
            task.wait(0.35)
        end
        TravelToDestination(safePlotCenter, 240, true)
    else
        TravelToDestination(safePlotCenter, speed, true)
    end

    -- Settle in the base pen and wait for delivery to confirm
    local tDeliver = os.clock()
    while os.clock() - tDeliver < 1.5 and isPlayerCarryingEgg() and not HUB.dead do
        task.wait(0.08)
    end

    -- 4. Plant all carried egg tools in the base pen
    PlantAllCarriedEggsInPen()

    -- 5. Land safely on base pen ground (Never go under map)
    local char = LP.Character
    local h = char and char:FindFirstChild("HumanoidRootPart")
    local hu = char and char:FindFirstChildOfClass("Humanoid")
    if h then
        h.CFrame = CFrame.new(safePlotCenter.X, math.max(safePlotCenter.Y, 70.4), safePlotCenter.Z)
        h.AssemblyLinearVelocity = Vector3.zero
        h.AssemblyAngularVelocity = Vector3.zero
    end
    if hu then
        hu.PlatformStand = false
        hu.AutoRotate = true
        pcall(function() hu:ChangeState(Enum.HumanoidStateType.Running) end)
    end

    return carried or isPlayerCarryingEgg()
end

local function StealBestEggOnce()
    pcall(HatchAllReadyEggs)
    local eggs = GetMatchingFieldEggs(selectedStealAreas, selectedStealRarities, selectedMutationTypes)
    if #eggs == 0 then
        return false -- Strictly respect user filter, no fallback to unwanted eggs!
    end

    local target = eggs[1] -- First item is highest rarity / score among matching eggs
    return StealSpecificEggRobust(target)
end

local function HatchAllReadyEggs()
    if not EggState or not EggState.ReadOwnedEggs then return 0 end
    local ok, snapshot = pcall(EggState.ReadOwnedEggs, LP.UserId)
    if not ok or not snapshot then return 0 end

    local count = 0
    local records = snapshot.Records or snapshot
    if typeof(records) == "table" then
        for uid, eggData in pairs(records) do
            if typeof(eggData) == "table" then
                local isReady = false
                if EggState.IsReadyToHatch then
                    isReady = EggState.IsReadyToHatch(eggData)
                else
                    isReady = eggData.Placement ~= nil
                end

                if isReady then
                    pcall(function()
                        if EggState.BeginHatch then EggState.BeginHatch(uid) end
                        task.wait(0.05)
                        if EggState.FinishHatch then EggState.FinishHatch(uid) end
                        count = count + 1
                    end)
                end
            end
        end
    end
    return count
end

-- ==============================================================================
-- BASE, HOMESTEAD & REWARDS AUTOMATION LOGIC
-- ==============================================================================
local function UpgradeHomesteadBase()
    local re1 = GetNetRemote("RE/Homestead/AskNearbyPurchase")
    if re1 then pcall(function() re1:FireServer() end) end
    local re2 = GetNetRemote("RE/Homestead/AskBaseTierRaise")
    if re2 then pcall(function() re2:FireServer() end) end
end

local function UpgradeTreadmillTier()
    local rf = GetNetRemote("RF/Treadmill/AskTierRaise")
    if rf then pcall(function() rf:InvokeServer() end) end
end

local function EquipBestPets()
    local rf = GetNetRemote("RF/Haul/WearBest") or GetNetRemote("RF/PenRoster/ConfirmEquipBestBadge")
    if rf then pcall(function() rf:InvokeServer() end) end
end

-- ==============================================================================
-- BOSS ARENA (Abyss Overlord) - rotating live event, opens every 30 minutes.
-- The old feedable monster (MonsterParasite) event is retired in-game and has
-- been removed from this HUB.
-- ==============================================================================
Boss.Data = nil
Boss.MasteryData = nil

-- Loaded on first use instead of at script load: keeps the startup path of this
-- HUB free of anything device specific (phones were crashing at execute time).
function Boss.EnsureData()
    if Boss._dataTried then return end
    Boss._dataTried = true
    pcall(function() Boss.Data = require(RS.Data.BossEvent) end)
    pcall(function() Boss.MasteryData = require(RS.Data.BossMastery) end)
end

Boss.MilestoneFallback = { "Mastery3", "Mastery5", "Mastery10", "Mastery15", "Mastery20", "Mastery30" }

function Boss.Snapshot()
    local rf = GetNetRemote("RF/BossEvent/AskSnapshot")
    if not rf then return nil end
    local ok, res = pcall(function() return rf:InvokeServer() end)
    if ok and type(res) == "table" then return res end
    return nil
end

function Boss.IsOpen()
    Boss.EnsureData()
    local snap = Boss.Snapshot()
    if snap then
        if snap.Open ~= nil then return snap.Open == true end
        if snap.BossHealth and snap.BossMaxHealth then
            return (tonumber(snap.BossHealth) or 0) > 0
        end
    end
    if Boss.Data and type(Boss.Data.SecondsUntilNextOpen) == "function" then
        local ok, secs = pcall(function() return Boss.Data.SecondsUntilNextOpen() end)
        if ok and tonumber(secs) then return tonumber(secs) <= 0 end
    end
    return false
end

function Boss.SecondsUntilOpen()
    Boss.EnsureData()
    if Boss.Data and type(Boss.Data.SecondsUntilNextOpen) == "function" then
        local ok, secs = pcall(function() return Boss.Data.SecondsUntilNextOpen() end)
        if ok and tonumber(secs) then return tonumber(secs) end
    end
    return nil
end

function Boss.Join()
    local rf = GetNetRemote("RF/BossEvent/AskEnter")
    if not rf then return false end
    local ok, res = pcall(function() return rf:InvokeServer() end)
    return ok and res ~= false and res ~= nil
end

function Boss.ClaimMastery()
    Boss.EnsureData()
    local rf = GetNetRemote("RF/BossMastery/AskClaimMilestone")
    if not rf then return 0 end

    local ids = {}
    if Boss.MasteryData and type(Boss.MasteryData.Milestones) == "table" then
        for _, m in pairs(Boss.MasteryData.Milestones) do
            if type(m) == "table" and type(m.Id) == "string" and not Boss.claimed[m.Id] then
                table.insert(ids, m.Id)
            end
        end
    end
    if #ids == 0 then
        for _, id in ipairs(Boss.MilestoneFallback) do
            if not Boss.claimed[id] then table.insert(ids, id) end
        end
    end

    local claimed = 0
    for _, id in ipairs(ids) do
        local ok, res = pcall(function() return rf:InvokeServer(id) end)
        if ok and res ~= false and res ~= nil then
            Boss.claimed[id] = true
            claimed = claimed + 1
        end
    end
    return claimed
end

-- ------------------------------------------------------------------------------
-- FULLY AUTOMATIC BOSS FIGHT
-- Flow inside the arena (verified against the live client): the boss is an
-- "Abyss Overlord" with 7000 HP and takes 100 damage per player hit; CrystalTowers
-- shield it and are destroyed with the bat gear (IsBat = true). Hazards (black
-- hole / rotating X / expanding rings) are damage-reported BY THE CLIENT through
-- BossEvent.HazardHit / BossEvent.BlackHoleHit, so refusing to send those reports
-- is what makes hazard immunity real.
-- ------------------------------------------------------------------------------
Boss.autoFight        = false
Boss.hazardImmune     = false
Boss.arenaApproach    = "Crystals First"
Boss.glideSpeed       = 260          -- arena approach speed (studs/s) - no teleporting
Boss.engageDistance   = 7            -- swing once this close to the crystal
Boss.swingInterval    = 0.15         -- seconds between swings
Boss._target          = nil
Boss._targetPart      = nil
Boss._targetAt        = 0
Boss._stepAt          = 0
Boss._swingAt         = 0
Boss._batAt           = 0

function Boss.IsInArena()
    return LP:GetAttribute("InBossArena") == true
end

-- Equips a bat gear (the only thing that breaks the crystals).
function Boss.FindBat()
    local char = LP.Character
    if not char then return nil end

    local held = char:FindFirstChildWhichIsA("Tool")
    if held and held:GetAttribute("IsBat") == true then return held end

    local bag = LP:FindFirstChild("Backpack")
    if bag then
        for _, c in ipairs(bag:GetChildren()) do
            if c:IsA("Tool") and c:GetAttribute("IsBat") == true then
                c.Parent = char
                return c
            end
        end
    end

    -- Nothing bat-like carried: ask the Codex for the field bat, then re-scan.
    local wear = GetNetRemote("RF/Codex/AskWearFieldBat")
    if wear then pcall(function() wear:InvokeServer() end) end
    task.wait(0.25)

    if bag then
        for _, c in ipairs(bag:GetChildren()) do
            if c:IsA("Tool") and c:GetAttribute("IsBat") == true then
                c.Parent = char
                return c
            end
        end
    end
    return nil
end

-- Closest live crystal hitbox, else the boss itself / its bat bone.
function Boss.FindTarget()
    local arena = Workspace:FindFirstChild("BossArena")
    if not arena then return nil end
    local root = findHRP()
    if not root then return nil end

    local best, bestDist = nil, math.huge
    local towers = arena:FindFirstChild("CrystalTowers")
    if towers then
        for _, tower in ipairs(towers:GetChildren()) do
            local hb = tower:FindFirstChild("Hitbox", true)
            if hb and hb:IsA("BasePart") then
                local hp = tonumber(hb:GetAttribute("Health"))
                if hp == nil or hp > 0 then
                    local d = (root.Position - hb.Position).Magnitude
                    if d < bestDist then best, bestDist = hb, d end
                end
            end
        end
    end

    if best and Boss.arenaApproach == "Crystals First" then
        return best, "Crystal"
    end

    local boss = arena:FindFirstChild("Boss")
    if boss then
        local aim = boss:FindFirstChild("UpperHand1.R", true) or boss.PrimaryPart
        if aim and aim:IsA("BasePart") then
            local d = (root.Position - aim.Position).Magnitude
            if d < bestDist then best, bestDist = aim, d end
        end
    end

    return best, (best and best:IsDescendantOf(towers or arena) and "Boss" or nil)
end

-- One FRAME of travel toward a stand position 5 studs from the target.
-- Continuous by design: the worker calls this every frame while we are far away,
-- so movement never pauses between ticks. The arena is a floating platform, so
-- this never uses the overworld travel helpers (they clamp the route to ground
-- level and would drop us off it). Returns true when close enough to swing.
function Boss.GlideStep(target)
    local root = findHRP()
    if not root or not target then return false end

    local offset = root.Position - target.Position
    offset = Vector3.new(offset.X, 0, offset.Z)
    if offset.Magnitude < 0.5 then offset = Vector3.new(0, 0, 1) end

    local destination = target.Position + offset.Unit * 5
    local toGo = destination - root.Position
    local remain = toGo.Magnitude
    if remain < 1.0 then
        root.AssemblyLinearVelocity = Vector3.zero
        root.AssemblyAngularVelocity = Vector3.zero
        return true
    end

    -- Advance by the REAL frame delta so the speed stays constant no matter how
    -- often the worker ticks (a fixed per-tick step made it stutter).
    local now = os.clock()
    local dt = math.clamp(now - (Boss._stepAt or now), 0.001, 0.1)
    Boss._stepAt = now

    local speed = math.clamp(tonumber(Boss.glideSpeed) or 260, 60, 500)
    local dir = toGo.Unit
    local step = math.min(speed * dt, remain)
    local nextPos = root.Position + dir * step

    local face = Vector3.new(dir.X, 0, dir.Z)
    if face.Magnitude < 0.01 then face = root.CFrame.LookVector end

    root.CFrame = CFrame.lookAt(nextPos, nextPos + face.Unit)
    root.AssemblyLinearVelocity = Vector3.zero
    root.AssemblyAngularVelocity = Vector3.zero
    return false
end

-- Keeps a bat in hand without hammering the server: the Codex request only goes
-- out once every 1.5 s until a bat is actually equipped.
function Boss.EnsureBat()
    local char = LP.Character
    if not char then return nil end

    local held = char:FindFirstChildWhichIsA("Tool")
    if held and held:GetAttribute("IsBat") == true then return held end

    local now = os.clock()
    if now - (Boss._batAt or 0) < 1.5 then return nil end
    Boss._batAt = now
    return Boss.FindBat()
end

-- Holds the chosen crystal for a moment: re-picking the closest one every single
-- frame made the character jitter between two crystals instead of gliding.
function Boss.CurrentTarget()
    local now = os.clock()
    local held = Boss._targetPart
    if held and held.Parent and (now - (Boss._targetAt or 0)) < 0.35 then
        local hp = tonumber(held:GetAttribute("Health"))
        if hp == nil or hp > 0 then return held, Boss._target end
    end
    local part, kind = Boss.FindTarget()
    Boss._targetPart, Boss._target, Boss._targetAt = part, kind, now
    return part, kind
end

-- One combat FRAME - the worker calls this every Heartbeat:
--   far away -> a single smooth glide step;   in range -> swing on a fixed timer.
function Boss.Fight()
    if not Boss.IsInArena() then return false end

    local root = findHRP()
    if not root then return false end

    local target, kind = Boss.CurrentTarget()
    if not target then return false end

    local dist = (root.Position - target.Position).Magnitude
    if dist > Boss.engageDistance then
        Boss.GlideStep(target)
        Boss._target = kind
        return true
    end

    local now = os.clock()
    if now - (Boss._swingAt or 0) < Boss.swingInterval then return true end
    Boss._swingAt = now

    -- The bat swing is what the server scores; the tool activation covers gear
    -- driven hits. Both are cheap and harmless when the server rejects one.
    local bat = Boss.EnsureBat()
    if bat then pcall(function() bat:Activate() end) end
    local swing = GetNetRemote("RE/BatSwing/Trigger")
    if swing then pcall(function() swing:FireServer() end) end

    return true
end

-- Hazard immunity: the arena's hazard damage is reported by the client, so
-- blocking those two reports means the boss can never damage us.
-- NOTE: FireServer is one shared C closure, so the hook must match on `self`
-- and pass everything else straight through - otherwise it would mute every
-- remote in the game. One hook covers both reports.
--
-- IMPORTANT: this hook is installed LAZILY (only when the user opts in below).
-- Installing it at script load hard-crashed several phone executors, because
-- hooking a C closure on those runtimes is not supported. Touch-only devices
-- skip it entirely so the menu still loads on mobile.
Boss._hazardRemotes = {}
Boss.hazardHook = false
Boss.hazardHookTried = false

do
    local hazard = GetNetRemote("RE/BossEvent/HazardHit")
    local blackHole = GetNetRemote("RE/BossEvent/BlackHoleHit")
    for _, remote in ipairs({ hazard, blackHole }) do
        if type(remote) == "userdata" and remote:IsA("RemoteEvent") then
            Boss._hazardRemotes[remote] = true
        end
    end
end

function Boss.InstallHazardHook()
    if Boss.hazardHook then return true end
    if Boss.hazardHookTried then return false end
    Boss.hazardHookTried = true

    -- Phone executors crash when a C closure gets hooked, so never do it there.
    local touchOnly = false
    pcall(function()
        touchOnly = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    end)
    if touchOnly then
        Notify("Boss Hazards", "Hazard immunity is not supported on mobile - the boss can still hit you", "Error")
        return false
    end

    if not HookFn then return false end
    local hazard = GetNetRemote("RE/BossEvent/HazardHit")
    if type(hazard) ~= "userdata" or not hazard:IsA("RemoteEvent") then return false end

    local oldFire = hazard.FireServer
    if type(oldFire) ~= "function" then return false end

    local ok = pcall(function()
        HookFn(oldFire, function(self, ...)
            if Boss.hazardImmune and Boss._hazardRemotes[self] then
                return -- swallow the hazard damage report
            end
            return oldFire(self, ...)
        end)
    end)
    Boss.hazardHook = ok
    return ok
end

local function DropHeldEgg()
    local rf = GetNetRemote("RF/EggWorld/AskFieldEggDrop")
    if rf then pcall(function() rf:InvokeServer() end) end
    if EggState and EggState.DropFieldEgg then pcall(EggState.DropFieldEgg) end
end

local function BuyAffordableTrails()
    local rf = GetNetRemote("RF/Trailwear/AskPurchase")
    local TrailsData = RS:FindFirstChild("Data") and RS.Data:FindFirstChild("Trails") and require(RS.Data.Trails)
    local save = nil
    pcall(function() save = SaveModule and SaveModule.Get and SaveModule.Get() end)
    if not rf or not TrailsData or not save then return end

    local myMoney = tonumber(save.Money) or 0
    local inv = save.TrailInventory or {}

    for _, t in pairs(TrailsData.Directory or TrailsData) do
        if type(t) == "table" and t._id and not inv[t._id] then
            local price = tonumber(t.Price) or math.huge
            if myMoney >= price then
                pcall(function() rf:InvokeServer(t._id) end)
                task.wait(0.25)
            end
        end
    end
end

local function SetNoKnockback(enabled)
    noKnockbackEnabled = enabled
    if enabled then
        pcall(function()
            local rigSync = GetNetRemote("RE/RigSync/Refresh")
            if rigSync and getconnections then
                for _, conn in ipairs(getconnections(rigSync.OnClientEvent)) do
                    pcall(function() conn:Disconnect() end)
                end
            end
        end)
    end
end

-- Auto-enable defensive features by default (user request)
pcall(function() if avoidTrapsEnabled then NeutralizeTraps() end end)
pcall(function() if noKnockbackEnabled then SetNoKnockback(true) end end)

local function SellSelectedPets()
    local re = GetNetRemote("RE/PetSatchel/SellPet")
    if not re or not SaveModule then return end
    local save = nil
    pcall(function() save = SaveModule.Get and SaveModule.Get() end)
    local inv = save and save.Inventory
    if type(inv) ~= "table" then return end

    for uid, petData in pairs(inv) do
        if type(petData) == "table" and not petData.Locked then
            local rName = petData.Rarity or "Common"
            if isRarityAllowed(rName, getSellRarityFilter(selectedSellPetRarities)) then
                pcall(function() re:FireServer(uid) end)
                task.wait(0.08)
            end
        end
    end
end

local function SellSelectedEggs()
    if not SaveModule then return end
    local save = nil
    pcall(function() save = SaveModule.Get and SaveModule.Get() end)
    if not save then return end
    local inv = save.EggInventory
    if type(inv) ~= "table" then return end

    local wear = GetNetRemote("RF/EggWorld/AskWearTool")
    local sell = GetNetRemote("RE/PetSatchel/SellPet")
    if not wear or not sell then return end

    for uid, eggData in pairs(inv) do
        if type(eggData) == "table" and not eggData.Placement and not eggData.Locked then
            local rName = GetEggRarityInfo(eggData)
            if isRarityAllowed(rName, getSellRarityFilter(selectedSellEggRarities)) then
                pcall(function() wear:InvokeServer(uid) end)
                pcall(function() sell:FireServer({ uid }) end)
                task.wait(SELL_REQUEST_DELAY)
            end
        end
    end
end

local function DeleteOwnPetRenders()
    local count = 0
    local function sweep(container)
        if not container then return end
        for _, child in ipairs(container:GetChildren()) do
            if child:IsA("Model") or child:IsA("BasePart") then
                pcall(function()
                    child:Destroy()
                    count = count + 1
                end)
            end
        end
    end
    sweep(Workspace:FindFirstChild("Pets"))
    sweep(Workspace:FindFirstChild("RenderedPets"))
    return count
end

local function ClaimAllAvailableRewards()
    pcall(function()
        local rf1 = GetNetRemote("RF/AwayEarnings/AskCollect")
        if rf1 then rf1:InvokeServer() end
    end)
    pcall(function()
        local rf2 = GetNetRemote("RF/Codex/AskRedeemAll")
        if rf2 then rf2:InvokeServer() end
    end)
    pcall(function()
        local rf3 = GetNetRemote("RF/GroupPerk/RedeemPerk")
        if rf3 then rf3:InvokeServer() end
    end)
    pcall(Boss.ClaimMastery)
end

-- ==============================================================================
-- WORKER LOOPS
-- ==============================================================================
-- 1. Auto Steal Eggs Loop
task.spawn(function()
    while not HUB.dead do
        if autoStealEnabled then
            pcall(StealBestEggOnce)
        end
        task.wait(stealDelay)
    end
end)

-- 2. Auto Hatch & Auto Plant Loop
task.spawn(function()
    while not HUB.dead do
        if autoHatchEnabled then
            pcall(HatchAllReadyEggs)
        end
        if autoPlantEnabled then
            pcall(PlantAllCarriedEggsInPen)
        end
        task.wait(hatchCheckDelay)
    end
end)

-- 3. Base, Homestead, Sales & Event Upgrades Loop
task.spawn(function()
    while not HUB.dead do
        if autoUpgradeBase then pcall(UpgradeHomesteadBase) end
        if autoUpgradeTreadmill then pcall(UpgradeTreadmillTier) end
        if autoEquipBestPets then pcall(EquipBestPets) end
        if autoClaimRewards then pcall(ClaimAllAvailableRewards) end
        if Boss.autoMastery then pcall(Boss.ClaimMastery) end
        if autoSellPets then pcall(SellSelectedPets) end
        if autoSellEggs then pcall(SellSelectedEggs) end
        task.wait(2.5)
    end
end)

-- 3b. Boss Arena worker: joins when the window opens, then fights EVERY FRAME
--     (one glide step per frame while far away, swings on a timer in range) so
--     the movement is continuous and the Overlord still goes down inside the
--     330 s window.
task.spawn(function()
    while not HUB.dead do
        if Boss.autoJoin or Boss.autoFight then
            if Boss.IsInArena() then
                if Boss.autoFight then pcall(Boss.Fight) end
                RunService.Heartbeat:Wait()
            else
                local ok, open = pcall(Boss.IsOpen)
                Boss.arenaReady = (ok and open == true)
                if Boss.arenaReady then pcall(Boss.Join) end
                task.wait(2)
            end
        else
            task.wait(1)
        end
    end
end)

-- 4. Bat / Slap Aura Loop
task.spawn(function()
    local batRe = GetNetRemote("RE/BatSwing/Trigger")
    while not HUB.dead do
        if batAuraEnabled and batRe then
            local hrp = findHRP()
            if hrp then
                local foundNearby = false
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LP and p.Character then
                        local oHrp = p.Character:FindFirstChild("HumanoidRootPart")
                        if oHrp and (oHrp.Position - hrp.Position).Magnitude <= batAuraRadius then
                            foundNearby = true
                            break
                        end
                    end
                end
                if foundNearby then
                    pcall(function() batRe:FireServer() end)
                end
            end
        end
        task.wait(batAuraDelay)
    end
end)

-- 5. Trap Neutralizer Loop
task.spawn(function()
    local debris = Workspace:FindFirstChild("__DEBRIS")
    if debris then
        track(debris.ChildAdded:Connect(function(child)
            if avoidTrapsEnabled and child.Name == "PlayerTrap" then
                task.wait(0.05)
                if child:GetAttribute("Owner") ~= LP.Name then
                    if child:IsA("BasePart") then child.CanTouch = false end
                    for _, c in ipairs(child:GetChildren()) do
                        if c:IsA("BasePart") then c.CanTouch = false end
                    end
                end
            end
        end))
    end

    while not HUB.dead do
        if avoidTrapsEnabled or autoStealEnabled then
            pcall(NeutralizeTraps)
        end
        task.wait(1.5)
    end
end)

-- ==============================================================================
-- VISUALS & ESP
-- ==============================================================================
local esp = {
    enabled         = false,
    eggs            = true,
    traps           = false,
    players         = false,
    guards          = false,
    rareEggsOnly    = false,
    showPetIcons    = true,
    maxDistance     = 800,

    eggColor        = Color3.fromRGB(255, 200, 50),
    rareEggColor    = Color3.fromRGB(255, 60, 220),
    trapColor       = Color3.fromRGB(255, 60, 60),
    playerColor     = Color3.fromRGB(100, 220, 100),
    guardColor      = Color3.fromRGB(255, 60, 60),
}

local hasDrawing = type(Drawing) == "table" and type(Drawing.new) == "function"
local trackedEspObjects = {}
local espBillboards = {}
local espContainer = nil

local function getEspContainer()
    if espContainer and espContainer.Parent then return espContainer end
    local p = nil
    pcall(function() p = (gethui and gethui()) end)
    if not p then pcall(function() p = game:GetService("CoreGui") end) end
    if not p then p = LP:FindFirstChild("PlayerGui") or Workspace end

    pcall(function()
        for _, c in ipairs(p:GetChildren()) do
            if c:IsA("Folder") and c.Name == "SAE_Esp_Holder" then c:Destroy() end
        end
    end)
    espContainer = Instance.new("Folder")
    espContainer.Name = "SAE_Esp_Holder"
    pcall(function() espContainer.Parent = p end)
    return espContainer
end

local function updateEggBillboard(key, pos, icon)
    local bb = espBillboards[key]
    if not bb or not bb.gui or not bb.gui.Parent then
        local holder = getEspContainer()
        local part = Instance.new("Part")
        part.Name = "EspAnchor"
        part.Size = Vector3.new(1, 1, 1)
        part.Transparency = 1
        part.Anchored = true
        part.CanCollide = false
        part.CanQuery = false
        part.CanTouch = false
        part.CFrame = CFrame.new(pos)
        part.Parent = holder

        local gui = Instance.new("BillboardGui")
        gui.Name = "EggIconBillboard"
        gui.Adornee = part
        gui.Size = UDim2.fromOffset(28, 28)
        gui.StudsOffset = Vector3.new(-2.2, 1.2, 0)
        gui.AlwaysOnTop = true
        gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        gui.Parent = part

        local img = Instance.new("ImageLabel")
        img.Name = "PetImage"
        img.Size = UDim2.fromScale(1, 1)
        img.BackgroundTransparency = 1
        img.ScaleType = Enum.ScaleType.Fit
        img.Image = icon or ""
        img.Parent = gui

        bb = {
            part = part,
            gui = gui,
            img = img
        }
        espBillboards[key] = bb
    else
        bb.part.CFrame = CFrame.new(pos)
        bb.img.Image = icon or ""
        bb.gui.Enabled = (icon ~= nil and icon ~= "")
    end
    return bb
end

local function createDrawingObject()
    if not hasDrawing then return {} end
    local o = {}
    o.name = trackDrawing(Drawing.new("Text"))
    o.name.Size = 13; o.name.Center = true; o.name.Outline = true; o.name.Visible = false

    o.dist = trackDrawing(Drawing.new("Text"))
    o.dist.Size = 11; o.dist.Center = true; o.dist.Outline = true; o.dist.Visible = false

    o.box = trackDrawing(Drawing.new("Square"))
    o.box.Thickness = 1.5; o.box.Filled = false; o.box.Visible = false

    return o
end

track(RunService.RenderStepped:Connect(function()
    if HUB.dead or not esp.enabled then
        for _, obj in pairs(trackedEspObjects) do
            if obj.name then obj.name.Visible = false end
            if obj.dist then obj.dist.Visible = false end
            if obj.box then obj.box.Visible = false end
        end
        for _, bb in pairs(espBillboards) do
            if bb.gui then bb.gui.Enabled = false end
        end
        return
    end

    local hrp = findHRP()
    local myPos = hrp and hrp.Position or Vector3.zero
    local renderItems = {}
    local activeBbKeys = {}

    -- Eggs ESP
    if esp.eggs and EggState and EggState.ReadFieldEggs then
        local ok, snap = pcall(EggState.ReadFieldEggs)
        if ok and snap and snap.Records then
            for _, egg in ipairs(snap.Records) do
                if egg.State == "Slot" and egg.BoundsCFrame then
                    local pos = egg.BoundsCFrame.Position
                    local dist = (pos - myPos).Magnitude
                    if esp.maxDistance <= 0 or dist <= esp.maxDistance then
                        local muts = egg.Mutations or {}
                        local isRare = #muts > 0
                        if not esp.rareEggsOnly or isRare then
                            local mutText = isRare and (" [" .. table.concat(muts, ",") .. "]") or ""
                            local rName = GetEggRarityInfo(egg)
                            local label = (egg.AssetCategory or "Egg") .. " (" .. rName .. ")" .. mutText
                            local cat = egg.AssetCategory
                            local aInfo = AssetsData and (AssetsData.Directory or AssetsData) and (AssetsData.Directory or AssetsData)[cat]
                            local petIcon = aInfo and (aInfo.Icon or (aInfo.Egg and aInfo.Egg.Icon)) or ""

                            local itemColor = isRare and esp.rareEggColor or esp.eggColor

                            table.insert(renderItems, {
                                Key = egg.Uid,
                                Pos = pos,
                                Name = label,
                                Color = itemColor,
                                Dist = dist,
                            })

                            if esp.showPetIcons and petIcon ~= "" then
                                activeBbKeys[egg.Uid] = true
                                updateEggBillboard(egg.Uid, pos, petIcon)
                            end
                        end
                    end
                end
            end
        end
    end

    -- Traps ESP
    if esp.traps then
        local debris = Workspace:FindFirstChild("__DEBRIS")
        if debris then
            for _, trap in ipairs(debris:GetChildren()) do
                if trap.Name == "PlayerTrap" and trap:IsA("BasePart") then
                    local pos = trap.Position
                    local dist = (pos - myPos).Magnitude
                    if esp.maxDistance <= 0 or dist <= esp.maxDistance then
                        local owner = trap:GetAttribute("Owner") or "Enemy"
                        table.insert(renderItems, {
                            Key = trap,
                            Pos = pos + Vector3.new(0, 1.5, 0),
                            Name = "[TRAP] @" .. owner,
                            Color = esp.trapColor,
                            Dist = dist,
                        })
                    end
                end
            end
        end
    end

    -- Players ESP
    if esp.players then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LP and p.Character then
                local oHrp = p.Character:FindFirstChild("HumanoidRootPart")
                if oHrp then
                    local dist = (oHrp.Position - myPos).Magnitude
                    if esp.maxDistance <= 0 or dist <= esp.maxDistance then
                        table.insert(renderItems, {
                            Key = p,
                            Pos = oHrp.Position,
                            Name = p.DisplayName .. " (@" .. p.Name .. ")",
                            Color = esp.playerColor,
                            Dist = dist,
                        })
                    end
                end
            end
        end
    end

    -- Hide unreferenced billboards
    for k, bb in pairs(espBillboards) do
        if not activeBbKeys[k] and bb.gui then
            bb.gui.Enabled = false
        end
    end

    local cam = GetCamera()
    local activeKeys = {}
    for _, item in ipairs(renderItems) do
        activeKeys[item.Key] = true
        local obj = trackedEspObjects[item.Key]
        if not obj then
            obj = createDrawingObject()
            trackedEspObjects[item.Key] = obj
        end

        local screenPos, onScreen = nil, false
        if cam then
            screenPos, onScreen = cam:WorldToViewportPoint(item.Pos)
        end
        if onScreen and hasDrawing and screenPos then
            if obj.name then
                obj.name.Text = item.Name
                obj.name.Position = Vector2.new(screenPos.X, screenPos.Y - 14)
                obj.name.Color = item.Color
                obj.name.Visible = true
            end
            if obj.dist then
                obj.dist.Text = math.floor(item.Dist) .. " studs"
                obj.dist.Position = Vector2.new(screenPos.X, screenPos.Y + 2)
                obj.dist.Color = Color3.fromRGB(220, 220, 220)
                obj.dist.Visible = true
            end
        else
            if obj.name then obj.name.Visible = false end
            if obj.dist then obj.dist.Visible = false end
            if obj.box then obj.box.Visible = false end
        end
    end

    for k, obj in pairs(trackedEspObjects) do
        if not activeKeys[k] then
            if obj.name then obj.name.Visible = false end
            if obj.dist then obj.dist.Visible = false end
            if obj.box then obj.box.Visible = false end
        end
    end
end))

-- Fullbright
local fullbrightEnabled = false
local defaultAmbient = Lighting.Ambient
local defaultOutdoor = Lighting.OutdoorAmbient
local defaultBrightness = Lighting.Brightness
local defaultClockTime = Lighting.ClockTime

local function SetFullbright(v)
    fullbrightEnabled = v
    if v then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
    else
        Lighting.Ambient = defaultAmbient
        Lighting.OutdoorAmbient = defaultOutdoor
        Lighting.Brightness = defaultBrightness
        Lighting.ClockTime = defaultClockTime
    end
end

-- ==============================================================================
-- MOVEMENT & PLAYER MODIFIERS
-- ==============================================================================
local walkSpeedEnabled = false
local walkSpeedVal     = 24
local jumpPowerEnabled = false
local jumpPowerVal     = 60
local infiniteJump     = false
local flying           = false
local flySpeed         = 60
local antiAFK          = false

local function ApplyWalkSpeed(v)
    walkSpeedVal = v
    local hum = findHum()
    if hum and walkSpeedEnabled then hum.WalkSpeed = v end
end

local function ApplyJumpPower(v)
    jumpPowerVal = v
    local hum = findHum()
    if hum and jumpPowerEnabled then
        hum.UseJumpPower = true
        hum.JumpPower = v
    end
end

track(RunService.Stepped:Connect(function()
    if HUB.dead then return end
    local hum = findHum()
    if hum then
        if walkSpeedEnabled then hum.WalkSpeed = walkSpeedVal end
        if jumpPowerEnabled then hum.UseJumpPower = true; hum.JumpPower = jumpPowerVal end
    end
end))

track(UserInputService.JumpRequest:Connect(function()
    if HUB.dead then return end
    local hum = findHum()
    if hum then
        hum.Jump = true
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end))

local function startFly()
    if flying then return end
    local hrp = findHRP()
    local hum = findHum()
    if not (hrp and hum) then return end
    flying = true
    hrp.Anchored = true

    local bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(1, 1, 1) * 1e5
    bodyGyro.P = 1e5
    bodyGyro.CFrame = hrp.CFrame
    bodyGyro.Parent = hrp

    HUB._fly = {
        hrp = hrp,
        gyro = bodyGyro,
        conn = track(RunService.RenderStepped:Connect(function(dt)
            if not flying or HUB.dead then return end
            local cam = GetCamera()
            if not cam then return end
            local look = cam.CFrame.LookVector
            local right = cam.CFrame.RightVector
            local flatLook = Vector3.new(look.X, 0, look.Z)
            flatLook = flatLook.Magnitude > 0.001 and flatLook.Unit or Vector3.new(0, 0, -1)
            local flatRight = Vector3.new(right.X, 0, right.Z)
            flatRight = flatRight.Magnitude > 0.001 and flatRight.Unit or Vector3.new(1, 0, 0)

            local dir = Vector3.zero
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + flatLook end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - flatLook end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - flatRight end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + flatRight end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.new(0, 1, 0) end

            if dir.Magnitude > 0 then
                hrp.CFrame = hrp.CFrame + dir.Unit * flySpeed * math.min(dt, 0.1)
            end
            bodyGyro.CFrame = CFrame.lookAt(hrp.Position, hrp.Position + look)
        end))
    }
end

local function stopFly()
    flying = false
    local f = HUB._fly
    if f then
        pcall(function() f.conn:Disconnect() end)
        pcall(function() f.hrp.Anchored = false end)
        pcall(function() f.gyro:Destroy() end)
        HUB._fly = nil
    end
end

local antiAfkConn = nil
local function SetAntiAFK(v)
    antiAFK = v
    if v and not antiAfkConn then
        antiAfkConn = track(LocalPlayer.Idled:Connect(function()
            if antiAFK then
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end
        end))
    elseif not v and antiAfkConn then
        pcall(function() antiAfkConn:Disconnect() end)
        antiAfkConn = nil
    end
end

-- ==============================================================================
-- UI CREATION - MAIN TABS
-- ==============================================================================
local EggsTab     = Window:AddTab({ Name = "Eggs", Subtitle = "Steal, hatch & plant", Icon = "crown" })
local BaseTab     = Window:AddTab({ Name = "Base", Subtitle = "Homestead & training", Icon = "bolt" })
local CombatTab   = Window:AddTab({ Name = "Combat", Subtitle = "Bat, slaps & defense", Icon = "combat" })
local PlayerTab   = Window:AddTab({ Name = "Player", Subtitle = "Movement & teleports", Icon = "player" })
local SettingsTab = Window:AddTab({ Name = "Settings", Subtitle = "Configs & unloader", Icon = "gear" })

-- -----------------------------------------------------------------------------
-- TAB 1: EGGS
-- -----------------------------------------------------------------------------
local StealSub = EggsTab:AddSubTab("Auto Steal")
local HatchSub = EggsTab:AddSubTab("Auto Hatch & Plant")
local EggEspSub = EggsTab:AddSubTab("Egg Tracker ESP")

-- SubTab: Auto Steal
StealSub:AddToggle({
    Name = "Auto Steal Eggs", Default = false, Flag = "steal_auto",
    Callback = safeCallback(function(v)
        autoStealEnabled = v
        if v then EnsureSavedReturnPosition() end
        Notify("Auto Steal", v and "Enabled" or "Disabled", v and "Success" or "Error")
    end)
})
StealSub:AddDropdown({
    Name = "Steal Movement Method", Options = { "Tween Glide", "Fly Glide", "Safe Walk" }, Default = "Tween Glide", Flag = "steal_method",
    Callback = function(v) stealMovementMethod = v end
})
StealSub:AddToggle({
    Name = "Rare Egg Hunter (Highest Rarity First)", Default = true, Flag = "rare_hunter",
    Callback = function(v) rareEggHunter = v end
})
StealSub:AddMultiDropdown({
    Name = "Filter by Rarity (Multi-Select)", Options = RARITY_NAMES, Default = {}, Flag = "steal_rarities",
    Callback = function(selectedList) selectedStealRarities = selectedList end
})
StealSub:AddMultiDropdown({
    Name = "Filter by Area (Multi-Select)", Options = AREA_NAMES, Default = {}, Flag = "steal_areas",
    Callback = function(selectedList) selectedStealAreas = selectedList end
})
StealSub:AddMultiDropdown({
    Name = "Filter by Mutation (Multi-Select)", Options = MUTATION_FILTERS, Default = {}, Flag = "steal_muts",
    Callback = function(selectedList) selectedMutationTypes = selectedList end
})
StealSub:AddSlider({
    Name = "Glide / Travel Speed", Min = 50, Max = 750, Default = 750, Suffix = " studs/s", Flag = "glide_speed",
    Callback = function(v) glideSpeed = tonumber(v) or 750 end
})
StealSub:AddSlider({
    Name = "Steal Delay Gap", Min = 0.5, Max = 10, Default = 1.5, Suffix = "s", Flag = "steal_gap",
    Callback = function(v) stealDelay = v end
})
StealSub:AddButton({
    Name = "Steal Best Available Egg Once", Primary = true,
    Callback = safeCallback(function()
        local ok = StealBestEggOnce()
        Notify("Steal Egg", ok and "Stealing target egg" or "No matching egg found for selected filters", ok and "Success" or "Info")
    end)
})

-- SubTab: Auto Hatch & Plant
HatchSub:AddToggle({
    Name = "Auto Hatch Ready Eggs", Default = false, Flag = "hatch_auto",
    Callback = safeCallback(function(v)
        autoHatchEnabled = v
        Notify("Auto Hatch", v and "Enabled" or "Disabled", v and "Success" or "Error")
    end)
})
HatchSub:AddToggle({
    Name = "Auto Place Egg (Base Pen)", Default = false, Flag = "plant_auto",
    Callback = function(v)
        autoPlantEnabled = v
        Notify("Auto Place Egg", v and "Enabled" or "Disabled", v and "Success" or "Error")
    end
})
HatchSub:AddSlider({
    Name = "Hatch Check Delay", Min = 0.5, Max = 10, Default = 2.0, Suffix = "s", Flag = "hatch_gap",
    Callback = function(v) hatchCheckDelay = v end
})
HatchSub:AddButton({
    Name = "Hatch All Ready Eggs Now", Primary = true,
    Callback = safeCallback(function()
        local count = HatchAllReadyEggs()
        Notify("Hatch", "Hatched " .. count .. " egg(s)", "Success")
    end)
})
HatchSub:AddButton({
    Name = "Place Carried Eggs in Pen Now",
    Callback = safeCallback(function()
        local count = PlantAllCarriedEggsInPen()
        Notify("Plant Eggs", "Planted " .. count .. " egg(s) in pen", "Success")
    end)
})

-- SubTab: Egg Tracker ESP
EggEspSub:AddToggle({
    Name = "Egg ESP Enabled", Default = false, Flag = "esp_eggs_enabled",
    Callback = safeCallback(function(v)
        esp.enabled = v
        Notify("Egg ESP", v and "Enabled" or "Disabled", v and "Success" or "Error")
    end)
})
EggEspSub:AddToggle({
    Name = "Show 3D Pet Image Badges", Default = true, Flag = "esp_pet_icons",
    Callback = function(v) esp.showPetIcons = v end
})
EggEspSub:AddToggle({
    Name = "Trap ESP (Highlights Enemy Traps)", Default = false, Flag = "esp_traps",
    Callback = function(v) esp.traps = v end
})
EggEspSub:AddToggle({
    Name = "Show Mutated / Rare Eggs Only", Default = false, Flag = "esp_eggs_rare_only",
    Callback = function(v) esp.rareEggsOnly = v end
})
EggEspSub:AddSlider({
    Name = "Max ESP Distance", Min = 100, Max = 2500, Default = 800, Suffix = " studs", Flag = "esp_max_dist",
    Callback = function(v) esp.maxDistance = v end
})

-- -----------------------------------------------------------------------------
-- TAB 2: BASE & UPGRADES
-- -----------------------------------------------------------------------------
do
local UpgradesSub = BaseTab:AddSubTab("Homestead & Treadmill")
local PetsSub     = BaseTab:AddSubTab("Pets & Satchel")
local SalesSub    = BaseTab:AddSubTab("Auto Sell")
local EventsSub   = BaseTab:AddSubTab("Events & Bosses")
local RewardsSub  = BaseTab:AddSubTab("Claim Rewards")

-- SubTab: Homestead & Treadmill
UpgradesSub:AddToggle({
    Name = "Auto Upgrade Base / Plot", Default = false, Flag = "up_base_auto",
    Callback = function(v) autoUpgradeBase = v end
})
UpgradesSub:AddToggle({
    Name = "Auto Upgrade Treadmill Tier", Default = false, Flag = "up_tread_auto",
    Callback = function(v) autoUpgradeTreadmill = v end
})
UpgradesSub:AddToggle({
    Name = "Auto Buy Speed Trails", Default = false, Flag = "auto_buy_trails",
    Callback = function(v) autoBuyTrails = v end
})
UpgradesSub:AddButton({
    Name = "Upgrade Base Now", Primary = true,
    Callback = safeCallback(function()
        UpgradeHomesteadBase()
        Notify("Base Upgrade", "Requested base upgrade", "Success")
    end)
})
UpgradesSub:AddButton({
    Name = "Upgrade Treadmill Now",
    Callback = safeCallback(function()
        UpgradeTreadmillTier()
        Notify("Treadmill Upgrade", "Requested treadmill upgrade", "Success")
    end)
})

-- SubTab: Pets & Satchel
PetsSub:AddToggle({
    Name = "Auto Equip Best Pets", Default = false, Flag = "equip_best_pets",
    Callback = function(v) autoEquipBestPets = v end
})
PetsSub:AddButton({
    Name = "Equip Best Pets Now", Primary = true,
    Callback = safeCallback(function()
        EquipBestPets()
        Notify("Pets", "Equipped best pets", "Success")
    end)
})

-- SubTab: Auto Sell
SalesSub:AddToggle({
    Name = "Auto Sell Low-Tier Pets", Default = false, Flag = "auto_sell_pets",
    Callback = function(v) autoSellPets = v end
})
SalesSub:AddMultiDropdown({
    Name = "Filter Pet Sell Rarities", Options = RARITY_NAMES, Default = {}, Flag = "sell_pet_rarities",
    Callback = function(selectedList) selectedSellPetRarities = selectedList end
})
SalesSub:AddToggle({
    Name = "Auto Sell Low-Tier Eggs", Default = false, Flag = "auto_sell_eggs",
    Callback = function(v) autoSellEggs = v end
})
SalesSub:AddMultiDropdown({
    Name = "Filter Egg Sell Rarities", Options = RARITY_NAMES, Default = {}, Flag = "sell_egg_rarities",
    Callback = function(selectedList) selectedSellEggRarities = selectedList end
})
SalesSub:AddButton({
    Name = "Sell Selected Pets Now", Primary = true,
    Callback = safeCallback(function()
        SellSelectedPets()
        Notify("Sales", "Sold matching pets", "Success")
    end)
})
SalesSub:AddButton({
    Name = "Sell Selected Eggs Now",
    Callback = safeCallback(function()
        SellSelectedEggs()
        Notify("Sales", "Sold matching eggs", "Success")
    end)
})

-- SubTab: Events & Bosses (Abyss Overlord Boss Arena)
EventsSub:AddToggle({
    Name = "FULL AUTO Boss Fight (Join + Fight + Dodge + Claim)", Default = false, Flag = "auto_fight_boss",
    Callback = safeCallback(function(v)
        Boss.autoFight = v
        -- Full auto also drives the join/claim toggles, but never turns them off,
        -- so the granular controls below stay independent.
        if v then
            Boss.autoJoin = true
            Boss.autoMastery = true
            if Boss.hazardImmune then pcall(Boss.InstallHazardHook) end
            Notify("Boss Auto", "Fully automatic: joins, fights the Overlord and claims rewards", "Success")
        else
            Notify("Boss Auto", "Disabled", "Error")
        end
    end)
})
EventsSub:AddDropdown({
    Name = "Boss Targeting", Options = { "Crystals First", "Boss First" }, Default = "Crystals First", Flag = "boss_targeting",
    Callback = function(v) Boss.arenaApproach = v end
})
EventsSub:AddToggle({
    -- Flag deliberately renamed: the first release of this toggle could autosave a
    -- `true` that re-installed the load-time hook and crashed phones on next run.
    Name = "Hazard Immunity (No Black Hole / Trap Damage)", Default = false, Flag = "boss_hazard_imm2",
    Callback = safeCallback(function(v)
        Boss.hazardImmune = v
        if v then
            -- Installed only on request: hooking a C closure at load crashed phones.
            if Boss.InstallHazardHook() then
                Notify("Boss Hazards", "Immune - hazard damage reports blocked", "Success")
            end
        else
            Notify("Boss Hazards", "Normal hazard damage", "Info")
        end
    end)
})
EventsSub:AddToggle({
    Name = "Auto Join Boss Arena (Every 30 min)", Default = false, Flag = "auto_join_boss",
    Callback = safeCallback(function(v)
        Boss.autoJoin = v
        Notify("Boss Arena", v and "Will join whenever the arena opens" or "Disabled", v and "Success" or "Error")
    end)
})
EventsSub:AddToggle({
    Name = "Auto Claim Boss Mastery Rewards", Default = false, Flag = "auto_boss_mastery",
    Callback = safeCallback(function(v)
        Boss.autoMastery = v
        Notify("Boss Mastery", v and "Enabled" or "Disabled", v and "Success" or "Error")
    end)
})
EventsSub:AddButton({
    Name = "Join Boss Arena Now", Primary = true,
    Callback = safeCallback(function()
        if Boss.Join() then
            Notify("Boss Arena", "Sent to Abyss Overlord", "Success")
        else
            Notify("Boss Arena", "Arena is closed - opens every 30 minutes", "Error")
        end
    end)
})
EventsSub:AddButton({
    Name = "Claim Boss Mastery Now",
    Callback = safeCallback(function()
        local n = Boss.ClaimMastery()
        if n and n > 0 then
            Notify("Boss Mastery", "Claimed " .. tostring(n) .. " milestone reward(s)", "Success")
        else
            Notify("Boss Mastery", "Nothing claimable yet", "Info")
        end
    end)
})
EventsSub:AddButton({
    Name = "Boss Arena Status",
    Callback = safeCallback(function()
        local snap = Boss.Snapshot()
        if snap and snap.Open then
            local hp = tonumber(snap.BossHealth) or 0
            local maxHp = tonumber(snap.BossMaxHealth) or 0
            Notify("Boss Arena", "OPEN - " .. tostring(math.floor(hp)) .. "/" .. tostring(math.floor(maxHp)) .. " HP", "Success")
        else
            local secs = Boss.SecondsUntilOpen()
            local eta = "unknown"
            if secs then eta = string.format("%d min %d s", math.floor(secs / 60), math.floor(secs % 60)) end
            Notify("Boss Arena", "Closed - next in " .. eta, "Info")
        end
    end)
})

-- SubTab: Claim Rewards
RewardsSub:AddToggle({
    Name = "Auto Claim Away Earnings & Codex", Default = false, Flag = "claim_auto_rewards",
    Callback = function(v) autoClaimRewards = v end
})
RewardsSub:AddButton({
    Name = "Claim Away Earnings & Codex Now", Primary = true,
    Callback = safeCallback(function()
        ClaimAllAvailableRewards()
        Notify("Rewards", "Claimed all ready rewards and earnings", "Success")
    end)
})
end

-- -----------------------------------------------------------------------------
-- TAB 3: COMBAT & DEFENSE
-- -----------------------------------------------------------------------------
do
local BatSub   = CombatTab:AddSubTab("Bat & Slap Aura")
local GuardSub = CombatTab:AddSubTab("Defense & Guards")

-- SubTab: Bat & Slap Aura
BatSub:AddToggle({
    Name = "Bat / Slap Aura", Default = false, Flag = "bat_aura_enabled",
    Callback = safeCallback(function(v)
        batAuraEnabled = v
        Notify("Bat Aura", v and "Enabled" or "Disabled", v and "Success" or "Error")
    end)
})
BatSub:AddSlider({
    Name = "Aura Radius", Min = 5, Max = 50, Default = 20, Suffix = " studs", Flag = "bat_radius",
    Callback = function(v) batAuraRadius = v end
})
BatSub:AddSlider({
    Name = "Swing Delay", Min = 0.05, Max = 1.0, Default = 0.2, Suffix = "s", Flag = "bat_delay",
    Callback = function(v) batAuraDelay = v end
})
BatSub:AddButton({
    Name = "Swing Bat Once (Manual)", Primary = true,
    Callback = safeCallback(function()
        local re = GetNetRemote("RE/BatSwing/Trigger")
        if re then re:FireServer() end
        Notify("Bat", "Triggered bat swing", "Info")
    end)
})

-- SubTab: Defense & Guards
GuardSub:AddToggle({
    Name = "Anti-Trap (Full Immunity / Destroy Hitboxes)", Default = true, Flag = "avoid_traps",
    Callback = safeCallback(function(v)
        avoidTrapsEnabled = v
        if v then pcall(NeutralizeTraps) end
        Notify("Anti-Trap", v and "Immunity Active (Enemy Hitboxes Destroyed)" or "Anti-Trap Disabled", v and "Success" or "Error")
    end)
})

GuardSub:AddToggle({
    Name = "No Knockback / Ragdoll Immunity", Default = true, Flag = "no_knockback",
    Callback = safeCallback(function(v)
        SetNoKnockback(v)
        Notify("Knockback", v and "Ragdoll Immunity Active" or "Knockback Enabled", v and "Success" or "Error")
    end)
})

GuardSub:AddToggle({
    Name = "Anti-Ragdoll (Quick Standup)", Default = true, Flag = "anti_ragdoll",
    Callback = function(v) antiRagdollEnabled = v end
})

track(RunService.Heartbeat:Connect(function()
    if HUB.dead or not antiRagdollEnabled then return end
    local hum = findHum()
    if hum and hum:GetState() == Enum.HumanoidStateType.Physics then
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
    end
end))
end

-- -----------------------------------------------------------------------------
-- TAB 4: PLAYER & MOVEMENT
-- -----------------------------------------------------------------------------
do
local MoveSub     = PlayerTab:AddSubTab("Movement")
local AreaTpSub   = PlayerTab:AddSubTab("Area Travel")
local PlotTpSub   = PlayerTab:AddSubTab("Plot Travel")
local PlayerTpSub = PlayerTab:AddSubTab("Player Travel")
local PerfSub     = PlayerTab:AddSubTab("Visuals & Performance")

-- SubTab: Movement
MoveSub:AddToggle({
    Name = "Enable WalkSpeed", Default = false, Flag = "speed_enabled",
    Callback = safeCallback(function(v)
        walkSpeedEnabled = v
        if not v then
            local hum = findHum()
            if hum then hum.WalkSpeed = 16 end
        end
        Notify("WalkSpeed", v and "Enabled" or "Disabled", v and "Success" or "Error")
    end)
})
MoveSub:AddSlider({
    Name = "WalkSpeed Value", Min = 16, Max = 10000, Default = 24, Suffix = " studs/s", Flag = "speed_val",
    Callback = function(v) ApplyWalkSpeed(v) end
})
MoveSub:AddToggle({
    Name = "Enable JumpPower", Default = false, Flag = "jump_enabled",
    Callback = safeCallback(function(v)
        jumpPowerEnabled = v
        if not v then
            local hum = findHum()
            if hum then hum.JumpPower = 50 end
        end
        Notify("JumpPower", v and "Enabled" or "Disabled", v and "Success" or "Error")
    end)
})
MoveSub:AddSlider({
    Name = "JumpPower Value", Min = 50, Max = 300, Default = 60, Suffix = "", Flag = "jump_val",
    Callback = function(v) ApplyJumpPower(v) end
})
MoveSub:AddToggle({
    Name = "Infinite Jump", Default = false, Flag = "inf_jump",
    Callback = function(v) infiniteJump = v end
})
MoveSub:AddToggle({
    Name = "Smooth Fly (WASD + Space/Shift)", Default = false, Flag = "fly_enabled",
    Callback = safeCallback(function(v)
        if v then startFly() else stopFly() end
        Notify("Fly", v and "Enabled" or "Disabled", v and "Success" or "Error")
    end)
})
MoveSub:AddSlider({
    Name = "Fly Speed", Min = 20, Max = 250, Default = 60, Suffix = " studs/s", Flag = "fly_speed",
    Callback = function(v) flySpeed = v end
})
MoveSub:AddToggle({
    Name = "Anti-AFK (Bypass 20min Kick)", Default = false, Flag = "anti_afk",
    Callback = function(v) SetAntiAFK(v) end
})

-- SubTab: Area Travel
local selectedAreaTp = "Base / Plot"
local areaKeys = {}
for k in pairs(AREA_COORDINATES) do table.insert(areaKeys, k) end
table.sort(areaKeys)

AreaTpSub:AddDropdown({
    Name = "Select Area", Options = areaKeys, Items = areaKeys, Default = "Base / Plot", Flag = "tele_area",
    Callback = function(v) selectedAreaTp = v end
})
AreaTpSub:AddButton({
    Name = "Travel to Selected Area", Primary = true,
    Callback = safeCallback(function()
        local pos = AREA_COORDINATES[selectedAreaTp]
        if selectedAreaTp == "Base / Plot" then
            pos = GetLocalPlotCenter()
        end
        if pos then
            Notify("Travel", "Traveling to " .. selectedAreaTp, "Info")
            TravelRoadPath(pos, glideSpeed or 200)
            Notify("Travel", "Arrived at " .. selectedAreaTp, "Success")
        else
            Notify("Travel", "Area position not found", "Error")
        end
    end)
})

-- SubTab: Plot Travel
local selectedPlotNum = "Plot 1"
local plotOptions = { "Plot 1", "Plot 2", "Plot 3", "Plot 4", "Plot 5", "Plot 6", "Plot 7", "My Plot" }

PlotTpSub:AddDropdown({
    Name = "Select Plot", Options = plotOptions, Items = plotOptions, Default = "My Plot", Flag = "tele_plot",
    Callback = function(v) selectedPlotNum = v end
})
PlotTpSub:AddButton({
    Name = "Travel to Plot", Primary = true,
    Callback = safeCallback(function()
        local slotNum = selectedPlotNum == "My Plot" and GetLocalSlot() or tonumber(selectedPlotNum:match("%d+")) or 1
        local plot = Workspace.Plots:FindFirstChild(tostring(slotNum))
        local targetPos = plot and (plot:FindFirstChild("CenterPoint") and plot.CenterPoint.Position or plot:GetPivot().Position)
        if targetPos then
            TravelRoadPath(targetPos + Vector3.new(0, 2, 0), glideSpeed or 200)
            Notify("Plot", "Arrived at Plot " .. tostring(slotNum), "Success")
        else
            Notify("Plot", "Plot not found", "Error")
        end
    end)
})

-- SubTab: Player Travel
local selectedPlayerName = nil
local function GetPlayerList()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LP then table.insert(names, p.Name) end
    end
    table.sort(names)
    if #names == 0 then names = { "(no other players)" } end
    return names
end

local playerDropdown = PlayerTpSub:AddDropdown({
    Name = "Select Player", Options = GetPlayerList(), Items = GetPlayerList(), Default = nil, Flag = "tele_plr",
    Callback = function(v) selectedPlayerName = v end
})

PlayerTpSub:AddButton({
    Name = "Refresh Player List",
    Callback = function()
        playerDropdown:SetOptions(GetPlayerList())
        Notify("Players", "Refreshed player list", "Info")
    end
})
PlayerTpSub:AddButton({
    Name = "Travel to Player", Primary = true,
    Callback = safeCallback(function()
        if not selectedPlayerName then return end
        local targetPlr = Players:FindFirstChild(selectedPlayerName)
        local tHrp = targetPlr and targetPlr.Character and targetPlr.Character:FindFirstChild("HumanoidRootPart")
        if tHrp then
            TravelRoadPath(tHrp.Position + Vector3.new(0, 2, 0), glideSpeed or 200)
            Notify("Player", "Arrived at " .. selectedPlayerName, "Success")
        else
            Notify("Player", "Player unavailable", "Error")
        end
    end)
})

-- SubTab: Visuals & Performance
PerfSub:AddToggle({
    Name = "Fullbright (Daylight Visuals)", Default = false, Flag = "fullbright",
    Callback = function(v) SetFullbright(v) end
})
PerfSub:AddButton({
    Name = "Delete Own Pet Renders (FPS Boost)", Primary = true,
    Callback = safeCallback(function()
        local count = DeleteOwnPetRenders()
        Notify("Performance", "Removed " .. count .. " rendered pet model(s)", "Success")
    end)
})
end

-- -----------------------------------------------------------------------------
-- TAB 5: SETTINGS & CONFIG
-- -----------------------------------------------------------------------------
do
local ConfigSub = SettingsTab:AddSubTab("Configuration")

if HAS_CONFIG then
    ConfigSub:AddInput({
        Name = "Config Name", Default = CONFIG_NAME, Flag = "cfg_name",
        Callback = function(v) if v and #v > 0 then CONFIG_NAME = v end end
    })
    ConfigSub:AddButton({
        Name = "Save Config", Primary = true,
        Callback = safeCallback(function()
            local ok, err = Library:SaveConfig(CONFIG_NAME)
            Notify("Config", ok and ("Saved config '" .. CONFIG_NAME .. "'") or ("Save failed: " .. tostring(err)), ok and "Success" or "Error")
        end)
    })
    ConfigSub:AddButton({
        Name = "Load Config",
        Callback = safeCallback(function()
            local ok, err = Library:LoadConfig(CONFIG_NAME)
            if ok then
                ResyncAll()
                Notify("Config", "Loaded config '" .. CONFIG_NAME .. "'", "Success")
            else
                Notify("Config", "Load failed: " .. tostring(err), "Error")
            end
        end)
    })
end

ConfigSub:AddKeybind({
    Name = "Toggle UI Keybind", Default = Enum.KeyCode.RightControl, Flag = "ui_toggle_key",
    OnPress = function()
        Window:Toggle()
    end
})

ConfigSub:AddDivider()

ConfigSub:AddButton({
    Name = "Unload QyrexHub",
    Callback = safeCallback(function()
        pcall(function() HUB.Unload() end)
    end)
})

    ConfigSub:AddParagraph({
        Title = "QyrexHub | Steal an Egg",
        Content = "Version 4.2.2 (Production)\nEquipped with UGI / Client AC Neutralizer, BAC Telemetry Spoofer, Evidence Scrubber, Strict Rarity Filtering, clean open walkway travel without wall clipping, automatic return to trigger position, and auto egg placement in pen.\nAutomated egg stealing, hatching, homestead base upgrades, treadmill speed training, rewards collector, bat aura, ESP tracker."
    })
end

-- ==============================================================================
-- HUB CLEANUP & UNLOAD HANDLER
-- ==============================================================================
HUB.Unload = function()
    HUB.dead = true

    for _, c in ipairs(HUB.conns) do pcall(function() c:Disconnect() end) end
    HUB.conns = {}

    for _, d in ipairs(HUB.drawings) do pcall(function() d:Remove() end) end
    HUB.drawings = {}

    for _, h in ipairs(HUB.highlights) do pcall(function() h:Destroy() end) end
    HUB.highlights = {}

    stopFly()
    SetFullbright(false)

    local hum = findHum()
    if hum then
        hum.PlatformStand = false
        hum.WalkSpeed = 16
        hum.JumpPower = 50
    end

    pcall(function() Window:Destroy() end)
    _G.QyrexStealAnEgg = nil
end

Notify("QyrexHub", "Steal an Egg script loaded successfully!", "Success", 3.5)

