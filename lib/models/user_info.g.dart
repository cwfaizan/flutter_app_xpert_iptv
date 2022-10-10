// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInfoAdapter extends TypeAdapter<UserInfo> {
  @override
  final int typeId = 1;

  @override
  UserInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInfo(
      name: fields[0] as String,
      username: fields[1] as String,
      password: fields[2] as String,
      message: fields[3] as String,
      auth: fields[4] as int,
      status: fields[5] as String,
      expDate: fields[6] as String,
      isTrial: fields[7] as String,
      activeCons: fields[8] as String,
      createdAt: fields[9] as String,
      maxConnections: fields[10] as String,
      url: fields[11] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserInfo obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(4)
      ..write(obj.auth)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.expDate)
      ..writeByte(7)
      ..write(obj.isTrial)
      ..writeByte(8)
      ..write(obj.activeCons)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.maxConnections)
      ..writeByte(11)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
