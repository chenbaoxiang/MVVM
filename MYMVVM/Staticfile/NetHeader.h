
#ifndef NetManager_h
#define NetManager_h
//#define HOST_URL            @"http://192.168.3.136:9501/"        // 强哥
#define HOST_URL            @"http://47.94.212.177:9501/"       // 测试

#define kImageURL            @"http://xuanyi.iot12369.com:8989"     // 图片url

// ------------------ 错误码 --------------------
#define kError401          401   // token 失效
#define kError407          407   // 微信登录未绑定手机号
#define kSuccessCode       200   // 成功


// ------------------ 登录 --------------------
// 登录
#define kLoginURL          @"Login/login"
#define kSendCode          @"Login/Login/sendSmsVerificationCode"

// ------------------ 首页 --------------------
// 服务列表
#define kServerList(type,page,limit)              [NSString stringWithFormat:@"Client/Server/getList?type=%@&page=%d&limit=%d",(type),(page),(limit)]
// 提交报修或者投诉
#define kServerAdd               @"Client/Server/add"


// ------------------ 我的 --------------------
// 根据区/县获取小区名称
#define kGetCommunityByArea(area)    [NSString stringWithFormat:@"Client/Community/getCommunityByArea?area=%@",(area)]
// 根据小区获取门牌号
#define kGetUnitByCommunityId(community_id)    [NSString stringWithFormat:@"Client/Community/getUnitByCommunityId?community_id=%@",(community_id)]
// 添加地址
#define kAddAddress                 @"Client/User/addAddress"



#endif
