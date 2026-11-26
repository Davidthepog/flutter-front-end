import 'dart:convert';

import 'package:flutter_application_1/data/models/segnalazioni_operatore_dto.dart';
import 'package:flutter_application_1/data/services/api_handler.dart';
import 'package:flutter_application_1/data/services/auth_service.dart';
import 'package:flutter_application_1/features/auth/views/login_page.dart';
import 'package:flutter_application_1/features/widgets/logout_button.dart';
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
      // print(segnalazioniResponse.statusCode);
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
        actions: [
          LogoutButton(
            onPressed: () async {
              await _apiHandler.logOut();

              if (!context.mounted) return;

              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            },
          ),
        ],
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
                        elevation: 3,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Titolo e stato
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      'Segnalazione: ${segnalazione.descrizione}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Chip(label: Text(segnalazione.tipologia)),
                                ],
                              ),

                              const SizedBox(height: 8),

                              // Descrizione
                              // Text(
                              //   segnalazione.descrizione,
                              //   style: const TextStyle(fontSize: 15),
                              // ),
                              // const SizedBox(height: 12),

                              // Luogo
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 18),
                                  const SizedBox(width: 6),
                                  Expanded(child: Text(segnalazione.luogo)),
                                ],
                              ),

                              const SizedBox(height: 8),

                              // Data
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today, size: 18),
                                  const SizedBox(width: 6),
                                  Text(
                                    '${segnalazione.dataSegnalazione.day}/'
                                    '${segnalazione.dataSegnalazione.month}/'
                                    '${segnalazione.dataSegnalazione.year}',
                                  ),
                                ],
                              ),

                              const Divider(height: 24),

                              // Stato azioni
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    segnalazione.azioniAttive
                                        ? 'Azioni attive'
                                        : 'Nessuna azione attiva',
                                  ),
                                  if (segnalazione.idAzioneAttiva != null)
                                    Text(
                                      'Azione #${segnalazione.idAzioneAttiva}',
                                    ),
                                ],
                              ),
                            ],
                          ),
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
