class RuoloDto {
  final int id;
  final String nomeRuolo;
  final int numeroUtenze;

  const RuoloDto({
    required this.id,
    required this.nomeRuolo,
    required this.numeroUtenze,
  });

  factory RuoloDto.fromJson(Map<String, dynamic> json) {
    return RuoloDto(
      id: json['id'],
      nomeRuolo: json['nomeRuolo'],
      numeroUtenze: json['numeroUtenze'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nomeRuolo': nomeRuolo, 'numeroUtenze': numeroUtenze};
  }
}
