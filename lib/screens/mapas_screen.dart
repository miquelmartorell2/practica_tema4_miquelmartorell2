import 'package:flutter/material.dart';
import 'package:practica_tema4_miquelmartorell/widgets/scan_tiles.dart';

/**
 * Classe MapasScreen s'encarrega de inicialitzar ScanTiles de tipus "geo"
 */

///
class MapasScreen extends StatelessWidget {
  const MapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: ScanTiles(
      tipus: 'geo',
    ));
  }
}
