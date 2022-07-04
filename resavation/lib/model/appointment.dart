import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

enum AppointmentStatus { Free, Booked, Pending, Declined, Passed }

class Appointment {
  int? appointmentDate;
  int? appointmentEndTime;
  int? appointmentStartTime;

  String? propertyName;
  String? landOwnerMail;
  AppointmentStatus status;
  String? tenantImage;
  String? tenantMail;

  String? landOwnerName;
  String? tenantName;
  String? location;

  Appointment({
    this.appointmentDate,
    this.appointmentEndTime,
    this.appointmentStartTime,
    this.propertyName,
    this.landOwnerMail,
    this.status = AppointmentStatus.Free,
    this.tenantImage,
    this.tenantMail,
    this.location,
    this.landOwnerName,
    this.tenantName,
  });

  factory Appointment.fromMap(Map<String, dynamic> data) {
    final now = DateTime.now();
    final currentTime =
        DateTime(now.year, now.month, now.day).millisecondsSinceEpoch;
    AppointmentStatus status;
    if (data['status'] == 'Free') {
      status = AppointmentStatus.Free;
    } else if (data['status'] == 'Declined') {
      status = AppointmentStatus.Declined;
    } else if ((data['appointment_date'] ?? 0) < currentTime) {
      status = AppointmentStatus.Passed;
    } else if (data['status'] == 'Booked') {
      status = AppointmentStatus.Booked;
    } else {
      status = AppointmentStatus.Pending;
    }

    return Appointment(
      status: status,
      appointmentDate: data['appointment_date'] as int?,
      appointmentEndTime: data['appointment_end_time'] as int?,
      appointmentStartTime: data['appointment_start_time'] as int?,
      landOwnerMail: data['land_owner_mail'] as String?,
      tenantImage: data['tenant_image'] as String?,
      tenantMail: data['tenant_mail'] as String?,
      propertyName: data['property_name'] as String?,
      location: data['location'] as String?,
      landOwnerName: data['owner_name'] as String?,
      tenantName: data['tenant_name'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'appointment_date': appointmentDate,
        'appointment_end_time': appointmentEndTime,
        'appointment_start_time': appointmentStartTime,
        'land_owner_mail': landOwnerMail,
        'status': status.name,
        'property_name': propertyName,
        'tenant_image': tenantImage,
        'tenant_mail': tenantMail,
        'location': location,
        'owner_name': landOwnerName,
        'tenant_name': tenantName,
      };

  factory Appointment.fromJson(String data) {
    return Appointment.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  String toJson() => json.encode(toMap());
}

//get the list of owner appointment
Stream<QuerySnapshot<Map<String, dynamic>>> getOwnerAppointmentSchedule(
    String ownerId, int startTime, int endTime) {
  return FirebaseFirestore.instance
      .collection('appointment')
      .doc(ownerId)
      .collection('owner_appointment')
      .where('appointment_date',
          isLessThan: endTime, isGreaterThanOrEqualTo: startTime)
      .snapshots();
}

//todo get all the appointments in one stream then manually sort into different lists on the page based on the criterias
Future<QuerySnapshot<Map<String, dynamic>>> getTenantAppointments(
    String tenantId,
    {int limit: 5}) {
  return FirebaseFirestore.instance
      .collection('appointment')
      .doc(tenantId)
      .collection('tenant_appointment')
      .orderBy('appointment_date', descending: true)
      .limit(limit)
      .get();
}

Stream<QuerySnapshot<Map<String, dynamic>>> getOwnerAppointments(
    String ownerId) {
  return FirebaseFirestore.instance
      .collection('appointment')
      .doc(ownerId)
      .collection('owner_appointment')
      .snapshots();
}

// used to  set the appointment to accepted, declined etc.
void setAppointmentStatus(Appointment appointment) {
  final String id = (appointment.appointmentDate ?? 0).toString() +
      '-' +
      (appointment.appointmentStartTime ?? 0).toString() +
      '-' +
      (appointment.appointmentEndTime ?? 0).toString();
  //owner doc
  FirebaseFirestore.instance
      .collection('appointment')
      .doc(appointment.landOwnerMail)
      .collection('owner_appointment')
      .doc(id)
      .set(appointment.toMap(), SetOptions(merge: true));

  //tenant doc
  FirebaseFirestore.instance
      .collection('appointment')
      .doc(appointment.tenantMail)
      .collection('tenant_appointment')
      .doc(id)
      .set(appointment.toMap(), SetOptions(merge: true));
}

class AppointmentBookingDetails {
  final String ownerEmail;
  final String propertyName;
  final String ownerName;
  final String location;

  AppointmentBookingDetails(
      {required this.ownerEmail,
      required this.propertyName,
      required this.ownerName,
      required this.location});
}
