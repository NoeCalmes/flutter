import 'package:flutter/material.dart';
import 'package:todoapp/add_habit_page.dart';
import 'widget/cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/firestore_service.dart';
import 'habit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  final FirestoreService _firestoreService = const FirestoreService();

  static const Gradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color.fromRGBO(102, 126, 234, 1), Color.fromRGBO(118, 75, 162, 1)],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 210,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: primaryGradient),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HabiTrack',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            SizedBox(height: 5),
            Text(
              'Construisez vos habitudes, jour après jour',
              style: TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 25),
            StreamBuilder<QuerySnapshot>(
              stream: _firestoreService.getHabitudes(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final habitudes = snapshot.data!.docs;
                  final habits = habitudes.map((doc) => Habit.fromFirestore(doc)).toList();
                  
                  // Calculer les statistiques
                  int totalHabitudes = habits.length;
                  int completedToday = habits.where((h) => h.isCompletedToday).length;
                  int meilleureStrie = habits.isNotEmpty ? 
                      habits.map((h) => h.joursConsecutifs).reduce((a, b) => a > b ? a : b) : 0;
                  
                  return Row(
                    children: [
                      Expanded(
                        child: Cards(number: '$totalHabitudes', label: 'Habitudes'),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Cards(number: '$completedToday', label: 'Complétées'),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Cards(number: '$meilleureStrie', label: 'Meilleure série'),
                      ),
                    ],
                  );
                }
                
                // Valeurs par défaut pendant le chargement
                return Row(
                  children: [
                    Expanded(
                      child: Cards(number: '0', label: 'Habitudes'),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Cards(number: '0', label: 'Complétées'),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Cards(number: '0', label: 'Meilleure série'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: _firestoreService.getHabitudes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '❌ Erreur: ${snapshot.error}',
                style: TextStyle(color: Colors.red),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Color.fromRGBO(102, 126, 234, 1),
              ),
            );
          }

          final habitudes = snapshot.data?.docs ?? [];

          if (habitudes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.emoji_emotions_outlined,
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Aucune habitude pour le moment',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Appuyez sur + pour ajouter votre première habitude',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: EdgeInsets.all(16),
            itemCount: habitudes.length,
            itemBuilder: (context, index) {
              final doc = habitudes[index];
              final habit = Habit.fromFirestore(doc);

              return Card(
                margin: EdgeInsets.only(bottom: 12),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(
                    habit.nom,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: habit.isCompletedToday ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  subtitle: Text(
                    'Série: ${habit.joursConsecutifs} jours consécutifs • Total: ${habit.totalCompletions}',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: habit.isCompletedToday ? null : () async {
                          try {
                            await _firestoreService.marquerCommeCompletee(habit.id!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('✅ Habitude complétée !'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('❌ Erreur: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          habit.isCompletedToday ? Icons.check_circle : Icons.check_circle_outline,
                          color: habit.isCompletedToday ? Colors.green : Colors.grey[400],
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          try {
                            await _firestoreService.supprimerHabitude(habit.id!);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('🗑️ Habitude supprimée'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('❌ Erreur: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          color: Colors.red[400],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      // Bouton +
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddHabitPage()),
          );
        },
        backgroundColor: Color.fromRGBO(102, 126, 234, 1),
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
