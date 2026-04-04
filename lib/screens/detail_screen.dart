import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/student_service.dart';

class DetailScreen extends StatefulWidget {
  final SinhVien sinhvien;

  DetailScreen({required this.sinhvien});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final StudentService service = StudentService();
  late TextEditingController name;
  late TextEditingController email;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text: widget.sinhvien.name);
    email = TextEditingController(text: widget.sinhvien.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Thông tin chi tiết sinh viên")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: InputDecoration(labelText: "Tên"),
            ),
            TextField(
              controller: email,
              decoration: InputDecoration(labelText: "Email"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              minimumSize: Size(100, 40),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              "Hủy", 
              style: TextStyle(fontSize: 20),
              ),
          ),
          SizedBox(width: 8),
          ElevatedButton(
            onPressed: () async{
              await service.updateStudent(
                SinhVien(
                  id: widget.sinhvien.id,
                  name: name.text,
                  email: email.text),
              );
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              minimumSize: Size(100, 40),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text("Lưu", style: TextStyle(fontSize: 20)),
          ),
        ],
        )
      ),
    );
  }
}