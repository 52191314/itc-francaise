/// Roleplay topic data ported from po_roleplay.js
class RoleplayTopic {
  final int number;
  final String title;
  final List<String> keywords;
  final String script;      // model answer / monologue
  final List<String> phrases; // useful phrases

  const RoleplayTopic({
    required this.number,
    required this.title,
    required this.keywords,
    this.script = '',
    this.phrases = const [],
  });
}

// ── ENTRETIEN topics ──────────────────────────────────────────
const List<RoleplayTopic> kEntretienTopics = [
  RoleplayTopic(
    number: 1,
    title: 'Se présenter',
    keywords: ['nom', 'prénom', 'âge', 'nationalité', 'études'],
    script: 'Bonjour, je m\'appelle CHEANG Mengsean. J\'ai vingt et un ans. Je suis cambodgien et j\'habite à Phnom Penh. J\'étudie le génie civil à l\'Institut de Technologie du Cambodge. Je parle khmer, anglais et un peu français. Dans mon temps libre, j\'aime lire des mangas et me promener.',
    phrases: [
      'Je m\'appelle…',
      'J\'ai … ans.',
      'Je suis de nationalité cambodgienne.',
      'J\'étudie … à …',
      'Dans mon temps libre, j\'aime…',
    ],
  ),
  RoleplayTopic(
    number: 2,
    title: 'La famille',
    keywords: ['père', 'mère', 'frère', 'sœur', 'parents'],
    script: 'Ma famille est composée de quatre personnes : mon père, ma mère, ma sœur et moi. Mon père est enseignant et ma mère travaille dans un commerce. Ma sœur est plus jeune que moi, elle a dix-neuf ans et elle étudie à l\'université. Nous habitons tous ensemble à Phnom Penh.',
    phrases: [
      'Ma famille est composée de … personnes.',
      'Mon père / Ma mère est …',
      'J\'ai … frères et … sœurs.',
      'Nous habitons à …',
    ],
  ),
  RoleplayTopic(
    number: 3,
    title: 'Les études',
    keywords: ['université', 'cours', 'matière', 'ITC', 'génie civil'],
    script: 'J\'étudie le génie civil à l\'Institut de Technologie du Cambodge. Mes cours commencent à sept heures et finissent à dix-sept heures. J\'ai des cours de mathématiques, de physique, de français et d\'informatique. Mon cours préféré est le français parce que c\'est utile pour ma future carrière.',
    phrases: [
      'J\'étudie … à …',
      'Mes cours commencent à … et finissent à …',
      'Mon cours préféré est … parce que …',
      'J\'ai des cours de …',
    ],
  ),
  RoleplayTopic(
    number: 4,
    title: 'Les loisirs et les passe-temps',
    keywords: ['sport', 'musique', 'lecture', 'manga', 'marcher'],
    script: 'Dans mon temps libre, j\'aime lire des mangas chinois et des romans. J\'aime aussi me promener dans le quartier le soir. Parfois, je joue au football avec mes amis le week-end. J\'écoute aussi de la musique pour me détendre après les cours.',
    phrases: [
      'Dans mon temps libre, j\'aime…',
      'Mon passe-temps préféré est…',
      'Je pratique … deux fois par semaine.',
      'Ça me détend / ça me permet de…',
    ],
  ),
  RoleplayTopic(
    number: 5,
    title: 'La ville et les transports',
    keywords: ['Phnom Penh', 'bus', 'moto', 'quartier', 'rue'],
    script: 'J\'habite à Phnom Penh, la capitale du Cambodge. C\'est une grande ville avec beaucoup de restaurants, de marchés et de musées. Pour aller à l\'université, je prends généralement le bus ou une moto-taxi. Il y a souvent des embouteillages le matin, donc je pars tôt de chez moi.',
    phrases: [
      'Pour aller à …, je prends …',
      'Il y a souvent des embouteillages…',
      'C\'est à … minutes de chez moi.',
      'Je préfère … parce que c\'est plus …',
    ],
  ),
];

