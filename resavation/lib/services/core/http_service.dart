import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:resavation/app/app.locator.dart';
import 'package:resavation/model/login_model.dart';
import 'package:resavation/model/owner_booked_property/owner_booked_property.dart';
import 'package:resavation/model/owner_property/owner_property.dart';
import 'package:resavation/model/propety_model/property_model.dart';
import 'package:resavation/model/registration_model.dart';
import 'package:resavation/model/saved_property/saved_property.dart';
import 'package:resavation/model/search_model/search_model.dart';
import 'package:resavation/model/tenant_booked_property/tenant_booked_property.dart';
import 'package:resavation/model/top_states_model/top_states_model.dart';
import 'package:resavation/services/core/upload_service.dart';
import 'package:resavation/services/core/user_type_service.dart';
import 'package:resavation/utility/app_preferences.dart';

import '../../model/edit_profile_model.dart';

import '../../model/filter.dart';
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
      final response = await http.post(
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
        AppPreferences.setRefeshTokenAndAccessRole(
          token: loginModel.refreshToken,
          accessRoles: loginModel.accessRoles,
          tokenType: loginModel.tokenType,
        );
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

  Future<String> refreshToken(String refershToken,
      [bool isUpdate = true]) async {
    try {
      final response = await http.post(
        Uri.http(requestSite, "api/v1/auth/refreshtoken"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(
          <String, dynamic>{
            "refreshToken": refershToken,
          },
        ),
      );

      if (response.statusCode <= 299) {
        final loginModel = loginFromRefreshToken(response.body);
        if (isUpdate) {
          userTypeService.updateUserData(loginModel);
        } else {
          userTypeService.setUserData(loginModel);
        }

        AppPreferences.setRefeshTokenAndAccessRole(
          token: loginModel.refreshToken,
          accessRoles: AppPreferences.getAccessRoles,
          tokenType: loginModel.tokenType,
        );
        return loginModel.accessToken;
      } else {
        return Future.error((json.decode(response.body)['message']) ??
            'Failed to refresh user session');
      }
    } catch (exception) {
      return Future.error("Failed to register user");
    }
  }

  editDetails({
    required String firstName,
    required String lastName,
    required String email,
    required String imageUrl,
    required String phoneNumber,
    required String gender,
    required DateTime dateOfBirth,
    required String country,
    required String state,
    required String city,
    required String address,
    required String postalCode,
    required String aboutMe,
    required String occupation,
  }) async {
    try {
      final authorization = await userTypeService.authorization();
      final response = await http.post(
        Uri.http(requestSite, "/api/v1/user/profile/update"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': authorization
        },
        body: jsonEncode(
          <String, dynamic>{
            "aboutMe": aboutMe,
            "address": address,
            "city": city,
            "country": country,
            "dateOfBirth": DateFormat('dd-MM-yyyy').format(dateOfBirth),
            "firstName": firstName,
            "gender": gender,
            "imageUrl": imageUrl,
            "lastName": lastName,
            "occupation": occupation,
            "phoneNumber": phoneNumber,
            "postalCode": postalCode,
            "state": state,
          },
        ),
      );

      if (response.statusCode <= 299) {
        final loginModel =
            loginFromOldModel(response.body, userTypeService.userData);
        AppPreferences.setRefeshTokenAndAccessRole(
          token: loginModel.refreshToken,
          accessRoles: loginModel.accessRoles,
          tokenType: loginModel.tokenType,
        );
        userTypeService.updateUserData(loginModel);
        return;
      } else {
        return Future.error((json.decode(response.body)['message']) ??
            'Failed to update profile');
      }
    } catch (exception) {
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
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(requestSite, "api/v1/user/property", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(requestSite, "api/v1/properties/filter", <String, String>{
          "category": category,
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(requestSite, "api/v1/properties/search", <String, String>{
          "key": state,
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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
      {required int userId, required int page, required int size}) async {
    try {
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(
            requestSite, "api/v1/user/property/owner/$userId", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(requestSite, "api/v1/properties/search", <String, String>{
          "key": text,
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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

  Future<OwnerPropertyModel> getOwnerProperty(
      {required int page, required int size}) async {
    try {
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(requestSite, "api/v1/owner/property/all", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
        },
      );

      if (response.statusCode <= 299) {
        return OwnerPropertyModel.fromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<String> verifiyPayment({
    required int propertyId,
    required String interval,
    required String reference,
  }) async {
    try {
      final authorization = await userTypeService.authorization();
      final response = await http.post(
        Uri.http(
          requestSite,
          "api/v1/payment/verify",
        ),
        body: jsonEncode(
          <String, dynamic>{
            "paymentInterval": interval,
            "propertyId": propertyId,
            "reference": reference,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
        },
      );

      if (response.statusCode <= 299) {
        return json.decode(response.body)['paymentStatus'] ?? '';
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
      final authorization = await userTypeService.authorization();
      final response = await http.post(
        Uri.http(
            requestSite, "/api/v1/properties/filter-property", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        body: filter.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(
          requestSite,
          "api/v1/properties/$id",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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
      final authorization = await userTypeService.authorization();
      final response = await http.post(
          Uri.http(requestSite, "api/v1/user/property/favourite/alter"),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
            'Authorization': authorization
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
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(requestSite,
            "api/v1/user/property/favourite/fetch", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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

  Future<TenantBookedProperty> getAllTenantsBookedProperty(
      {required int page, required int size}) async {
    try {
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(requestSite, "api/v1/user/property/booked", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
        },
      );
      debugPrint(response.body.toString());
      if (response.statusCode <= 299) {
        return TenantBookedProperty.fromJson(response.body);
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
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(
            requestSite, "api/v1/properties/top-categories", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(requestSite, "api/v1/properties/top-cities", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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

  uploadProperty({
    required UploadService uploadTypeService,
    required List<String> images,
  }) async {
    final body = <String, dynamic>{
      "propertyCategory": uploadTypeService.propertyCategory ?? '',
      "unit": uploadTypeService.unit,
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
            : 'Self Serviced',
        "propertyStatus": uploadTypeService.propertyStatus ?? '',
        "spacePrice": uploadTypeService.spacePrice ?? 0.0,
        "state": uploadTypeService.state ?? '',
        "subscription": {
          "annualPrice": uploadTypeService.annualPrice ?? 0.0,
          "biannualPrice": uploadTypeService.biannualPrice ?? 0.0,
          "monthlyPrice": uploadTypeService.monthlyPrice ?? 0.0,
          "quarterlyPrice": uploadTypeService.quarterlyPrice ?? 0.0
        },
        "surfaceArea": uploadTypeService.surfaceArea ?? 0,
        "unit": uploadTypeService.unit,
      }
    };
    debugPrint(jsonEncode(body));
    try {
      final authorization = await userTypeService.authorization();
      final response = await http.post(
          Uri.http(requestSite, "/api/v1/properties/upload"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': authorization
          },
          body: jsonEncode(body));
      debugPrint(response.request?.url.toString());
      debugPrint(response.body);
      if (response.statusCode == 200) {
        return;
      } else {
        return Future.error("Failed to upload property");
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  saveProperty({
    required UploadService uploadTypeService,
    required List<String> images,
  }) async {
    final body = <String, dynamic>{
      "propertyCategory": uploadTypeService.propertyCategory,
      "propertyDetails": {
        "address": uploadTypeService.address,
        "amenities": uploadTypeService.amenities,
        "availability": {
          "from": uploadTypeService.startDate != null
              ? DateFormat('dd-MM-yyyy').format(uploadTypeService.startDate!)
              : null,
          "to": uploadTypeService.endDate != null
              ? DateFormat('dd-MM-yyyy').format(uploadTypeService.endDate!)
              : null,
        },
        "bathTubCount": uploadTypeService.noOfBathroom,
        "bedroomCount": uploadTypeService.noOfBedroom,
        "carSlots": uploadTypeService.numberOfCarSLot,
        "city": uploadTypeService.city,
        "country": 'Nigeria',
        "description": uploadTypeService.propertyDescription,
        "imageUrl": images,
        "liveInSPace": uploadTypeService.liveInSpace,
        "propertyName": uploadTypeService.propertyName,
        "roomType": uploadTypeService.spaceType,
        "rules": uploadTypeService.rules,
        "spaceFurnished": uploadTypeService.isSpaceFurnished,
        "spaceServiced": uploadTypeService.isSpaceServiced,
        "commercialPropertyType": uploadTypeService.commercialPropertyType,
        "retailPropertyType": uploadTypeService.retailPropertyType,
        "industrialPropertyType": uploadTypeService.industrialPropertyType,
        "residentialPropertyType": uploadTypeService.residentialPropertyType,
        "propertyStyle": uploadTypeService.propertyStyle,
        "serviceType": uploadTypeService.isSpaceServiced == null
            ? null
            : (uploadTypeService.isSpaceServiced!)
                ? "Serviced"
                : 'Not Serviced',
        "propertyStatus": uploadTypeService.propertyStatus,
        "spacePrice": uploadTypeService.spacePrice,
        "state": uploadTypeService.state,
        "subscription": {
          "annualPrice": uploadTypeService.annualPrice,
          "biannualPrice": uploadTypeService.biannualPrice,
          "monthlyPrice": uploadTypeService.monthlyPrice,
          "quarterlyPrice": uploadTypeService.quarterlyPrice,
        },
        "surfaceArea": uploadTypeService.surfaceArea,
        "unit": uploadTypeService.unit,
      }
    };

    try {
      final authorization = await userTypeService.authorization();
      final response = await http.post(
          Uri.http(requestSite, "api/v1/properties/save"),
          headers: <String, String>{
            'Content-Type': 'application/json',
            'Authorization': authorization
          },
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        return;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  Future<SavedProperty> getSavedProperty() async {
    try {
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(
          requestSite,
          "api/v1/properties/saved_property",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
        },
      );

      if (response.statusCode <= 299) {
        return SavedProperty.fromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }

  bookProperty({
    required double amount,
    required int id,
    required String paymentCycle,
    required DateTime checkInDate,
  }) async {
    final body = <String, dynamic>{
      "amount": amount,
      "checkInDate": DateFormat('dd-MM-yyyy').format(checkInDate),
      "paymentCycle": paymentCycle,
      "propertyId": id
    };

    try {
      final authorization = await userTypeService.authorization();

      final response = await http.post(
        Uri.http(requestSite, "api/v1/user/property/book"),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': authorization
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
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/properties/commercial",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/properties/industrial",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/properties/residential",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/properties/retail",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/properties/status",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/properties/styles",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/properties/categories",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/properties/states",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
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
  Future<OwnerBookedProperty> getAllOwnerBookedProperty(
      {required int page, required int size}) async {
    try {
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(
            requestSite, "/api/v1/owner/property/booked/all", <String, String>{
          "page": page.toString(),
          "size": size.toString(),
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
        },
      );
      //log(response.body);
      if (response.statusCode <= 299) {
        return OwnerBookedProperty.fromJson(response.body);
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  acceptDeclineTeantRequest(
    bool accepted,
    int id,
  ) async {
    try {
      final authorization = await userTypeService.authorization();
      debugPrint(jsonEncode(<String, dynamic>{
        "accepted": accepted,
        "propertyId": id,
      }).toString());
      debugPrint(authorization);
      final response = await http.post(
        Uri.http(
          requestSite,
          "api/v1/owner/property/booked",
        ),
        body: jsonEncode(<String, dynamic>{
          "accepted": accepted,
          "propertyId": id,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
        },
      );
      debugPrint(response.body.toString());
      if (response.statusCode <= 299) {
        return;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  updatePropertyDescription({
    required Property property,
    required String description,
  }) async {
    try {
      final authorization = await userTypeService.authorization();
      final response = await http.put(
        Uri.http(
          requestSite,
          "api/v1/owner/property/update",
        ),
        body: jsonEncode(
          <String, dynamic>{
            "description": description,
            "price": property.spacePrice ?? 0.0,
            "propertyId": property.id ?? -1,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
        },
      );

      if (response.statusCode <= 299) {
        return;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  updatePropertyAmenities({
    required Property property,
    required List<String> amenities,
  }) async {
    try {
      final authorization = await userTypeService.authorization();

      final response = await http.put(
        Uri.http(
          requestSite,
          "api/v1/owner/property/update/amenity",
        ),
        body: jsonEncode(
          <String, dynamic>{
            "amenity": amenities,
            "propertyId": property.id ?? -1,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
        },
      );

      if (response.statusCode <= 299) {
        return;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  updatePropertyAvailiability({
    required Property property,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final authorization = await userTypeService.authorization();
      final response = await http.put(
        Uri.http(
          requestSite,
          "/api/v1/owner/property/update/availability",
        ),
        body: jsonEncode(
          <String, dynamic>{
            "from": DateFormat('dd-MM-yyyy').format(startDate),
            "to": DateFormat('dd-MM-yyyy').format(endDate),
            "propertyId": property.id ?? -1,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
        },
      );
      if (response.statusCode <= 299) {
        return;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  updatePropertyRules({
    required Property property,
    required List<String> rules,
  }) async {
    try {
      final authorization = await userTypeService.authorization();
      final response = await http.put(
        Uri.http(
          requestSite,
          "/api/v1/owner/property/update/rule",
        ),
        body: jsonEncode(
          <String, dynamic>{
            "propertyId": property.id ?? -1,
            "rule": rules,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
        },
      );
      if (response.statusCode <= 299) {
        return;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  updatePropertyImages({
    required Property property,
    required List<String> images,
  }) async {
    try {
      final authorization = await userTypeService.authorization();
      final response = await http.put(
        Uri.http(
          requestSite,
          "/api/v1/owner/property/update/image",
        ),
        body: jsonEncode(
          <String, dynamic>{
            "propertyId": property.id ?? -1,
            "images": images,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
        },
      );

      if (response.statusCode <= 299) {
        return;
      } else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      }
    } catch (exception) {
      return Future.error("Error occurred in communicating with the server");
    }
  }

  Future<EditProfileModel> getUserProfile() async {
    try {
      final authorization = await userTypeService.authorization();
      final response = await http.get(
        Uri.http(
          requestSite,
          "/api/v1/user/profile",
        ),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=UTF-8',
          'Authorization': authorization
        },
      );
      debugPrint(response.statusCode.toString());

      if (response.statusCode <= 299) {
        return editProfileModelFromJson(response.body);
      } else {
        return EditProfileModel();
      } /* else {
        return Future.error(json.decode(response.body)['message'] ?? '');
      } */
    } catch (exception) {
      return Future.error(exception);
    }
  }
}
