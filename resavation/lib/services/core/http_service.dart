import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/model/booked_property/booked_property.dart';
import 'package:resavation/model/filter/filter.dart';
import 'package:resavation/model/login_model.dart';
import 'package:resavation/model/registration_model.dart';
import 'package:resavation/model/search_model/search_model.dart';
import 'package:resavation/model/top_states_model/top_states_model.dart';
import 'package:resavation/services/core/upload_service.dart';
import 'package:resavation/services/core/user_type_service.dart';


import '../../model/edit_profile_model.dart';
import '../../model/property_cotroller_model/booked_propety_model.dart';

import '../../model/top_categories_model/top_categories_model.dart';

class HttpService {
  final userTypeService = locator<UserTypeService>();

  final requestSite = "resavation-backend.herokuapp.com";

  Future<String> getPaymentLink({
    required String email,
    required int amount,
    required String subscriptionCode,
    required String authorization,
  }) async {
    try {
      var response = await http.post(
        Uri.https('api.paystack.co', "transaction/initialize"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $authorization'
        },
        body: jsonEncode(
          <String, dynamic>{
            "email": email,
            "amount": amount.toString(),
            "plan": subscriptionCode,
          },
        ),
      );
      debugPrint(response.statusCode.toString());
      if (response.statusCode <= 299) {
        final decodedData = json.decode(response.body);
        return decodedData['data']['authorization_url'] ?? '';
      } else {
        return Future.error('An error occurred in setting up payment');
      }
    } catch (exception) {
      return Future.error("An error occurred in setting up payment");
    }
  }

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

