// To parse this JSON data, do
//
//     final timekeepingModel = timekeepingModelFromJson(jsonString);

import 'dart:convert';

TimekeepingModel timekeepingModelFromJson(String str) => TimekeepingModel.fromJson(json.decode(str));

String timekeepingModelToJson(TimekeepingModel data) => json.encode(data.toJson());

class TimekeepingModel {
    final int? id;
    final DateTime? clockIn;
    final DateTime? clockOut;
    final DateTime? serverTimestampIn;
    final DateTime? serverTimestampOut;
    final String? enrollment;

    TimekeepingModel({
        this.id,
        this.clockIn,
        this.clockOut,
        this.serverTimestampIn,
        this.serverTimestampOut,
        this.enrollment,
    });

    TimekeepingModel copyWith({
        int? id,
        DateTime? clockIn,
        DateTime? clockOut,
        DateTime? serverTimestampIn,
        DateTime? serverTimestampOut,
        String? enrollment,
    }) => 
        TimekeepingModel(
            id: id ?? this.id,
            clockIn: clockIn ?? this.clockIn,
            clockOut: clockOut ?? this.clockOut,
            serverTimestampIn: serverTimestampIn ?? this.serverTimestampIn,
            serverTimestampOut: serverTimestampOut ?? this.serverTimestampOut,
            enrollment: enrollment ?? this.enrollment,
        );

    factory TimekeepingModel.fromJson(Map<String, dynamic> json) => TimekeepingModel(
        id: json["id"] ?? 0,
        clockIn: json["clockIn"] != null ? DateTime.tryParse(json["clockIn"]) : null,
        clockOut: json["clockOut"] != null ? DateTime.tryParse(json["clockOut"]) : null,
        serverTimestampIn: json["serverTimestampIn"] != null ? DateTime.tryParse(json["serverTimestampIn"]) : null,
        serverTimestampOut: json["serverTimestampOut"] != null ? DateTime.tryParse(json["serverTimestampOut"]) : null,
        enrollment: json["enrollment"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "clockIn": clockIn?.toIso8601String(),
        "clockOut": clockOut?.toIso8601String(),
        "serverTimestampIn": serverTimestampIn?.toIso8601String(),
        "serverTimestampOut": serverTimestampOut?.toIso8601String(),
        "enrollment": enrollment,
    }..removeWhere((key, value) => value == null);


    @override
    String toString() {
        return 'TimekeepingModel(id: $id, clockIn: $clockIn, clockOut: $clockOut, serverTimestampIn: $serverTimestampIn, serverTimestampOut: $serverTimestampOut, collaboratorId: $enrollment)';
    }
}
