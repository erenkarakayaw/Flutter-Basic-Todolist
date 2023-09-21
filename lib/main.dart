import 'package:flutter/material.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeKismi()
    );
  }
}

class HomeKismi extends StatefulWidget {

  const HomeKismi({Key? key}) : super(key: key);

  @override
  State<HomeKismi> createState() => _HomeKismiState();

}

class _HomeKismiState extends State<HomeKismi> {

  var kelime = "";

  var todos = [
    {
      "isFinished" : false,
      "name" : "Ders Calis"
    },
    {
      "isFinished" : true,
      "name" : "Flutter Calis"
    }
  ];

  void _CheckBoxTodos(index) {
    setState(() {
      var bl = todos[index]["isFinished"];
      todos[index]["isFinished"] = !bool.parse(bl.toString());
    });
  }

  void _deleteTodos(index) {
    setState(() {
      todos.removeAt(index);
    });
  }

   TextStyle _analyzeFinish(isfinished){
    if (isfinished) {
      return TextStyle(
        decoration: TextDecoration.lineThrough,
            color: Colors.green
      );
    }
    else {
      return TextStyle(
        decoration: TextDecoration.none
      );
    }
   }

   void _AddTodo() {
    setState(() {
      todos.add(
        {
          "isFinished" : false,
          "name" : kelime.toString().trim()
        }

      );
      kelime = "";
    });
   }

   void _updateText(text)
   {
     setState(() {
       kelime = text.toString();
     });
   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
        title: Text("Todo List"),
        titleTextStyle: TextStyle(fontWeight: FontWeight.w100, fontSize: 29),
      ),
        body:
          Center(
            child:
              ListView.builder(
                itemCount: todos.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: IconButton(
                      icon: Icon(Icons.remove_circle,color: Colors.red),
                      onPressed: () => {
                        _deleteTodos(index)
                      },
                      color: Colors.red,
                    ),
                     trailing: Checkbox(
                       onChanged: (val) => {
                         _CheckBoxTodos(index),
                         val = bool.parse(todos[index]["isFinished"].toString())
                       },
                       value: bool.parse(todos[index]["isFinished"].toString()),
                     ),
                     title : Text(todos[index]["name"].toString()),
                     titleTextStyle: _analyzeFinish(todos[index]["isFinished"]),
                     hoverColor: Colors.red,
                     focusColor: Colors.red,
                     onFocusChange: (a) => {},
                  );
              },
            )
          ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
        floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () => showDialog<String>(context: context,
          builder: (BuildContext context) => AlertDialog(
            shape: Border.symmetric(),
            title: const Text("Yeni ToDo ekle"),
            content: TextField(
              decoration: InputDecoration(
                hintText: "Yapılacak"
              ),
              onChanged: (txt) => _updateText(txt),
            ),
            actions: <Widget>[
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancel');
                    if (kelime.trim().length > 0) {
                      _AddTodo();

                    }
                    },
                  child: Text("Ekle"),
                ),
              )
            ],
          ),
          ),

        tooltip: "Yeni ToDo Ekle",
        backgroundColor: Colors.redAccent,
        foregroundColor: Colors.white,
        focusColor: Colors.red,
        mouseCursor: SystemMouseCursors.click,
        hoverColor: Colors.red,
        child: const Icon(
            Icons.add
        ),
      ),
    );
  }
}

