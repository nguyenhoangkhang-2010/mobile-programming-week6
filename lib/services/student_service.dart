import 'package:app_week_6/database/db_helper.dart';
import 'package:app_week_6/models/student.dart';

class StudentService {
  final DataBaseHelper _dbHelper = DataBaseHelper();

  Future<List<SinhVien>> getStudents() async{
    final db = await _dbHelper.database;
    final res = await db.query('sinhviens');
    return res.map((e) => SinhVien.fromMap(e)).toList();
  }
  Future<void> addStudent(SinhVien s) async{
    final db = await _dbHelper.database;
    await db.insert('sinhviens', s.toMap());
  }
  Future<void> deleteStudent (int id) async{
    final db = await _dbHelper.database;
    await db.delete('sinhviens', where: 'id=?', whereArgs: [id]);
  }

  Future<void> updateStudent(SinhVien s) async{
    final db = await _dbHelper.database;
    await db.update(
      'sinhviens', 
      s.toMap(),
      where: 'id=?',
      whereArgs: [s.id],
    );
  }
}