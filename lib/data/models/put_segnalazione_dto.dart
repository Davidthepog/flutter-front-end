class PutSegnalazioneDto {
  final int id;
  final int idStato;
  final int idUtenza;
  final String descrizione;

  const PutSegnalazioneDto({
    required this.id,
    required this.idStato,
    required this.idUtenza,
    required this.descrizione,
  });

  factory PutSegnalazioneDto.fromJson(Map<String, dynamic> json) {
    return PutSegnalazioneDto(
      id: json['id'],
      idStato: json['idStato'],
      idUtenza: json['idUtenza'],
      descrizione: json['descrizione'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'idStato': idStato,
      'idUtenza': idUtenza,
      'descrizione': descrizione,
    };
  }
}
