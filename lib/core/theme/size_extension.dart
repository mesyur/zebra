import 'package:flutter_screenutil/flutter_screenutil.dart';

extension CustomSizeExtension on num {
  double get rh => ((this / 896)).sh;

  double get rw => ((this / 414)).sw;
}
