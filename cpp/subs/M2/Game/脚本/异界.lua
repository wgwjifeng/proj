加载配置脚本("通用配置")
自动换装(假)
设置自动补血补蓝(0.7, 0.3)


设置地图过滤(过滤类型.物品等级,5)
设置地图过滤(过滤类型.黑名单,{"禁灵之狱"})
设置地图过滤(过滤类型.物品属性,{{"怪物反射",10}})
设置地图过滤(过滤类型.颜色,物品颜色.蓝色)

定义函数 处理事件(事件名)
    如果 事件名 == "死亡后变更地图事件" 那么
        
    否则如果 事件名 == "背包已满事件" 那么
    结束
    --返回 真 表示会再次运行 执行函数
    返回 真
结束

定义函数 杀怪执行函数()
    返回 全图杀怪(假)
结束

局部变量 刷完当前地图 = 假
定义函数 循环一次异界地图()
    局部变量 传送门 = 寻找异界传送门()
    如果 传送门 == 空 或 刷完当前地图 == 真 那么
        如果 根据类型获得物品数量(物品类型.异界地图) <= 0 那么
            LogE("自动异界之没有地图了")
            返回 假
        结束
        如果 开启地图装置() ~= 真 那么
            LogE("开启异界装置失败")
            返回 假
        结束
    结束 
    传送门 = 寻找异界传送门()
    如果 传送门 == 空 那么
        LogE("开启异界装置不正常")
        返回 假
    结束
    如果 打开目标(传送门) ~= 真 那么
        返回 假
    结束 
    如果 执行并等待事件(杀怪执行函数, 处理事件, { "死亡后变更地图事件", "背包已满事件" }) == 真 那么
        刷完当前地图 = 真
        杀到打开目标("永恒的实验室")
        LogE("地图刷完");
    结束
	返回 真 
结束

定义函数 处理游戏内场景()
    循环 真 执行
        如果 当前地图名字() == "永恒的实验室" 那么
            循环 真 执行
                如果 循环一次异界地图() ~= 真 那么
                    中断
                结束
            结束
        结束
        如果 根据类型获得物品数量(物品类型.异界地图) <= 0 那么
            如果 杀到指定地图("萨恩营地",3,假) ~= 真 那么
                Log("自动异界不能移动到城镇")
                中断
            结束
            如果 仓库提取异界地图(10) == 0 那么
                LogE("仓库和身上都没有异界地图了吧")
                中断
            结束
        结束
        如果 杀到指定地图("永恒的实验室",3) ~= 真 那么
            中断
        结束
        LogE("退出来了！ ")
    结束
    返回 假
结束

场景循环处理({
    通用_选择角色场景,
    游戏内场景(处理游戏内场景),
}):处理()
