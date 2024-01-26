import 'package:flutter/material.dart';
import 'package:practica_tema4_miquelmartorell/providers/scan_list_provider.dart';
import 'package:practica_tema4_miquelmartorell/utils/utils.dart';
import 'package:provider/provider.dart';

/**
 * El métode scantiles s'encarrega de mostrar els valors que conte la base de dades segons el seu tipus
 * de forma que quan es crida requereix indicar el tipus que el crida.
 * Retorna un ListView.builder que s'encarrega de posar cada un al seu lloc correspoent així com aplicarli la funcio onDimissed i onTap
 */

///
class ScanTiles extends StatelessWidget {
  final String tipus;

  const ScanTiles({super.key, required this.tipus});

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
      itemCount: scans.length,
      itemBuilder: (_, index) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.delete_forever),
            ),
          ),
        ),
        onDismissed: (DismissDirection direccio) {
          Provider.of<ScanListProvider>(context, listen: false)
              .esborraPerId(scans[index].id!);
        },
        child: ListTile(
          leading: Icon(
            tipus == 'http' ? Icons.home_outlined : Icons.map_outlined,
            color: Theme.of(context).primaryColor,
          ),
          title: Text(scans[index].valor),
          subtitle: Text(scans[index].id.toString()),
          trailing: const Icon(
            Icons.keyboard_arrow_right,
            color: Colors.grey,
          ),
          onTap: () {
            launchURL(context, scans[index]);
          },
        ),
      ),
    );
  }
}
