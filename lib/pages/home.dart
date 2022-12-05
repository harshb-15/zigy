import 'package:flutter/material.dart';
import 'package:zigy/models/user_model.dart';
import 'package:zigy/services/api_service.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(onPressed: (){
            Navigator.pushNamed(context, '/addUser');
          }, icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: FutureBuilder<List<User>?>(
            future: ApiService().getUsers(),
            builder:
                (BuildContext context, AsyncSnapshot<List<User>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                if (snapshot.data == null) {
                  return const Text("Error");
                } else {
                  return GridView.builder(
                      // padding: EdgeInsets.all(10),
                      itemCount: snapshot.data!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: Colors.white),
                          ),
                          // margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                  "${snapshot.data![index].first_name!} ${snapshot.data![index].last_name!}"),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(snapshot.data![index].email!),
                              const SizedBox(
                                height: 5,
                              ),
                              Image.network(snapshot.data![index].avatar!),
                            ],
                          ),
                        );
                      });
                }
              } else if (snapshot.hasError) {
                return const Text("Error");
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
