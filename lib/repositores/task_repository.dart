import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive/hive.dart';
import 'task.dart';

class TaskRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Box<Task> _taskBox;

  TaskRepository(this._taskBox);

  Future<void> syncWithFirebase() async {
    final snapshot = await _firestore.collection('tasks').get();
    for (var doc in snapshot.docs) {
      final task = Task.fromJson(doc.data());
      _taskBox.put(task.id, task); // Salva no Hive
    }
  }

  Future<void> addTask(Task task) async {
    await _firestore.collection('tasks').doc(task.id).set(task.toJson());
    _taskBox.put(task.id, task); // Salva no Hive
  }
}
