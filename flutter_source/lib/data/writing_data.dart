import '../models/writing_text.dart';

typedef _TextBuilder = String Function(Map<String, String> profile);

String _byTransport(Map<String, String> profile) {
  final transport = profile['transport']!;
  if (transport == 'à pied') return transport;
  if (transport == 'la moto') return 'à moto';
  if (transport == 'le vélo') return 'à vélo';
  return 'en ${transport.replaceFirst(RegExp(r'^(le|la|l’)\s+'), '')}';
}

class _WritingPattern {
  final String level;
  final String category;
  final String title;
  final String task;
  final String grammarFocus;
  final String grammarExplanation;
  final _TextBuilder buildText;

  const _WritingPattern({
    required this.level,
    required this.category,
    required this.title,
    required this.task,
    required this.grammarFocus,
    required this.grammarExplanation,
    required this.buildText,
  });
}

const _profiles = <Map<String, String>>[
  {
    'name': 'Lina',
    'city': 'Phnom Penh',
    'place': 'la bibliothèque',
    'study': 'le génie civil',
    'activity': 'lire des romans',
    'food': 'le riz sauté',
    'day': 'samedi',
    'time': 'huit heures',
    'transport': 'le bus',
    'person': 'ma sœur',
    'weather': 'chaud',
    'destination': 'Siem Reap',
    'object': 'un dictionnaire',
    'quality': 'calme',
  },
  {
    'name': 'Sokha',
    'city': 'Battambang',
    'place': 'le marché',
    'study': 'l’informatique',
    'activity': 'jouer au football',
    'food': 'la soupe de nouilles',
    'day': 'dimanche',
    'time': 'sept heures',
    'transport': 'la moto',
    'person': 'mon meilleur ami',
    'weather': 'ensoleillé',
    'destination': 'Kampot',
    'object': 'un ordinateur portable',
    'quality': 'animé',
  },
  {
    'name': 'Marie',
    'city': 'Lyon',
    'place': 'le parc',
    'study': 'les langues étrangères',
    'activity': 'faire du vélo',
    'food': 'une salade',
    'day': 'vendredi',
    'time': 'neuf heures',
    'transport': 'le métro',
    'person': 'ma cousine',
    'weather': 'frais',
    'destination': 'Paris',
    'object': 'un carnet',
    'quality': 'agréable',
  },
  {
    'name': 'Thomas',
    'city': 'Toulouse',
    'place': 'le musée',
    'study': 'l’architecture',
    'activity': 'dessiner',
    'food': 'un sandwich',
    'day': 'mercredi',
    'time': 'dix heures',
    'transport': 'le tramway',
    'person': 'mon frère',
    'weather': 'nuageux',
    'destination': 'Bordeaux',
    'object': 'un appareil photo',
    'quality': 'intéressant',
  },
  {
    'name': 'Nary',
    'city': 'Kampong Cham',
    'place': 'le café',
    'study': 'la chimie',
    'activity': 'écouter de la musique',
    'food': 'un croissant',
    'day': 'lundi',
    'time': 'six heures et demie',
    'transport': 'le vélo',
    'person': 'ma mère',
    'weather': 'pluvieux',
    'destination': 'Phnom Penh',
    'object': 'un livre de grammaire',
    'quality': 'confortable',
  },
  {
    'name': 'Julien',
    'city': 'Nantes',
    'place': 'la piscine',
    'study': 'les mathématiques',
    'activity': 'nager',
    'food': 'une omelette',
    'day': 'mardi',
    'time': 'onze heures',
    'transport': 'le train',
    'person': 'mon père',
    'weather': 'venteux',
    'destination': 'Rennes',
    'object': 'une montre',
    'quality': 'moderne',
  },
  {
    'name': 'Dara',
    'city': 'Siem Reap',
    'place': 'le temple',
    'study': 'le tourisme',
    'activity': 'prendre des photos',
    'food': 'le poisson grillé',
    'day': 'jeudi',
    'time': 'midi',
    'transport': 'le tuk-tuk',
    'person': 'mon professeur',
    'weather': 'très chaud',
    'destination': 'Angkor',
    'object': 'une carte de la ville',
    'quality': 'magnifique',
  },
  {
    'name': 'Claire',
    'city': 'Montpellier',
    'place': 'la plage',
    'study': 'la médecine',
    'activity': 'se promener',
    'food': 'une tarte aux pommes',
    'day': 'samedi matin',
    'time': 'deux heures',
    'transport': 'la voiture',
    'person': 'ma grand-mère',
    'weather': 'doux',
    'destination': 'Marseille',
    'object': 'un petit cadeau',
    'quality': 'reposant',
  },
  {
    'name': 'Vannak',
    'city': 'Kampot',
    'place': 'la rivière',
    'study': 'l’électricité',
    'activity': 'cuisiner',
    'food': 'un curry',
    'day': 'dimanche soir',
    'time': 'cinq heures',
    'transport': 'le minibus',
    'person': 'mon oncle',
    'weather': 'humide',
    'destination': 'Kep',
    'object': 'un sac à dos',
    'quality': 'paisible',
  },
  {
    'name': 'Élodie',
    'city': 'Strasbourg',
    'place': 'la boulangerie',
    'study': 'l’histoire',
    'activity': 'regarder des films',
    'food': 'du pain frais',
    'day': 'vendredi soir',
    'time': 'quatre heures',
    'transport': 'à pied',
    'person': 'ma colocataire',
    'weather': 'froid',
    'destination': 'Colmar',
    'object': 'une écharpe',
    'quality': 'charmant',
  },
  {
    'name': 'Rithy',
    'city': 'Sihanoukville',
    'place': 'le restaurant',
    'study': 'la mécanique',
    'activity': 'faire de la randonnée',
    'food': 'des fruits de mer',
    'day': 'mercredi soir',
    'time': 'sept heures et demie',
    'transport': 'le bateau',
    'person': 'mes camarades',
    'weather': 'orageux',
    'destination': 'Koh Rong',
    'object': 'une bouteille d’eau',
    'quality': 'bruyant',
  },
  {
    'name': 'Camille',
    'city': 'Grenoble',
    'place': 'la montagne',
    'study': 'la géographie',
    'activity': 'faire du ski',
    'food': 'une soupe chaude',
    'day': 'dimanche après-midi',
    'time': 'trois heures',
    'transport': 'le téléphérique',
    'person': 'mon voisin',
    'weather': 'neigeux',
    'destination': 'Annecy',
    'object': 'des gants',
    'quality': 'impressionnant',
  },
];