        final loginModel = loginModelFromJson(responseString);
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
    } catch (exception) {
      return Future.error("Failed to register user");
    }
  }

  editDetails(
    String firstName,
    String lastName,
    String email,
    String imageUrl,
    String phoneNumber,
    String gender,
    DateTime dateOfBirth,
    String country,
    String state,
    String city,
    String address,
    String postalCode,
    String aboutMe,
    String occupation,
  ) async {
    try {
      print("property");
      final response = await http.post(
        Uri.http(requestSite, "/api/v1/user/profile"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(
          <String, dynamic>{
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "imageUrl": "",
            "phoneNumber": phoneNumber,
            "dateOfBirth": "",
            "country": country,
            "state": state,
            "address": address,
            "postalCode": postalCode,
            "aboutMe": aboutMe,
            "occupation": occupation,
          },
        ),
      );
      if (response.statusCode <= 299) {
        log(await response.body);
        print(response.statusCode);
        print('Response status: ${response.statusCode}');
        return editProfileModelFromJson(response.body);
      } else {
        return Future.error((json.decode(response.body)['message']) ??
            'Failed to update profile');
      }
    } catch (exception) {
      print(" Error is :${exception.toString()}");
      return Future.error("Failed to update user profile");
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
    } catch (exception) {
      return Future.error("Error occurred in sending OTP");
    }
  }

//////
  Future<SearchModel> getAllProperties(
      {required int page, required int size}) async {
    try {
      var response = await http.get(
        Uri.http(requestSite, "api/v1/user/property", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );

      if (response.statusCode <= 299) {
        return SearchModel.fromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<SearchModel> getPropertiesByCategories(
      {required String category, required int page, required int size}) async {
    try {
      final response = await http.get(
        Uri.http(requestSite, "api/v1/properties/filter", <String, String>{
          "category": category,
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );

      if (response.statusCode <= 299) {
        return SearchModel.fromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<SearchModel> getPropertiesByStates(
      {required String state, required int page, required int size}) async {
    try {
      final response = await http.get(
        Uri.http(requestSite, "api/v1/properties/search", <String, String>{
          "key": state,
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );

      if (response.statusCode <= 299) {
        return SearchModel.fromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<SearchModel> getLandOwnerListings(
      {required int propertyId, required int page, required int size}) async {
    try {
      final response = await http.get(
        Uri.http(requestSite,
            "api/v1/user/property/owner/$propertyId", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );

      if (response.statusCode <= 299) {
        return SearchModel.fromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<SearchModel> getSearchProperty(
      {required String text, required int page, required int size}) async {
    try {
      final response = await http.get(
        Uri.http(requestSite, "api/v1/properties/search", <String, String>{
          "key": text,
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );

      if (response.statusCode <= 299) {
        return SearchModel.fromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<SearchModel> getFilteredProperty(
      {required Filter filter, required int page, required int size}) async {
    try {
      var response = await http.post(
        Uri.http(requestSite, "/api/v1/properties/filter", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        body: filter.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );

      if (response.statusCode <= 299) {
        return SearchModel.fromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
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
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  togglePropertyAsFavourite({required int propertyId}) async {
    try {
      var response = await http.post(
          Uri.http(requestSite, "api/v1/user/property/favourite/alter"),
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

  Future<SearchModel> getAllFavouriteProperties(
      {required int page, required int size}) async {
    try {
      final response = await http.get(
        Uri.http(requestSite,
            "api/v1/user/property/favourite/fetch", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        return SearchModel.fromJson(response.body);
      } else {
        return Future.error(
            json.decode(response.body)['message'] ?? 'Error Occurred');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<BookedProperty> getAllTenantsBookedProperty(
      {required int page, required int size}) async {
    try {
      final response = await http.get(
        Uri.http(requestSite, "api/v1/user/property/booked", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        return BookedProperty.fromJson(response.body);
      } else {
        return Future.error(
            json.decode(response.body)['message'] ?? 'Error Occurred');
      }
    } catch (exception) {
      return Future.error(exception.toString());
      // return Future.error("Error occurred in communicating with the server");
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

  Future<TopStatesModel> getTopStatesWithHighestProperties(
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
        return TopStatesModel.fromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
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
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  uploadProperty({
    required UploadService uploadTypeService,
    required List<String> images,
  }) async {
    final body = <String, dynamic>{
      "propertyCategory": uploadTypeService.propertyCategory ?? '',
      "propertyDetails": {
        "address": uploadTypeService.address ?? '',
        "amenities": uploadTypeService.amenities,
        "availability": {
          "from": uploadTypeService.startDate != null
              ? DateFormat('dd-MM-yyyy').format(uploadTypeService.startDate!)
              : '',
          "to": uploadTypeService.endDate != null
              ? DateFormat('dd-MM-yyyy').format(uploadTypeService.endDate!)
              : '',
        },
        "bathTubCount": uploadTypeService.noOfBathroom,
        "bedroomCount": uploadTypeService.noOfBedroom,
        "carSlots": uploadTypeService.numberOfCarSLot,
        "city": uploadTypeService.city ?? '',
        "country": 'Nigeria',
        "description": uploadTypeService.propertyDescription ?? '',
        "imageUrl": images,
        "liveInSPace": uploadTypeService.liveInSpace ?? false,
        "propertyName": uploadTypeService.propertyName ?? '',
        "roomType": uploadTypeService.spaceType ?? '',
        "rules": uploadTypeService.rules,
        "spaceFurnished": uploadTypeService.isSpaceFurnished ?? false,
        "spaceServiced": uploadTypeService.isSpaceServiced ?? false,
        "commercialPropertyType":
            uploadTypeService.commercialPropertyType ?? '',
        "retailPropertyType": uploadTypeService.retailPropertyType ?? '',
        "industrialPropertyType":
            uploadTypeService.industrialPropertyType ?? '',
        "residentialPropertyType":
            uploadTypeService.residentialPropertyType ?? '',
        "propertyStyle": uploadTypeService.propertyStyle ?? '',
        "serviceType": (uploadTypeService.isSpaceServiced ?? false)
            ? "Serviced"
            : 'Not Serviced',
        "propertyStatus": uploadTypeService.propertyStatus ?? '',
        "spacePrice": uploadTypeService.spacePrice ?? 0.0,
        "state": uploadTypeService.state ?? '',
        "subscription": {
          "annualPrice": uploadTypeService.annualPrice ?? 0.0,
          "biannualPrice": uploadTypeService.biannualPrice ?? 0.0,
          "monthlyPrice": uploadTypeService.monthlyPrice ?? 0.0,
          "quarterlyPrice": uploadTypeService.quarterlyPrice ?? 0.0
        },
        "surfaceArea": uploadTypeService.surfaceArea ?? 0
      }
    };

    try {
      final response =
          await http.post(Uri.http(requestSite, "/api/v1/properties/upload"),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization': userTypeService.authorization
              },
              body: jsonEncode(body));

      if (response.statusCode == 200) {
        return;
      } else {
        return Future.error("Failed to upload property");
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  bookProperty({
    required double amount,
    required int id,
    required String paymentType,
    required DateTime checkInDate,
  }) async {
    final body = <String, dynamic>{
      "amount": amount,
      "checkInDate": DateFormat('dd-MM-yyyy').format(checkInDate),
      "paymentType": paymentType,
      "propertyId": id
    };

    try {
      final response = await http.post(
        Uri.http(requestSite, "api/v1/user/property/book"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': userTypeService.authorization
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        return;
      } else {
        return Future.error("Failed to book property");
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<String> getCallToken(
      {required String callId,
      required bool isSender,
      required int userId}) async {
    try {
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
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  /////////////////
  Future<List<String>> getCommercialPropertyTypes() async {
    try {
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/properties/commercial",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        final decodedMessage = json.decode(response.body);
        return (decodedMessage['propertyTypes'] as List<dynamic>?)
                ?.map(
                  (e) => e.toString(),
                )
                .toList() ??
            [];
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<List<String>> getIndustrialPropertyTypes() async {
    try {
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/properties/industrial",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        final decodedMessage = json.decode(response.body);
        return (decodedMessage['propertyTypes'] as List<dynamic>?)
                ?.map(
                  (e) => e.toString(),
                )
                .toList() ??
            [];
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<List<String>> getResidentialPropertyTypes() async {
    try {
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/properties/residential",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        final decodedMessage = json.decode(response.body);
        return (decodedMessage['propertyTypes'] as List<dynamic>?)
                ?.map(
                  (e) => e.toString(),
                )
                .toList() ??
            [];
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<List<String>> getRetailPropertyTypes() async {
    try {
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/properties/retail",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        final decodedMessage = json.decode(response.body);
        return (decodedMessage['propertyTypes'] as List<dynamic>?)
                ?.map(
                  (e) => e.toString(),
                )
                .toList() ??
            [];
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<List<String>> getPropertyStatus() async {
    try {
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/properties/status",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        final decodedMessage = json.decode(response.body);
        return (decodedMessage['propertyStatus'] as List<dynamic>?)
                ?.map(
                  (e) => e.toString(),
                )
                .toList() ??
            [];
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<List<String>> getPropertyStyle() async {
    try {
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/properties/styles",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        final decodedMessage = json.decode(response.body);
        return (decodedMessage['propertyStyles'] as List<dynamic>?)
                ?.map(
                  (e) => e.toString(),
                )
                .toList() ??
            [];
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<List<String>> getPropertyCategories() async {
    try {
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/properties/categories",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        final decodedMessage = json.decode(response.body);
        return (decodedMessage['propertyTypes'] as List<dynamic>?)
                ?.map(
                  (e) => e.toString(),
                )
                .toList() ??
            [];
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<List<String>> getStates() async {
    try {
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/properties/states",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        final decodedMessage = json.decode(response.body);
        return (decodedMessage['stateType'] as List<dynamic>?)
                ?.map(
                  (e) => e.toString(),
                )
                .toList() ??
            [];
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  // Future<List<String>> getBookedProperty() async {
  //   try {
  //     final response = await http.get(
  //         Uri.http(
  //           requestSite,
  //           "/api/v1/owner/property/booked/all",
  //         ),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json;charset=UTF-8'
  //         });
  //     if (response.statusCode <= 299) {
  //       final decodedMessage = json.decode(response.body);
  //       return (decodedMessage['booked'] as List<dynamic>?)
  //               ?.map(
  //                 (e) => e.toString(),
  //               )
  //               .toList() ??
  //           [];
  //     } else {
  //       return Future.error(json.decode(response.body)['message'] ?? '');
  //     }
  //   } catch (exception) {
  //     return Future.error("Error occurred in communicating with the server");
  //   }
  // }
  Future<SearchModel> getBookedProperty() async {
    try {
      var response = await http.get(
        Uri.http(requestSite, "/api/v1/owner/property/booked/all",
            <String, String>{}),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      //log(response.body);
      if (response.statusCode <= 299) {
        return SearchModel.fromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  // getUserProfile() async {
  //   List incomingProfile = [''];
  //   print("${incomingProfile}");
  //   print("verify");
  //   try {
  //     var headers = {
  //       'Authorization':
  //           'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJyZXNhdmF0aW9uQGdtYWlsLmNvbSIsInJvbGUiOiJST0xFX1BST1BFUlRZX09XTkVSIiwiaWQiOiI1NyIsImZpcnN0bmFtZSI6IlN0ZXBoZW4iLCJsYXN0bmFtZSI6IkFkZXllbW8iLCJlbWFpbCI6InJlc2F2YXRpb25AZ21haWwuY29tIiwiaWF0IjoxNjU2Mzk3NzYxLCJleHAiOjE2ODc5Mzc3NjF9.nNEt9F5OBGUD4Y7uvof1MHnemQRA7FOHSFtHPY1daL8FUJOHClNZe_12pHBAOyKkBKrMDLRjJv1sr9UlLp3BHw'
  //     };
  //     var request = http.Request(
  //         'GET',
  //         Uri.parse(
  //             'https://resavation-backend.herokuapp.com/api/v1/user/profile'));
  //     request.body = '''''';
  //     request.headers.addAll(headers);

  //     http.StreamedResponse response = await request.send();

  //     if (response.statusCode == 200) {
  //       print(" respomse is ${await response.stream.bytesToString()}");

  //       incomingProfile =
  //           editProfileModelFromJson(await response.stream.bytesToString())
  //               .firstName! as List;
  //     } else {
  //       print(response.reasonPhrase);
  //     }
  //   } catch (exception) {
  //     return Future.error(
  //         "Error occurred in communicating wit the server: $exception");
  //   }
  // }

  Future<EditProfileModel> getUserProfile() async {
    try {
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/user/profile",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': userTypeService.authorization
        },
      );
      if (response.statusCode <= 299) {
        final decodedMessage = json.decode(response.body);
        print("resut ${decodedMessage}");
        return editProfileModelFromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error(exception.toString());
      // return Future.error("Error occurred in communicating with the server");
    }
  }
}
