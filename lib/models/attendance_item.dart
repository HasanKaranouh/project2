class AttendanceItem {
  int? id;
  String userName;
  String subject;
  String status;
  String attendanceDate;

  AttendanceItem({
    this.id,
    required this.userName,
    required this.subject,
    required this.status,
    required this.attendanceDate,
  });

  // Convert to Map for sending to API (if needed)
  Map<String, String> toMap() {
    return {
      'user_name': userName,
      'subject': subject,
      'status': status,
    };
  }

  // Factory to create AttendanceItem from JSON
  factory AttendanceItem.fromJson(Map<String, dynamic> json) {
    return AttendanceItem(
      id: int.tryParse(json['id'].toString()),
      userName: json['user_name'] ?? '',
      subject: json['subject'] ?? '',
      status: json['status'] ?? '',
      attendanceDate: json['attendance_date'] ?? '',
    );
  }
}
