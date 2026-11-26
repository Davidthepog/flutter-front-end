class SegnalazioneOperatoreDto {
  final int id;
  final DateTime dataSegnalazione;
  final String descrizione;
  final String luogo;
  final String tipologia;
  final bool azioniAttive;
  final int? idAzioneAttiva;

  const SegnalazioneOperatoreDto({
    required this.id,
    required this.dataSegnalazione,
    required this.descrizione,
    required this.luogo,
    required this.tipologia,
    required this.azioniAttive,
    this.idAzioneAttiva,
  });

  factory SegnalazioneOperatoreDto.fromJson(Map<String, dynamic> json) {
    return SegnalazioneOperatoreDto(
      id: json['id'],
      dataSegnalazione: DateTime.parse(json['dataSegnalazione']),
      descrizione: json['descrizione'],
      luogo: json['luogo'],
      tipologia: json['tipologia'],
      azioniAttive: json['azioniAttive'],
      idAzioneAttiva: json['idAzioneAttiva'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dataSegnalazione': dataSegnalazione,
      'descrizione': descrizione,
      'luogo': luogo,
      'tipologia': tipologia,
      'azioniAttive': azioniAttive,
      'idAzioneAttiva': idAzioneAttiva,
    };
  }
}
