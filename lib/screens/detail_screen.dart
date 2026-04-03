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
      appBar: AppBar(title: Text("Chi tiết sinh viên")),
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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await service.updateStudent(
                  SinhVien(
                    id: widget.sinhvien.id,
                    name: name.text,
                    email: email.text,
                  ),
                );
                Navigator.pop(context);
              },
              child: Text("Cập nhật"),
            )
          ],
        ),
      ),
    );
  }
}