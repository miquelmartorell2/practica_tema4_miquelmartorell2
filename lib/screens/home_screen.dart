import 'package:flutter/material.dart';
import 'package:practica_tema4_miquelmartorell/providers/scan_list_provider.dart';
import 'package:practica_tema4_miquelmartorell/providers/ui_provider.dart';
import 'package:practica_tema4_miquelmartorell/screens/screens.dart';
import 'package:practica_tema4_miquelmartorell/widgets/widgets.dart';
import 'package:provider/provider.dart';

/**
 * La classe HomeScreen es la pantalla principal la qual conte un appBar amb el nom Historial i un icone de paparera, que quan es pitja
 * executa el metode esborraTots del provider ScanListProviderdinalment conte un body una barra inferio i un botó centrat a la part inferior
 */

///
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false)
                  .esborraTots();
            },
          )
        ],
      ),
      body: const _HomeScreenBody(),
      bottomNavigationBar: const CustomNavigationBar(),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

/**
 * La classe _HomeScreenBody gestionja  el contingut de la pantalla d'inici. De manera que inicialita el provider UIProvider
 * on realitza selectedMenuOpt del provider per obenir el index seleccionat on seguidament amb un switch s'obri la pagina corresponent depenent del botó utilitzat
 */

///
class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.carregaScansPerTipus('geo');
        return const MapasScreen();

      case 1:
        scanListProvider.carregaScansPerTipus('http');
        return const DireccionsScreen();

      default:
        scanListProvider.carregaScansPerTipus('geo');
        return const MapasScreen();
    }
  }
}
