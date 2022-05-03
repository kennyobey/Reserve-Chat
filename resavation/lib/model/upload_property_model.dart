import 'dart:convert';

UploadProperty uploadPropertyFromJson(String str) =>
    UploadProperty.fromJson(json.decode(str));

String uploadPropertyToJson(UploadProperty data) => json.encode(data.toJson());

class UploadProperty {
  UploadProperty({
    required this.message,
  });

  String message;

  factory UploadProperty.fromJson(Map<String, dynamic> json) => UploadProperty(
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
      };
}