final _patterns = <_WritingPattern>[
  _WritingPattern(
    level: 'A1',
    category: 'Présentation',
    title: 'Se présenter',
    task: 'Write three sentences to introduce yourself.',
    grammarFocus: 'Être, avoir and the present tense',
    grammarExplanation:
        'Use être for identity or nationality and avoir for age. In French, age is expressed with avoir: “J’ai vingt ans”, not “Je suis vingt ans”.',
    buildText: (p) =>
        'Je m’appelle ${p['name']} et j’habite à ${p['city']}. J’étudie ${p['study']}. Dans mon temps libre, j’aime ${p['activity']}.',
  ),
  _WritingPattern(
    level: 'A1',
    category: 'Routine',
    title: 'Ma journée',
    task: 'Describe a simple daily routine.',
    grammarFocus: 'Present tense and time expressions',
    grammarExplanation:
        'Use the present tense for habits. Put time expressions such as “à huit heures” after the action, and use puis to connect two actions.',
    buildText: (p) =>
        'Je me lève à ${p['time']}. Puis, je vais à l’université ${_byTransport(p)}. Le soir, j’aime ${p['activity']}.',
  ),
  _WritingPattern(
    level: 'A1',
    category: 'Famille',
    title: 'Une personne de ma famille',
    task: 'Describe one family member.',
    grammarFocus: 'Possessive adjectives and adjective agreement',
    grammarExplanation:
        'Use mon, ma or mes before a family noun. Adjectives normally agree with the person or thing they describe.',
    buildText: (p) =>
        '${p['person']} s’appelle ${p['name']}. Cette personne habite à ${p['city']} et elle est très ${p['quality']}. Nous aimons ${p['activity']} ensemble.',
  ),
  _WritingPattern(
    level: 'A1',
    category: 'Lieu',
    title: 'Mon lieu préféré',
    task: 'Describe a place you like.',
    grammarFocus: 'Il y a and c’est',
    grammarExplanation:
        'Use il y a to say what exists in a place. Use c’est followed by an adjective or noun to give a general description.',
    buildText: (p) =>
        'Mon lieu préféré est ${p['place']} à ${p['city']}. Il y a toujours quelque chose à voir. C’est un endroit ${p['quality']} où je peux ${p['activity']}.',
  ),
  _WritingPattern(
    level: 'A1',
    category: 'Repas',
    title: 'Un repas simple',
    task: 'Write about a meal you enjoy.',
    grammarFocus: 'Partitive articles',
    grammarExplanation:
        'Use du, de la, de l’ or des for an unspecified quantity of food. After a negative verb, these forms usually become de.',
    buildText: (p) =>
        'À midi, je mange souvent ${p['food']}. Je bois de l’eau et je prends parfois un dessert. Ce repas est simple, mais délicieux.',
  ),
  _WritingPattern(
    level: 'A1',
    category: 'Transport',
    title: 'Aller quelque part',
    task: 'Explain how you travel to a place.',
    grammarFocus: 'Aller + place and transport',
    grammarExplanation:
        'Use aller à before most places. For transport, use en with enclosed vehicles and à with expressions such as à pied.',
    buildText: (p) =>
        '${p['day']}, je visite ${p['place']} avec ${p['person']}. Je pars à ${p['time']} et je me déplace ${_byTransport(p)}. Le trajet est assez facile.',
  ),
  _WritingPattern(
    level: 'A1',
    category: 'Météo',
    title: 'Le temps aujourd’hui',
    task: 'Describe today’s weather and your plan.',
    grammarFocus: 'Faire for weather',
    grammarExplanation:
        'Use faire in common expressions such as il fait chaud or il fait froid. Use être with weather adjectives such as ensoleillé or pluvieux, and parce que to give a reason.',
    buildText: (p) =>
        'Aujourd’hui, le temps est ${p['weather']} à ${p['city']}. Je prends ${p['object']} avant de sortir. Je visite ${p['place']} parce que j’aime ${p['activity']}.',
  ),
  _WritingPattern(
    level: 'A1',
    category: 'Invitation',
    title: 'Inviter un ami',
    task: 'Write a short invitation message.',
    grammarFocus: 'Vouloir and polite questions',
    grammarExplanation:
        'Use “Tu veux… ?” for a friendly invitation. Add a day and time, then finish with a simple question such as “Tu es libre ?”.',
    buildText: (p) =>
        'Salut ${p['name']} ! Tu veux visiter ${p['place']} ${p['day']} ? Nous pouvons ${p['activity']} à ${p['time']}. Tu es libre ?',
  ),
  _WritingPattern(
    level: 'A1',
    category: 'Objet',
    title: 'Un objet utile',
    task: 'Describe an object you use often.',
    grammarFocus: 'Demonstrative adjectives',
    grammarExplanation:
        'Use ce, cet, cette or ces to point to a specific noun. The form depends on the noun’s gender and number.',
    buildText: (p) =>
        'J’utilise souvent ${p['object']}. Cet objet est très utile pour ${p['study']}. Je le garde toujours dans mon sac.',
  ),
  _WritingPattern(
    level: 'A1',
    category: 'Week-end',
    title: 'Mon prochain week-end',
    task: 'Write three sentences about a near-future plan.',
    grammarFocus: 'Futur proche',
    grammarExplanation:
        'Form the futur proche with the present tense of aller plus an infinitive: je vais visiter, nous allons manger.',
    buildText: (p) =>
        '${p['day']}, je vais visiter ${p['destination']} avec ${p['person']}. Nous allons ${p['activity']} et manger ${p['food']}. Je vais aussi prendre ${p['object']}.',
  ),
  _WritingPattern(
    level: 'A2',
    category: 'Expérience',
    title: 'Une sortie récente',
    task: 'Describe a recent outing and your reaction.',
    grammarFocus: 'Passé composé',
    grammarExplanation:
        'Use the passé composé for completed past actions. Most verbs take avoir; movement verbs such as aller often take être and agree with the subject.',
    buildText: (p) =>
        'La semaine dernière, je suis allé(e) à ${p['destination']} avec ${p['person']}. Nous avons décidé de ${p['activity']} et nous avons mangé ${p['food']}. J’ai trouvé la journée vraiment ${p['quality']}.',
  ),
  _WritingPattern(
    level: 'A2',
    category: 'Opinion',
    title: 'Donner son opinion',
    task: 'Give and support an opinion.',
    grammarFocus: 'Opinion phrases and parce que',
    grammarExplanation:
        'Introduce an opinion with “À mon avis” or “Je pense que”. Support it with parce que, puisque or car.',
    buildText: (p) =>
        'À mon avis, ${p['activity']} est une activité très ${p['quality']}. Cela permet de se détendre et d’apprendre de nouvelles choses. C’est pourquoi je la recommande à mes amis.',
  ),
  _WritingPattern(
    level: 'A2',
    category: 'Comparaison',
    title: 'Comparer deux transports',
    task: 'Compare two ways of travelling.',
    grammarFocus: 'Comparatives',
    grammarExplanation:
        'Use plus… que, moins… que and aussi… que to compare. With nouns, use plus de or moins de.',
    buildText: (p) =>
        'Pour aller à ${p['destination']}, je me déplace généralement ${_byTransport(p)}. Ce choix est plus pratique que la voiture et il y a moins de stress. Cependant, la voiture est parfois plus rapide.',
  ),
  _WritingPattern(
    level: 'A2',
    category: 'Conseil',
    title: 'Donner un conseil',
    task: 'Give practical advice to a friend.',
    grammarFocus: 'Devoir and the imperative',
    grammarExplanation:
        'Use devoir in the present or conditionnel for advice: tu dois, tu devrais. The imperative gives a more direct instruction.',
    buildText: (p) =>
        'Pour progresser dans ${p['study']}, tu devrais travailler un peu chaque jour. Prépare ${p['object']} et demande conseil à ${p['person']}. Surtout, n’abandonne pas quand un exercice est difficile.',
  ),
  _WritingPattern(
    level: 'A2',
    category: 'Projet',
    title: 'Un projet futur',
    task: 'Explain a future goal and the steps needed.',
    grammarFocus: 'Futur simple',
    grammarExplanation:
        'Use the futur simple for plans or predictions that feel more distant or certain. Regular endings are -ai, -as, -a, -ons, -ez and -ont.',
    buildText: (p) =>
        'L’année prochaine, je visiterai ${p['destination']} pour approfondir ${p['study']}. Je me déplacerai ${_byTransport(p)} et je prendrai ${p['object']}. Cette expérience sera certainement enrichissante.',
  ),
  _WritingPattern(
    level: 'A2',
    category: 'Problème',
    title: 'Expliquer un problème',
    task: 'Describe a problem and propose a solution.',
    grammarFocus: 'Connectors of contrast and result',
    grammarExplanation:
        'Use pourtant or cependant to introduce a contrast. Use donc or c’est pourquoi to introduce a result or solution.',
    buildText: (p) =>
        'Je voulais visiter ${p['place']}, pourtant le temps était ${p['weather']}. J’ai donc décidé de rester chez moi pour ${p['activity']}. Finalement, cette solution était assez ${p['quality']}.',
  ),
  _WritingPattern(
    level: 'A2',
    category: 'Description',
    title: 'Décrire une ville',
    task: 'Write a balanced description of a city.',
    grammarFocus: 'Relative pronouns qui and où',
    grammarExplanation:
        'Use qui to replace the subject of a following verb. Use où for a place or time: une ville où il fait bon vivre.',
    buildText: (p) =>
        '${p['city']} est une ville ${p['quality']} où il y a beaucoup d’activités. Les visiteurs qui aiment ${p['activity']} peuvent visiter ${p['place']}. Pourtant, les transports sont parfois difficiles.',
  ),
  _WritingPattern(
    level: 'A2',
    category: 'Courriel',
    title: 'Un courriel formel',
    task: 'Write a short, polite request.',
    grammarFocus: 'Polite conditionnel',
    grammarExplanation:
        'The conditionnel makes requests softer and more polite. Common forms include “je voudrais”, “pourriez-vous” and “serait-il possible”.',
    buildText: (p) =>
        'Madame, Monsieur, je voudrais obtenir des informations sur ${p['study']}. Pourriez-vous m’envoyer les horaires et me dire s’il serait possible de visiter ${p['place']} ? Je vous remercie par avance.',
  ),
  _WritingPattern(
    level: 'A2',
    category: 'Habitudes',
    title: 'Avant et maintenant',
    task: 'Contrast a past habit with the present.',
    grammarFocus: 'Imparfait versus present',
    grammarExplanation:
        'Use the imparfait for repeated past habits or background descriptions. Use the present to contrast those habits with life now.',
    buildText: (p) =>
        'Avant, je sortais rarement et je passais beaucoup de temps chez moi. Maintenant, je visite souvent ${p['place']} pour ${p['activity']}. Ce changement me rend plus actif et plus curieux.',
  ),
  _WritingPattern(
    level: 'A2',
    category: 'Récit',
    title: 'Une petite surprise',
    task: 'Tell a short story with a background and an event.',
    grammarFocus: 'Imparfait and passé composé',
    grammarExplanation:
        'Use the imparfait for the background or an action in progress. Use the passé composé for the event that interrupts or advances the story.',
    buildText: (p) =>
        'Le temps était ${p['weather']} et je marchais vers ${p['place']}. Soudain, j’ai rencontré ${p['person']}, qui m’a offert ${p['object']}. J’étais très surpris(e), mais heureux/heureuse.',
  ),
];

