class Task {
  late int id;
  late String title;
  late String time;
  late String date;

  Task.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    title = json['title'];
    time = json['time'];
    date = json['date'];
  }
}
