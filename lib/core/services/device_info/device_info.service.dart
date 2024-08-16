import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'package:zebra/core/services/api/api_service.dart';
import 'package:zebra/core/services/api/dto/device_register_request_dto.dart';

class DeviceInfoService extends GetxService {
  final _apiService = Get.find<ApiService>();

  Future<DeviceInfoService> init() async {
    await initDeviceInfo();
    return this;
  }

  late IosDeviceInfo? iosDeviceInfo;
  late AndroidDeviceInfo? androidDeviceInfo;

  Future<void> initDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (GetPlatform.isIOS) {
      iosDeviceInfo = await deviceInfoPlugin.iosInfo;
      /*  deviceName = iosDeviceInfo.name;
      deviceModel = iosDeviceInfo.model;
      systemName = iosDeviceInfo.systemName;
      systemVersion = iosDeviceInfo.systemVersion; */
    } else if (GetPlatform.isAndroid) {
      androidDeviceInfo = await deviceInfoPlugin.androidInfo;
      /* deviceName = androidDeviceInfo.brand;
      deviceModel = androidDeviceInfo.model;
      systemName = androidDeviceInfo.product;
      systemVersion = androidDeviceInfo.version.release; */
    }
  }

  registerDevice() async {
    if (GetPlatform.isIOS) {
      await _apiService.deviceRegister(
        DeviceRegisterRequestDto(
          os: iosDeviceInfo!.systemVersion,
          userId: '',
          fcmToken: '',
          model: '',
          brand: '',
        ),
      );
    } else if (GetPlatform.isAndroid) {
      await _apiService.deviceRegister(
        DeviceRegisterRequestDto(
          userId: '',
          fcmToken: '',
          model: '',
          os: androidDeviceInfo!.version.release,
          brand: '',
        ),
      );
    }
  }
}
