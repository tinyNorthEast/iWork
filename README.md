# iWork
an app for hounter，u can search some message for the best hounter

【scope】

- 用户系统

          | 注册：主动注册+邀请注册
               || 主动注册：手机号+短信验证（短信通道）
               || 邀请注册：服务端生成邀请码
          | 个人资料补全：用户名、密码、公司、工作年限、邮箱等；
          | 登录：用户名+密码登录
          | 忘记密码、修改密码
          | 用户角色：猎头顾问、HR、候选者
          | 用户权限：猎头顾问在查看案例时，隐藏敏感信息；

- 首页

          | 地区：默认使用定位服务，地区列表待定（北上广深）；—NavigationBar
          | Profile（我的）：未注册用户进入注册页面，已登录用户进入『我的』页面；—NavigationBar
          | More（更多功能）：点击出现下拉页，展示更多的行业选择页面；
          | 猎头顾问列表：
               || 排序（人气-业绩-综合评分等）；
               || 下拉刷新（前三不变），其余按照时间顺序更新；
               || 上拉加载（分页5条）；
               || 关注/取消关注（需要登录）；
               || 评论：查看评论，只有完成咨询才可以评论；

- 详情页：

          | 关注：同首页列表中的功能；
          | 分享：转发到微信朋友圈；
          | 个人信息：
               || 照片：首页中的图片；
               || 姓名：用户名/公司名；
               || 电话：可拨打；
               || 邮件：调起email发送邮件；
          | 自我介绍：猎头顾问履历；
          | 擅长行业：猎头顾问擅长从事的行业；
          | 个人业绩：分权限展示，用户类型为猎头的要敏感数据脱敏；
          | 发表的话题：功能待定；
          | 评价：展示一条评价内容，查看更多！

- 评论：

          | 星级评论：满分5※，默认5※，用户可选；
          | 文字评论：限制140字；
          | 评论时间：服务端时间；
          | 评论的话题：
          | 评论人：用户名
          | 评论人头像：

- 我的

          | 我的信息：未登录的点击进行登录，已登录的进入我的详情页
          | 我的消息：待定，是否是评论我的；
          | 谁关注我：关注我的猎头顾问；
          | 我的关注：关注的猎头顾问；
          | 设置：
               || 推荐码：生成邀请码，邀请新用户；
               || 推送设置；
               || 清空缓存；
               || 关于：
               || 反馈：
               || 联系客服：
