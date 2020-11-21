import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
// import '../components/InformacoesNomeIdade.dart';

class MainPage extends StatefulWidget{
  _MainPage createState()=> _MainPage();
}

class _MainPage extends State<MainPage>{
  Future<Null> _refresh() async {
    setState(() => {});
  }

  Future<List> getAllPersons() async {
    var response = await http.get('http://10.0.2.2:5000/api/people');
    List  data = convert.jsonDecode(response.body);
    List items = data.toList();
    return items;
  }

   Future<void> goToHome(BuildContext context) async {
    Navigator.of(context).popAndPushNamed(
      '/home',
    );
  }

  Future<void> goToInstrucoesFoto(BuildContext context) async {
    Navigator.of(context).pushNamed(
      '/instrucoes_foto',
    );
  }

  Future<void> goToProfile(BuildContext context) async {
    Navigator.of(context).pushNamed(
      '/profile',
    );
  }

  Future<void> goToAnuncioPessoaDesaparecida(BuildContext context, int anuncioId) async {
    Navigator.of(context).pushNamed(
      '/anuncio_pessoa_desaparecida',
      arguments: anuncioId
    );
  }

  Future<void> goToAnuncioPessoaAchada(BuildContext context, int anuncioId) async {
    Navigator.of(context).pushNamed(
      '/anuncio_pessoa_achada',
      arguments: anuncioId
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Missing Finder",
        ),
        centerTitle: true,
      ),

      body: RefreshIndicator(
        onRefresh: _refresh,
        child: FutureBuilder(
            future: getAllPersons(), // Fetch the data
            builder: (_, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<dynamic> newsList = snapshot.data;

                return  GridView.count(
                  crossAxisCount: 2, //Grid com 2 colunas
                  children: List.generate(newsList.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: new InkResponse(
                        child: Stack(
                          children: <Widget> [
                            Image.network(
                              newsList[index]['url_imagem'], 
                              width: 500,
                              height: 500,
                              fit: BoxFit.cover
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container (
                                    height: 35,
                                    // width: 20,
                                    child: Card(
                                      color: Colors.grey[350].withOpacity(0.6),
                                      child: Row (
                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          // Container(
                                          //   margin: const EdgeInsets.all(20.0),
                                          // ),
                                          Text(
                                            '${newsList[index]['nome']}, ${newsList[index]['idade']}',
                                            style: TextStyle(
                                              fontFamily: 'Arial',
                                              fontSize: 10.0,
                                              fontWeight: FontWeight.w600
                                            )
                                            // style: TextStyle(height: 2, fontSize: 1),
                                          ),
                                        ],
                                      )
                                    ),
                                  ),
                                // ),
                              ],
                            ),
                          ]
                        ),
                        onTap: () => newsList[index]['tipo'] == 'DESAPARECIDA' ? goToAnuncioPessoaDesaparecida(context, newsList[index]['id']) : goToAnuncioPessoaAchada(context, newsList[index]['id']),
                      ),
                    );
                  }),
                );
              } else {
                // If you have no data, show a progress indicator
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
        ),
      ),

      // BOTTOM BAR
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () {}, //=> goToHome(context),
              icon: Icon(Icons.home, color: Colors.white, size: 30),
            ),
            IconButton(
              onPressed: () => goToInstrucoesFoto(context),
              icon: Icon(Icons.add_circle, color: Colors.white, size: 30),
            ),
            IconButton(
              onPressed: () => goToProfile(context),
              icon: Icon(Icons.person, color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}