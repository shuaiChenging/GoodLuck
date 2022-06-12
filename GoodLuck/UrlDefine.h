//
//  UrlDefine.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/3.
//

#ifndef UrlDefine_h
#define UrlDefine_h

/// 发送验证码
#define smscode @"/customer/sms/smscode"

/// 验证码登录
#define smslogin @"/customer/login/sms"

/// 手机密码登录
#define phonelogin @"/customer/login/phone"

/// 注册接口
#define registerurl @"/customer/tenant/register"

/// 首页-工地管理员
#define indexadmin @"/customer/index/admin"

/// 首页-工地老板
#define indexboss @"/customer/index/boss"

/// 工地详情
#define projectdetails @"/customer/project/details"

/// 查询土方单位列表
#define companylist @"/customer/company/list"

/// 人员管理-老板列表
#define listboss @"/customer/project/list/boss"

/// 人员管理-管理员列表
#define listAdmin @"/customer/project/list/admin"

/// 人员管理-增加管理员
#define projectaddadmin @"/customer/project/add/admin"

/// 查询车队
#define fleetquery @"/customer/fleet/query"

/// 创建车队
#define fleetsave @"/customer/fleet/save"

/// 删除车队
#define fleetdelete @"/customer/fleet/delete"

/// 查询渣土厂
#define ztcquery @"/customer/ztc/query"

/// 删除渣土厂
#define ztcdelete @"/customer/ztc/delete"

/// 创建渣土厂
#define ztcsave @"/customer/ztc/save"

/// 查询土类型
#define tlxquery @"/customer/tlx/query"

/// 删除土类型
#define tlxdelete @"/customer/tlx/delete"

/// 保存土类型
#define tlxsave @"/customer/tlx/save"

/// 申请工地
#define projectapply @"/customer/project/apply"

#endif /* UrlDefine_h */
