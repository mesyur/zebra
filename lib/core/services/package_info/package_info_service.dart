import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:zebra/core/routes/app_pages.dart';
import 'package:zebra/core/services/formatter/formatter.dart';
import 'package:zebra/core/services/remote_config/remote_config_service.dart';

class PackageInfoService extends GetxService {
  final _remoteConfigService = Get.find<RemoteConfigService>();
  late final PackageInfo _packageInfo;

  bool isAvailableUpdate = false;
  bool isForceUpdate = false;

  String get appName => _packageInfo.appName;
  String get packageName => _packageInfo.packageName;
  String get version => _packageInfo.version;
  String get buildNumber => _packageInfo.buildNumber;

  Future<PackageInfoService> init() async {
    await initialize();
    checkVersion();
    return this;
  }

  Future<void> initialize() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  void checkVersion() {
    final remoteVersion = Formatter.versionToNumber(
        _remoteConfigService.appVersionConfig.version);
    final remoteMinVersion = Formatter.versionToNumber(
        _remoteConfigService.appVersionConfig.minVersion);
    final localVersion = Formatter.versionToNumber("$version+$buildNumber");

    if (localVersion < remoteMinVersion) {
      isForceUpdate = true;
      isAvailableUpdate = true;
      AppPages.updateInitial(Routes.forceUpdate);
    } else if (localVersion < remoteVersion) {
      isAvailableUpdate = true;
      isForceUpdate = false;
    }
  }

  void showUpdateDialog() {
    if (isForceUpdate) {
      Get.offAllNamed(Routes.forceUpdate);
      return;
    }

    if (isAvailableUpdate) {
/*       Get.customBottomSheet(
        const AvailableUpdateBottomSheet(),
      ); */

      return;
    }
  }

  void openStore() {
    /*  StoreRedirect.redirect(
      androidAppId: StoreConstants.androidAppId,
      iOSAppId: StoreConstants.iOSAppId,
    ); */
  }
}
