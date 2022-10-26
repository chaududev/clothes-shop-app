import 'package:flutter/material.dart';
class WelcomePage extends StatefulWidget {
  WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List<String> list = [
    'assets/layout/d1.png',
    'assets/layout/d2.png',
    'assets/layout/d3.png',
    'assets/layout/d4.png'
  ];

  bool showGrid=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildTitle(context),
                  SizedBox(height: 20,),
                  buildWelcome(context),
                  SizedBox(height: 20,),
                  buildSearch(context),
                  SizedBox(height: 80,),
                  buildSavePlace(context),
                  SizedBox(height: 20,),
                  showGrid? buildGrid(context):buildList(context)
                ],
            ),
          ),
        ),
    );
  }

  buildTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(onPressed: (){}, icon: Icon(Icons.notifications)),
        IconButton(onPressed: (){}, icon: Icon(Icons.extension)),
      ],
    );
  }

  buildWelcome(BuildContext context) {
    return const Text.rich(
      TextSpan(
        text: "Welcome, ",
        style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: "Charlie",
            style: TextStyle(fontWeight: FontWeight.normal)
          )
        ]
      )
    );
  }

  buildSearch(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10)
        )
      ),
    );
  }

  buildSavePlace(BuildContext context) {
    return Row(
            children: [
              Text("Save Places",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
              Row(
                children: [
                  IconButton(onPressed: (){
                    setState((){
                      showGrid=true;
                    });
                  },
                      icon: Icon(Icons.grid_3x3,size : 30,)),
                  IconButton(onPressed: (){
                    setState((){
                      showGrid=false;
                    });
                  },
                      icon: Icon(Icons.list,size : 30,)),
                ],
              )
              ]
          );
  }

  buildGrid(BuildContext context) {
    return Expanded(
        child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            children: [
              ...list.map((e){
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(e),
                      fit: BoxFit.cover,
                    ),
                      borderRadius: BorderRadius.circular(20)
                  ),
                );
              }).toList()
            ],
        )
    );
  }

  buildList(BuildContext context) {
    return Expanded(
        child: ListView(
          scrollDirection: Axis.vertical,
          children:[
            ...list.map((e){
              return Container(
                height:200,
                margin:EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  image:DecorationImage(
                    image:AssetImage(e),
                    fit: BoxFit.cover,
                  ),
                borderRadius: BorderRadius.circular(20)
               ),
              );
            }).toList()
        ]
        )
    );
  }
}