// ── MONOLOGUE topics ──────────────────────────────────────────
const List<RoleplayTopic> kMonologueTopics = [
  RoleplayTopic(
    number: 1,
    title: 'Les musées à Phnom Penh',
    keywords: ['Tuol Sleng', 'musée national', 'histoire', 'culture', 'génocide'],
    script:
        'Bonjour Monsieur. Aujourd\'hui, je vais vous parler des musées à Phnom Penh '
        'et de leur importance pour les Cambodgiens et pour les visiteurs étrangers.\n\n'
        'Phnom Penh est la capitale du Cambodge. C\'est une grande ville moderne, '
        'mais elle garde aussi une histoire très riche et parfois très douloureuse. '
        'Il y a plusieurs musées importants dans cette ville. '
        'Le plus connu est probablement le musée du Génocide de Tuol Sleng, '
        'aussi appelé S-21. '
        'Il y a aussi le Musée national du Cambodge, qui est très différent.\n\n'
        'J\'ai déjà visité le musée de Tuol Sleng il y a quatre ou cinq ans, avec ma famille. '
        'Avant d\'être un musée, ce lieu était une prison pendant le régime des Khmers rouges. '
        'Nous avons passé presque deux heures là-bas. '
        'Nous avons regardé les photos historiques des victimes, '
        'les dessins faits par les survivants, '
        'et les anciennes cellules où les prisonniers étaient enfermés. '
        'C\'était une visite très émouvante et difficile, '
        'mais je pense que c\'était nécessaire. '
        'On ne peut pas oublier ce qui s\'est passé dans notre pays.\n\n'
        'À mon avis, ce musée n\'est pas seulement intéressant pour les touristes étrangers. '
        'Il est aussi très important pour les jeunes Cambodgiens comme moi. '
        'Quand on visite Tuol Sleng, on comprend mieux pourquoi la paix est si précieuse. '
        'On comprend aussi pourquoi notre génération doit travailler fort '
        'pour construire un pays meilleur.\n\n'
        'Plus tard, je voudrais visiter le Musée national du Cambodge. '
        'Ce musée est très différent de Tuol Sleng. '
        'Il y a de grandes statues de l\'époque d\'Angkor, '
        'des objets anciens en bronze et en pierre, '
        'et beaucoup d\'œuvres d\'art de la culture khmère. '
        'Je veux voir ces objets pour mieux connaître mes racines '
        'et comprendre d\'où vient ma culture.\n\n'
        'Pour conclure, je pense que les musées sont très importants '
        'parce qu\'ils gardent vivantes l\'histoire et la culture d\'un pays. '
        'Ils nous permettent de ne pas oublier le passé '
        'et de mieux comprendre qui nous sommes. '
        'Je recommande à tout le monde de visiter les musées de Phnom Penh, '
        'que l\'on soit cambodgien ou étranger. '
        'Merci de m\'avoir écouté.',
    phrases: [
      'Aujourd\'hui, je vais vous parler de…',
      'À mon avis, …',
      'C\'était une visite très émouvante parce que…',
      'Pour conclure, je pense que…',
      'Il est important pour les jeunes de…',
      'On ne peut pas oublier…',
      'Je recommande à tout le monde de…',
    ],
  ),
  RoleplayTopic(
    number: 2,
    title: 'Ma chambre',
    keywords: ['lit', 'bureau', 'fenêtre', 'armoire', 'confortable'],
    script:
        'Bonjour Monsieur. Aujourd\'hui, je vais vous parler de ma chambre : '
        'comment elle est organisée, ce que j\'y fais, '
        'et ce que je voudrais changer dans le futur.\n\n'
        'J\'habite à Phnom Penh, au Cambodge, avec ma famille. '
        'Ma chambre n\'est pas très grande, mais elle est confortable et calme. '
        'C\'est très important pour moi parce que j\'ai besoin d\'un endroit calme pour étudier.\n\n'
        'Dans ma chambre, il y a plusieurs meubles. '
        'D\'abord, il y a un lit simple près de la fenêtre. '
        'La fenêtre donne sur la rue, alors le matin, il y a beaucoup de lumière naturelle. '
        'Ensuite, il y a un grand bureau en bois marron. '
        'C\'est là où je travaille tous les jours. '
        'Sur le bureau, il y a mon ordinateur portable, mes cahiers de cours, '
        'mes livres de français et une lampe de table pour étudier le soir. '
        'Il y a aussi une chaise bleue devant le bureau. '
        'À côté du bureau, il y a une armoire pour mes vêtements '
        'et une petite étagère pour mes livres et mes affaires personnelles.\n\n'
        'À mon avis, le meilleur endroit dans ma chambre est mon bureau. '
        'C\'est là où je passe le plus de temps. '
        'Je peux me concentrer, étudier les mathématiques, la physique et le français, '
        'et préparer mes devoirs sans bruit et sans distraction. '
        'Quand j\'étudie à mon bureau, je me sens plus organisé et plus efficace.\n\n'
        'L\'année dernière, j\'ai changé un peu la décoration de ma chambre. '
        'J\'ai repeint les murs en blanc parce que je voulais quelque chose de plus propre et de plus lumineux. '
        'J\'ai aussi collé des photos de mes amis et de ma famille sur le mur près de mon lit. '
        'Ça me donne de la motivation quand je suis fatigué ou stressé par les examens.\n\n'
        'Dans ma chambre, je fais beaucoup de choses différentes. '
        'Le matin, je me prépare pour aller à l\'Institut de Technologie du Cambodge. '
        'Le soir, j\'étudie, je lis, ou j\'écoute de la musique pour me détendre après les cours. '
        'Le week-end, je regarde parfois des vidéos éducatives sur mon ordinateur.\n\n'
        'Plus tard, quand je travaillerai comme ingénieur, '
        'je voudrais avoir une chambre plus grande avec un grand balcon. '
        'Je voudrais aussi plus de lumière naturelle et un bureau plus spacieux '
        'pour travailler sur des plans et des projets d\'ingénierie.\n\n'
        'Pour conclure, j\'aime beaucoup ma chambre parce que c\'est mon espace personnel. '
        'C\'est un endroit où je peux être moi-même, me reposer et me préparer pour mon avenir. '
        'Merci de m\'avoir écouté.',
    phrases: [
      'Ma chambre est … (grande / petite / confortable)',
      'Il y a … dans ma chambre.',
      'Le meilleur endroit est … parce que …',
      'L\'année dernière, j\'ai … parce que je voulais…',
      'Dans ma chambre, je fais…',
      'Plus tard, je voudrais…',
      'Pour conclure, j\'aime … parce que…',
    ],
  ),
  RoleplayTopic(
    number: 3,
    title: 'Mon université',
    keywords: ['ITC', 'campus', 'professeurs', 'étudiants', 'cours'],
    script: 'Je voudrais vous parler de mon université : l\'Institut de Technologie du Cambodge, que nous appelons l\'ITC. C\'est l\'une des meilleures universités du Cambodge, spécialisée dans les sciences et la technologie.\n\nLe campus est moderne et bien équipé. Il y a des salles de cours, des laboratoires, une bibliothèque et des espaces verts où les étudiants peuvent se détendre entre les cours. Les professeurs sont très compétents et expliquent bien les matières.\n\nJ\'étudie le génie civil depuis deux ans. Les cours sont parfois difficiles, mais très intéressants. Nous apprenons à concevoir des bâtiments, des ponts et des infrastructures. Pour conclure, je suis très content d\'étudier à l\'ITC parce que je pense que c\'est une bonne préparation pour mon avenir professionnel.',
    phrases: [
      'Je voudrais vous parler de…',
      'C\'est l\'une des meilleures…',
      'Les cours sont parfois difficiles mais…',
      'Pour conclure, je suis … de…',
    ],
  ),
  RoleplayTopic(
    number: 4,
    title: 'Le sport et la santé',
    keywords: ['exercice', 'football', 'marcher', 'santé', 'bien-être'],
    script: 'Le sport est très important pour la santé. Personnellement, j\'essaie de rester actif même si j\'ai beaucoup de cours à l\'université. Je marche souvent le soir dans mon quartier pour me détendre et m\'oxygéner après une longue journée d\'études.\n\nLe week-end, je joue parfois au football avec mes amis. C\'est un sport que j\'aime beaucoup parce qu\'il est dynamique et permet de travailler en équipe. Je pense que faire du sport régulièrement aide à se concentrer et à avoir de meilleures notes.\n\nÀ mon avis, les jeunes devraient faire au moins trente minutes de sport par jour pour maintenir une bonne santé physique et mentale. Pour conclure, je crois que l\'équilibre entre les études et le sport est essentiel pour réussir.',
    phrases: [
      'Le sport est très important pour…',
      'Personnellement, j\'essaie de…',
      'Je pense que faire du sport…',
      'À mon avis, les jeunes devraient…',
    ],
  ),
  RoleplayTopic(
    number: 5,
    title: 'Les voyages et les destinations',
    keywords: ['voyage', 'Angkor', 'tourisme', 'destination', 'découvrir'],
    script: 'J\'adore l\'idée de voyager et de découvrir de nouveaux endroits. Jusqu\'à présent, j\'ai surtout visité des villes cambodgiennes comme Siem Reap et Sihanoukville.\n\nMa visite préférée était à Siem Reap pour voir les temples d\'Angkor Wat. C\'était magnifique ! Les temples sont immenses et l\'histoire est fascinante. J\'ai appris beaucoup de choses sur la civilisation khmère de l\'époque.\n\nDans le futur, je voudrais visiter la France, surtout Paris, pour voir la Tour Eiffel et pratiquer mon français. Je crois que voyager est la meilleure façon d\'apprendre une nouvelle culture et une nouvelle langue. Pour conclure, les voyages nous ouvrent l\'esprit et nous permettent de mieux comprendre le monde.',
    phrases: [
      'J\'adore l\'idée de voyager parce que…',
      'Ma visite préférée était à … parce que…',
      'Dans le futur, je voudrais visiter…',
      'Je crois que voyager permet de…',
    ],
  ),
];

