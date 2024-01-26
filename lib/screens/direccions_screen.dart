import 'package:flutter/material.dart';
import 'package:practica_tema4_miquelmartorell/widgets/scan_tiles.dart';

/**
 * Classe DireccionsScreen s'encarrega de inicialitzar ScanTiles de tipus "http"
 */

///
class DireccionsScreen extends StatelessWidget {
  const DireccionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ScanTiles(tipus: "http"),
    );
  }
}
