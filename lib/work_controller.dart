import 'package:flutter/material.dart';
import 'package:work_register/activity.dart';
import 'package:work_register/objectbox.g.dart';

class WorkController {
  WorkController() {
    getActivities();
  }
  ValueNotifier<List<Activity>> activities = ValueNotifier([]);
  TextEditingController activityController = TextEditingController();

  List<Activity> get orderedActivities =>
      activities.value..sort((a, b) => b.time.compareTo(a.time));
  addActivity() {
    print('Adicionando atividade: ${activityController.text}');

    final activity = Activity(
      name: activityController.text,
      time: DateTime.now(),
    );
    activities.value = List.from(activities.value..add(activity));

    activityController.clear();
    saveActivity(activity);
  }

  Future<void> getActivities() async {
    final Store store =
        await openStore(macosApplicationGroup: 'activities.demo');
    final box = store.box<Activity>();

    activities.value = box.getAll();
    store.close();
  }

  saveActivity(Activity a) async {
    final Store store =
        await openStore(macosApplicationGroup: 'activities.demo');
    final box = store.box<Activity>();

    box.put(a);
    store.close();
  }

  deleteActivity(Activity a) async {
    final Store store =
        await openStore(macosApplicationGroup: 'activities.demo');
    final box = store.box<Activity>();

    box.remove(a.id);
    activities.value = List.from(activities.value..remove(a));
    store.close();
  }

  ValueNotifier<bool> isReporting = ValueNotifier(false);
}
