class AttendanceItem {
  final String id;
  final String userName;
  final String subject;
  final String status;
  final String date;

  AttendanceItem({
    required this.id,
    required this.userName,
    required this.subject,
    required this.status,
    required this.date,
  });

  factory AttendanceItem.fromJson(Map<String, dynamic> json) {
    return AttendanceItem(
      id: json['id'].toString(),
      userName: json['user_name'],
      subject: json['subject'],
      status: json['status'],
      date: json['attendance_date'],
    );
  }
}