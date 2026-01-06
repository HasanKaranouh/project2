import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'add_notice_screen.dart';

class HomeScreen extends StatefulWidget {
  final String userName;
  const HomeScreen({super.key, required this.userName});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List notices = [];

  @override
  void initState() {
    super.initState();
    fetchNotices();
  }

  void fetchNotices() async {
    final data = await ApiService.getNotices();
    setState(() {
      notices = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Campus Notice Board")),
      body: ListView.builder(
        itemCount: notices.length,
        itemBuilder: (context, index) {
          final notice = notices[index];
          return ListTile(
            title: Text(notice['user_name']),
            subtitle: Text(notice['content']),
            trailing: Text(notice['created_at'] ?? ''),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddNoticeScreen(userName: widget.userName),
            ),
          );
          fetchNotices(); // refresh after adding
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
