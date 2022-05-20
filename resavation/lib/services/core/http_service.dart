import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/model/login_model.dart';
import 'package:resavation/model/property_model.dart';
import 'package:resavation/model/registration_model.dart';
import 'package:resavation/model/upload_property_model.dart';
import 'package:resavation/services/core/user_type_service.dart';

class HttpService {
  final userTypeService = locator<UserTypeService>();

  //final _httpService = locator<HttpService>();

  final requestSite = "resavation-backend.herokuapp.com";

  confirmRegByOTP({required String email, required String otp}) async {
    try {
      var response = await http.post(
        Uri.http(
            requestSite, "api/v1/auth/confirm-reg-by-otp", <String, dynamic>{
          "email": email,
          "otp": otp,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
      );
      if (response.statusCode <= 299) {
        return;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } on SocketException {
      return Future.error("No internet connection");
    } catch (exception) {
      return Future.error("Error occurred in confirming OTP");
    }
  }

  loginUser(String email, String password) async {
    try {
      var response = await http.post(
        Uri.http(requestSite, "api/v1/auth/login"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(
          <String, String>{
            "email": email,
            "password": password,
          },
        ),
      );

      if (response.statusCode <= 299) {
        String responseString = response.body;
        var loginModel = loginModelFromJson(responseString);
        userTypeService.setUserData(loginModel);
        return loginModel;
      } else if (response.statusCode == 400) {
        userTypeService.error.value = "Incorrect Username or Password";
        return Future.error("Incorrect Username or Password");
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } on SocketException {
      return Future.error("No internet connection");
    } catch (exception) {
      return Future.error("Failed to login user");
    }
  }

  // Sign-up Request Logic
  sendDetailsToServer(
      String email,
      String firstname,
      String lastname,
      String password,
      String verifyPassword,
      bool termAndCondition,
      String accountType) async {
    try {
      final response =
          await http.post(Uri.http(requestSite, "api/v1/auth/register"),
              headers: <String, String>{'Content-Type': 'application/json'},
              body: jsonEncode(<String, dynamic>{
                "verifyPassword": verifyPassword,
                "accountType": accountType,
                "email": email,
                "firstname": firstname,
                "lastname": lastname,
                "password": password,
                "platform": "mobile",
                "imageUrl": "",
                "termAndCondition": termAndCondition,
              }));

      if (response.statusCode <= 299) {
        return registrationModelFromJson(response.body);
      } else {
        return Future.error((json.decode(response.body)['message']) ??
            'Failed to register user');
      }
    } on SocketException {
      return Future.error("No internet connection");
    } catch (exception) {
      return Future.error("Failed to register user");
    }
  }

  forgotPassword(
      {required String email,
      required String password,
      required String confirmPassword,
      required String otp}) async {
    try {
      var response = await http.post(
        Uri.http(requestSite, "api/v1/auth/reset-password"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(
          <String, String>{
            "confirmPassword": confirmPassword,
            "email": email,
            "newPassword": password,
            "otp": otp
          },
        ),
      );
      if (response.statusCode <= 299) {
        return;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } on SocketException {
      return Future.error("No internet connection");
    } catch (exception) {
      return Future.error("Error occurred in changing your password");
    }
  }

  sendOTP({required String email}) async {
    try {
      var response = await http.post(
        Uri.http(requestSite, "api/v1/auth/forgot-password", <String, dynamic>{
          "email": email,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
      );
      if (response.statusCode <= 299) {
        return;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } on SocketException {
      return Future.error("No internet connection");
    } catch (exception) {
      return Future.error("Error occurred in sending OTP");
    }
  }

  Future<List<Property>> getAllProperties(
      {required int page, required int size}) async {
    try {
      var response = await http.get(
        Uri.http(requestSite, "api/v1/properties", <String, dynamic>{
          "page": page,
          "size": size,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        return propertyFromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } on SocketException {
      return Future.error("No internet connection");
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  getAllPropertyById({required int id}) async {
    try {
      var response = await http.get(
        Uri.http(
          requestSite,
          "api/v1/properties/$id",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        // return registrationModelFromJson(response.body);
        return;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } on SocketException {
      return Future.error("No internet connection");
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  togglePropertyAsFavourite(
      {required int propertyId, required bool isFavourite}) async {
    try {
      var response = await http.post(
        Uri.http(
            requestSite, "api/v1/properties/$propertyId", <String, dynamic>{
          "property_id": propertyId,
          "is_favourite": isFavourite,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        return;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } on SocketException {
      return Future.error("No internet connection");
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  updateProfile({required Map<String, dynamic> body}) async {
    try {
      var response = await http.post(
        Uri.http(
          requestSite,
          "api/v1/user/profile/update",
        ),
        body: jsonEncode(body),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        final loginModel =
            loginFromOldModel(response.body, userTypeService.userData);
        userTypeService.updateUserData(loginModel);
        return;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } on SocketException {
      return Future.error("No internet connection");
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  //Property Upload Logic
  // Future<UploadProperty?> uploadProperty({
  //   String? address,
  //   List<String>? amenities,
  //   Map<String, String>? availability,
  //   String? from,
  //   String? to,
  //   int? bathTubCount,
  //   int? bedroomCount,
  //   int? carSlots,
  //   String? city,
  //   String? country,
  //   String? description,
  //   String? imageUrl,
  //   List<String>? listingOption,
  //   bool? liveInSPace,
  //   String? propertyName,
  //   String? roomType,
  //   List<String>? rules,
  //   bool? spaceFurnished,
  //   int? spacePrice,
  //   bool? spaceServiced,
  //   String? spaceType,
  //   String? state,
  //   Map<String, int>? subscription,
  //   int? annualPrice,
  //   int? biannualPrice,
  //   int? monthlyPrice,
  //   int? quarterlyPrice,
  //   int? surfaceArea,
  //   Map<String, String>? userDetails,
  //   String? dateOfBirth,
  //   String? firstName,
  //   String? gender,
  //   String? lastName,
  //   String? phoneNumber,
  // }) async {
  //   var data = jsonEncode({
  //     "address": address,
  //     "amenities": amenities,
  //     "availability": {"from": from, "to": to},
  //     "bathTubCount": bathTubCount,
  //     "bedroomCount": bedroomCount,
  //     "carSlots": carSlots,
  //     "city": city,
  //     "country": country,
  //     "description": description,
  //     "imageUrl": imageUrl,
  //     "listingOption": listingOption,
  //     "liveInSPace": liveInSPace,
  //     "propertyName": propertyName,
  //     "roomType": roomType,
  //     "rules": rules,
  //     "spaceFurnished": spaceFurnished,
  //     "spacePrice": spacePrice,
  //     "spaceServiced": spaceServiced,
  //     "spaceType": spaceType,
  //     "state": state,
  //     "subscription": {
  //       "annualPrice": annualPrice,
  //       "biannualPrice": biannualPrice,
  //       "monthlyPrice": monthlyPrice,
  //       "quarterlyPrice": quarterlyPrice
  //     },
  //     "surfaceArea": surfaceArea,
  //     "userDetails": {
  //       "address": address,
  //       "city": city,
  //       "country": country,
  //       "dateOfBirth": dateOfBirth,
  //       "firstName": firstName,
  //       "gender": gender,
  //       "lastName": lastName,
  //       "phoneNumber": phoneNumber,
  //       "state": state
  //     }
  //   });
  //   print(data);
  //   var response = await http.post(
  //       Uri.http(requestSite, "/api/v1/properties/upload"),
  //       headers: <String, String>{'Content-Type': 'application/json'},
  //       body: data);
  Future<UploadProperty?> uploadProperty({
    String? address,
    List<bool>? amenities,
    bool? airConditional,
    bool? airDryer,
    bool? fireAlarm,
    bool? tv,
    bool? washingMachine,
    bool? wifi,
    Map<String, String>? availability,
    String? from,
    String? to,
    int? bathTubCount,
    int? bedroomCount,
    int? carSlots,
    String? city,
    String? country,
    String? description,
    String? imageUrl,
    List<String>? listingOption,
    bool? liveInSPace,
    String? propertyName,
    String? roomType,
    List<bool>? rules,
    bool? noHouseParty,
    bool? noPet,
    bool? noSmoking,
    bool? spaceFurnished,
    int? spacePrice,
    bool? spaceServiced,
    String? spaceType,
    String? state,
    Map<String, int>? subscription,
    int? annualPrice,
    int? biannualPrice,
    int? monthlyPrice,
    int? quarterlyPrice,
    int? surfaceArea,
    Map<String, String>? userDetails,
    String? dateOfBirth,
    String? firstName,
    String? gender,
    String? lastName,
    String? phoneNumber,
  }) async {
    var response =
        await http.post(Uri.http(requestSite, "/api/v1/properties/upload"),
            headers: <String, String>{'Content-Type': 'application/json'},
            body: jsonEncode({
              "address": address,
              "amenities": {
                "airConditional": true,
                "airDryer": true,
                "fireAlarm": true,
                "tv": true,
                "washingMachine": true,
                "wifi": true
              },
              "availability": {"from": from, "to": to},
              "bathTubCount": bathTubCount,
              "bedroomCount": bedroomCount,
              "carSlots": carSlots,
              "city": city,
              "country": country,
              "description": description,
              "imageUrl": imageUrl,
              "listingOption": listingOption,
              "liveInSPace": liveInSPace,
              "propertyName": propertyName,
              "roomType": roomType,
              "rules": rules,
              "noHouseParty": true,
              "noPet": true,
              "noSmoking": true,
              "spaceFurnished": spaceFurnished,
              "spacePrice": spacePrice,
              "spaceServiced": spaceServiced,
              "spaceType": spaceType,
              "state": state,
              "subscription": {
                "annualPrice": annualPrice,
                "biannualPrice": biannualPrice,
                "monthlyPrice": monthlyPrice,
                "quarterlyPrice": quarterlyPrice
              },
              "surfaceArea": surfaceArea,
              "userDetails": {
                "address": address,
                "city": city,
                "country": country,
                "dateOfBirth": dateOfBirth,
                "firstName": firstName,
                "gender": gender,
                "lastName": lastName,
                "phoneNumber": phoneNumber,
                "state": state
              }
            }));

    print('From the uploading session: ${response.body}');
    if (response.statusCode == 200) {
      String responseString = response.body;
      return uploadPropertyFromJson(responseString);
    } else if (response.statusCode == 400) {
      String responseString = response.body;
      userTypeService.error.value = "";
      print(responseString);
      throw Exception(userTypeService.error.value);
    } else
      throw Exception("Failed to upload property");
  }
}
