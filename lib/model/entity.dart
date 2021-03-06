//用户user模型
class UserModel {
  UserData data;
  String status;

  UserModel({this.data, this.status});

  UserModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new UserData.fromJson(json['data']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}
class UserData {
  String avatar;
  int color;
  String email;
  String name;
  String nickname;
  String phone;
  int sex;

  UserData(
      {this.avatar,
      this.color,
      this.email,
      this.name,
      this.nickname,
      this.phone,
      this.sex});

  UserData.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    color = json['color'];
    email = json['email'];
    name = json['name'];
    nickname = json['nickname'];
    phone = json['phone'];
    sex = json['sex'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['color'] = this.color;
    data['email'] = this.email;
    data['name'] = this.name;
    data['nickname'] = this.nickname;
    data['phone'] = this.phone;
    data['sex'] = this.sex;
    return data;
  }

  @override
  String toString() =>
      ', 颜色: $color, 邮箱: $email, 用户名: $name, 昵称: $nickname, 电话: $phone, 性别: $sex';
}

//请求消息模型
class MessageModel {
  List<MessageData> data;
  String status;

  MessageModel({this.data, this.status});

  MessageModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<MessageData>();
      json['data'].forEach((v) {
        data.add(new MessageData.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}
class MessageData {
  String avatar;
  String content;
  String createAt;
  int designerId;
  int id;
  List<String> imgsName;
  bool isCollected;
  bool isFollowed;
  bool isLiked;
  String name;
  int sumCollects;
  int sumLikes;
  List<TopComment> topComment;

  MessageData(
      {this.avatar,
      this.content,
      this.createAt,
      this.designerId,
      this.id,
      this.imgsName,
      this.isCollected,
      this.isFollowed,
      this.isLiked,
      this.name,
      this.sumCollects,
      this.sumLikes,
      this.topComment});

  MessageData.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    content = json['content'];
    createAt = json['create_at'];
    designerId = json['designer_id'];
    id = json['id'];
    imgsName = json['imgs_name'].cast<String>();
    isCollected = json['is_collected'];
    isFollowed = json['is_followed'];
    isLiked = json['is_liked'];
    name = json['name'];
    sumCollects = json['sum_collects'];
    sumLikes = json['sum_likes'];
    if (json['top_comment'] != null) {
      topComment = new List<TopComment>();
      json['top_comment'].forEach((v) {
        topComment.add(new TopComment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['content'] = this.content;
    data['create_at'] = this.createAt;
    data['designer_id'] = this.designerId;
    data['id'] = this.id;
    data['imgs_name'] = this.imgsName;
    data['is_collected'] = this.isCollected;
    data['is_followed'] = this.isFollowed;
    data['is_liked'] = this.isLiked;
    data['name'] = this.name;
    data['sum_collects'] = this.sumCollects;
    data['sum_likes'] = this.sumLikes;
    if (this.topComment != null) {
      data['top_comment'] = this.topComment.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

//一级评论消息
class TopComment {
  String content;
  String createAt;
  String createBy;
  int id;
  List<SecondComment> secondComment;

  TopComment({this.content, this.createAt, this.createBy, this.secondComment, this.id});

  TopComment.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    createAt = json['create_at'];
    createBy = json['create_by'];
    id = json['id'];
    if (json['second_comment'] != null) {
      secondComment = new List<SecondComment>();
      json['second_comment'].forEach((v) {
        secondComment.add(new SecondComment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['create_at'] = this.createAt;
    data['create_by'] = this.createBy;
    if (this.secondComment != null) {
      data['second_comment'] =
          this.secondComment.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

//二级评论
class SecondComment {
  String content;
  String createAt;
  String createBy;

  SecondComment({this.content, this.createAt, this.createBy});

  SecondComment.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    createAt = json['create_at'];
    createBy = json['create_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['create_at'] = this.createAt;
    data['create_by'] = this.createBy;
    return data;
  }
}

//通知类
class NoticeModel {
  List<NoticeData> data;
  String status;

  NoticeModel({this.data, this.status});

  NoticeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<NoticeData>();
      json['data'].forEach((v) {
        data.add(new NoticeData.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}
class NoticeData {
  String content;
  String createAt;
  String avatar;

  NoticeData({this.content, this.createAt, this.avatar});

  NoticeData.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    createAt = json['create_at'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['create_at'] = this.createAt;
    data['avatar'] = this.avatar;
    return data;
  }
}

//颜色类
class ColorModel {
  List<ColorData> data;

  ColorModel({this.data});

  ColorModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<ColorData>();
      json['data'].forEach((v) {
        data.add(new ColorData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class ColorData {
  String color;
  int colorId;

  ColorData({this.color, this.colorId});

  ColorData.fromJson(Map<String, dynamic> json) {
    color = json['color'];
    colorId = json['color_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['color'] = this.color;
    data['color_id'] = this.colorId;
    return data;
  }
}
