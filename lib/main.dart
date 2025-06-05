import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:tambay/provider/cart_provider.dart';
import 'package:tambay/provider/products_provider.dart';
import 'package:tambay/screens/cart_screen.dart';
import 'package:tambay/screens/home_screen.dart';
import 'package:tambay/screens/search_screen.dart';
// import 'package:tambay/screens/sp_test.dart';
// import 'package:tambay/screens/specific_screen.dart';
// import 'package:tambay/screens/test_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(
    MultiProvider(
      // do not call provider functions in runapp
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      routes: {
        // '/': (context) => const SPTest(),
        '/': (context) => const HomeScreen(),
        '/cart': (context) => const CartScreen(),
        '/search': (context) => const SearchScreen(),
      },
      onGenerateRoute: (settings) {
        // if (settings.name != null && settings.name!.startsWith('/specific/')) {
        //   final id = int.tryParse(settings.name!.split('/').last);
        //   if (id != null) {
        //     return MaterialPageRoute(
        //       builder: (context) => SpecificScreen(id: id),
        //     );
        //   }
        // }
        return null;
      },
    );
  }
}