List<WritingText> _buildWritingTexts() {
  final texts = <WritingText>[];
  for (var patternIndex = 0; patternIndex < _patterns.length; patternIndex++) {
    final pattern = _patterns[patternIndex];
    for (var profileIndex = 0;
        profileIndex < _profiles.length;
        profileIndex++) {
      final number = profileIndex + 1;
      texts.add(
        WritingText(
          id: '${pattern.level}-${patternIndex + 1}-$number',
          level: pattern.level,
          category: pattern.category,
          title: '${pattern.title} $number',
          task: pattern.task,
          text: pattern.buildText(_profiles[profileIndex]),
          grammarFocus: pattern.grammarFocus,
          grammarExplanation: pattern.grammarExplanation,
        ),
      );
    }
  }
  return List.unmodifiable(texts);
}

final List<WritingText> kWritingTexts = _buildWritingTexts();

const Map<String, String> kWritingGlossary = {
  'à mon avis': 'in my opinion',
  'à pied': 'on foot',
  'afin de': 'in order to',
  'agréable': 'pleasant',
  'améliorer': 'to improve',
  'année prochaine': 'next year',
  'avant de sortir': 'before going out',
  'avoir lieu': 'to take place',
  'car': 'because / since',
  'cependant': 'however',
  'certainement': 'certainly',
  'c’est pourquoi': 'that is why',
  'changement': 'change',
  'charmant': 'charming',
  'colocataire': 'roommate',
  'connaissances': 'knowledge',
  'conseil': 'advice',
  'curieux': 'curious',
  'd’habitude': 'usually',
  'délicieux': 'delicious',
  'demander conseil': 'to ask for advice',
  'détendre': 'to relax',
  'difficile': 'difficult',
  'enrichissante': 'enriching',
  'finalement': 'finally / in the end',
  'frais': 'cool / fresh',
  'heureux': 'happy',
  'horaires': 'schedule / opening hours',
  'humide': 'humid',
  'impressionnant': 'impressive',
  'l’année dernière': 'last year',
  'la semaine dernière': 'last week',
  'lieu préféré': 'favorite place',
  'moins de': 'less / fewer',
  'neigeux': 'snowy',
  'nuageux': 'cloudy',
  'obtenir': 'to obtain / get',
  'orageux': 'stormy',
  'paisible': 'peaceful',
  'par avance': 'in advance',
  'parce que': 'because',
  'parfois': 'sometimes',
  'permet de': 'allows someone to',
  'plus pratique': 'more practical',
  'pourtant': 'however / yet',
  'pourriez-vous': 'could you',
  'prendre des photos': 'to take photos',
  'prochain week-end': 'next weekend',
  'rarement': 'rarely',
  'recommande': 'recommend',
  'remercie': 'thank',
  'reposant': 'restful',
  'réussir': 'to succeed',
  'soudain': 'suddenly',
  'surtout': 'above all / especially',
  'trajet': 'journey / commute',
  'venteux': 'windy',
  'visiterai': 'will visit',
  'voudrais': 'would like',
};
