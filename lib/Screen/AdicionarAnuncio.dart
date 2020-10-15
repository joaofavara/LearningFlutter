import 'package:flutter/material.dart';

class AdicionarAnuncio extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missing Finder'),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.person, color: Colors.white),
            ),
          ],
        ),
      ),

      // body
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            FlatButton(
              child: Text(
                'UMA PESSOA ESTÁ DESAPARECIDA',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: () {},
            ),
            Divider(
              color: Colors.white,
            ),
            Divider(
              color: Colors.white,
            ),
            FlatButton(
              child: Text(
                'ENCONTREI UMA PESSOA',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.blue,
              textColor: Colors.white,
              onPressed: ()  {},
            ),
          ],
        ),
      ),
    );
  }
}
//	Widget build(BuildContext context){
//		return Container (
//			padding: EdgeInsets.all (25.0),
//			child: Text ('Adicionar Anuncio', style: TextStyle (fontSize: 36.0)),
//		);
//	}
