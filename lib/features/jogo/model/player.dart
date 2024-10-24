class Player {
  final int id;
  final String nome;
  final int pontos;

  Player({
    required this.id,
    required this.nome,
    required this.pontos,
  });

  factory Player.fromMap(Map<String, Object?> map) {
    return Player(
      id: map['id'] as int,
      nome: map['nome'] as String,
      pontos: map['pontos'] as int,
    );
  }

  @override
  String toString() {
    return "[$id, $nome, $pontos]";
  }
}
