import 'package:hive/hive.dart';

part 'user_info.g.dart';

@HiveType(typeId: 1)
class UserInfo {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String username;
  @HiveField(2)
  final String password;
  @HiveField(3)
  final String message;
  @HiveField(4)
  final int auth;
  @HiveField(5)
  final String status;
  @HiveField(6)
  final String expDate;
  @HiveField(7)
  final String isTrial;
  @HiveField(8)
  final String activeCons;
  @HiveField(9)
  final String createdAt;
  @HiveField(10)
  final String maxConnections;
  @HiveField(11)
  final String url;

  UserInfo({
    required this.name,
    required this.username,
    required this.password,
    required this.message,
    required this.auth,
    required this.status,
    required this.expDate,
    required this.isTrial,
    required this.activeCons,
    required this.createdAt,
    required this.maxConnections,
    required this.url,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        name: json['name'],
        username: json['username'],
        password: json['password'],
        message: json['message'],
        auth: json['auth'],
        status: json['status'],
        expDate: json['exp_date'],
        isTrial: json['is_trial'],
        activeCons: json['active_cons'],
        createdAt: json['created_at'],
        maxConnections: json['max_connections'],
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'username': username,
        'password': password,
        'message': message,
        'auth': auth,
        'status': status,
        'exp_date': expDate,
        'is_trial': isTrial,
        'active_cons': activeCons,
        'created_at': createdAt,
        'max_connections': maxConnections,
        'url': url,
      };
}
