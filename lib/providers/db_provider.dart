import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:practica_tema4_miquelmartorell/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/**
 * La classe DBProvider s'encarregada de crear la base de dades si no esta creada i si ja esta creada permet realitzar una serie d'operacion
 * que estan definides
 */

///
class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    _database ??= await initDB();

    return _database!;
  }

  /**
   * Inicialitzacio de la base de dades on s'obre el path on s'ha de crear i seguidament amb openDatabase es realitza la operació de creacio de les
   * taules corresponents
   */

  ///
  Future<Database> initDB() async {
    //Obtenir path
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Scans.db');

    //Creació de la BBDD
    return openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('''
            CREATE TABLE Scans(
              id INTEGER PRIMARY KEY,
              tipus TEXT,
              valor TEXT
            )
          ''');
    });
  }

  /**
   * Métode inser insertRawScan rep per parametre un objecte ScanModel on fica tots esl valors correspoents dins una variable tipus final
   * i seguidament amb rewInsert realitza l'operació d'insert
   */

  ///
  Future<int> insertRawScan(ScanModel nouScan) async {
    final id = nouScan.id;
    final tipus = nouScan.tipus;
    final valor = nouScan.valor;

    final db = await database;

    final res = await db.rawInsert('''
        INSERT INTO Scans(id, tipus, valor)
          VALUES ($id, $tipus, $valor)
      ''');

    return res;
  }

  /**
   * Métode insertScan rep per parametre un objecte scan on amb l'operacio db.insert insereix dins la taula Scans
   * els valors de l'objecte pasat per parametre
   */

  ///
  Future<int> insertScan(ScanModel nouScan) async {
    final db = await database;

    final res = await db.insert('Scans', nouScan.toMap());

    return res;
  }

  /**
   * Métode getAllScans s'encarrega utilitzat db.query de la taula scans de retornar una llista amb tots els valors que conte la taula scans
   */

  ///
  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Scans');

    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

  /**
   * Méotde getScanById obé un id per parametre s'encarrega de realitzar una db.query de la tuala scans amb utilitzant un where amb arguments
   * finalment si el resultat  conte informacio retrorna el resultat
   */

  ///
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Scans', where: "id = ?", whereArgs: [id]);

    if (res.isNotEmpty) {
      return ScanModel.fromMap(res.first);
    }
    return null;
  }

  /**
   * EXERCICI
   * Métode getAllByTipus rep per parametre  un tipus i retorna tots els scans que tenen aquest tipus asignat, ho fa utilitzant un db.query amb arguments
   * finalment converteix el resultat en una llista
   */

  ///
  Future<List<ScanModel>> getAllByTipus(String tipus) async {
    final db = await database;
    final res = await db.query('Scans', where: "tipus = ?", whereArgs: [tipus]);

    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

  /**
   * Métode updateScan rep per paramete un objecte Scan on utilitzant sb.update a la tuala scans introdueix els nous valors
   * de l'objecte introduït per parametre sempre i quan es compleixi la condició
   */

  ///
  Future<int> updateScan(ScanModel nouScan) async {
    final db = await database;
    final res = db.update('Scans', nouScan.toMap(),
        where: "id = ?", whereArgs: [nouScan.id]);

    return res;
  }

  /**
   * Metode deleteAllScans s'encarrega d'eliminar toes les files de la taula scans utilitzant rawDelete
   */

  ///
  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete('''
      DELETE FROM Scans
    ''');

    return res;
  }

  /**
   * EXERCICI
   * Métode deleteScanById rep el id per parametre s'encarrega de realitzar un rawDelete  amb aquest id de menra que en aquest cas
   * només s'elimina la fila amb el id indicat
   */

  ///
  Future<int> deleteScanById(int id) async {
    final db = await database;
    final res = await db.rawDelete('''
    DELETE FROM Scans 
    WHERE id = $id
    ''');

    return res;
  }
}
