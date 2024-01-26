import 'package:flutter/material.dart';

/**
 * Classe UIProvider és el provide rencarregat de gestionar que s'actualitzi correctament el menú inferior seleccionat
 */

///
class UIProvider extends ChangeNotifier {
  int _selectedMenuOpt = 1;

  int get selectedMenuOpt {
    return _selectedMenuOpt;
  }

  /**
   * Set encarregat de notificar el canvi quan s'ha de canviar de vista
   */

  ///
  set selectedMenuOpt(int index) {
    _selectedMenuOpt = index;
    notifyListeners();
  }
}
