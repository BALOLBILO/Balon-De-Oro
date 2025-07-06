import 'package:flutter_application_tp/entities/BalonOro.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final lista = StateProvider<List<BalonOro>>(
  (ref) => [
    BalonOro(
      posicion: 1,
      name: 'Cristiano Ronaldo',
      descripcion:
          "Delantero portugués, famoso por su potencia física, su remate demoledor y su mentalidad ganadora. Ícono mundial, máximo goleador histórico en varias competiciones",
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbb0F8HduvgtvHB4Witpm-1QiRrcDqHymTiQ&s',
    ),
    BalonOro(
      posicion: 2,
      name: 'Leonel Andrés Messi',
      descripcion:
          "Argentino, considerado por muchos el mejor de la historia. Dotado de un regate único, visión de juego y precisión quirúrgica para asistir y marcar.",
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi-UBrsfmvIXJTTcEePX3VyXBQJNY40-l-tg&s',
    ),
    BalonOro(
      posicion: 3,
      name: 'Neymar Jr',
      descripcion:
          "Brasileño, extremadamente habilidoso, creativo y con gran capacidad para desequilibrar uno contra uno. También destacado por su flair y su juego vistoso.",
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQth1q7fxDPry_XLcuZV0wdDAnNnej7UAFwOw&s',
    ),
    BalonOro(
      posicion: 4,
      name: 'Gianluigi Buffon',
      descripcion:
          "Legendario arquero italiano, símbolo de liderazgo y longevidad. Reconocido por sus reflejos, carisma y seguridad bajo los tres palos.",
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4CQeOqFmcAYy_sU4rkOx526VZX9ksbTl6rA&s',
    ),
    BalonOro(
      posicion: 5,
      name: 'Luka Modric',
      descripcion:
          "Croata, mediocampista elegante y cerebral, con una asombrosa capacidad para organizar el juego y distribuir el balón. Balón de Oro 2018.",
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBCZdk8lT5B2w_kUM7u0Wu9KxklP_DWoPOvA&s',
    ),
    BalonOro(
      posicion: 6,
      name: 'Sergio Ramos',
      descripcion:
          "Defensor español, fuerte, aguerrido y con gran olfato goleador en jugadas de balón parado. Líder nato y símbolo del Real Madrid",
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7LOGDQyV4MpO2XghtFYR5Hd-2ur9CSTZvsQ&s',
    ),
    BalonOro(
      posicion: 7,
      name: 'Kylian Mbappe',
      descripcion:
          "Francés, una bala por la banda o el centro. Combina velocidad explosiva con definición letal. Campeón del mundo con apenas 19 años.",
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGNQI1tMKLLmNmm9wuV_yqBr0_kdwzFw1A7w&s',
    ),
    BalonOro(
      posicion: 8,
      name: 'NGolo Kante',
      descripcion:
          "Francés, incansable mediocentro defensivo, experto en recuperar balones y dar equilibrio al equipo. Humildad y eficacia pura.",
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZyEQmBbhMorsgzizJ2KFAUBxf2ovQt_hMKA&s',
    ),
    BalonOro(
      posicion: 9,
      name: 'Robert Lewandowski',
      descripcion:
          "Delantero polaco, uno de los mejores “9” de la última década. Letal en el área, inteligente para desmarcarse y con una técnica impecable para definir con ambos pies y de cabeza. Goleador serial en Bundesliga y Champions, destacadísimo en el Bayern Múnich y luego en el Barcelona. Además, reconocido por su profesionalismo, disciplina física y constancia.",
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9a8qWxdD8EXj_reyy-5f86_N0KuajYkGT1w&s',
    ),
    BalonOro(
      posicion: 10,
      name: 'Harry Kane',
      descripcion:
          "Inglés, delantero centro clásico con excelente definición, buen juego aéreo y capacidad para generar juego además de anotar.",
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSc0l385n5taP0mXQbT3FE3PJ1qG21QSO8dGQ&s',
    ),
    BalonOro(
      posicion: 11,
      name: 'Edinson Cavani',
      descripcion:
          "Uruguayo, goleador potente, sacrificado en defensa, siempre presionando y con gran sentido de ubicación en el área.",
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXdxLCyBuxQ4QcZvfEfw5ex1-66U__rOhsog&s',
    ),
    BalonOro(
      posicion: 12,
      name: 'Isco Alarcón',
      descripcion:
          "Español, talentoso mediapunta con gran control del balón y capacidad de filtrar pases, aunque irregular en continuidad.",
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNa_9T4sWr7m4AiNNuhnv0WvYjIK4F04fUZQ&s',
    ),
    BalonOro(
      posicion: 13,
      name: 'Luis Suárez',
      descripcion:
          "Uruguayo, delantero letal, agresivo y oportunista. Con instinto depredador en el área, gran conexión con Messi en el Barcelona.",
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXQ8ZScYnRrYAZ2dAwfpfX4z6PO9Us_oXEVw&s',
    ),
    BalonOro(
      posicion: 14,
      name: 'Kevin De Bruyne',
      descripcion:
          "Belga, mediocampista ofensivo con visión privilegiada, pase largo preciso y llegada constante. Motor del Manchester City.",
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUULA5ysu4k_BI8YfrpEOP-GJwGniiLEr0sA&s',
    ),
    BalonOro(
      posicion: 15,
      name: 'Paulo Dybala',
      descripcion:
          "Argentino, zurdo, habilidoso y con gol. Puede jugar como segundo punta o enganche, famoso por su pegada y sus tiros curvos.",
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfgorBJdDe6B-aKpKpCtXwV33R1pf-Q30hHQ&s',
    ),
  ],
);
