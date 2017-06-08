globlaAccount = "kuksiubwvunw@outlook.com";
globlaPassword = "noxDJx44";


--local tsld = loadTSLibrary("aso.tsl") --库加载
--if tsld.status == 0 then --验证判断
--	dialog("插件加载异常,退出脚本", 0)

--	lua_exit();
--	return
--end
--require("ascmd") --需要加载

--如果普通版tsp可以加上该段代码
local tsld = loadTSLibrary("pretender.tsl") --库加载
if tsld.status == 0 then --验证判断
	dialog("插件加载异常", 0)
	return
end
require("TBackups") --需要加载

require "TSLib";



--字符串分割函数
--传入字符串和分隔符，返回分割后的table
function string.split(str, delimiter)
	if str==nil or str=='' or delimiter==nil then
		return nil
	end

	local result = {}
	for match in (str..delimiter):gmatch("(.-)"..delimiter) do
		table.insert(result, match)
	end
	return result
end

function GetDeviceFuck()
	local width, height = getScreenSize();
	if width == 640 and height == 1136 then         --iPhone 5, 5S, iPod touch 5
		return 5;
	elseif width == 640 and height == 960 then      --iPhone 4,4S, iPod touch 4
		return 4;
	else
		return 0;
	end
end

--返回 true/false 账号 密码
function getAccountInfo(url)

	local sz = require("sz")
	local http = require("szocket.http")
	local res, code = http.request(url);

	if code == 200 then
		local tableTemp = string.split(res,",");

		toast(res);
--		toast(tableTemp[13]);
		if #tableTemp > 1 then
			return true,tableTemp[1],tableTemp[2];
		else 
			return false;
		end
	else
		return false;
	end
end

function  ReportiCloudSuccess()
	local sz = require("sz")
	local http = require("szocket.http")
	local res, code = http.request("http://ios.pettostudio.net/AccountInfo.aspx?action=updateaccountstate&state=icloud&account=" .. globlaAccount);

	return code == 200;
end

function  ReportiCloudMayDie()
	local sz = require("sz")
	local http = require("szocket.http")
	local res, code = http.request("http://ios.pettostudio.net/AccountInfo.aspx?action=updateaccountstate&state=maydie&account=" .. globlaAccount);

	return code == 200;
end

function NewDevice()
	fakePerApp({"com.apple.Preferences","com.apple.AppStore"});
	return  appDel({},{CarrierType="3G"});
end

function Click(x,y)
	touchDown(1, x, y)
	mSleep(math.random(20,80))
	touchUp(1, x, y)
end


function iCloudReg(timeout)

	local time1 = os.time();
	local isZhuXiaoed = false;
	while true do

		if deviceIsLock() ~= 0 then
			unlockDevice();
			mSleep(3000);
		end

		if isFrontApp("com.apple.Preferences")~= 1 then
			openURL("prefs:root=CASTLE");
			mSleep(1000);
		end


		local x, y = findImageInRegionFuzzy("exampleicoud注册icoude用.png",90, 160, 220, 520, 270,0);
		if x ~= -1 and y ~= -1 then        
			touchDown(250,240);
			mSleep(30);
			touchUp(250,240);

			mSleep(1000);

			inputText(globlaAccount);
			mSleep(1500);

			touchDown(330,330);
			mSleep(30);
			touchUp(330,330);

			mSleep(1000);

			inputText(globlaPassword);
			mSleep(800);

--			keyDown("ReturnOrEnter")
--			mSleep(30);
--			keyUp("ReturnOrEnter")

			Click(230,470);
		end	


		local x, y = findImageInRegionFuzzy("需要激活_注册IC_4.png",90, 20, 355, 235, 415,0);
		if x ~= -1 and y ~= -1 then     
			unlockDevice();
		end

