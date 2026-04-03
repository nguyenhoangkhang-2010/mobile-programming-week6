import 'package:flutter/material.dart';
import '../models/student.dart';
import '../services/student_service.dart';
import '../screens/detail_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StudentService services = StudentService();
  List<SinhVien> sinhvien = []; 

  @override
  void initState(){
    super.initState();
    loadData();
  }

  void loadData() async{
    sinhvien = await services.getStudents();
    setState(() {});
  }

  void showAddDialog(){
    TextEditingController name = TextEditingController();
    TextEditingController email = TextEditingController();

    showDialog(
      context: context, 
      builder: (_) => AlertDialog(
        title: Text("Thêm sinh viên"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: name, decoration: InputDecoration(labelText: "Tên")),
            TextField(controller: email, decoration: InputDecoration(labelText: "email")),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: Text("Hủy"),
            ),
          ElevatedButton(
            onPressed: () async{
              await services.addStudent(
                SinhVien(name: name.text, email: email.text)
              );
              Navigator.pop(context);
              loadData();
            }, 
            child: Text("Lưu")
          )
        ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý sinh viên"),
      ),
      body: ListView.builder(
        itemCount: sinhvien.length,
        itemBuilder: (_, i){
          final s = sinhvien[i];
          return ListTile(
            title: Text(s.name),
            subtitle: Text(s.email),
            trailing: IconButton(
              onPressed: () async{
                await services.deleteStudent(s.id!);
                loadData();
              }, 
              icon: Icon(Icons.delete, color: Colors.red,),
            ),
            onTap: (){
              Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (_) => DetailScreen(sinhvien: s),
                ),
              ).then((_) => loadData());
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(onPressed: showAddDialog, child: Icon(Icons.add),),
    );
  }
}