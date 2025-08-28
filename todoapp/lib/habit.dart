import 'package:cloud_firestore/cloud_firestore.dart';

class Habit {
  final String? id;
  final String nom;
  final DateTime dateCreation;
  final List<String> completions;

  Habit({
    this.id,
    required this.nom,
    required this.dateCreation,
    required this.completions,
  });

  // Constructeur depuis Firestore
  factory Habit.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Habit(
      id: doc.id,
      nom: data['nom'] ?? '',
      dateCreation: (data['dateCreation'] as Timestamp).toDate(),
      completions: List<String>.from(data['completions'] ?? []),
    );
  }

  // Convertir vers Map pour Firestore
  Map<String, dynamic> toMap() {
    return {
      'nom': nom,
      'dateCreation': Timestamp.fromDate(dateCreation),
      'completions': completions,
    };
  }

  // Vérifier si l'habitude est complétée aujourd'hui
  bool get isCompletedToday {
    String today = DateTime.now().toIso8601String().split('T')[0];
    return completions.contains(today);
  }

  // Calculer les jours consécutifs
  int get joursConsecutifs {
    if (completions.isEmpty) return 0;
    
    // Trier les dates de completion par ordre décroissant
    List<DateTime> dates = completions.map((dateStr) => DateTime.parse(dateStr)).toList();
    dates.sort((a, b) => b.compareTo(a));
    
    int consecutifs = 0;
    DateTime today = DateTime.now();
    DateTime currentDate = DateTime(today.year, today.month, today.day);
    
    for (DateTime date in dates) {
      DateTime completionDate = DateTime(date.year, date.month, date.day);
      if (completionDate.isAtSameMomentAs(currentDate) || 
          completionDate.isAtSameMomentAs(currentDate.subtract(Duration(days: consecutifs)))) {
        consecutifs++;
        currentDate = currentDate.subtract(Duration(days: 1));
      } else {
        break;
      }
    }
    
    return consecutifs;
  }

  // Nombre total de complétions
  int get totalCompletions => completions.length;
}