

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
   TextEditingController _updateController = TextEditingController();

  Box? myBox;

  @override
  void initState() {
    myBox = Hive.box("mylist");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("Local DB with Hive"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                var contact = _controller.text;
                myBox!.add(contact);
              },
              child: Text("Add Data")),
          Expanded(
              child: ValueListenableBuilder(
            valueListenable: Hive.box("mylist").listenable(),
            builder: (context, box, widget) {
              return ListView.builder(
                  itemCount: myBox!.keys.toList().length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5,vertical:3,),
                      child: Card(
                        color: Colors.white12,
                        child: ListTile(
                          title: Text(myBox!.getAt(index).toString()),
                          trailing: Container(
                            width: 120,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: (() {
                                      showDialog(
                                          context: (context),
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.teal,
                                              
                                              content: Column(
                                                
                                                children: [
                                                  TextField(
                                                    controller: _updateController,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20))),
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        myBox!.putAt(index, _updateController.text);
                                                      },
                                                      child: Text("Update")),
                                                ],
                                              ),
                                            );
                                          });
                                    }),
                                    icon: Icon(Icons.edit)),
                                IconButton(
                                    onPressed: (() {
                                      myBox!.delete(index);
                                    }), icon: Icon(Icons.delete))
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }));
            },
          ))
        ],
      ),
    );
  }
}
