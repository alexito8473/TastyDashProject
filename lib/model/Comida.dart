
class Comida{
  final String nombre;
  final String foto;
  final int tiempoMinuto;
  final bool isCarne;
  final bool isBurguer;
  final bool isEnsalada;
  final bool isPostre;
  final bool isPescado;
  final bool isBebida;
  final bool haveApio;
  final bool haveMoluscos;
  final bool haveCrustaceos;
  final bool haveMostaza;
  final bool haveHuevo;
  final bool havePescado;
  final bool haveCacahuetes;
  final bool haveGluten;
  final bool haveLeche;
  final bool haveAzufre;
  final List<String> ingredientes;
  //El precio esta en español
  final double precio;
   const Comida({
    required this.nombre,
    required this.foto,
    required this.isCarne,
    required this.isBurguer,
    required this.isEnsalada,
    required this.isPostre,
    required this.isPescado,
    required this.isBebida,
    required this.precio,
     required this.tiempoMinuto,
     required this.haveApio,
     required this.haveMoluscos,
     required this.haveCrustaceos,
     required this.haveMostaza,
     required this.haveHuevo,
     required this.havePescado,
     required this.haveCacahuetes,
     required this.haveGluten,
     required this.haveLeche,
     required this.haveAzufre,
     required this.ingredientes,
  });
}
