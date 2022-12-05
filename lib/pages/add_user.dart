import 'package:flutter/material.dart';
import 'package:zigy/services/api_service.dart';
import 'package:zigy/models/user_model.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Name :- ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: width * 0.7,
                  child: TextField(
                    controller: nameController,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Job :- ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: width * 0.7,
                  child: TextField(
                    controller: jobController,
                  ),
                ),
              ],
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          insetPadding: const EdgeInsets.symmetric(vertical: 100),
                          content: FutureBuilder<List<String>?>(
                            future: ApiService().addUser(
                                nameController.text, jobController.text),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<String>?> snapshot) {
                              if (snapshot.connectionState ==
                                      ConnectionState.done &&
                                  snapshot.hasData) {
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text("User Created Successfully"),
                                    Text("Id: ${snapshot.data![2]}"),
                                    Text("Name: ${snapshot.data![0]}"),
                                    Text("Job: ${snapshot.data![1]}"),
                                  ],
                                );
                              } else if (snapshot.hasError) {
                                return const Text("Unknown Error");
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            },
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                nameController.clear();
                                jobController.clear();
                              },
                              child: const Text('Close'),
                            ),
                          ],
                        );
                      });
                },
                child: const Text("Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
