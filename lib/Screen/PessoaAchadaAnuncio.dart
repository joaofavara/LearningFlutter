import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../classes/FoundPeople.dart';
import '../components/TipPeolpleFound.dart';

// ignore: must_be_immutable
class PessoaAchada extends StatelessWidget {
  FoundPeople foundPeople;

  Future<FoundPeople> getPerson(int id) async {
    var response = await http.get('http://10.0.2.2:5000/api/people/found/$id');
    Map parsed = await jsonDecode(response.body);
    foundPeople = FoundPeople.fromJson(parsed);
    return foundPeople;
  }

  @override
  Widget build(BuildContext context) {
  final anuncioId = (ModalRoute.of(context).settings.arguments);

    return Scaffold(
      appBar: AppBar(
        title: Text("Missing Finder",),
        centerTitle: true,
      ),
      body: FutureBuilder<FoundPeople>(
            future: getPerson(anuncioId), // Fetch the data
            builder: (_, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                FoundPeople data = snapshot.data;
                 return Container (
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Image.network(
                        data.urlImagem, 
                        width: 400,
                        height: 275,
                        fit: BoxFit.cover
                      ),
                      Container(
                        height: 400,
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: data.tip.length,
                          itemBuilder: (_, int index) {
                            return TipPeolpleFound(data.tip[index]);
                          },
                        ),
                      ),
                    ],
                  )
                );
              } else {
              // If you have no data, show a progress indicator
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
      )
    );
  }
}
