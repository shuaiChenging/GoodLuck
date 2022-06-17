//
//  EnumDefine.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/5/31.
//

#ifndef EnumDefine_h
#define EnumDefine_h

typedef enum {
    UserInput, /// 用户名
    PasswordInput, /// 密码
    PhoneInput, /// 手机号
    CodeInput, /// 手机验证码
    SetPasswordInput, /// 设置密码
    ReSetPasswordInput /// 确认设置密码
} TextFeildType;

typedef enum {
    Default, /// 默认输入
    Seleted, /// 选择
    DSwitch  /// 开关
} WorkConfigType;


typedef enum {
    ZtcManage, /// 渣土场管理
    TlxManage, /// 土类型管理
    PriceManage, /// 价格管理
    CarTeamManage, /// 车队管理
    TravelModel, /// 旅行模式
    WorkOrderDelete, /// 工单删除
    WorkOrderChange, /// 工单修改
    CarCardSetting, /// 新车牌记住上一车配置
    CarCardAlert, /// 车牌识别辅助提醒
    PrintNumber, /// 默认打印联数
    WorkInfoEdit, /// 工地信息编辑
    WorkManage /// 工地人员管理
    
} WorkSettingType;

typedef enum {
    Car, /// 车辆
    Soil, /// 土
    Card,  /// 卡牌
    ZTC, /// 渣土场
    Fall, /// 自倒
    CarTeam, /// 车队
    Backhoe /// 挖机
} WorkDataType;

#endif /* EnumDefine_h */
