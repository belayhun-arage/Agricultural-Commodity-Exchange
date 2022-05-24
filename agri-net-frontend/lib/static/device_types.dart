import "dart:io" show Platform;
import "dart:ui" as ui;

import '../libs.dart';

enum DeviceType {
  Unknown,
  Phone,
  Tablet,
  Desktop,
}

// The Logic To Define The Device Type
DeviceType getDeviceType() {
  if (Platform.isAndroid || Platform.isIOS) {
    final double devicePixelRatio = ui.window.devicePixelRatio;
    final ui.Size size = ui.window.physicalSize;
    final double width = size.width;
    final double height = size.height;
    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      StaticDataStore.DType = DeviceType.Tablet;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      StaticDataStore.DType = DeviceType.Tablet;
    } else {
      StaticDataStore.DType = DeviceType.Phone;
    }
    return StaticDataStore.DType;
  } else if (Platform.isLinux) {
    StaticDataStore.DType = DeviceType.Desktop;
    return StaticDataStore.DType;
  } else if (Platform.isWindows) {
    StaticDataStore.DType = DeviceType.Desktop;
    return StaticDataStore.DType;
  }
  return DeviceType.Unknown;
}
