class CallModel {
  String callerId;
  String callerName;
  String callerPic;
  String receiverId;
  String receiverName;
  String receiverPic;
  String channelId;
  bool hasDialled;
  int callUtcTime;

  CallModel(
      {required this.callerId,
      required this.callerName,
      required this.callerPic,
      required this.receiverId,
      required this.receiverName,
      required this.receiverPic,
      required this.channelId,
      required this.hasDialled,
      required this.callUtcTime});

  // to map
  Map<String, dynamic> toMap(CallModel call) {
    Map<String, dynamic> callMap = Map();
    callMap["caller_id"] = call.callerId;
    callMap["caller_name"] = call.callerName;
    callMap["caller_pic"] = call.callerPic;
    callMap["receiver_id"] = call.receiverId;
    callMap["receiver_name"] = call.receiverName;
    callMap["receiver_pic"] = call.receiverPic;
    callMap["channel_id"] = call.channelId;
    callMap["has_dialled"] = call.hasDialled;
    callMap["call_utc"] = call.callUtcTime;
    return callMap;
  }

  static CallModel fromMap(Map callMap) {
    return CallModel(
      callerId: callMap["caller_id"] ?? '',
      callUtcTime: callMap['call_utc'] ?? 0,
      callerName: callMap["caller_name"] ?? '',
      callerPic: callMap["caller_pic"] ?? '',
      receiverId: callMap["receiver_id"] ?? '',
      receiverName: callMap["receiver_name"] ?? '',
      receiverPic: callMap["receiver_pic"] ?? '',
      channelId: callMap["channel_id"] ?? '',
      hasDialled: callMap["has_dialled"] ?? false,
    );
  }
}
