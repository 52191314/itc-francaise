import '../models/grammar_rule.dart';

const List<GrammarRule> grammarRules = [
  GrammarRule(
    id: 1,
    title: 'Subject Pronouns',
    level: 'A1',
    rule: 'The subject tells who does the action. French normally needs an explicit subject pronoun.',
    pattern: '`je`, `tu`, `il/elle/on`, `nous`, `vous`, `ils/elles` + verb',
    examples: [
      GrammarExample(
        french: 'Je suis étudiant.',
        english: 'I am a student.',
      ),
      GrammarExample(
        french: 'Tu habites à Bangkok ?',
        english: 'Do you live in Bangkok?',
      ),
      GrammarExample(
        french: 'Elle parle français.',
        english: 'She speaks French.',
      ),
      GrammarExample(
        french: 'On regarde la photo.',
        english: 'We/people look at the photo.',
      ),
    ],
    note: '`on` often means informal `we`, but grammar treats it like `il/elle`: on est, on parle.',
  ),
  GrammarRule(
    id: 2,
    title: 's\'appeler',
    level: 'A1',
    rule: 'Use s\'appeler to say someone\'s name. It is pronominal.',
    pattern: '`je m\'appelle`, `tu t\'appelles`, `il/elle/on s\'appelle`, `nous nous appelons`, `vous vous appelez`, `ils/elles s\'appellent`',
    examples: [
      GrammarExample(
        french: 'Je m\'appelle Lina.',
        english: 'My name is Lina.',
      ),
      GrammarExample(
        french: 'Tu t\'appelles comment ?',
        english: 'What is your name?',
      ),
      GrammarExample(
        french: 'Il s\'appelle Marc.',
        english: 'His name is Marc.',
      ),
    ],
    note: 'In French, you "call yourself" a name: Je m\'appelle..., not Je suis...',
  ),
  GrammarRule(
    id: 3,
    title: 'être (to be)',
    level: 'A1',
    rule: 'être means to be. It is irregular and very common.',
    pattern: '`je suis`, `tu es`, `il/elle/on est`, `nous sommes`, `vous êtes`, `ils/elles sont`',
    examples: [
      GrammarExample(
        french: 'Je suis français.',
        english: 'I am French.',
      ),
      GrammarExample(
        french: 'Tu es en classe ?',
        english: 'Are you in class?',
      ),
      GrammarExample(
        french: 'Elle est calme.',
        english: 'She is calm.',
      ),
      GrammarExample(
        french: 'Nous sommes amis.',
        english: 'We are friends.',
      ),
    ],
    note: 'Use être for identity, nationality, profession, location, and many states.',
  ),
  GrammarRule(
    id: 4,
    title: 'avoir (to have)',
    level: 'A1',
    rule: 'avoir means to have, but French also uses it for age and physical states.',
    pattern: '`j\'ai`, `tu as`, `il/elle/on a`, `nous avons`, `vous avez`, `ils/elles ont`',
    examples: [
      GrammarExample(
        french: 'J\'ai vingt ans.',
        english: 'I am twenty years old.',
      ),
      GrammarExample(
        french: 'Tu as un frère ?',
        english: 'Do you have a brother?',
      ),
      GrammarExample(
        french: 'Elle a une carte d\'identité.',
        english: 'She has an ID card.',
      ),
    ],
    note: 'Age uses avoir: J\'ai 25 ans, not Je suis 25 ans.',
  ),
  GrammarRule(
    id: 5,
    title: 'Regular -er Verbs: parler',
    level: 'A1',
    rule: 'Most French verbs ending in -er follow the same present-tense pattern.',
    pattern: 'Remove `-er`, add `-e`, `-es`, `-e`, `-ons`, `-ez`, `-ent`',
    examples: [
      GrammarExample(
        french: 'Je parle anglais.',
        english: 'I speak English.',
      ),
      GrammarExample(
        french: 'Tu regardes la carte.',
        english: 'You look at the map.',
      ),
      GrammarExample(
        french: 'Nous habitons à Lyon.',
        english: 'We live in Lyon.',
      ),
    ],
    note: 'The endings -e, -es, and -ent are often silent.',
  ),
  GrammarRule(
    id: 6,
    title: 'Living In Cities & Countries',
    level: 'A1',
    rule: 'Use à with cities. Use en, au, aux with countries depending on gender/number.',
    pattern: '`à + city`; `en + feminine country`; `au + masculine country`; `aux + plural country`',
    examples: [
      GrammarExample(
        french: 'J\'habite à Paris.',
        english: 'I live in Paris.',
      ),
      GrammarExample(
        french: 'Elle habite en France.',
        english: 'She lives in France.',
      ),
      GrammarExample(
        french: 'Il habite au Canada.',
        english: 'He lives in Canada.',
      ),
    ],
    note: 'Many feminine country names end in -e: la France, l\'Espagne.',
  ),
  GrammarRule(
    id: 7,
    title: 'venir de (coming from)',
    level: 'A1',
    rule: 'Use venir de to say where someone comes from.',
    pattern: '`venir de + city`; `venir du/de la/de l\'/des + country`',
    examples: [
      GrammarExample(
        french: 'Je viens de Marseille.',
        english: 'I come from Marseille.',
      ),
      GrammarExample(
        french: 'Elle vient du Maroc.',
        english: 'She comes from Morocco.',
      ),
    ],
    note: 'de + le = du, de + les = des, de becomes d\' before a vowel.',
  ),
  GrammarRule(
    id: 8,
    title: 'Negation: ne…pas',
    level: 'A1',
    rule: 'Put ne before the conjugated verb and pas after it.',
    pattern: '`subject + ne/n\' + verb + pas`',
    examples: [
      GrammarExample(
        french: 'Je ne suis pas professeur.',
        english: 'I am not a teacher.',
      ),
      GrammarExample(
        french: 'Elle ne parle pas espagnol.',
        english: 'She does not speak Spanish.',
      ),
    ],
    note: 'In casual speech, ne is often dropped, but keep it in writing.',
  ),
  GrammarRule(
    id: 9,
    title: 'Questions by Intonation',
    level: 'A1',
    rule: 'The simplest spoken question keeps normal word order and rises at the end.',
    pattern: 'statement + rising voice + `?`',
    examples: [
      GrammarExample(
        french: 'Tu es français ?',
        english: 'Are you French?',
      ),
      GrammarExample(
        french: 'Vous parlez anglais ?',
        english: 'Do you speak English?',
      ),
    ],
    note: 'Common in conversation. In writing, prefer est-ce que or inversion.',
  ),
  GrammarRule(
    id: 10,
    title: 'quel / quelle / quels / quelles',
    level: 'A1',
    rule: 'quel means which/what before a noun. It agrees with the noun.',
    pattern: '`quel` masc.sg; `quelle` fem.sg; `quels` masc.pl; `quelles` fem.pl',
    examples: [
      GrammarExample(
        french: 'Quel âge as-tu ?',
        english: 'How old are you?',
      ),
      GrammarExample(
        french: 'Quelle langue parlez-vous ?',
        english: 'What language do you speak?',
      ),
    ],
    note: 'quel agrees with the noun after it, not the person answering.',
  ),
  GrammarRule(
    id: 11,
    title: 'Presentatives: voici, voilà, c\'est',
    level: 'A1',
    rule: 'Use presentatives to point out or introduce someone/something.',
    pattern: '`voici/voilà + noun`; `c\'est + name/singular`; `ce sont + plural`',
    examples: [
      GrammarExample(
        french: 'Voici mon amie Sarah.',
        english: 'Here is my friend Sarah.',
      ),
      GrammarExample(
        french: 'C\'est Lucas.',
        english: 'This is Lucas.',
      ),
      GrammarExample(
        french: 'Ce sont mes parents.',
        english: 'These are my parents.',
      ),
    ],
    note: 'c\'est is singular; ce sont is plural in careful writing.',
  ),
  GrammarRule(
    id: 12,
    title: 'Definite Articles',
    level: 'A1',
    rule: 'Definite articles mean the or refer to a general category.',
    pattern: '`le` masc.sg; `la` fem.sg; `l\'` before vowel/silent h; `les` plural',
    examples: [
      GrammarExample(
        french: 'J\'aime le chocolat.',
        english: 'I like chocolate (in general).',
      ),
      GrammarExample(
        french: 'Les enfants jouent.',
        english: 'The children are playing.',
      ),
    ],
    note: 'French uses articles more often than English.',
  ),
  GrammarRule(
    id: 13,
    title: 'Indefinite Articles',
    level: 'A1',
    rule: 'Indefinite articles mean a/an or some.',
    pattern: '`un` masc.sg; `une` fem.sg; `des` plural',
    examples: [
      GrammarExample(
        french: 'J\'ai un frère.',
        english: 'I have a brother.',
      ),
      GrammarExample(
        french: 'Elle a une sœur.',
        english: 'She has a sister.',
      ),
    ],
    note: 'After negation: un/une/des → de: pas de frère.',
  ),
  GrammarRule(
    id: 14,
    title: 'Contracted Articles',
    level: 'A1',
    rule: 'Some preposition + article combinations contract.',
    pattern: '`à + le = au`; `à + les = aux`; `de + le = du`; `de + les = des`',
    examples: [
      GrammarExample(
        french: 'Je vais au cinéma.',
        english: 'I am going to the cinema.',
      ),
      GrammarExample(
        french: 'Il vient du lycée.',
        english: 'He comes from the high school.',
      ),
    ],
    note: 'No contraction with la or l\': à la maison, à l\'école.',
  ),
  GrammarRule(
    id: 15,
    title: 'Possessive Adjectives',
    level: 'A1',
    rule: 'Possessive adjectives agree with the thing possessed, not the owner.',
    pattern: '`mon/ma/mes`; `ton/ta/tes`; `son/sa/ses`; `notre/nos`; `votre/vos`; `leur/leurs`',
    examples: [
      GrammarExample(
        french: 'Mon père est drôle.',
        english: 'My father is funny.',
      ),
      GrammarExample(
        french: 'Leur chien est petit.',
        english: 'Their dog is small.',
      ),
    ],
    note: 'Use mon/ton/son before a feminine noun starting with a vowel: mon amie.',
  ),
  GrammarRule(
    id: 16,
    title: 'Feminine Adjectives',
    level: 'A1',
    rule: 'Most feminine adjectives add -e. Some forms change more.',
    pattern: '`-eux → -euse`; `-if → -ive`; `-er → -ère`; `-ien → -ienne`',
    examples: [
      GrammarExample(
        french: 'Il est grand. / Elle est grande.',
        english: 'He/She is tall.',
      ),
      GrammarExample(
        french: 'Il est sportif. / Elle est sportive.',
        english: 'He/She is athletic.',
      ),
    ],
    note: 'Some adjectives already end in silent -e and don\'t change: calme, jeune.',
  ),
  GrammarRule(
    id: 17,
    title: 'Plural Nouns & Adjectives',
    level: 'A1',
    rule: 'Most plurals add -s; adjectives agree with the noun.',
    pattern: '`noun/adj + s`; `-eau → -eaux`; many `-al → -aux`',
    examples: [
      GrammarExample(
        french: 'un ami français / des amis français',
        english: 'French friends',
      ),
      GrammarExample(
        french: 'un animal original / des animaux originaux',
        english: 'original animals',
      ),
    ],
    note: 'Final plural -s is usually silent.',
  ),
  GrammarRule(
    id: 18,
    title: 'Stressed Pronouns',
    level: 'A1',
    rule: 'Used after prepositions, for emphasis, and in short answers.',
    pattern: '`moi`, `toi`, `lui`, `elle`, `nous`, `vous`, `eux`, `elles`',
    examples: [
      GrammarExample(
        french: 'Moi, je suis belge.',
        english: 'Me, I am Belgian.',
      ),
      GrammarExample(
        french: 'Je travaille avec lui.',
        english: 'I work with him.',
      ),
    ],
    note: 'Use moi/toi after prepositions, not je/tu.',
  ),
  GrammarRule(
    id: 19,
    title: 'Questions with est-ce que',
    level: 'A1',
    rule: 'Est-ce que turns a statement into a question without changing word order.',
    pattern: '`Est-ce que/qu\' + subject + verb…?`',
    examples: [
      GrammarExample(
        french: 'Est-ce que tu es prêt ?',
        english: 'Are you ready?',
      ),
      GrammarExample(
        french: 'Est-ce qu\'elle parle français ?',
        english: 'Does she speak French?',
      ),
    ],
    note: 'Use Est-ce qu\' before a vowel sound.',
  ),
  GrammarRule(
    id: 20,
    title: 'qu\'est-ce que',
    level: 'A1',
    rule: 'Use qu\'est-ce que to ask what as the object of the verb.',
    pattern: '`Qu\'est-ce que/qu\' + subject + verb…?`',
    examples: [
      GrammarExample(
        french: 'Qu\'est-ce que tu fais ?',
        english: 'What are you doing?',
      ),
      GrammarExample(
        french: 'Qu\'est-ce que c\'est ?',
        english: 'What is it?',
      ),
    ],
    note: 'For people, use qui: Qui est-ce que tu appelles ?',
  ),
  GrammarRule(
    id: 21,
    title: 'Professions Without Articles',
    level: 'A1',
    rule: 'After être, basic professions normally appear without an article.',
    pattern: '`subject + être + profession`',
    examples: [
      GrammarExample(
        french: 'Je suis étudiant.',
        english: 'I am a student.',
      ),
      GrammarExample(
        french: 'Elle est médecin.',
        english: 'She is a doctor.',
      ),
    ],
    note: 'Add an article if you add a qualifying adjective: C\'est un bon médecin.',
  ),
  GrammarRule(
    id: 22,
    title: 'Pronominal Verbs',
    level: 'A1',
    rule: 'Pronominal verbs use a reflexive pronoun that changes with the subject.',
    pattern: '`me/m\'`, `te/t\'`, `se/s\'`, `nous`, `vous`, `se/s\'` + verb',
    examples: [
      GrammarExample(
        french: 'Je me lève à sept heures.',
        english: 'I get up at seven.',
      ),
      GrammarExample(
        french: 'Elle se prépare vite.',
        english: 'She gets ready quickly.',
      ),
    ],
    note: 'In the negative: Je ne me lève pas.',
  ),
  GrammarRule(
    id: 23,
    title: 'aller + Going To Places',
    level: 'A1',
    rule: 'Use aller à to say where someone is going.',
    pattern: '`aller à + place`; contractions: `au`, `aux`',
    examples: [
      GrammarExample(
        french: 'Je vais à l\'école.',
        english: 'I am going to school.',
      ),
      GrammarExample(
        french: 'Tu vas au parc ?',
        english: 'Are you going to the park?',
      ),
    ],
    note: 'chez = to/at someone\'s place: chez moi, chez le médecin.',
  ),
  GrammarRule(
    id: 24,
    title: 'il y a (there is/are)',
    level: 'A1',
    rule: 'il y a means there is/there are.',
    pattern: '`Il y a + noun`; negative: `Il n\'y a pas de + noun`',
    examples: [
      GrammarExample(
        french: 'Il y a un parc près d\'ici.',
        english: 'There is a park near here.',
      ),
      GrammarExample(
        french: 'Il n\'y a pas de bus.',
        english: 'There is no bus.',
      ),
    ],
    note: 'In negative quantity, use de/d\'.',
  ),
  GrammarRule(
    id: 25,
    title: 'faire de (activities)',
    level: 'A1',
    rule: 'Use faire de for many sports and activities.',
    pattern: '`faire du/de la/de l\'/des + activity`',
    examples: [
      GrammarExample(
        french: 'Je fais du vélo.',
        english: 'I cycle.',
      ),
      GrammarExample(
        french: 'Elle fait de la natation.',
        english: 'She swims.',
      ),
    ],
    note: 'After negation, partitives → de: Je ne fais pas de sport.',
  ),
  GrammarRule(
    id: 26,
    title: 'Partitive Articles',
    level: 'A1',
    rule: 'Use partitives for an unspecified amount of food, drink, or abstract things.',
    pattern: '`du`, `de la`, `de l\'`, `des`; negative: `pas de/d\'`',
    examples: [
      GrammarExample(
        french: 'Je prends du pain.',
        english: 'I am having some bread.',
      ),
      GrammarExample(
        french: 'Tu veux du café ?',
        english: 'Do you want coffee?',
      ),
    ],
    note: 'Definite for likes: J\'aime le café. Partitive for consumption: Je bois du café.',
  ),
  GrammarRule(
    id: 27,
    title: 'Quantity Expressions',
    level: 'A1',
    rule: 'Quantity words are followed by de/d\', not du/de la/des.',
    pattern: '`beaucoup de`, `un peu de`, `trop de`, `assez de`',
    examples: [
      GrammarExample(
        french: 'Je bois beaucoup d\'eau.',
        english: 'I drink a lot of water.',
      ),
      GrammarExample(
        french: 'Tu as assez de temps ?',
        english: 'Do you have enough time?',
      ),
    ],
    note: 'Combien de... also uses de.',
  ),
  GrammarRule(
    id: 28,
    title: 'vouloir (to want)',
    level: 'A1',
    rule: 'vouloir means to want. It is irregular.',
    pattern: '`je veux`, `tu veux`, `il veut`, `nous voulons`, `vous voulez`, `ils veulent`',
    examples: [
      GrammarExample(
        french: 'Je veux un café.',
        english: 'I want a coffee.',
      ),
      GrammarExample(
        french: 'Elle veut apprendre le français.',
        english: 'She wants to learn French.',
      ),
    ],
    note: 'For politeness, prefer je voudrais or j\'aimerais.',
  ),
  GrammarRule(
    id: 29,
    title: 'Recent Past: venir de + inf.',
    level: 'A1',
    rule: 'Use venir de + infinitive for something that has just happened.',
    pattern: 'present of `venir` + `de/d\'` + infinitive',
    examples: [
      GrammarExample(
        french: 'Je viens de finir.',
        english: 'I have just finished.',
      ),
      GrammarExample(
        french: 'Elle vient d\'arriver.',
        english: 'She has just arrived.',
      ),
    ],
    note: 'Compare: Je viens de Paris (origin) vs. Je viens de partir (recent past).',
  ),
  GrammarRule(
    id: 30,
    title: 'Near Future: aller + inf.',
    level: 'A1',
    rule: 'Use the near future for plans or things going to happen soon.',
    pattern: 'present of `aller` + infinitive',
    examples: [
      GrammarExample(
        french: 'Je vais étudier ce soir.',
        english: 'I am going to study tonight.',
      ),
      GrammarExample(
        french: 'Nous allons visiter Lyon.',
        english: 'We are going to visit Lyon.',
      ),
    ],
    note: 'Only aller is conjugated; the second verb stays infinitive.',
  ),
  GrammarRule(
    id: 31,
    title: 'The Imperative',
    level: 'A1',
    rule: 'Use the imperative for commands, invitations, advice, instructions.',
    pattern: 'verb without subject: `tu`, `nous`, or `vous` form; -er drops final s in tu',
    examples: [
      GrammarExample(
        french: 'Regarde la photo !',
        english: 'Look at the photo!',
      ),
      GrammarExample(
        french: 'Allons au parc !',
        english: 'Let\'s go to the park!',
      ),
    ],
    note: 'tu imperative of -er verbs drops s: parle, not parles; but vas-y keeps s.',
  ),
  GrammarRule(
    id: 32,
    title: 'Place Prepositions',
    level: 'A1',
    rule: 'Place prepositions say where something is.',
    pattern: '`dans`, `sur`, `sous`, `entre`, `à côté de`, `devant`, `derrière`',
    examples: [
      GrammarExample(
        french: 'Le livre est sur la table.',
        english: 'The book is on the table.',
      ),
      GrammarExample(
        french: 'La pharmacie est à côté de la banque.',
        english: 'The pharmacy is next to the bank.',
      ),
    ],
    note: 'de + le = du: près du métro.',
  ),
  GrammarRule(
    id: 33,
    title: 'Demonstrative Adjectives',
    level: 'A1',
    rule: 'Demonstratives mean this/that/these and agree with the noun.',
    pattern: '`ce` masc; `cet` masc before vowel; `cette` fem; `ces` plural',
    examples: [
      GrammarExample(
        french: 'Cette robe est jolie.',
        english: 'This dress is pretty.',
      ),
      GrammarExample(
        french: 'Ces chaussures sont confortables.',
        english: 'These shoes are comfortable.',
      ),
    ],
    note: 'Add -ci or -là if needed: ce livre-ci, ce livre-là.',
  ),
  GrammarRule(
    id: 34,
    title: 'passé composé with avoir',
    level: 'A2',
    rule: 'Use passé composé for completed past actions. Most verbs use avoir.',
    pattern: 'present of `avoir` + past participle',
    examples: [
      GrammarExample(
        french: 'J\'ai visité Paris.',
        english: 'I visited Paris.',
      ),
      GrammarExample(
        french: 'Elle a fini son travail.',
        english: 'She finished her work.',
      ),
    ],
    note: '-er → -é, -ir → -i, -re → -u; many irregular: faire → fait, prendre → pris.',
    summary: 'Build it in two parts: conjugate `avoir` in the present, then add the past participle.',
    explain: 'Use this tense for a finished past action: one thing happened and is complete. The auxiliary changes with the subject; the past participle usually stays fixed with `avoir` at A2.',
    steps: [
      'Choose the subject: `je`, `tu`, `elle`, `nous`, etc.',
      'Conjugate `avoir`: `j\'ai`, `tu as`, `il/elle a`, `nous avons`, `vous avez`, `ils/elles ont`.',
      'Add the past participle: `parler -> parlé`, `finir -> fini`, `vendre -> vendu`.',
      'Memorize common irregular participles: `faire -> fait`, `prendre -> pris`, `voir -> vu`, `mettre -> mis`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Subject',
          'parler',
          'finir',
        ],
        rows: [
          [
            'je',
            'j\'ai parlé',
            'j\'ai fini',
          ],
          [
            'tu',
            'tu as parlé',
            'tu as fini',
          ],
          [
            'il/elle/on',
            'il a parlé',
            'elle a fini',
          ],
          [
            'nous',
            'nous avons parlé',
            'nous avons fini',
          ],
          [
            'vous',
            'vous avez parlé',
            'vous avez fini',
          ],
          [
            'ils/elles',
            'ils ont parlé',
            'elles ont fini',
          ],
        ],
      ),
    ],
    trap: 'Do not conjugate the second verb: write `j\'ai parlé`, not `j\'ai parle` or `je suis parlé`.',
  ),
  GrammarRule(
    id: 35,
    title: 'passé composé with être',
    level: 'A2',
    rule: 'Some movement/change verbs and pronominal verbs use être; participle agrees with subject.',
    pattern: 'present of `être` + past participle (+agreement)',
    examples: [
      GrammarExample(
        french: 'Elle est arrivée à huit heures.',
        english: 'She arrived at eight.',
      ),
      GrammarExample(
        french: 'Nous sommes partis tôt.',
        english: 'We left early.',
      ),
    ],
    note: 'Common être verbs: aller, venir, arriver, partir, entrer, sortir, naître, mourir, rester, tomber.',
    summary: 'Same passé composé idea, but the auxiliary is `être`, so the past participle agrees with the subject.',
    explain: 'Use `être` with many verbs of movement/change of state and with pronominal verbs. The learner\'s job is to conjugate `être` first, then adjust the participle ending: add `e` for feminine, `s` for plural, `es` for feminine plural.',
    steps: [
      'Conjugate `être`: `je suis`, `tu es`, `il/elle est`, `nous sommes`, `vous êtes`, `ils/elles sont`.',
      'Add the past participle: `aller -> allé`, `venir -> venu`, `partir -> parti`, `arriver -> arrivé`.',
      'Make agreement with the subject: `elle est arrivée`, `nous sommes arrivés`, `elles sont venues`.',
      'Use `être` for common verbs like `aller`, `venir`, `arriver`, `partir`, `entrer`, `sortir`, `rester`, `tomber`, `naître`, `mourir`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Subject',
          'être + arriver',
        ],
        rows: [
          [
            'je',
            'je suis arrivé(e)',
          ],
          [
            'tu',
            'tu es arrivé(e)',
          ],
          [
            'il / elle',
            'il est arrivé / elle est arrivée',
          ],
          [
            'nous',
            'nous sommes arrivé(e)s',
          ],
          [
            'vous',
            'vous êtes arrivé(e)(s)',
          ],
          [
            'ils / elles',
            'ils sont arrivés / elles sont arrivées',
          ],
        ],
      ),
    ],
    trap: 'The auxiliary is the part you conjugate. The past participle is not `arrive`; it is `arrivé`, then agreement is added when needed.',
  ),
  GrammarRule(
    id: 36,
    title: 'passé composé of Pronominal Verbs',
    level: 'A2',
    rule: 'Pronominal verbs use être in the passé composé.',
    pattern: 'subject + reflexive pronoun + `être` + past participle',
    examples: [
      GrammarExample(
        french: 'Je me suis levé à sept heures.',
        english: 'I got up at seven.',
      ),
      GrammarExample(
        french: 'Elle s\'est couchée tard.',
        english: 'She went to bed late.',
      ),
    ],
    note: 'Negative: Je ne me suis pas levé.',
    summary: 'Pronominal passé composé keeps the reflexive pronoun and uses `être`: `je me suis levé`.',
    explain: 'The reflexive pronoun stays before `être`. After that, build the tense like other `être` verbs: conjugated `être` + past participle, with agreement for the subject in the usual A2 cases.',
    steps: [
      'Choose the reflexive pronoun: `me`, `te`, `se`, `nous`, `vous`, `se`.',
      'Conjugate `être`: `me suis`, `t\'es`, `s\'est`, `nous sommes`, `vous êtes`, `se sont`.',
      'Add the past participle: `levé`, `couché`, `préparé`, `promené`.',
      'Put negation around the reflexive pronoun + auxiliary: `Je ne me suis pas levé`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Subject',
          'se lever',
        ],
        rows: [
          [
            'je',
            'je me suis levé(e)',
          ],
          [
            'tu',
            'tu t\'es levé(e)',
          ],
          [
            'il / elle',
            'il s\'est levé / elle s\'est levée',
          ],
          [
            'nous',
            'nous nous sommes levé(e)s',
          ],
          [
            'vous',
            'vous vous êtes levé(e)(s)',
          ],
          [
            'ils / elles',
            'ils se sont levés / elles se sont levées',
          ],
        ],
      ),
    ],
    trap: 'Keep the small pronoun: `je me suis levé`, not `je suis levé` when the verb is `se lever`.',
  ),
  GrammarRule(
    id: 37,
    title: 'Pronoun y',
    level: 'A2',
    rule: 'y replaces a place or à + thing phrase.',
    pattern: '`y` before conjugated verb; before infinitive with two verbs',
    examples: [
      GrammarExample(
        french: 'Je vais à la gare. → J\'y vais.',
        english: 'I am going there.',
      ),
      GrammarExample(
        french: 'Je ne veux pas y aller.',
        english: 'I don\'t want to go there.',
      ),
    ],
    note: 'y cannot replace people. Use stressed pronouns: Je pense à elle.',
    summary: 'Use `y` to avoid repeating a place or an `à + thing` phrase.',
    explain: '`Y` usually means `there` or `to it`. It goes before the conjugated verb, but if there is an infinitive, it often goes before the infinitive.',
    steps: [
      'Find the phrase with a place or `à + thing`: `à la gare`, `au musée`, `à ce problème`.',
      'Replace that whole phrase with `y`.',
      'Place `y` before one conjugated verb: `J\'y vais`.',
      'With two verbs, place it before the infinitive: `Je vais y aller`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Original',
          'With `y`',
        ],
        rows: [
          [
            'Je vais à la gare.',
            'J\'y vais.',
          ],
          [
            'Nous pensons à ce problème.',
            'Nous y pensons.',
          ],
          [
            'Je veux aller au musée.',
            'Je veux y aller.',
          ],
        ],
      ),
    ],
    trap: 'Do not use `y` for people. Say `Je pense à elle`, not `j\'y pense`, when `elle` is a person.',
  ),
  GrammarRule(
    id: 38,
    title: 'Direct Object Pronouns: le, la, les',
    level: 'A2',
    rule: 'Replace a direct object (thing/person directly receiving action).',
    pattern: '`le/la/l\'/les` before conjugated verb; before infinitive in two-verb structures',
    examples: [
      GrammarExample(
        french: 'Je regarde le film. → Je le regarde.',
        english: 'I watch it.',
      ),
      GrammarExample(
        french: 'Je ne les comprends pas.',
        english: 'I don\'t understand them.',
      ),
    ],
    note: 'In passé composé with avoir, preceding DO can trigger agreement: Je l\'ai vue (fem).',
    summary: 'Direct object pronouns replace the thing or person directly receiving the action.',
    explain: 'Ask `verb + who/what?` If the answer is direct, use `le`, `la`, `l\'`, or `les`. The pronoun usually goes before the conjugated verb.',
    steps: [
      'Find the direct object: in `Je regarde le film`, ask `I watch what?` -> `le film`.',
      'Choose the pronoun: `le` masculine, `la` feminine, `l\'` before a vowel, `les` plural.',
      'Put it before the conjugated verb: `Je le regarde`.',
      'With two verbs, put it before the infinitive: `Je vais le regarder`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Object',
          'Pronoun',
          'Example',
        ],
        rows: [
          [
            'le film',
            'le',
            'Je le regarde.',
          ],
          [
            'la photo',
            'la',
            'Je la prends.',
          ],
          [
            'l\'adresse',
            'l\'',
            'Je l\'écris.',
          ],
          [
            'les billets',
            'les',
            'Je les achète.',
          ],
        ],
      ),
    ],
    trap: 'Do not keep both the noun and pronoun together: `Je le regarde`, not `Je le regarde le film`.',
  ),
  GrammarRule(
    id: 39,
    title: 'Pronoun en',
    level: 'A2',
    rule: 'en replaces de + noun, quantities, and partitive expressions.',
    pattern: '`en` before conjugated verb; before infinitive in two-verb structures',
    examples: [
      GrammarExample(
        french: 'Tu veux du pain ? → Oui, j\'en veux.',
        english: 'Yes, I want some.',
      ),
      GrammarExample(
        french: 'Elle a trois frères. → Elle en a trois.',
        english: 'She has three.',
      ),
    ],
    note: 'Keep the quantity word after verb: J\'en veux deux.',
    summary: 'Use `en` for `de + noun`, quantities, and partitive ideas like `du pain`.',
    explain: '`En` often means `some`, `of it`, or `of them`. It replaces the noun phrase, but numbers and quantity words usually remain after the verb.',
    steps: [
      'Find a `de` phrase or quantity: `du pain`, `trois frères`, `beaucoup de photos`.',
      'Replace the noun phrase with `en`.',
      'Place `en` before the conjugated verb: `J\'en veux`.',
      'Keep the quantity after the verb: `J\'en veux deux`, `Il en prend beaucoup`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Original',
          'With `en`',
        ],
        rows: [
          [
            'Tu veux du pain ?',
            'Oui, j\'en veux.',
          ],
          [
            'Elle a trois frères.',
            'Elle en a trois.',
          ],
          [
            'Il parle de ce film.',
            'Il en parle.',
          ],
        ],
      ),
    ],
    trap: 'Keep the number or amount: `J\'en ai deux`, not `J\'en ai` if the important information is `two`.',
  ),
  GrammarRule(
    id: 40,
    title: 'Present Progressive: être en train de',
    level: 'A2',
    rule: 'Emphasize that an action is happening right now.',
    pattern: 'present of `être` + `en train de/d\'` + infinitive',
    examples: [
      GrammarExample(
        french: 'Je suis en train de cuisiner.',
        english: 'I am cooking right now.',
      ),
      GrammarExample(
        french: 'Nous sommes en train de manger.',
        english: 'We are eating right now.',
      ),
    ],
    note: 'French present alone can mean I do or I am doing; this adds emphasis.',
    summary: 'Use `être en train de` when you want to stress that the action is happening right now.',
    explain: 'French present tense can already mean `I am doing`. This structure adds focus: the action is in progress at this exact moment.',
    steps: [
      'Conjugate `être` for the subject: `je suis`, `tu es`, `nous sommes`, etc.',
      'Add `en train de` before a consonant or `en train d\'` before a vowel.',
      'Add the infinitive: `lire`, `étudier`, `préparer`.',
      'For negation, put `ne... pas` around `être`: `Je ne suis pas en train de dormir`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Subject',
          'être en train de + infinitive',
        ],
        rows: [
          [
            'je',
            'je suis en train de lire',
          ],
          [
            'tu',
            'tu es en train d\'étudier',
          ],
          [
            'nous',
            'nous sommes en train de préparer',
          ],
          [
            'ils',
            'ils sont en train de manger',
          ],
        ],
      ),
    ],
    trap: 'Do not conjugate both verbs: say `je suis en train de lire`, not `je suis en train de lis`.',
  ),
  GrammarRule(
    id: 41,
    title: 'il faut (obligation)',
    level: 'A2',
    rule: 'il faut + infinitive expresses general obligation or necessity.',
    pattern: '`il faut + infinitive`; negative: `il ne faut pas + infinitive`',
    examples: [
      GrammarExample(
        french: 'Il faut écouter.',
        english: 'You/one must listen.',
      ),
      GrammarExample(
        french: 'Il ne faut pas fumer ici.',
        english: 'You must not smoke here.',
      ),
    ],
    note: 'il faut is impersonal. Use devoir for a specific person: Je dois partir.',
    summary: '`Il faut` gives a general rule or need, like `it is necessary to...`.',
    explain: 'The form `faut` does not change with the person. Use it when the instruction applies generally. Use `devoir` when you want to say exactly who must do something.',
    steps: [
      'Start with `il faut`.',
      'Add an infinitive: `écouter`, `réserver`, `partir`, `faire`.',
      'For a negative rule, use `il ne faut pas + infinitive`.',
      'For a specific person, switch to `devoir`: `Je dois partir`, `Vous devez payer`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Meaning',
          'French',
        ],
        rows: [
          [
            'One must listen.',
            'Il faut écouter.',
          ],
          [
            'You must not smoke.',
            'Il ne faut pas fumer.',
          ],
          [
            'I must leave.',
            'Je dois partir.',
          ],
        ],
      ),
    ],
    trap: 'Do not conjugate the second verb after `il faut`: `il faut réserver`, not `il faut réserves`.',
  ),
  GrammarRule(
    id: 42,
    title: 'Simple Future',
    level: 'A2',
    rule: 'Use the simple future for future events, predictions, promises.',
    pattern: 'infinitive + `-ai`, `-as`, `-a`, `-ons`, `-ez`, `-ont`',
    examples: [
      GrammarExample(
        french: 'Je visiterai Montréal.',
        english: 'I will visit Montreal.',
      ),
      GrammarExample(
        french: 'Vous serez libres samedi.',
        english: 'You will be free Saturday.',
      ),
    ],
    note: 'Irregular stems: être→ser-, avoir→aur-, aller→ir-, faire→fer-, venir→viendr-.',
    summary: 'For regular verbs, the future is infinitive stem + future ending.',
    explain: 'The simple future is a one-word future tense. For most verbs, keep the infinitive as the stem. For `-re` verbs, drop the final `e`. Then add the same endings for every verb.',
    steps: [
      'Take the future stem: `parler`, `finir`, `prendr-` from `prendre`.',
      'Add the future endings: `-ai`, `-as`, `-a`, `-ons`, `-ez`, `-ont`.',
      'Memorize common irregular stems: `être -> ser-`, `avoir -> aur-`, `aller -> ir-`, `faire -> fer-`, `venir -> viendr-`.',
      'Use it for predictions, promises, and future plans that sound a little more formal than `aller + infinitive`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Subject',
          'parler',
          'être',
        ],
        rows: [
          [
            'je',
            'je parlerai',
            'je serai',
          ],
          [
            'tu',
            'tu parleras',
            'tu seras',
          ],
          [
            'il/elle',
            'il parlera',
            'elle sera',
          ],
          [
            'nous',
            'nous parlerons',
            'nous serons',
          ],
          [
            'vous',
            'vous parlerez',
            'vous serez',
          ],
          [
            'ils/elles',
            'ils parleront',
            'elles seront',
          ],
        ],
      ),
    ],
    trap: 'The endings attach to the future stem, not the present stem: `je serai`, not `je suisai`.',
  ),
  GrammarRule(
    id: 43,
    title: 'Relative Pronoun qui',
    level: 'A2',
    rule: 'qui connects clauses and replaces the subject of the second clause.',
    pattern: 'noun + `qui` + verb',
    examples: [
      GrammarExample(
        french: 'C\'est un ami qui habite à Lyon.',
        english: 'A friend who lives in Lyon.',
      ),
      GrammarExample(
        french: 'Voici le bus qui va au centre-ville.',
        english: 'The bus that goes downtown.',
      ),
    ],
    note: 'The verb after qui agrees with the noun qui replaces.',
    summary: 'Use `qui` when the missing word is the subject of the second verb.',
    explain: 'After `qui`, the next verb belongs to the noun before `qui`. A quick test: if the noun is doing the action after the relative pronoun, use `qui`.',
    steps: [
      'Find two ideas: `J\'ai un ami. Il habite à Lyon.`',
      'Replace the repeated subject with `qui`.',
      'Put the verb right after `qui`: `un ami qui habite à Lyon`.',
      'Make the verb agree with the noun: `les bus qui vont`, `la personne qui parle`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Two sentences',
          'Combined',
        ],
        rows: [
          [
            'C\'est un ami. Il habite à Lyon.',
            'C\'est un ami qui habite à Lyon.',
          ],
          [
            'Je cherche des films. Ils font rire.',
            'Je cherche des films qui font rire.',
          ],
        ],
      ),
    ],
    trap: 'If there is already a subject after the relative pronoun, you probably need `que`, not `qui`.',
  ),
  GrammarRule(
    id: 44,
    title: 'Relative Pronoun que',
    level: 'A2',
    rule: 'que connects clauses and replaces the direct object of the second clause.',
    pattern: 'noun + `que/qu\'` + subject + verb',
    examples: [
      GrammarExample(
        french: 'C\'est le film que j\'aime.',
        english: 'The film that I like.',
      ),
      GrammarExample(
        french: 'Voici le livre qu\'elle lit.',
        english: 'The book she is reading.',
      ),
    ],
    note: 'que becomes qu\' before a vowel.',
    summary: 'Use `que` when the missing word is the direct object of the second verb.',
    explain: 'After `que`, you usually see a subject + verb because the object was moved out. Think: `the thing that I like`, `the book that she reads`.',
    steps: [
      'Find two ideas: `C\'est un film. J\'aime ce film.`',
      'Replace the repeated direct object with `que`.',
      'Put subject + verb after `que`: `le film que j\'aime`.',
      'Use `qu\'` before a vowel: `le livre qu\'elle lit`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Two sentences',
          'Combined',
        ],
        rows: [
          [
            'C\'est le film. J\'aime le film.',
            'C\'est le film que j\'aime.',
          ],
          [
            'Voici le livre. Elle lit le livre.',
            'Voici le livre qu\'elle lit.',
          ],
        ],
      ),
    ],
    trap: 'Do not add another object after the verb: `le film que j\'aime`, not `le film que j\'aime le film`.',
  ),
  GrammarRule(
    id: 45,
    title: 'Comparatives',
    level: 'A2',
    rule: 'Compare two people, things, or actions.',
    pattern: '`plus… que`; `moins… que`; `aussi… que`',
    examples: [
      GrammarExample(
        french: 'Paris est plus grand que Lyon.',
        english: 'Paris is bigger than Lyon.',
      ),
      GrammarExample(
        french: 'Elle est aussi sportive que son frère.',
        english: 'She is as athletic as her brother.',
      ),
    ],
    note: 'Irregular: bon → meilleur.',
    summary: 'Comparatives say more than, less than, or as much/as...as.',
    explain: 'Use the comparison word around the adjective/adverb, then add `que` before the second thing. With nouns and verbs, the pattern changes slightly, but `que` still introduces the comparison.',
    steps: [
      'For adjectives/adverbs: `plus/moins/aussi + adjective/adverb + que`.',
      'For nouns: `plus de/moins de/autant de + noun + que`.',
      'For verbs: `verb + plus/moins/autant + que`.',
      'Use `meilleur(e)(s)` instead of `plus bon`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Type',
          'Example',
        ],
        rows: [
          [
            'Adjective',
            'Lyon est plus calme que Paris.',
          ],
          [
            'Noun',
            'Il y a moins de voitures qu\'avant.',
          ],
          [
            'Verb',
            'Je travaille plus que toi.',
          ],
          [
            'Irregular',
            'Ce livre est meilleur.',
          ],
        ],
      ),
    ],
    trap: 'Use `que`, not `comme`, for most A2 comparisons: `plus grand que`, not `plus grand comme`.',
  ),
  GrammarRule(
    id: 46,
    title: 'Superlatives',
    level: 'A2',
    rule: 'Express the most or the least.',
    pattern: '`le/la/les plus + adj`; `le/la/les moins + adj`',
    examples: [
      GrammarExample(
        french: 'C\'est le plus grand parc de la ville.',
        english: 'The biggest park in the city.',
      ),
      GrammarExample(
        french: 'Ce sont les meilleurs croissants.',
        english: 'The best croissants.',
      ),
    ],
    note: 'The article agrees with the noun.',
    summary: 'Superlatives say the most or the least inside a group.',
    explain: 'Start with the definite article (`le`, `la`, `les`), then use `plus` or `moins`. The article agrees with the noun you are describing.',
    steps: [
      'Choose the article for the noun: `le`, `la`, or `les`.',
      'Add `plus` or `moins` + adjective: `le plus grand`, `la moins chère`.',
      'Add the group with `de`: `de la ville`, `du menu`, `de la classe`.',
      'Remember irregular `bon`: `le meilleur`, `la meilleure`, `les meilleurs`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Noun',
          'Superlative',
        ],
        rows: [
          [
            'le parc',
            'le plus grand parc',
          ],
          [
            'la journée',
            'la journée la plus difficile',
          ],
          [
            'les croissants',
            'les meilleurs croissants',
          ],
        ],
      ),
    ],
    trap: 'Match the article to the noun: `la plus jeune personne`, not `le plus jeune personne`.',
  ),
  GrammarRule(
    id: 47,
    title: 'Expanded Negation',
    level: 'A2',
    rule: 'French has several negative pairs beyond ne…pas.',
    pattern: '`ne… jamais`, `ne… plus`, `ne… rien`, `ne… personne`, `ne… que`',
    examples: [
      GrammarExample(
        french: 'Je ne sors jamais le lundi.',
        english: 'I never go out on Mondays.',
      ),
      GrammarExample(
        french: 'Elle ne travaille plus ici.',
        english: 'She no longer works here.',
      ),
    ],
    note: 'ne… que means only, not a true negative.',
    summary: 'These are negative pairs: one part before the verb, one part after it.',
    explain: 'The first part is usually `ne/n\'` before the conjugated verb. The second part gives the meaning: never, no longer, nothing, nobody, or only.',
    steps: [
      'Put `ne/n\'` before the conjugated verb.',
      'Choose the second negative word: `jamais`, `plus`, `rien`, `personne`, or `que`.',
      'Put that word after the conjugated verb in simple tenses: `Je ne sors jamais`.',
      'In passé composé, it surrounds the auxiliary: `Je n\'ai rien compris`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Meaning',
          'French',
        ],
        rows: [
          [
            'never',
            'Je ne sors jamais.',
          ],
          [
            'no longer',
            'Elle ne travaille plus ici.',
          ],
          [
            'nothing',
            'Je n\'ai rien compris.',
          ],
          [
            'nobody',
            'Je ne connais personne.',
          ],
          [
            'only',
            'Il ne boit que de l\'eau.',
          ],
        ],
      ),
    ],
    trap: '`Ne... que` means `only`, so it is restrictive rather than truly negative.',
  ),
  GrammarRule(
    id: 48,
    title: 'Imperfect (imparfait)',
    level: 'A2',
    rule: 'Use for habits, descriptions, background, ongoing past situations.',
    pattern: 'present nous stem + `-ais`, `-ais`, `-ait`, `-ions`, `-iez`, `-aient`',
    examples: [
      GrammarExample(
        french: 'Quand j\'étais petit, je jouais dehors.',
        english: 'When I was little, I played outside.',
      ),
      GrammarExample(
        french: 'Il faisait froid.',
        english: 'It was cold.',
      ),
    ],
    note: 'être is irregular: j\'étais, tu étais, il était…',
    summary: 'The imperfect is made from the present `nous` stem + imperfect endings.',
    explain: 'Use it for what was ongoing, repeated, descriptive, or background in the past. To conjugate it, start from the present `nous` form, remove `-ons`, and add the endings.',
    steps: [
      'Find the present `nous` form: `nous parlons`, `nous finissons`, `nous faisons`.',
      'Remove `-ons`: `parl-`, `finiss-`, `fais-`.',
      'Add endings: `-ais`, `-ais`, `-ait`, `-ions`, `-iez`, `-aient`.',
      'Memorize `être`, which is irregular: stem `ét-`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Subject',
          'parler',
          'être',
        ],
        rows: [
          [
            'je',
            'je parlais',
            'j\'étais',
          ],
          [
            'tu',
            'tu parlais',
            'tu étais',
          ],
          [
            'il/elle',
            'il parlait',
            'elle était',
          ],
          [
            'nous',
            'nous parlions',
            'nous étions',
          ],
          [
            'vous',
            'vous parliez',
            'vous étiez',
          ],
          [
            'ils/elles',
            'ils parlaient',
            'elles étaient',
          ],
        ],
      ),
    ],
    trap: 'Do not use the infinitive as the stem: `je parlais`, not `je parlerais` for the imperfect.',
  ),
  GrammarRule(
    id: 49,
    title: 'passé composé vs. imparfait',
    level: 'A2',
    rule: 'passé composé for completed events; imparfait for background/habits.',
    pattern: 'background in imparfait + event in passé composé',
    examples: [
      GrammarExample(
        french: 'Il pleuvait quand je suis sorti.',
        english: 'It was raining when I went out.',
      ),
      GrammarExample(
        french: 'Avant, nous habitions à Nice; puis nous avons déménagé.',
        english: 'We lived in Nice; then we moved.',
      ),
    ],
    note: 'Time markers help: hier/soudain → events; avant/tous les jours → background.',
    summary: 'Use imperfect for the scene; use passé composé for the event that happens in the scene.',
    explain: 'Imagine a story timeline. The imperfect paints the background or repeated habit. The passé composé marks completed actions that move the story forward.',
    steps: [
      'Use imparfait for descriptions: weather, feelings, age, time, background.',
      'Use imparfait for habits: `tous les jours`, `souvent`, `avant`.',
      'Use passé composé for completed events: `hier`, `soudain`, `puis`, `ensuite`.',
      'Combine them when one action interrupts a background action: `Je dormais quand tu as appelé`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Job',
          'Tense',
          'Example',
        ],
        rows: [
          [
            'Background',
            'imparfait',
            'Il pleuvait.',
          ],
          [
            'Habit',
            'imparfait',
            'On allait souvent à la mer.',
          ],
          [
            'Finished event',
            'passé composé',
            'J\'ai entendu un bruit.',
          ],
          [
            'Sequence',
            'passé composé',
            'Puis, elle est rentrée.',
          ],
        ],
      ),
    ],
    trap: 'The same English past form can translate two ways. `I watched TV` can be `je regardais` for background or `j\'ai regardé` for one finished event.',
  ),
  GrammarRule(
    id: 50,
    title: 'Condition with si',
    level: 'A2',
    rule: 'Use si to express a real or possible condition.',
    pattern: '`si + present`, then present/future/imperative',
    examples: [
      GrammarExample(
        french: 'Si tu veux, on sort ce soir.',
        english: 'If you want, we go out tonight.',
      ),
      GrammarExample(
        french: 'S\'il pleut, je resterai chez moi.',
        english: 'If it rains, I will stay home.',
      ),
    ],
    note: 'Do NOT use the future after si: Si j\'ai le temps (not Si j\'aurai).',
    summary: 'In real `si` conditions, the `si` part uses present, not future.',
    explain: 'This structure talks about a possible real situation. English often says `if it will rain` in learner logic, but French keeps the condition in the present.',
    steps: [
      'Start the condition with `si + present`: `si j\'ai`, `s\'il pleut`, `si tu veux`.',
      'Choose the result: present, future, or imperative.',
      'Use future in the result if needed: `je viendrai`, `nous partirons`.',
      'Use `s\'` before `il` or `ils`: `s\'il pleut`, `s\'ils arrivent`.',
    ],
    tables: [
      GrammarTable(
        title: null,
        headers: [
          'Condition',
          'Result',
        ],
        rows: [
          [
            'Si j\'ai le temps,',
            'je viendrai.',
          ],
          [
            'S\'il pleut,',
            'on reste à la maison.',
          ],
          [
            'Si tu comprends,',
            'explique-moi.',
          ],
        ],
      ),
    ],
    trap: 'Avoid future immediately after `si`: `Si j\'ai le temps`, not `Si j\'aurai le temps`.',
  ),
  GrammarRule(
    id: 51,
    title: 'Irregular Forms By Tense',
    level: 'A2',
    rule: 'Each tense asks you to remember a different irregular piece: present form, past participle, imparfait stem, future stem, or helper verb.',
    pattern: 'tense -> form to memorize -> example',
    examples: [
      GrammarExample(
        french: 'J\'ai pris le train.',
        english: 'I took the train.',
      ),
      GrammarExample(
        french: 'Nous ferons les exercices demain.',
        english: 'We will do the exercises tomorrow.',
      ),
      GrammarExample(
        french: 'Elle sait conduire.',
        english: 'She knows how to drive.',
      ),
    ],
    note: 'Use this card as the master irregular table for the tenses in this quiz.',
    summary: 'Use this as the irregular-form map for every tense and structure practiced in the quiz.',
    explain: 'Each tense has a different thing to memorize. Present needs full irregular forms. Passé composé needs the right auxiliary and past participle. Imparfait usually needs the present `nous` stem. Futur simple needs the future stem. Futur proche, passé récent, and présent progressif depend on one irregular helper verb.',
    steps: [
      'For present tense, memorize the full forms of the core irregular verbs.',
      'For passé composé, memorize the auxiliary pattern and the past participle.',
      'For imparfait, take the present `nous` form and remove `-ons`; only `être` has a truly irregular stem.',
      'For futur simple, memorize the future stem, then add `-ai`, `-as`, `-a`, `-ons`, `-ez`, `-ont`.',
      'For structured tenses, conjugate only the helper verb: `aller`, `venir`, or `être`.',
    ],
    tables: [
      GrammarTable(
        title: 'Present tense irregulars',
        headers: [
          'Infinitive',
          'Key present forms',
        ],
        rows: [
          [
            'être',
            'suis, es, est, sommes, êtes, sont',
          ],
          [
            'avoir',
            'ai, as, a, avons, avez, ont',
          ],
          [
            'aller',
            'vais, vas, va, allons, allez, vont',
          ],
          [
            'faire',
            'fais, fais, fait, faisons, faites, font',
          ],
          [
            'venir',
            'viens, viens, vient, venons, venez, viennent',
          ],
          [
            'pouvoir',
            'peux, peux, peut, pouvons, pouvez, peuvent',
          ],
          [
            'vouloir',
            'veux, veux, veut, voulons, voulez, veulent',
          ],
          [
            'devoir',
            'dois, dois, doit, devons, devez, doivent',
          ],
          [
            'savoir',
            'sais, sais, sait, savons, savez, savent',
          ],
        ],
      ),
      GrammarTable(
        title: 'Passé composé irregular participles',
        headers: [
          'Infinitive',
          'Auxiliary',
          'Past participle',
          'Example',
        ],
        rows: [
          [
            'être',
            'avoir',
            'été',
            'j\'ai été',
          ],
          [
            'avoir',
            'avoir',
            'eu',
            'j\'ai eu',
          ],
          [
            'faire',
            'avoir',
            'fait',
            'elle a fait',
          ],
          [
            'prendre',
            'avoir',
            'pris',
            'nous avons pris',
          ],
          [
            'mettre',
            'avoir',
            'mis',
            'il a mis',
          ],
          [
            'voir',
            'avoir',
            'vu',
            'j\'ai vu',
          ],
          [
            'pouvoir',
            'avoir',
            'pu',
            'tu as pu',
          ],
          [
            'vouloir',
            'avoir',
            'voulu',
            'ils ont voulu',
          ],
          [
            'devoir',
            'avoir',
            'dû',
            'j\'ai dû',
          ],
          [
            'venir',
            'être',
            'venu(e)(s)',
            'elle est venue',
          ],
          [
            'aller',
            'être',
            'allé(e)(s)',
            'nous sommes allés',
          ],
        ],
      ),
      GrammarTable(
        title: 'Imparfait stems to remember',
        headers: [
          'Infinitive',
          'Present nous form',
          'Imparfait stem',
          'Example',
        ],
        rows: [
          [
            'être',
            'nous sommes',
            'ét-',
            'j\'étais',
          ],
          [
            'faire',
            'nous faisons',
            'fais-',
            'il faisait',
          ],
          [
            'venir',
            'nous venons',
            'ven-',
            'ils venaient',
          ],
          [
            'prendre',
            'nous prenons',
            'pren-',
            'je prenais',
          ],
          [
            'pouvoir',
            'nous pouvons',
            'pouv-',
            'tu pouvais',
          ],
          [
            'vouloir',
            'nous voulons',
            'voul-',
            'elle voulait',
          ],
          [
            'savoir',
            'nous savons',
            'sav-',
            'vous saviez',
          ],
        ],
      ),
      GrammarTable(
        title: 'Futur simple irregular stems',
        headers: [
          'Infinitive',
          'Future stem',
          'Example',
        ],
        rows: [
          [
            'être',
            'ser-',
            'je serai',
          ],
          [
            'avoir',
            'aur-',
            'tu auras',
          ],
          [
            'aller',
            'ir-',
            'elle ira',
          ],
          [
            'faire',
            'fer-',
            'nous ferons',
          ],
          [
            'venir',
            'viendr-',
            'vous viendrez',
          ],
          [
            'pouvoir',
            'pourr-',
            'ils pourront',
          ],
          [
            'vouloir',
            'voudr-',
            'je voudrai',
          ],
          [
            'devoir',
            'devr-',
            'tu devras',
          ],
          [
            'savoir',
            'saur-',
            'elle saura',
          ],
          [
            'voir',
            'verr-',
            'nous verrons',
          ],
          [
            'mettre',
            'mettr-',
            'ils mettront',
          ],
        ],
      ),
      GrammarTable(
        title: 'Structured tenses: helper verbs',
        headers: [
          'Tense / structure',
          'Conjugate this verb',
          'Pattern',
          'Example',
        ],
        rows: [
          [
            'futur proche',
            'aller',
            'present `aller` + infinitive',
            'je vais partir',
          ],
          [
            'passé récent',
            'venir',
            'present `venir` + de/d\' + infinitive',
            'il vient d\'arriver',
          ],
          [
            'présent progressif',
            'être',
            'present `être` + en train de/d\' + infinitive',
            'nous sommes en train de lire',
          ],
        ],
      ),
    ],
    trap: 'Do not memorize one giant rule for every tense. Ask: does this tense need a present form, a past participle, an imparfait stem, or a future stem?',
  ),
];
