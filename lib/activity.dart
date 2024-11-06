import 'package:objectbox/objectbox.dart';

@Entity()
class Activity {
  @Id()
  int id;
  String name;
  DateTime time;

  Activity({
    this.id = 0,
    required this.name,
    required this.time,
  });

  String durationTime(Activity? next) {
    if (next == null) {
      return 'Em progresso ou última atividade';
    }

    final difference = next.time.difference(time);
    final hours = difference.inHours;
    final minutes = difference.inMinutes.remainder(60);
    final seconds = difference.inSeconds.remainder(60);
    return '${hours}h ${minutes}m ${seconds}s';
  }
}
