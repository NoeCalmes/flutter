import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  const FirestoreService();
  
  CollectionReference get habitudes => 
      FirebaseFirestore.instance.collection('habitudes');

  // Ajouter une habitude
  Future<void> ajouterHabitude(String nom) async {
    try {
      await habitudes.add({
        'nom': nom,
        'dateCreation': Timestamp.now(),
        'completions': [], // Liste des dates de completion
      });
      print('Habitude ajoutée avec succès');
    } catch (e) {
      print('Erreur lors de l\'ajout : $e');
      throw e;
    }
  }

  // Récupérer toutes les habitudes
  Stream<QuerySnapshot> getHabitudes() {
    return habitudes
        .orderBy('dateCreation', descending: false)
        .snapshots();
  }

  // Supprimer une habitude
  Future<void> supprimerHabitude(String id) async {
    try {
      await habitudes.doc(id).delete();
      print('Habitude supprimée avec succès');
    } catch (e) {
      print('Erreur lors de la suppression : $e');
      throw e;
    }
  }

  // Marquer une habitude comme complétée pour aujourd'hui
  Future<void> marquerCommeCompletee(String id) async {
    try {
      String today = DateTime.now().toIso8601String().split('T')[0];
      
      await habitudes.doc(id).update({
        'completions': FieldValue.arrayUnion([today])
      });
      print('Habitude marquée comme complétée');
    } catch (e) {
      print('Erreur lors du marquage : $e');
      throw e;
    }
  }
}