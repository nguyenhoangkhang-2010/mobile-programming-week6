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

  void showEditDialog(SinhVien s) {
  TextEditingController name = TextEditingController(text: s.name);
  TextEditingController email = TextEditingController(text: s.email);

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("Cập nhật sinh viên"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
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
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Hủy"),
        ),

        ElevatedButton(
          onPressed: () async {
            await services.updateStudent(
              SinhVien(
                id: s.id,
                name: name.text,
                email: email.text,
              ),
            );

            Navigator.pop(context);
            loadData();
          },
          child: Text("Cập nhật"),
        ),
      ],
    ),
  );
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2)
                  )
                ]
              ),
              child:  ListTile(
              leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/logo.png'),
              ),
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
                showEditDialog(s);
              },
            )
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(onPressed: showAddDialog, child: Icon(Icons.add),),
    );
  }
}