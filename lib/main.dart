import 'package:shared_preferences/shared_preferences.dart';
import 'package:impactagent/integrations/supabase_service.dart';
import 'package:nowa_runtime/nowa_runtime.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:impactagent/globals/app_state.dart';
import 'package:impactagent/pages/login_page.dart';
import 'package:impactagent/pages/signup_page.dart';

@NowaGenerated()
late final SharedPreferences sharedPrefs;

@NowaGenerated()
main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPrefs = await SharedPreferences.getInstance();
  await SupabaseService().initialize();
  runApp(const MyApp());
}

@NowaGenerated({'visibleInNowa': false})
class MyApp extends StatelessWidget {
  @NowaGenerated({'loader': 'auto-constructor'})
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (context) => AppState(),
      builder: (context, child) => MaterialApp(
        theme: AppState.of(context).theme,
        initialRoute: 'LoginPage',
        routes: {
          'LoginPage': (context) => const LoginPage(),
          'SignupPage': (context) => const SignupPage(),
        },
      ),
    );
  }
}
