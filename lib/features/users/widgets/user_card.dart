import 'package:flutter_application_1/data/models/output_utenza_dto.dart';
import 'package:material_ui/material_ui.dart';

class UserCard extends StatelessWidget {
  // final String nome;
  // final String cognome;
  // final String ruolo;
  final OutputUtenzaDto utenza;
  const UserCard({super.key, required this.utenza});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text("${utenza.cognome}, ${utenza.nome}"),
        subtitle: Text(utenza.ruolo),
      ),
    );
  }
}
