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

/// 获取该工地老板的工地列表
#define bosslist @"/customer/project/phone/boss/list"

/// 根据手机号检索工地老板
#define listbyphone @"/customer/tenant/listByPhone"

/// 申请工地
#define projectapply @"/customer/project/apply"

/// 增加工地
#define projectsave @"/customer/project/save"

/// 当前上班管理员
#define onworklist @"/customer/work/onWorkList"

/// 人员管理-删除管理员
#define deleteadmin @"/customer/project/delete/admin"

/// 工地老板-角色审批-申请列表
#define listapply @"/customer/project/list/apply"

/// 工地管理员-角色审批-申请列表
#define listadminapply @"/customer/project/list/admin/apply"

/// 工单数据统计
#define orderstatistics @"/customer/worker/order/statistics"

/// 工地数据统计-车辆
#define carstatistics @"/customer/worker/order/v2/ios/car/statistics"

/// 工地数据统计-卡牌
#define cardstatistics @"/customer/worker/order/v2/ios/card/statistics"

/// 功底数据统计-土类型
#define earthstatistics @"/customer/worker/order/ios/earth/statistics"

/// 工地数据统计-车队
#define fleetstatistics @"/customer/worker/order/ios/fleet/statistics"

/// 工地数据统计-自倒/渣土场
#define zdztcstatistics @"/customer/worker/order/ios/zd_ztc/statistics"

/// 工地数据统计-放行记录
#define accessstatistice @"/customer/worker/order/access/statistics"

/// 获取当前用户信息
#define userinfo @"/customer/user/info"

/// 获取所有的车斗信息
#define bodysizeall @"/customer/bodySize/all"

/// 上传车头照片
#define headerupload @"/customer/worker/order/car/header/upload"

/// 上传车斗照片
#define bodyupload @"/customer/worker/order/car/body/upload"

/// 生成一个工单
#define ordersave @"/customer/worker/order/save"

#define orderedit @"/customer/worker/order/edit"

/// 工单审批列表
#define listapplydelete @"/customer/project/list/applyDelete"

/// 查询工单
#define workerorderquery @"/customer/worker/order/query"

/// 下班
#define workoff @"/customer/work/off"

/// 上班
#define workon @"/customer/work/on"

/// 修改手机号
#define changephone @"/customer/tenant/changePhone"

/// 修改用户名
#define changename @"/customer/tenant/changeName"

/// 修改密码
#define resetpassword @"/customer/tenant/resetPassword"

/// 登出
#define logouturl @"/customer/logout"

/// 编辑工地
#define projectedit @"/customer/project/edit"

/// 审核
#define applystatus @"/customer/project/apply/status"

/// 工单审批
#define applydeletestatus @"/customer/project/applyDelete/status"

/// 项目统计详情
#define reportprojectstatistics @"/customer/mobile/report/project/statistics"

/// 删除一个工单
#define orderdelete @"/customer/worker/order/delete"

/// 工单详情
#define orderdetailsbyorderno @"/customer/worker/order/detailsByOrderNo"

/// 价格列表
#define pricequery @"/customer/ztc/price/query"

/// 车辆进出场状态
#define platenumberstatus @"/customer/worker/order/plateNumber/status"

/// 入场放行
#define workerorderinaccess @"/customer/worker/order/inAccess"

/// 出场放行
#define workorderoutaccess @"/customer/worker/order/outAccess"

/// 读取租户配置信息
#define configdetails @"/customer/config/details"

/// 修改配置
#define configedit @"/customer/config/edit"

/// 新车牌记住上一车配置
#define rememberlastconfig @"/customer/worker/order/remember/last/config"

/// 批量添加价格
#define pricesavebatch @"/customer/ztc/price/saveBatch"

/// 获取价格
#define pricegetprice @"/customer/ztc/price/getPrice"

/// 获取该车牌号，最近一次入场工单信息
#define detailsbyplatenumber @"/customer/worker/order/detailsByPlateNumber"

/// 删除当前账号
#define deleteaccount @"/customer/delete"

/// 放行规则设置信息
#define pcdetails @"/customer/config/pc/details"

/// 统计每天工单量
#define everydaystatistice @"/customer/worker/order/everyday/statistics"

/// 工单和角色审批个数
#define applycount @"/customer/project/apply/count"

/// 人员管理-管理员列表
#define listadmin @"/customer/project/list/admin"

#endif /* UrlDefine_h */
