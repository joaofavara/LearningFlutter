import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class TirarFoto extends StatefulWidget {
  @override
  _TirarFotoState createState() => _TirarFotoState();
}

class _TirarFotoState extends State<TirarFoto> {
  File imageFile;
  final _picker = ImagePicker();

  Future<void> goToSimilaridades(BuildContext context, File imagem) async {
    Navigator.of(context).pushNamed(
      '/similaridades',
      arguments: imagem,
    );
  }

  Future<void> goToAbrirGaleria(BuildContext context) async {
    // ignore: deprecated_member_use
    PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = File(pickedFile.path);
    });
    // Navigator.of(context).pushNamed(
    //   '/abrir_galeria',
    // );
  }

  Future<void> goToAbrirCamera(BuildContext context) async {
    // ignore: deprecated_member_use
    var imagem = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = imagem;
    });
    Navigator.of(context).pushNamed(
      '/abrir_camera',
    );
  }

  // ignore: missing_return
  Widget _decideImageView() {
    if (imageFile == null) {
      return Text('Nenhuma imagem selecionada');
    } else {
      return Image.file(
        imageFile,
        width: 500,
        height: 500,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Missing Finder'),
      ),
      backgroundColor: Colors.grey,

      // EXIBINDO IMAGEM NA TELA
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //Image.file(imageFile, width: 400, height: 400);
              _decideImageView(),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              onPressed: () => goToAbrirGaleria(context), //_abrirGaleria(context),
              icon: Icon(Icons.photo, color: Colors.white, size: 30),
            ),
            IconButton(
              onPressed: () => goToAbrirCamera(context), //_abrirCamera(context),
              icon: Icon(Icons.camera_alt, color: Colors.red, size: 30),
            ),
            IconButton(
              // onPressed: () => goToSimilaridades(context),
              onPressed: () => goToSimilaridades(context, imageFile),
              icon: Icon(Icons.arrow_forward, color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
