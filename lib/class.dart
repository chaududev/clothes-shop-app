import 'package:flutter/material.dart';
class Class{
  String? name;
  String? description;
  String? student;
  String? img;
  Class({this.name,this.description,this.student,this.img});
}
class ClassPage extends StatelessWidget {
  ClassPage({Key? key}) : super(key: key);
  List<Class> _listClass=[
    Class(name:"[2021-2022.2] - Thực tập viết niên luận - Nhóm 3",description: "2021-2022.2.TIN3142.003",student: "7 học viên",img:"assets/sliders/c1.jpg"),
    Class(name:"[2021-2022.2] - Công nghệ XML - Nhóm 1",description: "2021-2022.2.TIN4412.001",student: "10 học viên",img:"assets/sliders/c2.jpg"),
    Class(name:"[2021-2022.2] - Lập trình Front - End - Nhóm 12",description: "2021-2022.2.TIN3092.012",student: "36 học viên",img:"assets/sliders/c3.jpg"),
    Class(name:"[2021-2022.2] - Lập trình Front - End - Nhóm 11",description: "2021-2022.2.TIN3092.011",student: "35 học viên",img:"assets/sliders/c1.jpg"),
    Class(name:"[2021-2022.2] - Lập trình Front - End - Nhóm 10",description: "2021-2022.2.TIN3092.010",student: "37 học viên",img:"assets/sliders/c5.jpg"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: buildListImage(context),
        )
    );
  }

  buildListImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            ..._listClass.map((e) {
              return Container(
                margin: EdgeInsets.all(5),
                height: 195,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(e.img.toString()),
                        fit: BoxFit.cover
                    ),
                    borderRadius: BorderRadius.circular(10),

                ),
                child: Container(
                  margin: EdgeInsets.only(left: 15),
                  padding: EdgeInsets.only(top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex:2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                        Expanded(
                           flex:9,
                           child:   Wrap(children: [ Text(
                           maxLines:2,
                           e.name.toString(),
                           style:TextStyle(color:Colors.white,fontSize: 24,fontFamily: "Roboto"),
                         ),],),),
                            Expanded(
                                flex: 2,
                                child:Container(
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(right: 20),
                                  child:  Icon(
                                  color:Colors.white,
                                  Icons.more_horiz,
                                    size:25,
                                ),))
                          ],
                        )
                      ),
                      Expanded(
                          flex:3,
                          child: Text(
                            e.description.toString(),
                            style:TextStyle(color:Colors.white, height:2, fontSize: 16),
                          )
                      ),
                      Expanded(
                          flex:2,
                          child: Text(
                            e.student.toString(),
                            style:TextStyle(color:Colors.white70, height:2, fontSize: 16),
                          )
                      ),
                    ],
                  ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
