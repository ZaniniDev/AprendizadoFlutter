import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cases/case_4/models/usuario_model.dart';

class UsuarioRepository {
  //Instantiate Firestore
  static final db = FirebaseFirestore.instance;

  static String usuario_id = "phbDmvSm7MjMQQ2gD1jl";

  static Future<bool> verificaLogin(usuario, senha) async {
    bool _autenticado = false;
    await db
        .collection('usuarios')
        .where("usuario", isEqualTo: usuario)
        .where("senha", isEqualTo: senha)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          print("Usuario existente!");
          print('${docSnapshot.id} => ${docSnapshot.data()}');

          UsuarioRepository.usuario_id = docSnapshot.id;
          _autenticado = true;
          return true;
        }
      },
      onError: (e) => print("Error getting document: $e"),
    );
    return _autenticado;
  }

  static criarUsuario({usuario, nome, senha}) async {
    final docRef = db.collection('usuarios').doc();
    UsuarioModel usuarioModel =
        UsuarioModel(usuario: usuario, nome: nome, senha: senha, id: docRef.id);

    await docRef.set(usuarioModel.toMap()).then(
        (value) => print("Usuário criado com sucesso!"),
        onError: (e) => print("Error na criação do usuário : $e"));
  }
}
