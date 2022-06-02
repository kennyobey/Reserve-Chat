import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/model/login_model.dart';
import 'package:resavation/model/property_model.dart';
import 'package:resavation/model/property_search/property_search.dart';
import 'package:resavation/model/registration_model.dart';
import 'package:resavation/model/top_cities_model/top_cities_model.dart';
import 'package:resavation/model/upload_property_model.dart';
import 'package:resavation/services/core/user_type_service.dart';

import '../../model/top_categories_model/top_categories_model.dart';

class HttpService {
  final userTypeService = locator<UserTypeService>();

  //final _httpService = locator<HttpService>();

  final requestSite = "resavation-backend.herokuapp.com";

  resendOTP({required String email}) async {
    try {
      var response = await http.post(
        Uri.http(requestSite, "api/v1/auth/request-otp"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(
          <String, dynamic>{
            "email": email,
          },
        ),
      );
      if (response.statusCode <= 299) {
        return;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } on SocketException {
      return Future.error("No stable connection");
    } catch (exception) {
      return Future.error("Error occurred in sending OTP");
    }
  }

  confirmRegByOTP({required String email, required String otp}) async {
    try {
      var response = await http.post(
        Uri.http(
          requestSite,
          "api/v1/auth/confirm-reg-by-otp",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
        body: jsonEncode(
          <String, dynamic>{
            "email": email,
            "otp": otp,
          },
        ),
      );
      if (response.statusCode <= 299) {
        return;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } on SocketException {
      return Future.error("No stable connection");
    } catch (exception) {
      return Future.error("Error occurred in confirming OTP");
    }
  }

  Future<bool> loginUser(String email, String password) async {
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
        return true;
      } else if (response.statusCode == 400) {
        userTypeService.error.value = "Incorrect Username or Password";
        return Future.error("Incorrect Username or Password");
      } else if (response.statusCode == 406) {
        return false;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } on SocketException {
      return Future.error("No stable connection");
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
      final response = await http.post(
        Uri.http(requestSite, "api/v1/auth/register"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(
          <String, dynamic>{
            "verifyPassword": verifyPassword,
            "accountType": accountType,
            "email": email,
            "firstname": firstname,
            "lastname": lastname,
            "password": password,
            "platform": "mobile",
            "imageUrl": "",
            "termAndCondition": termAndCondition,
          },
        ),
      );
      if (response.statusCode <= 299) {
        return registrationModelFromJson(response.body);
      } else {
        return Future.error((json.decode(response.body)['message']) ??
            'Failed to register user');
      }
    } on SocketException {
      return Future.error("No stable connection");
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
      return Future.error("No stable connection");
    } catch (exception) {
      return Future.error("Error occurred in changing your password");
    }
  }

  forgotPasswordOtp({required String email}) async {
    try {
      var response = await http.post(
        Uri.http(requestSite, "api/v1/auth/forgot-password", <String, String>{
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
      return Future.error("No stable connection");
    } catch (exception) {
      return Future.error("Error occurred in sending OTP");
    }
  }

//////
  Future<PropertySearch> getAllProperties(
      {required int page, required int size}) async {
    try {
      var response = await http.get(
        Uri.http(requestSite, "api/v1/properties", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );

      if (response.statusCode <= 299) {
        return PropertySearch.fromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      debugPrint(exception.toString() + ": ttt");

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
      return Future.error("No stable connection");
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  togglePropertyAsFavourite({required int propertyId}) async {
    try {
      var response = await http.post(
          Uri.http(requestSite, "api/v1/properties/favourite/alter"),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
            'Authorization': userTypeService.authorization
          },
          body: jsonEncode(
            <String, dynamic>{
              "propertyId": propertyId,
            },
          ));
      if (response.statusCode <= 299) {
        return;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error togling selected property");
    }
  }

  Future<PropertySearch> getAllFavouriteProperties(
      {required int page, required int size}) async {
    try {
      var response = await http.get(
        Uri.http(
            requestSite, "api/v1/properties/favourite/fetch", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        return PropertySearch.fromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } on SocketException {
      return Future.error("No stable connection");
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<List<Property>> filterProperties({
    required int page,
    required int size,
  }) async {
    try {
      var response = await http.post(
        Uri.http(
            requestSite, "api/v1/properties/favourite/fetch", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
        body: jsonEncode(
          <String, dynamic>{
            "amenity": "string",
            "amenityCount": {
              "bathTubCount": 0,
              "bedRoomCount": 0,
              "carSlotCount": 0
            },
            "availability": {
              "moreThanOneYear": true,
              "shortLet": true,
              "withinOneYear": true,
              "withinSixMonth": true
            },
            "priceRange": {"max": 0, "min": 0},
            "propertyType": "string",
            "surfaceArea": 0
          },
        ),
      );
      if (response.statusCode <= 299) {
        return propertyFromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } on SocketException {
      return Future.error("No stable connection");
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<List<Property>> searchProperty({
    required int page,
    required int size,
    required String location,
  }) async {
    try {
      var response = await http.get(
        Uri.http(requestSite, "api/v1/properties/search", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
          "location": location,
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
      return Future.error("No stable connection");
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<List<Property>> getPropertyStatus() async {
    try {
      var response = await http.get(
        Uri.http(
          requestSite,
          "api/v1/properties/status",
        ),
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
      return Future.error("No stable connection");
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<List<Property>> getPropertyStyle() async {
    try {
      var response = await http.get(
        Uri.http(
          requestSite,
          "api/v1/properties/styles",
        ),
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
      return Future.error("No stable connection");
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<TopCategoriesModel> getTopCategoriesWithHighestProperties(
      {int page = 0, int size = 8}) async {
    try {
      var response = await http.get(
        Uri.http(
            requestSite, "api/v1/properties/top-categories", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );

      if (response.statusCode <= 299) {
        return TopCategoriesModel.fromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error(exception.toString());
      // return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<TopCitiesModel> getTopCitiesWithHighestProperties(
      {int page = 0, int size = 8}) async {
    try {
      var response = await http.get(
        Uri.http(requestSite, "api/v1/properties/top-cities", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        return TopCitiesModel.fromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<List<Property>> getPropertyTypes() async {
    try {
      var response = await http.get(
        Uri.http(
          requestSite,
          "api/v1/properties/types",
        ),
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
      return Future.error("No stable connection");
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

/////////////////////

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
      return Future.error("No stable connection");
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

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

  Future<String> getCallToken(
      {required String callId,
      required bool isSender,
      required int userId}) async {
    try {
      //https://agora-tokens-server.herokuapp.com/rtc/$callId/publisher/uid/2076
      //https://agora-tokens-server.herokuapp.com/rtc/otitem/audience/uid/56gf
      var response = await http.get(
        Uri.http(
          'agora-tokens-server.herokuapp.com',
          "rtc/$callId/${isSender ? 'publisher' : 'audience'}/uid/$userId",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8'
        },
      );
      if (response.statusCode <= 299) {
        return json.decode(response.body)['rtcToken'] ?? '';
      } else {
        return Future.error("Error occurred in communicating with the server");
      }
    } on SocketException {
      return Future.error("No stable connection");
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }
}
