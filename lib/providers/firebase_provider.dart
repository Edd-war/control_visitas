import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_visitas/models/visitas_dao.dart';

class FirebaseProvider {
  late FirebaseFirestore _firestore;
  late CollectionReference _visitasCollection;

  FirebaseProvider() {
    _firestore = FirebaseFirestore.instance;
    _visitasCollection = _firestore.collection('visitas');
  }

  //para almacenar
  Future<void> saveVisita(VisitaDAO objVisita) {
    return _visitasCollection.add(objVisita.toMap());
  }

  Stream<QuerySnapshot> getAllProducts() {
    return _visitasCollection.snapshots();
  }
}
