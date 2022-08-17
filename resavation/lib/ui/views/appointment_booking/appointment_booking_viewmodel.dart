import 'package:stacked/stacked.dart';
import '../../../model/appointment.dart';
import '../../../app/app.locator.dart';
import '../../../model/login_model.dart';
import '../../../services/core/http_service.dart';
import '../../../services/core/user_type_service.dart';
import 'package:intl/intl.dart';

final initialAppointments = [
  Appointment(
      appointmentStartTime: 8,
      appointmentEndTime: 9,
      status: AppointmentStatus.Free),
  Appointment(
      appointmentStartTime: 9,
      appointmentEndTime: 10,
      status: AppointmentStatus.Free),
  Appointment(
      appointmentStartTime: 10,
      appointmentEndTime: 11,
      status: AppointmentStatus.Free),
  Appointment(
      appointmentStartTime: 11,
      appointmentEndTime: 12,
      status: AppointmentStatus.Free),
  Appointment(
      appointmentStartTime: 12,
      appointmentEndTime: 13,
      status: AppointmentStatus.Free),
  Appointment(
      appointmentStartTime: 13,
      appointmentEndTime: 14,
      status: AppointmentStatus.Free),
  Appointment(
      appointmentStartTime: 14,
      appointmentEndTime: 15,
      status: AppointmentStatus.Free),
  Appointment(
      appointmentStartTime: 15,
      appointmentEndTime: 16,
      status: AppointmentStatus.Free),
  Appointment(
      appointmentStartTime: 16,
      appointmentEndTime: 17,
      status: AppointmentStatus.Free),
  Appointment(
      appointmentStartTime: 17,
      appointmentEndTime: 18,
      status: AppointmentStatus.Free),
  Appointment(
      appointmentStartTime: 18,
      appointmentEndTime: 19,
      status: AppointmentStatus.Free),
  Appointment(
      appointmentStartTime: 19,
      appointmentEndTime: 20,
      status: AppointmentStatus.Free),
];

List<Appointment> getLandOwnerAvailiableSlots(
    List<Appointment> userAppointment) {
  final List<Appointment> appointments = [];

  for (final appointment in initialAppointments) {
    final appointmentPresenList = userAppointment
        .where((userAppointment) =>
            userAppointment.appointmentStartTime ==
                appointment.appointmentStartTime &&
            userAppointment.appointmentEndTime ==
                appointment.appointmentEndTime)
        .toList();

    if (appointmentPresenList.isNotEmpty) {
      appointments.add(appointmentPresenList[0]);
    } else {
      appointments.add(appointment);
    }
  }

  return appointments;
}

String getFormattedTime(int timestamp) {
  try {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('MMM dd, yyyy').format(dateTime);
  } catch (exception) {
    return "";
  }
}

String getFormattedTime2(int timestamp) {
  try {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat('dd MMMM').format(dateTime);
  } catch (exception) {
    return "";
  }
}

String getAppointmentHour(int hour) {
  if (hour < 12) {
    return '$hour am';
  } else if (hour == 12) {
    return '$hour pm';
  } else {
    return '${hour - 12} pm';
  }
}

class AppointmentBookingViewModel extends BaseViewModel {
  final httpService = locator<HttpService>();
  final _userService = locator<UserTypeService>();

  DateTime _selectedDate = DateTime.now();
  DateTime date = DateTime.now();

  DateTime get initialDate => date.add(
        Duration(days: 1),
      );
  DateTime get endDate => date.add(
        Duration(days: 365),
      );

  Appointment? selectedAppointment;
  LoginModel get userData => _userService.userData;
  DateTime get selectedStartDate => _selectedDate;
  DateTime get selectedEndDate => _selectedDate.add(
        Duration(
          days: 1,
        ),
      );

  AppointmentBookingViewModel() {
    _selectedDate = date.add(
      Duration(days: 1),
    );
  }
  bool isAppointmentSelected(Appointment appointment) {
    if (selectedAppointment == null) {
      return false;
    }

    return appointment.appointmentDate ==
            selectedAppointment!.appointmentDate &&
        appointment.appointmentEndTime ==
            selectedAppointment!.appointmentEndTime &&
        appointment.appointmentStartTime ==
            selectedAppointment!.appointmentStartTime &&
        appointment.propertyName == selectedAppointment!.propertyName &&
        appointment.landOwnerMail == selectedAppointment!.landOwnerMail &&
        appointment.status == selectedAppointment!.status &&
        appointment.tenantImage == selectedAppointment!.tenantImage &&
        appointment.tenantMail == selectedAppointment!.tenantMail;
  }

  void onDateChanged(DateTime dateTime) {
    _selectedDate = dateTime;
    selectedAppointment = null;
    notifyListeners();
  }

  void onSelectedAppointmentChanged(Appointment appointment) {
    selectedAppointment = appointment;
    notifyListeners();
  }

  void pickAppointment(
      {required String? ownerEmail,
      required String? propertyName,
      required String? ownerName,
      required String? location}) {
    final appointment = Appointment();
    appointment.appointmentDate = selectedStartDate.millisecondsSinceEpoch;
    appointment.appointmentStartTime =
        selectedAppointment!.appointmentStartTime;
    appointment.appointmentEndTime = selectedAppointment!.appointmentEndTime;

    appointment.propertyName = propertyName;
    appointment.landOwnerMail = ownerEmail;
    appointment.status = AppointmentStatus.Pending;
    appointment.tenantImage = userData.imageUrl;
    appointment.tenantMail = userData.email;
    appointment.landOwnerName = ownerName;
    appointment.tenantName = userData.firstName + ' ' + userData.lastName;
    appointment.location = location;

    setAppointmentStatus(appointment);
  }
}
