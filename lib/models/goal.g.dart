// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalAdapter extends TypeAdapter<Goal> {
  @override
  final int typeId = 100;

  @override
  Goal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Goal()
      ..sleepGoal = fields[0] as String?
      ..activityGoal = fields[1] as String?
      ..screenTime = fields[2] as String?
      ..stepsGoal = fields[3] as String?
      ..username = fields[4] as String?;
  }

  @override
  void write(BinaryWriter writer, Goal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.sleepGoal)
      ..writeByte(1)
      ..write(obj.activityGoal)
      ..writeByte(2)
      ..write(obj.screenTime)
      ..writeByte(3)
      ..write(obj.stepsGoal)
      ..writeByte(4)
      ..write(obj.username);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
