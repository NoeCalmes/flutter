import 'package:flutter/material.dart';
import 'package:info/service/search_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _searchController = TextEditingController();
  final SearchService _searchService = SearchService();

  List _results = [];
  bool _loading = false;

  void search() async {
   if (_searchController.text.isEmpty) return;

  }

  setState((){

    _loading = true;
  });

  try {
    final result await _searchService.search(_searchController.text);

  }
  catch(e){

  } 







  @override
  Widget build(BuildContext context) {
    return Container();
  }
}