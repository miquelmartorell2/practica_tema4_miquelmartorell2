import 'package:flutter/material.dart';
import 'package:practica_tema4_miquelmartorell/models/scan_model.dart';
import 'package:practica_tema4_miquelmartorell/providers/scan_list_provider.dart';
import 'package:practica_tema4_miquelmartorell/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

/**
 * Classe ScanButton encarregada de gestionar el botó per a escanejar els codis, de manera que conté un boto que exceuta el métode _scanner
 */

///
class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      child: const Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        _scanner(context);
      },
    );
  }

  /**
   * El _metode _scanner s'encarrega d'obrir la camera i obtenir l'esaneig del codi utlitzant el widget FlutterBarcodeScanner
   * també realitza un comprovacio de si e lvalor escanejat es correcte, es a dir si es geo ,http, o https si ho es es crea l'objecte Scanmodel
   * i s'executen els métodes scanListProvider de ScanListProvider i el métode launchURL, si el codi non es correcte ho indica per terminal
   */

  ///
  void _scanner(context) async {
    String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#3D8BEF', 'Cancel·lar', false, ScanMode.QR);

    if (barcodeScanRes.startsWith('geo') ||
        barcodeScanRes.startsWith('http') ||
        barcodeScanRes.startsWith('https')) {
      final scanListProvider =
          Provider.of<ScanListProvider>(context, listen: false);
      ScanModel nouScan = ScanModel(valor: barcodeScanRes);
      scanListProvider.nouScan(barcodeScanRes);
      launchURL(context, nouScan);
    } else {
      // ignore: avoid_print
      print(
          'El código de barras no comienza con "geo", "http" o "https". No se guardará.');
    }
  }
}
