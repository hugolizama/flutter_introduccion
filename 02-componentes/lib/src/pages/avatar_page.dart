import 'package:flutter/material.dart';


class AvatarPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Avatar Page'),
        actions: [

          Container(
            child: CircleAvatar(
              backgroundImage: NetworkImage('https://i.pinimg.com/originals/2d/46/b7/2d46b7328b3f234c70a150430270a44e.jpg'),
            ),
            margin: EdgeInsets.only(right: 10),
          ),

          Container(
            child: CircleAvatar(
              child: Text('SL'),
              backgroundColor: Colors.brown[200],
              foregroundColor: Colors.white,
              
            ),
            margin: EdgeInsets.only(right: 10),
          )
        ],
      ),
      body: Center(
        child: FadeInImage(
          placeholder: AssetImage('assets/img/jar-loading.gif'), 
          image: NetworkImage('https://cdn.hobbyconsolas.com/sites/navi.axelspringer.es/public/styles/1200/public/media/image/2020/07/god-war-1993071.jpg?itok=CXRzW_k1'),
          fadeInDuration: Duration(milliseconds: 200),
        ),
      ),
    );
  }
}