// ── INTERACTION topics ────────────────────────────────────────
const List<RoleplayTopic> kInteractionTopics = [
  RoleplayTopic(
    number: 1,
    title: 'Au café — commander',
    keywords: ['café', 'commander', 'boisson', 'prix', 'addition'],
    phrases: [
      'Je voudrais … s\'il vous plaît.',
      'C\'est combien ?',
      'L\'addition, s\'il vous plaît.',
      'Avez-vous … ?',
      'Je vais prendre…',
    ],
    script: 'A: Bonjour, je peux vous aider ?\nB: Bonjour, je voudrais un café et un croissant, s\'il vous plaît.\nA: Bien sûr. Vous voulez un café noir ou un café au lait ?\nB: Un café au lait, merci. C\'est combien ?\nA: Ça fait trois euros cinquante.\nB: Voilà. Merci beaucoup.\nA: De rien, bonne journée !',
  ),
  RoleplayTopic(
    number: 2,
    title: 'Demander son chemin',
    keywords: ['direction', 'rue', 'tournez', 'tout droit', 'à gauche'],
    phrases: [
      'Excusez-moi, où est … ?',
      'Tournez à gauche / à droite.',
      'Allez tout droit.',
      'C\'est à … mètres / minutes.',
      'Je suis perdu(e). Pouvez-vous m\'aider ?',
    ],
    script: 'A: Excusez-moi, je cherche la bibliothèque municipale.\nB: La bibliothèque ? Elle est tout droit, puis tournez à gauche au feu rouge.\nA: C\'est loin ?\nB: Non, c\'est à environ cinq minutes à pied.\nA: Merci beaucoup, vous êtes très aimable.\nB: De rien, bonne continuation !',
  ),
  RoleplayTopic(
    number: 3,
    title: 'Chez le médecin',
    keywords: ['malade', 'symptômes', 'fièvre', 'médicament', 'ordonnance'],
    phrases: [
      'J\'ai mal à … (la tête, le ventre…)',
      'J\'ai de la fièvre depuis … jours.',
      'Je ne me sens pas bien.',
      'Vous pouvez me prescrire quelque chose ?',
      'Quand est-ce que je dois prendre ce médicament ?',
    ],
    script: 'A: Bonjour docteur, je ne me sens pas bien depuis hier.\nB: Qu\'est-ce qui ne va pas ?\nA: J\'ai de la fièvre et mal à la gorge.\nB: Depuis combien de temps ?\nA: Depuis deux jours environ.\nB: Je vais vous examiner. Ouvrez la bouche… Je vais vous prescrire des antibiotiques. Reposez-vous bien.\nA: Merci docteur.',
  ),
  RoleplayTopic(
    number: 4,
    title: 'Faire des achats',
    keywords: ['boutique', 'taille', 'prix', 'essayer', 'payer'],
    phrases: [
      'Je cherche … (une chemise, des chaussures…)',
      'Vous avez ça en taille … ?',
      'Je peux l\'essayer ?',
      'C\'est trop cher. Vous avez quelque chose de moins cher ?',
      'Je le / la prends.',
    ],
    script: 'A: Bonjour, je peux vous aider ?\nB: Oui, je cherche une chemise pour une occasion formelle.\nA: Quelle taille faites-vous ?\nB: Je fais du M en général.\nA: Voilà, nous avons ce modèle en bleu et en blanc.\nB: Je peux essayer la bleue ?\nA: Bien sûr, la cabine est par là.\nB: Elle me va bien. C\'est combien ?\nA: Trente-cinq euros.\nB: Je la prends. Je peux payer par carte ?',
  ),
  RoleplayTopic(
    number: 5,
    title: 'Réserver un hôtel',
    keywords: ['chambre', 'réservation', 'nuit', 'prix', 'disponible'],
    phrases: [
      'Je voudrais réserver une chambre pour … nuits.',
      'Avez-vous une chambre disponible pour … personnes ?',
      'Quel est le prix par nuit ?',
      'Le petit-déjeuner est inclus ?',
      'Pouvez-vous me confirmer la réservation par email ?',
    ],
    script: 'A: Allô, hôtel Mékong, bonjour.\nB: Bonjour, je voudrais réserver une chambre pour deux nuits.\nA: Pour quelles dates ?\nB: Du dix au douze juin.\nA: Nous avons une chambre double disponible à soixante euros la nuit.\nB: Le petit-déjeuner est inclus ?\nA: Oui, le buffet du matin est compris.\nB: Parfait, je la réserve. Pouvez-vous me confirmer par email ?\nA: Bien sûr, votre email ?',
  ),
];
