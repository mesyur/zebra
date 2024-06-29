import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:zebra/core/theme/decorations.dart';
import 'package:zebra/core/theme/size_extension.dart';
import 'package:zebra/core/theme/text_style_extension.dart';
import 'package:zebra/core/theme/theme_extension.dart';

class LoadingDialogView extends StatelessWidget {
  const LoadingDialogView({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: Decorations.pagePadding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SpinKitFadingCircle(
              size: 50.rh,
              itemBuilder: (_, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven
                        ? context.appColors.secondary
                        : context.appColors.gray2,
                  ),
                );
              },
            ),
            SizedBox(height: 24.rh),
            Text(
              'Loading...',
              style: context.appPrimaryTextTheme.bodyLarge.medium,
            ),
          ],
        ),
      ),
    );
  }
}