--		local x, y = findImageInRegionFuzzy("登录_注册IC_4.png",90, 25, 425, 110, 510,0);
--		if x ~= -1 and y ~= -1 then  
--			Click(230,470);			
--		end	

		local x, y = findImageInRegionFuzzy("未知设备_注册IC_4.png",90, 190, 135, 445, 215,0);
		if x ~= -1 and y ~= -1 then     
			return 3;
		end

		local x, y = findImageInRegionFuzzy("激活失败_注册IC_4.png",90, 190, 135, 450, 215,0);
		if x ~= -1 and y ~= -1 then     
			return 3;
		end

		local x, y = findImageInRegionFuzzy("无法登陆_注册IC.png",90, 240, 380, 400, 425,0);
		if x ~= -1 and y ~= -1 then     
			return 1;
		end

		local x, y = findImageInRegionFuzzy("同意_注册IC.png",90, 550, 890, 630, 940,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(590,910);
			mSleep(30);
			touchUp(590,910);
		end

		local x, y = findImageInRegionFuzzy("条款与条件_注册IC.png",90, 225, 390, 410, 440,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(440,555);
			mSleep(30);
			touchUp(440,555);
		end

		local x, y = findImageInRegionFuzzy("不合并_注册IC.png",90, 245, 875, 390, 930,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(320,900);
			mSleep(30);
			touchUp(320,900);
		end

		local x, y = findImageInRegionFuzzy("不允许_注册IC.png",90, 120, 575, 240, 620,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(180,590);
			mSleep(30);
			touchUp(180,590);
		end

		local x, y = findImageInRegionFuzzy("设置家人共享_注册IC.png",90, 110, 450, 370, 500,0);
		if x ~= -1 and y ~= -1 then     
			RollToEnd();
		end

		local x, y = findImageInRegionFuzzy("家人共享信息不可用_注册IC.png",90, 20, 450, 355, 500,0);
		if x ~= -1 and y ~= -1 then     
			RollToEnd();
		end

		local x, y = findImageInRegionFuzzy("注销_注册IC.png",90, 270, 820, 365, 865,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(320,840);
			mSleep(30);
			touchUp(320,840);

			mSleep(1500);

			touchDown(320,790);
			mSleep(30);
			touchUp(320,790);

			isZhuXiaoed = true;
		end

		local x, y = findImageInRegionFuzzy("注销2_注册IC_4.png",90, 270, 770, 380, 830,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(300,800);
			mSleep(30);
			touchUp(300,800);
		end

		local x, y = findImageInRegionFuzzy("允许icloud_注册IC_4.png",90, 90, 350, 280, 4000,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(180,600);
			mSleep(30);
			touchUp(180,600);
		end

		local x, y = findImageInRegionFuzzy("从iphone删除_注册IC.png",90, 170, 770, 470, 825,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(300,800);
			mSleep(30);
			touchUp(300,800);
		end


		local x, y = findImageInRegionFuzzy("忽略_注册IC_4.png",90, 140, 550, 230, 600,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(180,570);
			mSleep(30);
			touchUp(180,570);
		end	

		local x, y = findImageInRegionFuzzy("照片流_注册IC_4.png",90, 260, 380, 380, 425,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(180,570);
			mSleep(30);
			touchUp(180,570);
		end

		local x, y = findImageInRegionFuzzy("不支持此AppleID_注册IC_4.png",90, 160, 375, 470, 425,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(460,570);
			mSleep(30);
			touchUp(460,570);
		end


		local x, y = findImageInRegionFuzzy("appleid密码不正确_注册IC_4.png",90, 150, 400, 485, 445,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(450,560);
			mSleep(30);
			touchUp(450,560);
		end

		local x, y = findImageInRegionFuzzy("验证失败_注册IC_4.png",90, 240, 390, 395, 440,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(320,550);
			mSleep(30);
			touchUp(320,550);

			mSleep(2000);

			touchDown(320,480);
			mSleep(30);
			touchUp(320,480);
		end	

		local x, y = findImageInRegionFuzzy("尝试存储_注册IC_4.png",90, 80, 410, 235, 460,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(320,550);
			mSleep(30);
			touchUp(320,550);

			mSleep(2000);

			touchDown(320,480);
			mSleep(30);
			touchUp(320,480);
		end	

		local x, y = findImageInRegionFuzzy("iPhone尚未激活_注册IC_4.png",90, 180, 390, 455, 435,0);
		if x ~= -1 and y ~= -1 then  
			toast("尚未激活",1);
			Click(180,560);			
		end	

		local x, y = findImageInRegionFuzzy("忽略_注册IC_4.png",90, 135, 540, 225, 590,0);
		if x ~= -1 and y ~= -1 then  
			toast("尚未激活",1);
			Click(180,560);			
		end

		local x, y = findImageInRegionFuzzy("再试一次1_注册IC_4.png",90, 240, 355, 400, 400,0);
		if x ~= -1 and y ~= -1 then  
			toast("需要激活",1);
			Click(320,380);			
		end	


		local x, y = findImageInRegionFuzzy("再试一次2_注册IC_4.png",90, 245, 850, 400, 900,0);
		if x ~= -1 and y ~= -1 then  
			toast("需要激活",1);
			Click(320,875);			
		end	

		local x, y = findImageInRegionFuzzy("需要激活(单个)_注册IC_4.png",90, 240, 410, 400, 465,0);
		if x ~= -1 and y ~= -1 then  
			toast("需要激活",1);
			Click(320,540);			
		end	

		local x, y = findImageInRegionFuzzy("继续_注册IC_4.png",90, 265, 440, 380, 505,0);
		if x ~= -1 and y ~= -1 then     
			Click(320,470);			
		end	

		local x, y = findImageInRegionFuzzy("下一步_注册IC_4.png",90, 515, 60, 630, 110,0);
		if x ~= -1 and y ~= -1 then  
			Click(575,80);			
		end	

		local x, y = findImageInRegionFuzzy("不支持的设备_注册IC_4.png",90, 210, 375, 430, 420,0);
		if x ~= -1 and y ~= -1 then  
			Click(450,580);	
			mSleep(3000);
			Click(260,500);
		end	

		local x, y = findImageInRegionFuzzy("登录icloud_注册IC_4.png",90, 205, 105, 430, 180,0);
		if x ~= -1 and y ~= -1 then     
			inputText(globlaPassword);
			mSleep(300);
			inputText("\n");
		end


		local x, y = findImageInRegionFuzzy("需要密码_注册IC_4.png",90, 240, 80, 395, 165,0);
		if x ~= -1 and y ~= -1 then     
			inputText(globlaPassword);
			mSleep(300);
			inputText("\n");
		end

		local x, y = findImageInRegionFuzzy("登录icloud2_注册IC_4.png",90, 200, 105, 420, 180,0);
		if x ~= -1 and y ~= -1 then     
			inputText(globlaPassword);
			mSleep(300);
			inputText("\n");
		end


		local x, y = findImageInRegionFuzzy("无法连接服务器_注册IC_4.png",90, 170, 420, 450, 480,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(320,530);
			mSleep(30);
			touchUp(320,530);

			mSleep(2000);

			touchDown(310,480);
			mSleep(30);
			touchUp(310,480);
		end	


		if isZhuXiaoed then
			local x, y = findImageInRegionFuzzy("设置_注册IC.png",90, 275, 60, 370, 110,0);
			if x ~= -1 and y ~= -1 then     
				toast("完成...",1)
				return 0;
			end
		end	

		if isZhuXiaoed then
			local x, y = findImageInRegionFuzzy("通知_注册IC_4.png",90, 275, 60, 370, 110,0);
			if x ~= -1 and y ~= -1 then     
				toast("完成...",1)
				return 0;
			end
		end

		if isZhuXiaoed then
			local x, y = findImageInRegionFuzzy("控制中心_注册IC_4.png",90, 240, 60, 395, 105,0);
			if x ~= -1 and y ~= -1 then     
				toast("完成...",1)
				return 0;
			end
		end


		mSleep(1000);
		local time2 = os.time();

		if (time2 - time1) >= timeout then
			return 2;
		end
	end
end

function iCloudReg_5(timeout)

	local time1 = os.time();
	local isZhuXiaoed = false;
	while true do

		local x, y = findImageInRegionFuzzy("exampleicoud注册icoude用.png",90, 160, 220, 520, 270,0);
		if x ~= -1 and y ~= -1 then        
			touchDown(250,240);
			mSleep(30);
			touchUp(250,240);

			mSleep(1000);

			inputText(globlaAccount);
			mSleep(1500);

			touchDown(330,330);
			mSleep(30);
			touchUp(330,330);

			mSleep(1000);

			inputText(globlaPassword);
			mSleep(300);


			keyDown("ReturnOrEnter")
			mSleep(30);
			keyUp("ReturnOrEnter")
		end	

		local x, y = findImageInRegionFuzzy("无法登陆_注册IC.png",90, 240, 470, 400, 510,0);
		if x ~= -1 and y ~= -1 then     

			return 1;
		end

		local x, y = findImageInRegionFuzzy("同意_注册IC_5.png",90, 550, 1070, 630, 1110,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(590,1090);
			mSleep(30);
			touchUp(590,1090);
		end

		local x, y = findImageInRegionFuzzy("条款与条件_注册IC.png",90, 225, 480, 410, 525,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(440,645);
			mSleep(30);
			touchUp(440,645);
		end

		local x, y = findImageInRegionFuzzy("不合并_注册IC.png",90, 245, 1050, 390, 1105,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(320,1080);
			mSleep(30);
			touchUp(320,1080);
		end

		local x, y = findImageInRegionFuzzy("不允许_注册IC.png",90, 120, 660, 240, 710,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(180,680);
			mSleep(30);
			touchUp(180,680);
		end

		local x, y = findImageInRegionFuzzy("设置家人共享_注册IC.png",90, 110, 450, 370, 500,0);
		if x ~= -1 and y ~= -1 then     
			RollToEnd();
		end	

		local x, y = findImageInRegionFuzzy("家人共享信息不可用_注册IC_5.png",90,20, 450, 355, 500,0);
		if x ~= -1 and y ~= -1 then     
			RollToEnd();
		end

		local x, y = findImageInRegionFuzzy("注销_注册IC.png",90, 270, 990, 365, 1045,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(320,1010);
			mSleep(30);
			touchUp(320,1010);

			mSleep(1500);

			touchDown(320,970);
			mSleep(30);
			touchUp(320,970);

			isZhuXiaoed = true;
		end

		local x, y = findImageInRegionFuzzy("从iphone删除_注册IC_5.png",90, 170, 950, 470, 1000,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(300,980);
			mSleep(30);
			touchUp(300,980);
		end

		local x, y = findImageInRegionFuzzy("忽略_注册IC_5.png",90, 140, 640, 225, 690,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(180,660);
			mSleep(30);
			touchUp(180,660);
		end

		local x, y = findImageInRegionFuzzy("照片流_注册IC_5.png",90, 260, 465, 380, 515,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(180,660);
			mSleep(30);
			touchUp(180,660);
		end	

		local x, y = findImageInRegionFuzzy("不支持此appleid_注册IC_5.png",90, 165, 465, 465, 510,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(460,660);
			mSleep(30);
			touchUp(460,660);
		end

		local x, y = findImageInRegionFuzzy("appleid密码不正确_注册IC_5.png",90, 145, 480, 490, 530,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(460,640);
			mSleep(30);
			touchUp(460,640);
		end

		local x, y = findImageInRegionFuzzy("用户名或密码不正确_注册IC_5.png",90, 180, 525, 445, 570,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(315,645);
			mSleep(30);
			touchUp(315,645);

			mSleep(1000);
			return 3;
		end

		local x, y = findImageInRegionFuzzy("无法连接服务器_注册IC_5.png",90, 175, 505, 430, 555,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(320,625);
			mSleep(30);
			touchUp(320,625);

			mSleep(2000);

			touchDown(310,480);
			mSleep(30);
			touchUp(310,480);
		end	

		local x, y = findImageInRegionFuzzy("尝试存储_注册IC_5.png",90, 80, 500, 230, 550,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(320,625);
			mSleep(30);
			touchUp(320,625);

			mSleep(2000);

			touchDown(310,480);
			mSleep(30);
			touchUp(310,480);
		end

		local x, y = findImageInRegionFuzzy("验证失败_注册IC_5.png",90, 240, 480, 400, 530,0);
		if x ~= -1 and y ~= -1 then     
			touchDown(320,640);
			mSleep(30);
			touchUp(320,640);

			mSleep(2000);

			touchDown(320,480);
			mSleep(30);
			touchUp(320,480);
		end	

		local x, y = findImageInRegionFuzzy("登录icloud_注册IC_5.png",90, 210, 180, 430, 270,0);
		if x ~= -1 and y ~= -1 then     
			inputText(globlaPassword);
			mSleep(300);
			inputText("\n");
		end


		if isZhuXiaoed then
			local x, y = findImageInRegionFuzzy("设置_注册IC.png",90, 275, 60, 370, 110,0);
			if x ~= -1 and y ~= -1 then     
				toast("完成...",1)
				return 0;
			end
		end

		if isZhuXiaoed then
			local x, y = findImageInRegionFuzzy("勿扰模式_注册IC_5.png",90, 250, 55, 400, 105,0);
			if x ~= -1 and y ~= -1 then     
				toast("完成...",1)
				return 0;
			end
		end

		if isZhuXiaoed then
			local x, y = findImageInRegionFuzzy("通知_注册IC_5.png",90,275, 60, 370, 110,0);
			if x ~= -1 and y ~= -1 then     
				toast("完成...",1)
				return 0;
			end
		end

		if isZhuXiaoed then
			local x, y = findImageInRegionFuzzy("控制中心_注册IC_5.png",90, 250, 55, 400, 105,0);
			if x ~= -1 and y ~= -1 then     
				toast("完成...",1)
				return 0;
			end
		end

		mSleep(1000);
		local time2 = os.time();

		if (time2 - time1) >= timeout then
			return 2;
		end
	end
end



function RollToEnd()
	touchDown(150, 600);    --在坐标 (150, 550)按下
	mSleep(10);
	touchMove(150, 550);    --移动到坐标 (150, 600)，注意一次滑动的坐标间隔不要太大，不宜超过50像素
	mSleep(10);
	touchUp(150, 550);  

	mSleep(500);

	touchDown(150, 600);    --在坐标 (150, 550)按下
	mSleep(10);
	touchMove(150, 550);    --移动到坐标 (150, 600)，注意一次滑动的坐标间隔不要太大，不宜超过50像素
	mSleep(10);
	touchUp(150, 550);  

	mSleep(500);

	touchDown(150, 600);    --在坐标 (150, 550)按下
	mSleep(10);
	touchMove(150, 550);    --移动到坐标 (150, 600)，注意一次滑动的坐标间隔不要太大，不宜超过50像素
	mSleep(10);
	touchUp(150, 550); 
end

function  SaveAccounts()
	writeFileString("/var/mobile/Media/TouchSprite/config/AccountInfo.txt",globlaAccount .. "," .. globlaPassword);  
end

function DeleteAccountsFile()
	if isFileExist("/var/mobile/Media/TouchSprite/config/AccountInfo.txt") then
		delFile("/var/mobile/Media/TouchSprite/config/AccountInfo.txt");
	end
end

function  LoadAccounts()
	if isFileExist("/var/mobile/Media/TouchSprite/config/AccountInfo.txt") then

		local sz = require("sz");
		res = readFileString("/var/mobile/Media/TouchSprite/config/AccountInfo.txt");  
		local tableTemp = string.split(res,",");

		toast(res);
		if #tableTemp > 1 then
			globlaAccount = tableTemp[1]:trim();
			globlaPassword = tableTemp[2]:trim();

			return true;
		else 
			return false;
		end
	else
		return false;
	end
end

function CleanAccounts()
	os.execute("cp -rf /User/Library/Accounts/new/*.* /User/Library/Accounts/");
	os.execute("chown -R mobile:mobile /User/Library/Accounts/*.*");
end

function WriteTimeTagiCloud()
	local time1 = os.date("%Y-%m-%d %H:%M:%S");

	local sz = require("sz");
	writeFileString("/var/mobile/Media/TouchSprite/config/icloudlaunchtime.txt",tostring(time1):trim());	
end

--clearSafari();
----serialNumber();
--clearIDFAV();
--clearAllKeyChains();
--clearCookies();

--appDel();
--serialNumber();

--mSleep(200000);
--local thread = require('thread')
--local thread_id1 = thread.create(function()
--		return NewDevice();
--	end);

--local ok,bool,err = thread.wait(thread_id1)
--if err then
--	toast("一键新机傻逼结束".. err);
--	lua_restart();
--else
--	if ok then
--		toast("一键新机正常结束,ret is "..tostring(bool));
--	else
--		toast("一键新机线程傻逼");
--		lua_restart();
--	end
--end
WriteTimeTagiCloud();

closeApp("com.apple.Preferences");
mSleep(1000);
openURL("prefs:root=CASTLE");

mSleep(2000);

resultTemp = LoadAccounts();
if not resultTemp  then
	resultTemp,globlaAccount,globlaPassword = getAccountInfo("http://ios.pettostudio.net/AccountInfo.aspx?action=getappleaccountfullinfobystateforicloud&state=success");
end

if resultTemp then
	SaveAccounts();

	local deviceFuck = GetDeviceFuck();
	local result = false;

--	toast("机型：" .. deviceFuck,1)
	if deviceFuck == 4 then
		result = iCloudReg(300);
	else
		result = iCloudReg_5(300);
	end

	if result == 0 then
		if ReportiCloudSuccess() then
			toast("提交成功",1);
		end

		DeleteAccountsFile();
		lua_restart();
	elseif result == 1 then
		toast("到达最大限制",1);

		mSleep(1000);

		local bool,err = appDel();
		if err then
			toast("新机失败...",1);
			lua_restart();
		else
			CleanAccounts();
			mSleep(1000);
			serialNumber();
		end

	elseif result == 2 then
		toast("超时",1);

		mSleep(1000);		
		lua_restart();	

	elseif result == 3 then
		toast("其他异常",1);		
		mSleep(1000);
		os.execute("reboot");	
	else
		if ReportiCloudMayDie() then
			tostring("提交完成",1);
		end
		lua_restart();
	end

else
	lua_restart();
end



