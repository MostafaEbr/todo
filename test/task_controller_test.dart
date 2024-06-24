// test/task_controller_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:todo/domain/entities/task.dart';
import 'package:todo/domain/usecases/get_tasks.dart';
import 'package:todo/domain/usecases/save_tasks.dart';
import 'package:todo/presentation/controllers/task_controller.dart';

@GenerateNiceMocks([MockSpec<GetTasks>(), MockSpec<SaveTasks>()])
import 'task_controller_test.mocks.dart';

void main() {
  late TaskController controller;
  late MockGetTasks mockGetTasks;
  late MockSaveTasks mockSaveTasks;

  setUp(() {
    mockGetTasks = MockGetTasks();
    mockSaveTasks = MockSaveTasks();
    controller = TaskController(getTasks: mockGetTasks, saveTasks: mockSaveTasks);
  });

  test('initial load should get tasks', () async {
    when(mockGetTasks()).thenAnswer((_) async => [Task(title: 'Test Task')]);

    controller.onInit();

    await untilCalled(mockGetTasks());
    expect(controller.tasks.length, 1);
    expect(controller.tasks[0].title, 'Test Task');
    verify(mockGetTasks()).called(1);
  });

  test('add task should save tasks', () async {
    controller.newTaskTitle.value = 'New Task';
    controller.addTask();

    // Capture the argument passed to saveTasks
    final captured = verify(mockSaveTasks(captureAny)).captured.single;

    // Assert the tasks in the controller and those passed to saveTasks
    expect(controller.tasks.length, 1);
    expect(controller.tasks[0].title, 'New Task');
    expect(captured, isA<List<Task>>());
    expect((captured as List<Task>).length, 1);
    expect((captured as List<Task>)[0].title, 'New Task');
  });

  test('toggle task status should save tasks', () async {
    controller.tasks.add(Task(title: 'Test Task'));

    controller.toggleTaskStatus(0);

    final captured = verify(mockSaveTasks(captureAny)).captured.single;

    expect(controller.tasks[0].isCompleted, true);
    expect(captured, isA<List<Task>>());
    expect((captured as List<Task>)[0].isCompleted, true);
  });
}
