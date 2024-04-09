class Comida{
  final String nombre;
  String descripcion;
  final String foto;
  final bool isCarne;
  final bool isBurguer;
  final bool isEnsalada;
  final bool isPizza;
  final bool isPescado;
  final bool isSuchi;
  Comida({
    required this.nombre,
    required this.foto,
    required this.descripcion,
    required this.isCarne,
    required this.isBurguer,
    required this.isEnsalada,
    required this.isPizza,
    required this.isPescado,
    required this.isSuchi});
}