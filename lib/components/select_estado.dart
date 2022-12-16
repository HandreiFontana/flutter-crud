import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;

class SelectEstado extends StatelessWidget {
  const SelectEstado({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 5.0,
          ),
          TypeAheadField(
            textFieldConfiguration: const TextFieldConfiguration(
              autofocus: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Selecione o Estado...',
              ),
            ),
            suggestionsCallback: (pattern) async {
              return await BackendService.getSuggestions(pattern);
            },
            itemBuilder: (context, Map<String, String> suggestion) {
              return ListTile(
                title: Text(suggestion['uf']!),
                subtitle: Text('${suggestion['nomeEstado']}'),
              );
            },
            onSuggestionSelected: (Map<String, String> suggestion) {},
          ),
        ],
      ),
    );
  }
}

class BackendService {
  static Future<List<Map<String, String>>> getSuggestions(String query) async {
    if (query.isEmpty && query.length < 3) {
      return Future.value([]);
    }
    var url = Uri.parse(
        'http://172.17.39.144:3333/estados?page=1&pageSize=50&search=$query');

    var response = await http.get(url);
    List<Suggestion> suggestions = [];
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      suggestions = List<Suggestion>.from(
        data['items'].map((model) => Suggestion.fromJson(model)),
      );
    }

    return Future.value(suggestions
        .map((e) => {
              'id': e.id,
              'uf': e.uf,
              'nomeEstado': e.nomeEstado.toString(),
            })
        .toList());
  }
}

class Suggestion {
  final String id;
  final String uf;
  final String nomeEstado;

  Suggestion({
    required this.id,
    required this.uf,
    required this.nomeEstado,
  });

  factory Suggestion.fromJson(Map<String, dynamic> json) {
    return Suggestion(
      id: json['id'],
      uf: json['uf'],
      nomeEstado: json['nomeEstado'],
    );
  }
}
