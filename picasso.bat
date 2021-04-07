@echo off
cd %cd%/adb
adb.exe wait-for-device >NUL 2>NUL
adb.exe devices -l 
echo " Clean your phone " ;
adb.exe shell pm uninstall -k --user 0 com.zhihu.android;
adb.exe shell pm uninstall -k --user 0 com.xiaomi.jr ;
adb.exe shell pm uninstall -k --user 0 com.ss.android.article.news;
adb.exe shell pm uninstall -k --user 0 com.taobao.taobao;
adb.exe shell pm uninstall -k --user 0 com.duokan.free;
adb.exe shell pm uninstall -k --user 0 com.dragon.read
adb.exe shell pm uninstall -k --user 0 com.eg.android.AlipayGphone
adb.exe shell pm uninstall -k --user 0 com.xiaomi.youpin
adb.exe shell pm uninstall -k --user 0 com.xiaomi.vipaccount
adb.exe shell pm uninstall -k --user 0 com.miui.miservice
adb.exe shell pm uninstall -k --user 0 com.xiaomi.smarthome
adb.exe shell pm uninstall -k --user 0 com.mipay.wallet
adb.exe shell pm uninstall -k --user 0 com.xiaomi.gamecenter
adb.exe shell pm uninstall -k --user 0 com.xiaomi.shop
adb.exe shell pm uninstall -k --user 0 com.miui.voiceassist
adb.exe shell pm uninstall -k --user 0 com.android.email
adb.exe shell pm uninstall -k --user 0 com.miui.huanji
adb.exe shell pm uninstall -k --user 0 com.miui.virtualsim
adb.exe shell pm uninstall -k --user 0 com.mi.health
adb.exe shell pm uninstall -k --user 0 com.android.browser
adb.exe shell pm uninstall -k --user 0 com.iflytek.inputmethod.miui
adb.exe shell pm uninstall -k --user 0 com.baidu.input_mi
echo "Fuck xiaomi's trash app "
echo "If you want add more app to delete"
pause
start https://docs.google.com/spreadsheets/d/1uW2hyxLQRuGcxVtWkJ03GBfJaMLoJngA_iV328xk940/edit?usp=sharing
cd ..
pause