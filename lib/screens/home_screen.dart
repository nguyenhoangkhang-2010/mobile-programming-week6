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
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}