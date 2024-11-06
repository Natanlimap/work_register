import 'package:flutter/material.dart';
import 'package:work_register/work_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final WorkController workController = WorkController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Registro de trabalho'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Form(
              child: ValueListenableBuilder(
                  valueListenable: workController.isReporting,
                  builder: (context, isReporting, _) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Adicionar registro',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: workController.activityController,
                          decoration: InputDecoration(
                            labelText: 'Qual o nome da atividade?',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        ButtonBar(
                          alignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                workController.addActivity();
                              },
                              child: Text('Adicionar'),
                            ),
                          ],
                        ),

                        ValueListenableBuilder(
                          valueListenable: workController.activities,
                          builder: (_, activities, __) {
                            return ListView.builder(
                              shrinkWrap: true,
                              reverse: true,
                              itemCount: activities.length,
                              itemBuilder: (_, index) {
                                final activity = activities[index];

                                if (index == activities.length - 1) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 16),
                                        child: Text(
                                          '${activity.time.day.toString().padLeft(2, '0')}/${activity.time.month.toString().padLeft(2, '0')}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      InkWell(
                                        onLongPress: () {
                                          workController
                                              .deleteActivity(activity);
                                        },
                                        child: ListTile(
                                          subtitle: Text(
                                            '${activity.time.hour}:${activity.time.minute}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                          title: Text(
                                            activity.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }

                                return InkWell(
                                  onLongPress: () {
                                    workController.deleteActivity(activity);
                                  },
                                  child: ListTile(
                                    subtitle: Text(
                                      '${activity.time.hour}:${activity.time.minute} - ${activity.durationTime(activities.elementAtOrNull(index + 1))}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    title: Text(
                                      activity.name,
                                      style:
                                          Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                        // ListTile(
                        //   subtitle: Text(
                        //     'Hoje - 10:50',
                        //     style: Theme.of(context).textTheme.bodyMedium,
                        //   ),
                        //   title: Text(
                        //     'Terminei de refatorar a tela de biometria do fluxo de troca de device',
                        //     style: Theme.of(context).textTheme.bodyLarge,
                        //   ),
                        // ),
                      ],
                    );
                  }),
            ),
          ),
        ),
      ),
    );
  }
}
