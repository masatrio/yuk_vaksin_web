import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  static const routeName = '/dashboard';

  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint('CALLED');
    return const Center(
      child: Text('DASHBOARD'),
    );
  }
}
