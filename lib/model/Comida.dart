
class Comida{
  final String nombre;
  final String foto;
  final bool isCarne;
  final bool isBurguer;
  final bool isEnsalada;
  final bool isPizza;
  final bool isPescado;
  final bool isSuchi;
  //El precio esta en español
  final double precio;
   const Comida({
    required this.nombre,
    required this.foto,
    required this.isCarne,
    required this.isBurguer,
    required this.isEnsalada,
    required this.isPizza,
    required this.isPescado,
    required this.isSuchi,
    required this.precio
  });
}
