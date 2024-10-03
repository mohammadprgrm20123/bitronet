class MessageModel {
  Notifications? notifications;
  NoticeModel? notices;

  MessageModel({required this.notifications, required this.notices});

  factory MessageModel.fromJson(final Map<String, dynamic> json) =>
      MessageModel(
          notifications: json['notifications'] == null
              ? null
              : Notifications.fromJson(json['notifications']),
          notices: json['notices'] == null
              ? null
              : NoticeModel.fromJson(json['notices']));
}

class Notifications {
  List<UserUnreadNotifications> userUnreadNotifications;
  int userUnreadNotificationsCount;

  Notifications(
      {required this.userUnreadNotifications,
      required this.userUnreadNotificationsCount});

  factory Notifications.fromJson(final Map<String, dynamic> json) {
    final userUnreadNotifications = <UserUnreadNotifications>[];
    if (json['userUnreadNotifications'] != null) {
      json['userUnreadNotifications'].forEach((final v) {
        userUnreadNotifications.add(UserUnreadNotifications.fromJson(v));
      });
    }
    return Notifications(
        userUnreadNotifications: userUnreadNotifications,
        userUnreadNotificationsCount: json['userUnreadNotificationsCount']);
  }
}

class UserUnreadNotifications {
  String? type;
  String? typeOriginal;
  String? content;
  Data? data;
  String? createdAt;

  UserUnreadNotifications({
    required this.type,
    required this.typeOriginal,
    required this.content,
    required this.data,
    required this.createdAt,
  });

  factory UserUnreadNotifications.fromJson(final Map<String, dynamic> json) =>
      UserUnreadNotifications(
        type: json['type'],
        typeOriginal: json['type_original'],
        content: json['content'],
        data: json['data'] == null ? null : Data.fromJson(json['data']),
        createdAt: json['created_at'],
      );
}

class Data {
  String? id;
  String? date;
  String? url;
  String? msg;
  int? vcount;

  Data({this.id, this.date, this.url, this.msg, this.vcount});

  Data.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    url = json['url'];
    msg = json['msg'];
    vcount = json['vcount'];
  }
}

class NoticeModel {
  int? userNotifyCount;
  List<NotificationsUsersItems>? notificationsUsersItems;

  NoticeModel({this.userNotifyCount, this.notificationsUsersItems});

  NoticeModel.fromJson(final Map<String, dynamic> json) {
    userNotifyCount = json['userNotifyCount'];
    if (json['notifications_users_items'] != null) {
      notificationsUsersItems = <NotificationsUsersItems>[];
      json['notifications_users_items'].forEach((final v) {
        notificationsUsersItems!.add(NotificationsUsersItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userNotifyCount'] = userNotifyCount;
    if (notificationsUsersItems != null) {
      data['notifications_users_items'] =
          notificationsUsersItems!.map((final v) => v.toJson()).toList();
    }
    return data;
  }
}

class NotificationsUsersItems {
  int? id;
  String? title;
  String? content;
  String? createdAt;

  NotificationsUsersItems({this.id, this.title, this.content, this.createdAt});

  NotificationsUsersItems.fromJson(final Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['content'] = content;
    data['created_at'] = createdAt;
    return data;
  }
}
