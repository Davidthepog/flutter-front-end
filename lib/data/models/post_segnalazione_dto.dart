class PostSegnalazioneDto {
  final int idUtenza;
  final int idTipologia;
  final String luogo;
  final String descrizione;

  const PostSegnalazioneDto({
    required this.idUtenza,
    required this.idTipologia,
    required this.luogo,
    required this.descrizione,
  });

  factory PostSegnalazioneDto.fromJson(Map<String, dynamic> json) {
    return PostSegnalazioneDto(
      idUtenza: json['idUtenza'],
      idTipologia: json['idTipologia'],
      luogo: json['luogo'],
      descrizione: json['descrizione'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idUtenza': idUtenza,
      'idTipologia': idTipologia,
      'luogo': luogo,
      'descrizione': descrizione,
    };
  }
}
