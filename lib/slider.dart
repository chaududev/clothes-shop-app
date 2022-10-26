import 'package:flutter/material.dart';
class SliderPage extends StatelessWidget {
  SliderPage({Key? key}) : super(key: key);
  List<String> _list = [
     'assets/sliders/a1.jpg',
    'assets/sliders/a2.jpg',
    'assets/sliders/a3.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              buildRowSlider(context),
              buildListImage(context),
            ],
          ),
        )
    );
  }

  buildRowSlider(BuildContext context) {
    return Container(
          height: 300,
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ..._list.map((e) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(e),
                        fit: BoxFit.cover
                      ),
                    borderRadius: BorderRadius.circular(30)
                    ),
                  );
                })
              ],
            ),
          ),
        );
  }

  buildListImage(BuildContext context) {
    return Container(
      height: 310,
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            children: [
              ..._list.map((e) {
                return Container(
                  margin: EdgeInsets.all(10),
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(e),
                          fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.circular(30)
                  ),
                );
              })
            ],
        ),
      ),
    );
  }
}
