import 'package:cpea/src/navigation/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';
import 'package:go_router/go_router.dart';
import '../../login_module.dart';

abstract class ILoginPage extends StatelessWidget {
  ILoginPage({Key? key}) : super(key: key);

  List<ProviderConfiguration> get providers => LoginModule.loginProviders;

  final List<FlutterFireUIAction> actions = [
    AuthStateChangeAction<SignedIn>((context, signedIn) {
      if (signedIn.user != null) context.go(Routes.home);
    }),
  ];
}
