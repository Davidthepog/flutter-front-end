import 'dart:convert';

import 'package:flutter_application_1/data/models/segnalazioni_operatore_dto.dart';
import 'package:flutter_application_1/data/services/api_handler.dart';
import 'package:flutter_application_1/data/services/auth_service.dart';
import 'package:material_ui/material_ui.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final AuthService _auth = AuthService();
  final ApiHandler _apiHandler = ApiHandler();

  late List<SegnalazioneOperatoreDto> segnalazioni = [];

  void caricaDashboard() async {
    try {
      final segnalazioniResponse = await _apiHandler.authorizedRequest(
        method: "GET",
        endpoint: "utenze/1/segnalazioni",
      );
      if (segnalazioniResponse.statusCode >= 200 &&
          segnalazioniResponse.statusCode <= 299) {
        final List<dynamic> datiSegnalazioni = json.decode(
          segnalazioniResponse.body,
        );

        segnalazioni = datiSegnalazioni
            .map((json) => SegnalazioneOperatoreDto.fromJson(json))
            .toList();
      }
      setState(() {});
    } catch (e) {
      segnalazioni = [];
    }
  }

  @override
  void initState() {
    caricaDashboard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        onPressed: caricaDashboard,
        color: Colors.green,
        textColor: Colors.white,
        padding: EdgeInsets.all(10),
        child: Text('Ricarica'),
      ),
      body: segnalazioni.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'Segnalazioni:',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: segnalazioni.length,
                    itemBuilder: (context, index) {
                      final segnalazione = segnalazioni[index];

                      return Card(
                        child: ListTile(
                          title: Text('Segnalazione ${index + 1}'),
                          subtitle: Text(segnalazione.toString()),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
