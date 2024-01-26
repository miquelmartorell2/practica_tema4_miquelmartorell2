import 'package:flutter/material.dart';
import 'package:practica_tema4_miquelmartorell/providers/scan_list_provider.dart';
import 'package:practica_tema4_miquelmartorell/providers/ui_provider.dart';
import 'package:practica_tema4_miquelmartorell/screens/home_screen.dart';
import 'package:practica_tema4_miquelmartorell/screens/mapa_screen.dart';
import 'package:provider/provider.dart';

/**
 * Main s'encarrega de executar l'apliació, on s'inicialitzen els provider i te les fierents rutes i temes de l'aplicació
 */

///
void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UIProvider()),
      ChangeNotifierProvider(create: (_) => ScanListProvider())
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Reader',
      initialRoute: 'home',
      routes: {
        'home': (_) => const HomeScreen(),
        'mapa': (_) => const MapaScreen(),
      },
      theme: ThemeData(
        // No es pot emprar colorPrimary des de l'actualització de Flutter
        colorScheme: const ColorScheme.light().copyWith(
          primary: Colors.deepPurple,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
