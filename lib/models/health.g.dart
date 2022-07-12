// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'health.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HealthAdapter extends TypeAdapter<Health> {
  @override
  final int typeId = 11;

  @override
  Health read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Health()
      ..totalSteps = fields[0] as int
      ..totalAppUsage = fields[1] as int
      ..totalCalories = fields[2] as int
      ..totalSleepTime = fields[3] as int
      ..steps = (fields[4] as List).cast<HealthSteps>()
      ..usage = (fields[5] as List).cast<HealthUsage>()
      ..calories = (fields[6] as List).cast<HealthCalories>()
      ..sleep = (fields[7] as List).cast<HealthSleep>()
      ..username = fields[8] as String?
      ..qol = (fields[9] as List).cast<HealthQol>();
  }

  @override
  void write(BinaryWriter writer, Health obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.totalSteps)
      ..writeByte(1)
      ..write(obj.totalAppUsage)
      ..writeByte(2)
      ..write(obj.totalCalories)
      ..writeByte(3)
      ..write(obj.totalSleepTime)
      ..writeByte(4)
      ..write(obj.steps)
      ..writeByte(5)
      ..write(obj.usage)
      ..writeByte(6)
      ..write(obj.calories)
      ..writeByte(7)
      ..write(obj.sleep)
      ..writeByte(8)
      ..write(obj.username)
      ..writeByte(9)
      ..write(obj.qol);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HealthStepsAdapter extends TypeAdapter<HealthSteps> {
  @override
  final int typeId = 12;

  @override
  HealthSteps read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthSteps()
      ..datetime = fields[0] as String?
      ..value = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, HealthSteps obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.datetime)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthStepsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HealthUsageAdapter extends TypeAdapter<HealthUsage> {
  @override
  final int typeId = 13;

  @override
  HealthUsage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthUsage()
      ..datetime = fields[0] as String?
      ..value = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, HealthUsage obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.datetime)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthUsageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HealthCaloriesAdapter extends TypeAdapter<HealthCalories> {
  @override
  final int typeId = 14;

  @override
  HealthCalories read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthCalories()
      ..datetime = fields[0] as String?
      ..value = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, HealthCalories obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.datetime)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthCaloriesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HealthSleepAdapter extends TypeAdapter<HealthSleep> {
  @override
  final int typeId = 15;

  @override
  HealthSleep read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthSleep()
      ..datetime = fields[0] as String?
      ..value = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, HealthSleep obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.datetime)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthSleepAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HealthQolAdapter extends TypeAdapter<HealthQol> {
  @override
  final int typeId = 16;

  @override
  HealthQol read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HealthQol()
      ..datetime = fields[0] as String?
      ..value = fields[1] as int;
  }

  @override
  void write(BinaryWriter writer, HealthQol obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.datetime)
      ..writeByte(1)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthQolAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
