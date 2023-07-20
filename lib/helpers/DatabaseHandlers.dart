import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler
{


  Database? db;

  Future<Database> create_db() async
  {
    if(db!=null)
    {
      return db!;
    }
    else
    {
      Directory dir = await getApplicationDocumentsDirectory();
      String dbpath = join(dir.path,"review_db");
      var db = await openDatabase(dbpath,version: 1,onCreate: create_tables);
      return db!;
    }
  }

  create_tables(Database db,int version)
  {
    //create Table
    db.execute("create table review (rid integer primary key autoincrement,addtitle text,addreview text,addrating double)");
    print("Table Created");
  }


  Future<int> insertreview(addtitle,addreview,addrating) async
  {
    //create db
    var sdb = await create_db();
    var id = await sdb.rawInsert("insert into review (addtitle,addreview,addrating) values (?,?,?)",[addtitle,addreview,addrating]);
    return id;
  }

  Future<List> viewreview() async {
    var idb = await create_db();
    var data = await idb.rawQuery("select * from review");
    return data.toList();
  }

  }




