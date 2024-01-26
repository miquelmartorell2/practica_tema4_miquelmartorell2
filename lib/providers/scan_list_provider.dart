import 'dart:async';

import 'package:flutter/material.dart';
import 'package:practica_tema4_miquelmartorell/models/scan_model.dart';
import 'providers.dart';

/**
 * Classe ScanListProvider s'encarrega de gestionar els escanejos que s'estan realitzant
 */

///
class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipusSeleccionat = 'http';

  /**
   * Métode nouScan rep per paramere un valor on primer de tot el que fa es crear l'objecte ScanModel corresponent y seguidamnet
   * crida a el métode insertScan del dbprovider per inserir  l'escaneig en la base de dades, finalment indorueix les dades dins la llista creada
   */

  ///
  Future<ScanModel> nouScan(String valor) async {
    final nouScan = ScanModel(valor: valor);
    final id = await DBProvider.db.insertScan(nouScan);
    nouScan.id = id;
    if (nouScan.tipus == tipusSeleccionat) {
      scans.add(nouScan);
      notifyListeners();
    }
    return nouScan;
  }

  /**
   * Métode carregaScans s'encarrega de executar el méotde getAllScans de DBProvider i assigna el resultat obtingunt
   * a l'array de scans
   */

  ///
  carregaScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

  /**
   * EXERCICI:
   *Métode carregaScansPerTipus s'encarrega de executar el métode getAllByTipus de dbprovider on amb el resultat carrega els scsn del tipus seleccionat
      també canvia el valor de tipusSeleccionat
   */

  ///
  carregaScansPerTipus(String tipus) async {
    final scans = await DBProvider.db.getAllByTipus(tipus);
    this.scans = [...scans];
    tipusSeleccionat = tipus;
    notifyListeners();
  }

  /**
   * Métode esborraTots s'encarrega de executar el métode deleteAllScans de DBProvider i de deixar el array de scans buit
   */

  ///
  esborraTots() async {
    // ignore: unused_local_variable
    final scans = await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  /**
   * Métode  esborraPerId rep un id per parametre, s'encarrega de executar el métode deleteScanById de DBProvider
   * on seguidament esborra de dins el array de scans el array amb  els id que li passem
   */

  ///
  esborraPerId(int id) async {
    // ignore: unused_local_variable
    final scans = await DBProvider.db.deleteScanById(id);
    this.scans.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
