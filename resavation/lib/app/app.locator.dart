// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

import '../services/core/custom_snackbar_service.dart';
import '../services/core/http_service.dart';
import '../services/core/image_picker_service.dart';
import '../services/core/upload_type_service.dart';
import '../services/core/user_type_service.dart';

final locator = StackedLocator.instance;

void setupLocator({String? environment, EnvironmentFilter? environmentFilter}) {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => HttpService());
  locator.registerLazySingleton(() => UploadTypeService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => CustomSnackbarService());
  locator.registerLazySingleton(() => UserTypeService());
  locator.registerLazySingleton(() => ImagePickerService());
}
