import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/scan_model.dart';
export '../models/scan_model.dart';

class DBProvider {
  static Database? _database;

  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if( _database != null ) return _database!;

    _database = await initDB();

    return _database!;
  }

  Future<Database> initDB() async {
    // path de almacenamiento de la base de datos
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    final path = join( documentDirectory.path, 'ScanDB.db' );
    print(path);
    
    //crear base de datos
    /** Al cambiar el valor de version se fuerza a la nueva creacion de 
     * la base de datos en lugar de solo abrirla - hugo lizama
     */
    return await openDatabase(
      path, 
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          create table scans(
            id integer primary key,
            tipo text,
            valor text
          );
        ''');
      },
    ); 
  }

  Future<int> nuevoScanRaw( ScanModel nuevoScan ) async{

    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;

    // verificar que exista base de datos
    final db = await database;

    final res = await db.rawInsert('''
      insert into scans(id, tipo, valor) values(
        $id, '$tipo', '$valor'
      );
    ''');

    return res;
  }


  Future<int> nuevoScan( ScanModel nuevoScan) async{
    final db = await database;
    final res = await db.insert('scans', nuevoScan.toJson());

    // retorna el id del ultimo registro insertado
    return res;
  }


  Future<ScanModel?> getScanById (int id ) async {
    final db = await database;
    final res = await db.query('scans', 
      where: 'id = ?', 
      whereArgs: [ id ]
    );

    return res.isNotEmpty ? ScanModel.fromJson( res.first ) : null;
  }

  Future<List<ScanModel>> getTodosLosScans ( ) async {
    final db = await database;
    final res = await db.query('scans');

    return res.isNotEmpty ? 
            res.map( (s) => ScanModel.fromJson( s ) ).toList()   
            : [];
  }


  Future<List<ScanModel>> getScansPorTipo ( String tipo ) async {
    final db = await database;
    final res = await db.query('scans', where: 'tipo = ?', whereArgs: [ tipo ]);

    return res.isNotEmpty ? 
            res.map( (s) => ScanModel.fromJson( s ) ).toList()   
            : [];
  }


  Future<int> actualizarScan( ScanModel nuevoScan ) async{
    final db = await database;
    final res = await db.update('scans', nuevoScan.toJson() , where: 'id = ?', whereArgs: [nuevoScan.id]);

    return res;
  }


  Future<int> borrarScan( int id ) async {
    final db = await database;
    final res = await db.delete('scans', where: 'id = ?', whereArgs: [ id ]);
    return res;
  }


  Future<int> borrarTodosLosScans( ) async {
    final db = await database;
    final res = await db.delete('scans');
    return res;
  }


}