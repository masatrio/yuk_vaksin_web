import 'package:flutter/material.dart';
import 'package:yuk_vaksin_web/core/base_color.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: blue,
      strokeWidth: 2,
    );
  }
}
