const baseUrl = "https://wghtstudio.cn/app";
const String login = 'login';
const String register = 'register';
const String code = 'code';
const String findPwd = 'findPwd';
const String user = 'user';
const String follow = 'follow';
const String collect = 'collect';
const String like = 'like';
const String color = 'color';
const String notice = 'notice';
const String homeRecommend = 'homeRecommend';
const String homeFollow = 'homeFollow';
const String homeClass = 'homeClass';
const String myCollect = 'myCollect';
const String logout = 'logout';
const String setAvatar = 'setAvatar';

const servicePath = {
//登录
  login: '/start/login',
//注册
  register: '/start/register',
//验证码
  code: '/start/code',
//用户信息 get post
  user: '/user/info',
//是否关注
  follow: '/user/follow',
//是否收藏
  collect: '/user/collect',
//是否点赞
  like: '/user/like',
//请求颜色
  color: '/user/color',
//通知
  notice: '/notice',
//推荐消息
  homeRecommend: '/assets/recommend',
//关注消息
  homeFollow: '/assets/follow',
//分类消息
  homeClass: '/assets/class',
//收藏消息
  myCollect: '/assets/collect',
//退出登录
  logout: '/user/logout',
//设置头像
  setAvatar: '/user/avatar',
};
