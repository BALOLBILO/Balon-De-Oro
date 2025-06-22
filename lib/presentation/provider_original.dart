import 'package:flutter_application_tp/entities/BalonOro.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listaOriginal = StateProvider<List<BalonOro>>(
  (ref) => [
    BalonOro(
      posicion: 1,
      name: 'Cristiano Ronaldo',
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbb0F8HduvgtvHB4Witpm-1QiRrcDqHymTiQ&s',
    ),
    BalonOro(
      posicion: 2,
      name: 'Leonel Andrés Messi',
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTi-UBrsfmvIXJTTcEePX3VyXBQJNY40-l-tg&s',
    ),
    BalonOro(
      posicion: 3,
      name: 'Neymar Jr',
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQth1q7fxDPry_XLcuZV0wdDAnNnej7UAFwOw&s',
    ),
    BalonOro(
      posicion: 4,
      name: 'Gianluigi Buffon',
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT4CQeOqFmcAYy_sU4rkOx526VZX9ksbTl6rA&s',
    ),
    BalonOro(
      posicion: 5,
      name: 'Luka Modric',
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTBCZdk8lT5B2w_kUM7u0Wu9KxklP_DWoPOvA&s',
    ),
    BalonOro(
      posicion: 6,
      name: 'Sergio Ramos',
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS7LOGDQyV4MpO2XghtFYR5Hd-2ur9CSTZvsQ&s',
    ),
    BalonOro(
      posicion: 7,
      name: 'Kylian Mbappe',
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGNQI1tMKLLmNmm9wuV_yqBr0_kdwzFw1A7w&s',
    ),
    BalonOro(
      posicion: 8,
      name: 'NGolo Kante',
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZyEQmBbhMorsgzizJ2KFAUBxf2ovQt_hMKA&s',
    ),
    BalonOro(
      posicion: 9,
      name: 'Robert Lewandowski',
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS9a8qWxdD8EXj_reyy-5f86_N0KuajYkGT1w&s',
    ),
    BalonOro(
      posicion: 10,
      name: 'Harry Kane',
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSc0l385n5taP0mXQbT3FE3PJ1qG21QSO8dGQ&s',
    ),
    BalonOro(
      posicion: 11,
      name: 'Edinson Cavani',
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXdxLCyBuxQ4QcZvfEfw5ex1-66U__rOhsog&s',
    ),
    BalonOro(
      posicion: 12,
      name: 'Isco Alarcón',
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQNa_9T4sWr7m4AiNNuhnv0WvYjIK4F04fUZQ&s',
    ),
    BalonOro(
      posicion: 13,
      name: 'Luis Suárez',
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXQ8ZScYnRrYAZ2dAwfpfX4z6PO9Us_oXEVw&s',
    ),
    BalonOro(
      posicion: 14,
      name: 'Kevin De Bruyne',
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUULA5ysu4k_BI8YfrpEOP-GJwGniiLEr0sA&s',
    ),
    BalonOro(
      posicion: 15,
      name: 'Paulo Dybala',
      url:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfgorBJdDe6B-aKpKpCtXwV33R1pf-Q30hHQ&s',
    ),
  ],
);
