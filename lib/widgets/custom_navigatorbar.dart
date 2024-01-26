import 'package:flutter/material.dart';
import 'package:practica_tema4_miquelmartorell/providers/ui_provider.dart';
import 'package:provider/provider.dart';

/**
 * La classe CustomNavigationBar es l'encarregada de gestionar el BottomNavigationBar on conté dos BottomNavigationBarItem un per als mapes i
 * l'altre per a les webs on dpenent de quin es pitji accedint al UIProvider s'actualitza el valor del menu seleccionat utlitzant selectedMenuOpt
 */

///
class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
        onTap: (int i) => uiProvider.selectedMenuOpt = i,
        elevation: 0,
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration),
            label: 'Direccions',
          )
        ]);
  }
}
