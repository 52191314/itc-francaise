import '../models/word.dart';

const List<Word> kVocab = [


  // ============================================================
  // A1 VERBS (1–40)
  // ============================================================

  // 1. être
  Word( type: 'verb', level: 'A1', fr: 'être', en: 'to be', example: 'Je suis étudiant à l\'ITC.', conj: [
    ['suis','es','est','sommes','êtes','sont'],
    ['étais','étais','était','étions','étiez','étaient'],
    ['ai été','as été','a été','avons été','avez été','ont été'],
    ['serai','seras','sera','serons','serez','seront'],
    ['vais être','vas être','va être','allons être','allez être','vont être'],
    ['serais','serais','serait','serions','seriez','seraient']
  ]),

  // 2. avoir
  Word( type: 'verb', level: 'A1', fr: 'avoir', en: 'to have', example: 'J\'ai un dictionnaire français.', conj: [
    ['ai','as','a','avons','avez','ont'],
    ['avais','avais','avait','avions','aviez','avaient'],
    ['ai eu','as eu','a eu','avons eu','avez eu','ont eu'],
    ['aurai','auras','aura','aurons','aurez','auront'],
    ['vais avoir','vas avoir','va avoir','allons avoir','allez avoir','vont avoir'],
    ['aurais','aurais','aurait','aurions','auriez','auraient']
  ]),

  // 3. aller (être aux)
  Word( type: 'verb', level: 'A1', fr: 'aller', en: 'to go', example: 'Je vais à l\'université tous les jours.', conj: [
    ['vais','vas','va','allons','allez','vont'],
    ['allais','allais','allait','allions','alliez','allaient'],
    ['suis allé(e)','es allé(e)','est allé(e)','sommes allé(e)s','êtes allé(e)s','sont allé(e)s'],
    ['irai','iras','ira','irons','irez','iront'],
    ['vais aller','vas aller','va aller','allons aller','allez aller','vont aller'],
    ['irais','irais','irait','irions','iriez','iraient']
  ]),

  // 4. faire
  Word( type: 'verb', level: 'A1', fr: 'faire', en: 'to do, to make', example: 'Je fais mes devoirs chaque soir.', conj: [
    ['fais','fais','fait','faisons','faites','font'],
    ['faisais','faisais','faisait','faisions','faisiez','faisaient'],
    ['ai fait','as fait','a fait','avons fait','avez fait','ont fait'],
    ['ferai','feras','fera','ferons','ferez','feront'],
    ['vais faire','vas faire','va faire','allons faire','allez faire','vont faire'],
    ['ferais','ferais','ferait','ferions','feriez','feraient']
  ]),

  // 5. venir (être aux)
  Word( type: 'verb', level: 'A1', fr: 'venir', en: 'to come', example: 'Je viens du Cambodge.', conj: [
    ['viens','viens','vient','venons','venez','viennent'],
    ['venais','venais','venait','venions','veniez','venaient'],
    ['suis venu(e)','es venu(e)','est venu(e)','sommes venu(e)s','êtes venu(e)s','sont venu(e)s'],
    ['viendrai','viendras','viendra','viendrons','viendrez','viendront'],
    ['vais venir','vas venir','va venir','allons venir','allez venir','vont venir'],
    ['viendrais','viendrais','viendrait','viendrions','viendriez','viendraient']
  ]),

  // 6. voir
  Word( type: 'verb', level: 'A1', fr: 'voir', en: 'to see', example: 'Je vois mes amis le week-end.', conj: [
    ['vois','vois','voit','voyons','voyez','voient'],
    ['voyais','voyais','voyait','voyions','voyiez','voyaient'],
    ['ai vu','as vu','a vu','avons vu','avez vu','ont vu'],
    ['verrai','verras','verra','verrons','verrez','verront'],
    ['vais voir','vas voir','va voir','allons voir','allez voir','vont voir'],
    ['verrais','verrais','verrait','verrions','verriez','verraient']
  ]),

  // 7. savoir
  Word( type: 'verb', level: 'A1', fr: 'savoir', en: 'to know (a fact)', example: 'Je sais parler un peu français.', conj: [
    ['sais','sais','sait','savons','savez','savent'],
    ['savais','savais','savait','savions','saviez','savaient'],
    ['ai su','as su','a su','avons su','avez su','ont su'],
    ['saurai','sauras','saura','saurons','saurez','sauront'],
    ['vais savoir','vas savoir','va savoir','allons savoir','allez savoir','vont savoir'],
    ['saurais','saurais','saurait','saurions','sauriez','sauraient']
  ]),

  // 8. vouloir
  Word( type: 'verb', level: 'A1', fr: 'vouloir', en: 'to want', example: 'Je veux apprendre le français.', conj: [
    ['veux','veux','veut','voulons','voulez','veulent'],
    ['voulais','voulais','voulait','voulions','vouliez','voulaient'],
    ['ai voulu','as voulu','a voulu','avons voulu','avez voulu','ont voulu'],
    ['voudrai','voudras','voudra','voudrons','voudrez','voudront'],
    ['vais vouloir','vas vouloir','va vouloir','allons vouloir','allez vouloir','vont vouloir'],
    ['voudrais','voudrais','voudrait','voudrions','voudriez','voudraient']
  ]),

  // 9. pouvoir
  Word( type: 'verb', level: 'A1', fr: 'pouvoir', en: 'to be able to, can', example: 'Je peux t\'aider avec cet exercice.', conj: [
    ['peux','peux','peut','pouvons','pouvez','peuvent'],
    ['pouvais','pouvais','pouvait','pouvions','pouviez','pouvaient'],
    ['ai pu','as pu','a pu','avons pu','avez pu','ont pu'],
    ['pourrai','pourras','pourra','pourrons','pourrez','pourront'],
    ['vais pouvoir','vas pouvoir','va pouvoir','allons pouvoir','allez pouvoir','vont pouvoir'],
    ['pourrais','pourrais','pourrait','pourrions','pourriez','pourraient']
  ]),

  // 10. devoir
  Word( type: 'verb', level: 'A1', fr: 'devoir', en: 'must, to have to', example: 'Je dois étudier pour l\'examen.', conj: [
    ['dois','dois','doit','devons','devez','doivent'],
    ['devais','devais','devait','devions','deviez','devaient'],
    ['ai dû','as dû','a dû','avons dû','avez dû','ont dû'],
    ['devrai','devras','devra','devrons','devrez','devront'],
    ['vais devoir','vas devoir','va devoir','allons devoir','allez devoir','vont devoir'],
    ['devrais','devrais','devrait','devrions','devriez','devraient']
  ]),

  // 11. partir (être aux)
  Word( type: 'verb', level: 'A1', fr: 'partir', en: 'to leave, to depart', example: 'Je pars à l\'école à sept heures.', conj: [
    ['pars','pars','part','partons','partez','partent'],
    ['partais','partais','partait','partions','partiez','partaient'],
    ['suis parti(e)','es parti(e)','est parti(e)','sommes parti(e)s','êtes parti(e)s','sont parti(e)s'],
    ['partirai','partiras','partira','partirons','partirez','partiront'],
    ['vais partir','vas partir','va partir','allons partir','allez partir','vont partir'],
    ['partirais','partirais','partirait','partirions','partiriez','partiraient']
  ]),

  // 12. arriver (être aux)
  Word( type: 'verb', level: 'A1', fr: 'arriver', en: 'to arrive', example: 'J\'arrive à l\'université à huit heures.', conj: [
    ['arrive','arrives','arrive','arrivons','arrivez','arrivent'],
    ['arrivais','arrivais','arrivait','arrivions','arriviez','arrivaient'],
    ['suis arrivé(e)','es arrivé(e)','est arrivé(e)','sommes arrivé(e)s','êtes arrivé(e)s','sont arrivé(e)s'],
    ['arriverai','arriveras','arrivera','arriverons','arriverez','arriveront'],
    ['vais arriver','vas arriver','va arriver','allons arriver','allez arriver','vont arriver'],
    ['arriverais','arriverais','arriverait','arriverions','arriveriez','arriveraient']
  ]),

  // 13. parler
  Word( type: 'verb', level: 'A1', fr: 'parler', en: 'to speak, to talk', example: 'Je parle français avec mon professeur.', conj: [
    ['parle','parles','parle','parlons','parlez','parlent'],
    ['parlais','parlais','parlait','parlions','parliez','parlaient'],
    ['ai parlé','as parlé','a parlé','avons parlé','avez parlé','ont parlé'],
    ['parlerai','parleras','parlera','parlerons','parlerez','parleront'],
    ['vais parler','vas parler','va parler','allons parler','allez parler','vont parler'],
    ['parlerais','parlerais','parlerait','parlerions','parleriez','parleraient']
  ]),

  // 14. manger
  Word( type: 'verb', level: 'A1', fr: 'manger', en: 'to eat', example: 'Je mange du riz tous les jours.', conj: [
    ['mange','manges','mange','mangeons','mangez','mangent'],
    ['mangeais','mangeais','mangeait','mangions','mangiez','mangeaient'],
    ['ai mangé','as mangé','a mangé','avons mangé','avez mangé','ont mangé'],
    ['mangerai','mangeras','mangera','mangerons','mangerez','mangeront'],
    ['vais manger','vas manger','va manger','allons manger','allez manger','vont manger'],
    ['mangerais','mangerais','mangerait','mangerions','mangeriez','mangeraient']
  ]),

  // 15. boire
  Word( type: 'verb', level: 'A1', fr: 'boire', en: 'to drink', example: 'Je bois de l\'eau après le sport.', conj: [
    ['bois','bois','boit','buvons','buvez','boivent'],
    ['buvais','buvais','buvait','buvions','buviez','buvaient'],
    ['ai bu','as bu','a bu','avons bu','avez bu','ont bu'],
    ['boirai','boiras','boira','boirons','boirez','boiront'],
    ['vais boire','vas boire','va boire','allons boire','allez boire','vont boire'],
    ['boirais','boirais','boirait','boirions','boiriez','boiraient']
  ]),

  // 16. habiter
  Word( type: 'verb', level: 'A1', fr: 'habiter', en: 'to live (somewhere)', example: 'J\'habite à Phnom Penh avec ma famille.', conj: [
    ['habite','habites','habite','habitons','habitez','habitent'],
    ['habitais','habitais','habitait','habitions','habitiez','habitaient'],
    ['ai habité','as habité','a habité','avons habité','avez habité','ont habité'],
    ['habiterai','habiteras','habitera','habiterons','habiterez','habiteront'],
    ['vais habiter','vas habiter','va habiter','allons habiter','allez habiter','vont habiter'],
    ['habiterais','habiterais','habiterait','habiterions','habiteriez','habiteraient']
  ]),

  // 17. aimer
  Word( type: 'verb', level: 'A1', fr: 'aimer', en: 'to like, to love', example: 'J\'aime beaucoup la cuisine française.', conj: [
    ['aime','aimes','aime','aimons','aimez','aiment'],
    ['aimais','aimais','aimait','aimions','aimiez','aimaient'],
    ['ai aimé','as aimé','a aimé','avons aimé','avez aimé','ont aimé'],
    ['aimerai','aimeras','aimera','aimerons','aimerez','aimeront'],
    ['vais aimer','vas aimer','va aimer','allons aimer','allez aimer','vont aimer'],
    ['aimerais','aimerais','aimerait','aimerions','aimeriez','aimeraient']
  ]),

  // 18. préférer
  Word( type: 'verb', level: 'A1', fr: 'préférer', en: 'to prefer', example: 'Je préfère étudier le soir.', conj: [
    ['préfère','préfères','préfère','préférons','préférez','préfèrent'],
    ['préférais','préférais','préférait','préférions','préfériez','préféraient'],
    ['ai préféré','as préféré','a préféré','avons préféré','avez préféré','ont préféré'],
    ['préférerai','préféreras','préférera','préférerons','préférerez','préféreront'],
    ['vais préférer','vas préférer','va préférer','allons préférer','allez préférer','vont préférer'],
    ['préférerais','préférerais','préférerait','préférerions','préféreriez','préféreraient']
  ]),

  // 19. regarder
  Word( type: 'verb', level: 'A1', fr: 'regarder', en: 'to watch, to look at', example: 'Je regarde un film français ce soir.', conj: [
    ['regarde','regardes','regarde','regardons','regardez','regardent'],
    ['regardais','regardais','regardait','regardions','regardiez','regardaient'],
    ['ai regardé','as regardé','a regardé','avons regardé','avez regardé','ont regardé'],
    ['regarderai','regarderas','regardera','regarderons','regarderez','regarderont'],
    ['vais regarder','vas regarder','va regarder','allons regarder','allez regarder','vont regarder'],
    ['regarderais','regarderais','regarderait','regarderions','regarderiez','regarderaient']
  ]),

  // 20. écouter
  Word( type: 'verb', level: 'A1', fr: 'écouter', en: 'to listen', example: 'J\'écoute de la musique pour me détendre.', conj: [
    ['écoute','écoutes','écoute','écoutons','écoutez','écoutent'],
    ['écoutais','écoutais','écoutait','écoutions','écoutiez','écoutaient'],
    ['ai écouté','as écouté','a écouté','avons écouté','avez écouté','ont écouté'],
    ['écouterai','écouteras','écoutera','écouterons','écouterez','écouteront'],
    ['vais écouter','vas écouter','va écouter','allons écouter','allez écouter','vont écouter'],
    ['écouterais','écouterais','écouterait','écouterions','écouteriez','écouteraient']
  ]),

  // 21. lire
  Word( type: 'verb', level: 'A1', fr: 'lire', en: 'to read', example: 'Je lis un livre de grammaire française.', conj: [
    ['lis','lis','lit','lisons','lisez','lisent'],
    ['lisais','lisais','lisait','lisions','lisiez','lisaient'],
    ['ai lu','as lu','a lu','avons lu','avez lu','ont lu'],
    ['lirai','liras','lira','lirons','lirez','liront'],
    ['vais lire','vas lire','va lire','allons lire','allez lire','vont lire'],
    ['lirais','lirais','lirait','lirions','liriez','liraient']
  ]),

  // 22. écrire
  Word( type: 'verb', level: 'A1', fr: 'écrire', en: 'to write', example: 'J\'écris une lettre à mon correspondant.', conj: [
    ['écris','écris','écrit','écrivons','écrivez','écrivent'],
    ['écrivais','écrivais','écrivait','écrivions','écriviez','écrivaient'],
    ['ai écrit','as écrit','a écrit','avons écrit','avez écrit','ont écrit'],
    ['écrirai','écriras','écrira','écrirons','écrirez','écriront'],
    ['vais écrire','vas écrire','va écrire','allons écrire','allez écrire','vont écrire'],
    ['écrirais','écrirais','écrirait','écririons','écririez','écriraient']
  ]),

  // 23. travailler
  Word( type: 'verb', level: 'A1', fr: 'travailler', en: 'to work', example: 'Je travaille dans un café le week-end.', conj: [
    ['travaille','travailles','travaille','travaillons','travaillez','travaillent'],
    ['travaillais','travaillais','travaillait','travaillions','travailliez','travaillaient'],
    ['ai travaillé','as travaillé','a travaillé','avons travaillé','avez travaillé','ont travaillé'],
    ['travaillerai','travailleras','travaillera','travaillerons','travaillerez','travailleront'],
    ['vais travailler','vas travailler','va travailler','allons travailler','allez travailler','vont travailler'],
    ['travaillerais','travaillerais','travaillerait','travaillerions','travailleriez','travailleraient']
  ]),

  // 24. étudier
  Word( type: 'verb', level: 'A1', fr: 'étudier', en: 'to study', example: 'J\'étudie le génie civil à l\'ITC.', conj: [
    ['étudie','étudies','étudie','étudions','étudiez','étudient'],
    ['étudiais','étudiais','étudiait','étudiions','étudiiez','étudiaient'],
    ['ai étudié','as étudié','a étudié','avons étudié','avez étudié','ont étudié'],
    ['étudierai','étudieras','étudiera','étudierons','étudierez','étudieront'],
    ['vais étudier','vas étudier','va étudier','allons étudier','allez étudier','vont étudier'],
    ['étudierais','étudierais','étudierait','étudierions','étudieriez','étudieraient']
  ]),

  // 25. apprendre
  Word( type: 'verb', level: 'A1', fr: 'apprendre', en: 'to learn', example: 'J\'apprends le français depuis six mois.', conj: [
    ['apprends','apprends','apprend','apprenons','apprenez','apprennent'],
    ['apprenais','apprenais','apprenait','apprenions','appreniez','apprenaient'],
    ['ai appris','as appris','a appris','avons appris','avez appris','ont appris'],
    ['apprendrai','apprendras','apprendra','apprendrons','apprendrez','apprendront'],
    ['vais apprendre','vas apprendre','va apprendre','allons apprendre','allez apprendre','vont apprendre'],
    ['apprendrais','apprendrais','apprendrait','apprendrions','apprendriez','apprendraient']
  ]),

  // 26. comprendre
  Word( type: 'verb', level: 'A1', fr: 'comprendre', en: 'to understand', example: 'Je comprends mieux le français maintenant.', conj: [
    ['comprends','comprends','comprend','comprenons','comprenez','comprennent'],
    ['comprenais','comprenais','comprenait','comprenions','compreniez','comprenaient'],
    ['ai compris','as compris','a compris','avons compris','avez compris','ont compris'],
    ['comprendrai','comprendras','comprendra','comprendrons','comprendrez','comprendront'],
    ['vais comprendre','vas comprendre','va comprendre','allons comprendre','allez comprendre','vont comprendre'],
    ['comprendrais','comprendrais','comprendrait','comprendrions','comprendriez','comprendraient']
  ]),

  // 27. prendre
  Word( type: 'verb', level: 'A1', fr: 'prendre', en: 'to take', example: 'Je prends le bus pour aller à l\'université.', conj: [
    ['prends','prends','prend','prenons','prenez','prennent'],
    ['prenais','prenais','prenait','prenions','preniez','prenaient'],
    ['ai pris','as pris','a pris','avons pris','avez pris','ont pris'],
    ['prendrai','prendras','prendra','prendrons','prendrez','prendront'],
    ['vais prendre','vas prendre','va prendre','allons prendre','allez prendre','vont prendre'],
    ['prendrais','prendrais','prendrait','prendrions','prendriez','prendraient']
  ]),

  // 28. donner
  Word( type: 'verb', level: 'A1', fr: 'donner', en: 'to give', example: 'Le professeur nous donne beaucoup de devoirs.', conj: [
    ['donne','donnes','donne','donnons','donnez','donnent'],
    ['donnais','donnais','donnait','donnions','donniez','donnaient'],
    ['ai donné','as donné','a donné','avons donné','avez donné','ont donné'],
    ['donnerai','donneras','donnera','donnerons','donnerez','donneront'],
    ['vais donner','vas donner','va donner','allons donner','allez donner','vont donner'],
    ['donnerais','donnerais','donnerait','donnerions','donneriez','donneraient']
  ]),

  // 29. jouer
  Word( type: 'verb', level: 'A1', fr: 'jouer', en: 'to play', example: 'Je joue au football avec mes amis.', conj: [
    ['joue','joues','joue','jouons','jouez','jouent'],
    ['jouais','jouais','jouait','jouions','jouiez','jouaient'],
    ['ai joué','as joué','a joué','avons joué','avez joué','ont joué'],
    ['jouerai','joueras','jouera','jouerons','jouerez','joueront'],
    ['vais jouer','vas jouer','va jouer','allons jouer','allez jouer','vont jouer'],
    ['jouerais','jouerais','jouerait','jouerions','joueriez','joueraient']
  ]),

  // 30. finir
  Word( type: 'verb', level: 'A1', fr: 'finir', en: 'to finish', example: 'Je finis mes cours à dix-sept heures.', conj: [
    ['finis','finis','finit','finissons','finissez','finissent'],
    ['finissais','finissais','finissait','finissions','finissiez','finissaient'],
    ['ai fini','as fini','a fini','avons fini','avez fini','ont fini'],
    ['finirai','finiras','finira','finirons','finirez','finiront'],
    ['vais finir','vas finir','va finir','allons finir','allez finir','vont finir'],
    ['finirais','finirais','finirait','finirions','finiriez','finiraient']
  ]),

  // 31. choisir
  Word( type: 'verb', level: 'A1', fr: 'choisir', en: 'to choose', example: 'Je choisis toujours des livres intéressants.', conj: [
    ['choisis','choisis','choisit','choisissons','choisissez','choisissent'],
    ['choisissais','choisissais','choisissait','choisissions','choisissiez','choisissaient'],
    ['ai choisi','as choisi','a choisi','avons choisi','avez choisi','ont choisi'],
    ['choisirai','choisiras','choisira','choisirons','choisirez','choisiront'],
    ['vais choisir','vas choisir','va choisir','allons choisir','allez choisir','vont choisir'],
    ['choisirais','choisirais','choisirait','choisirions','choisiriez','choisiraient']
  ]),

  // 32. sortir (être aux)
  Word( type: 'verb', level: 'A1', fr: 'sortir', en: 'to go out', example: 'Je sors avec mes amis le vendredi soir.', conj: [
    ['sors','sors','sort','sortons','sortez','sortent'],
    ['sortais','sortais','sortait','sortions','sortiez','sortaient'],
    ['suis sorti(e)','es sorti(e)','est sorti(e)','sommes sorti(e)s','êtes sorti(e)s','sont sorti(e)s'],
    ['sortirai','sortiras','sortira','sortirons','sortirez','sortiront'],
    ['vais sortir','vas sortir','va sortir','allons sortir','allez sortir','vont sortir'],
    ['sortirais','sortirais','sortirait','sortirions','sortiriez','sortiraient']
  ]),

  // 33. dormir
  Word( type: 'verb', level: 'A1', fr: 'dormir', en: 'to sleep', example: 'Je dors huit heures par nuit.', conj: [
    ['dors','dors','dort','dormons','dormez','dorment'],
    ['dormais','dormais','dormait','dormions','dormiez','dormaient'],
    ['ai dormi','as dormi','a dormi','avons dormi','avez dormi','ont dormi'],
    ['dormirai','dormiras','dormira','dormirons','dormirez','dormiront'],
    ['vais dormir','vas dormir','va dormir','allons dormir','allez dormir','vont dormir'],
    ['dormirais','dormirais','dormirait','dormirions','dormiriez','dormiraient']
  ]),

  // 34. se lever (reflexive, être aux)
  Word( type: 'verb', level: 'A1', fr: 'se lever', en: 'to get up', example: 'Je me lève à six heures du matin.', conj: [
    ['me lève','te lèves','se lève','nous levons','vous levez','se lèvent'],
    ['me levais','te levais','se levait','nous levions','vous leviez','se levaient'],
    ['me suis levé(e)','t\'es levé(e)','s\'est levé(e)','nous sommes levé(e)s','vous êtes levé(e)s','se sont levé(e)s'],
    ['me lèverai','te lèveras','se lèvera','nous lèverons','vous lèverez','se lèveront'],
    ['vais me lever','vas te lever','va se lever','allons nous lever','allez vous lever','vont se lever'],
    ['me lèverais','te lèverais','se lèverait','nous lèverions','vous lèveriez','se lèveraient']
  ]),

  // 35. se coucher (reflexive, être aux)
  Word( type: 'verb', level: 'A1', fr: 'se coucher', en: 'to go to bed', example: 'Je me couche à vingt-deux heures.', conj: [
    ['me couche','te couches','se couche','nous couchons','vous couchez','se couchent'],
    ['me couchais','te couchais','se couchait','nous couchions','vous couchiez','se couchaient'],
    ['me suis couché(e)','t\'es couché(e)','s\'est couché(e)','nous sommes couché(e)s','vous êtes couché(e)s','se sont couché(e)s'],
    ['me coucherai','te coucheras','se couchera','nous coucherons','vous coucherez','se coucheront'],
    ['vais me coucher','vas te coucher','va se coucher','allons nous coucher','allez vous coucher','vont se coucher'],
    ['me coucherais','te coucherais','se coucherait','nous coucherions','vous coucheriez','se coucheraient']
  ]),

  // 36. s\'appeler (reflexive, être aux)
  Word( type: 'verb', level: 'A1', fr: 's\'appeler', en: 'to be called', example: 'Je m\'appelle Dara et j\'étudie le français.', conj: [
    ['m\'appelle','t\'appelles','s\'appelle','nous appelons','vous appelez','s\'appellent'],
    ['m\'appelais','t\'appelais','s\'appelait','nous appelions','vous appeliez','s\'appelaient'],
    ['me suis appelé(e)','t\'es appelé(e)','s\'est appelé(e)','nous sommes appelé(e)s','vous êtes appelé(e)s','se sont appelé(e)s'],
    ['m\'appellerai','t\'appelleras','s\'appellera','nous appellerons','vous appellerez','s\'appelleront'],
    ['vais m\'appeler','vas t\'appeler','va s\'appeler','allons nous appeler','allez vous appeler','vont s\'appeler'],
    ['m\'appellerais','t\'appellerais','s\'appellerait','nous appellerions','vous appelleriez','s\'appelleraient']
  ]),

  // 37. rentrer (être aux)
  Word( type: 'verb', level: 'A1', fr: 'rentrer', en: 'to go back home, to return', example: 'Je rentre à la maison après les cours.', conj: [
    ['rentre','rentres','rentre','rentrons','rentrez','rentrent'],
    ['rentrais','rentrais','rentrait','rentrions','rentriez','rentraient'],
    ['suis rentré(e)','es rentré(e)','est rentré(e)','sommes rentré(e)s','êtes rentré(e)s','sont rentré(e)s'],
    ['rentrerai','rentreras','rentrera','rentrerons','rentrerez','rentreront'],
    ['vais rentrer','vas rentrer','va rentrer','allons rentrer','allez rentrer','vont rentrer'],
    ['rentrerais','rentrerais','rentrerait','rentrerions','rentreriez','rentreraient']
  ]),

  // 38. chercher
  Word( type: 'verb', level: 'A1', fr: 'chercher', en: 'to look for, to search', example: 'Je cherche un appartement près de l\'ITC.', conj: [
    ['cherche','cherches','cherche','cherchons','cherchez','cherchent'],
    ['cherchais','cherchais','cherchait','cherchions','cherchiez','cherchaient'],
    ['ai cherché','as cherché','a cherché','avons cherché','avez cherché','ont cherché'],
    ['chercherai','chercheras','cherchera','chercherons','chercherez','chercheront'],
    ['vais chercher','vas chercher','va chercher','allons chercher','allez chercher','vont chercher'],
    ['chercherais','chercherais','chercherait','chercherions','chercheriez','chercheraient']
  ]),

  // 39. penser
  Word( type: 'verb', level: 'A1', fr: 'penser', en: 'to think', example: 'Je pense que le français est une belle langue.', conj: [
    ['pense','penses','pense','pensons','pensez','pensent'],
    ['pensais','pensais','pensait','pensions','pensiez','pensaient'],
    ['ai pensé','as pensé','a pensé','avons pensé','avez pensé','ont pensé'],
    ['penserai','penseras','pensera','penserons','penserez','penseront'],
    ['vais penser','vas penser','va penser','allons penser','allez penser','vont penser'],
    ['penserais','penserais','penserait','penserions','penseriez','penseraient']
  ]),

  // 40. commencer
  Word( type: 'verb', level: 'A1', fr: 'commencer', en: 'to start, to begin', example: 'Je commence mon cours de français à huit heures.', conj: [
    ['commence','commences','commence','commençons','commencez','commencent'],
    ['commençais','commençais','commençait','commencions','commenciez','commençaient'],
    ['ai commencé','as commencé','a commencé','avons commencé','avez commencé','ont commencé'],
    ['commencerai','commenceras','commencera','commencerons','commencerez','commenceront'],
    ['vais commencer','vas commencer','va commencer','allons commencer','allez commencer','vont commencer'],
    ['commencerais','commencerais','commencerait','commencerions','commenceriez','commenceraient']
  ]),

  // ============================================================
  // A2 VERBS (41–100)
  // ============================================================

  // 41. continuer
  Word( type: 'verb', level: 'A2', fr: 'continuer', en: 'to continue', example: 'Je continue à pratiquer le français chaque jour.', conj: [
    ['continue','continues','continue','continuons','continuez','continuent'],
    ['continuais','continuais','continuait','continuions','continuiez','continuaient'],
    ['ai continué','as continué','a continué','avons continué','avez continué','ont continué'],
    ['continuerai','continueras','continuera','continuerons','continuerez','continueront'],
    ['vais continuer','vas continuer','va continuer','allons continuer','allez continuer','vont continuer'],
    ['continuerais','continuerais','continuerait','continuerions','continueriez','continueraient']
  ]),

  // 42. décider
  Word( type: 'verb', level: 'A2', fr: 'décider', en: 'to decide', example: 'J\'ai décidé d\'étudier en France l\'année prochaine.', conj: [
    ['décide','décides','décide','décidons','décidez','décident'],
    ['décidais','décidais','décidait','décidions','décidiez','décidaient'],
    ['ai décidé','as décidé','a décidé','avons décidé','avez décidé','ont décidé'],
    ['déciderai','décideras','décidera','déciderons','déciderez','décideront'],
    ['vais décider','vas décider','va décider','allons décider','allez décider','vont décider'],
    ['déciderais','déciderais','déciderait','déciderions','décideriez','décideraient']
  ]),

  // 43. expliquer
  Word( type: 'verb', level: 'A2', fr: 'expliquer', en: 'to explain', example: 'Le professeur explique la grammaire clairement.', conj: [
    ['explique','expliques','explique','expliquons','expliquez','expliquent'],
    ['expliquais','expliquais','expliquait','expliquions','expliquiez','expliquaient'],
    ['ai expliqué','as expliqué','a expliqué','avons expliqué','avez expliqué','ont expliqué'],
    ['expliquerai','expliqueras','expliquera','expliquerons','expliquerez','expliqueront'],
    ['vais expliquer','vas expliquer','va expliquer','allons expliquer','allez expliquer','vont expliquer'],
    ['expliquerais','expliquerais','expliquerait','expliquerions','expliqueriez','expliqueraient']
  ]),

  // 44. oublier
  Word( type: 'verb', level: 'A2', fr: 'oublier', en: 'to forget', example: 'J\'oublie souvent le vocabulaire nouveau.', conj: [
    ['oublie','oublies','oublie','oublions','oubliez','oublient'],
    ['oubliais','oubliais','oubliait','oubliions','oubliiez','oubliaient'],
    ['ai oublié','as oublié','a oublié','avons oublié','avez oublié','ont oublié'],
    ['oublierai','oublieras','oubliera','oublierons','oublierez','oublieront'],
    ['vais oublier','vas oublier','va oublier','allons oublier','allez oublier','vont oublier'],
    ['oublierais','oublierais','oublierait','oublierions','oublieriez','oublieraient']
  ]),

  // 45. rappeler
  Word( type: 'verb', level: 'A2', fr: 'rappeler', en: 'to remind, to recall', example: 'Tu me rappelles l\'heure du rendez-vous ?', conj: [
    ['rappelle','rappelles','rappelle','rappelons','rappelez','rappellent'],
    ['rappelais','rappelais','rappelait','rappelions','appeliez','rappelaient'],
    ['ai rappelé','as rappelé','a rappelé','avons rappelé','avez rappelé','ont rappelé'],
    ['rappellerai','rappelleras','rappellera','rappellerons','rappellerez','rappelleront'],
    ['vais rappeler','vas rappeler','va rappeler','allons rappeler','allez rappeler','vont rappeler'],
    ['rappellerais','rappellerais','rappellerait','rappellerions','rappelleriez','rappelleraient']
  ]),

  // 46. répondre
  Word( type: 'verb', level: 'A2', fr: 'répondre', en: 'to answer, to reply', example: 'Je réponds aux questions du professeur.', conj: [
    ['réponds','réponds','répond','répondons','répondez','répondent'],
    ['répondais','répondais','répondait','répondions','répondiez','répondaient'],
    ['ai répondu','as répondu','a répondu','avons répondu','avez répondu','ont répondu'],
    ['répondrai','répondras','répondra','répondrons','répondrez','répondront'],
    ['vais répondre','vas répondre','va répondre','allons répondre','allez répondre','vont répondre'],
    ['répondrais','répondrais','répondrait','répondrions','répondriez','répondraient']
  ]),

  // 47. demander
  Word( type: 'verb', level: 'A2', fr: 'demander', en: 'to ask', example: 'Je demande de l\'aide à mon professeur.', conj: [
    ['demande','demandes','demande','demandons','demandez','demandent'],
    ['demandais','demandais','demandait','demandions','demandiez','demandaient'],
    ['ai demandé','as demandé','a demandé','avons demandé','avez demandé','ont demandé'],
    ['demanderai','demanderas','demandera','demanderons','demanderez','demanderont'],
    ['vais demander','vas demander','va demander','allons demander','allez demander','vont demander'],
    ['demanderais','demanderais','demanderait','demanderions','demanderiez','demanderaient']
  ]),

  // 48. proposer
  Word( type: 'verb', level: 'A2', fr: 'proposer', en: 'to suggest, to propose', example: 'Je propose de manger ensemble après le cours.', conj: [
    ['propose','proposes','propose','proposons','proposez','proposent'],
    ['proposais','proposais','proposait','proposions','proposiez','proposaient'],
    ['ai proposé','as proposé','a proposé','avons proposé','avez proposé','ont proposé'],
    ['proposerai','proposeras','proposera','proposerons','proposerez','proposeront'],
    ['vais proposer','vas proposer','va proposer','allons proposer','allez proposer','vont proposer'],
    ['proposerais','proposerais','proposerait','proposerions','proposeriez','proposeraient']
  ]),

  // 49. accepter
  Word( type: 'verb', level: 'A2', fr: 'accepter', en: 'to accept', example: 'J\'accepte ton invitation avec plaisir.', conj: [
    ['accepte','acceptes','accepte','acceptons','acceptez','acceptent'],
    ['acceptais','acceptais','acceptait','acceptions','acceptiez','acceptaient'],
    ['ai accepté','as accepté','a accepté','avons accepté','avez accepté','ont accepté'],
    ['accepterai','accepteras','acceptera','accepterons','accepterez','accepteront'],
    ['vais accepter','vas accepter','va accepter','allons accepter','allez accepter','vont accepter'],
    ['accepterais','accepterais','accepterait','accepterions','accepteriez','accepteraient']
  ]),

  // 50. refuser
  Word( type: 'verb', level: 'A2', fr: 'refuser', en: 'to refuse', example: 'Il refuse de sortir quand il fait mauvais temps.', conj: [
    ['refuse','refuses','refuse','refusons','refusez','refusent'],
    ['refusais','refusais','refusait','refusions','refusiez','refusaient'],
    ['ai refusé','as refusé','a refusé','avons refusé','avez refusé','ont refusé'],
    ['refuserai','refuseras','refusera','refuserons','refuserez','refuseront'],
    ['vais refuser','vas refuser','va refuser','allons refuser','allez refuser','vont refuser'],
    ['refuserais','refuserais','refuserait','refuserions','refuseriez','refuseraient']
  ]),

  // 51. inviter
  Word( type: 'verb', level: 'A2', fr: 'inviter', en: 'to invite', example: 'J\'invite mes amis à dîner chez moi.', conj: [
    ['invite','invites','invite','invitons','invitez','invitent'],
    ['invitais','invitais','invitait','invitions','invitiez','invitaient'],
    ['ai invité','as invité','a invité','avons invité','avez invité','ont invité'],
    ['inviterai','inviteras','invitera','inviterons','inviterez','inviteront'],
    ['vais inviter','vas inviter','va inviter','allons inviter','allez inviter','vont inviter'],
    ['inviterais','inviterais','inviterait','inviterions','inviteriez','inviteraient']
  ]),

  // 52. rencontrer
  Word( type: 'verb', level: 'A2', fr: 'rencontrer', en: 'to meet', example: 'J\'ai rencontré des étudiants étrangers à l\'université.', conj: [
    ['rencontre','rencontres','rencontre','rencontrons','rencontrez','rencontrent'],
    ['rencontrais','rencontrais','rencontrait','rencontrions','rencontriez','rencontraient'],
    ['ai rencontré','as rencontré','a rencontré','avons rencontré','avez rencontré','ont rencontré'],
    ['rencontrerai','rencontreras','rencontrera','rencontrerons','rencontrerez','rencontreront'],
    ['vais rencontrer','vas rencontrer','va rencontrer','allons rencontrer','allez rencontrer','vont rencontrer'],
    ['rencontrerais','rencontrerais','rencontrerait','rencontrerions','rencontreriez','rencontreraient']
  ]),

  // 53. connaître
  Word( type: 'verb', level: 'A2', fr: 'connaître', en: 'to know (a person, a place)', example: 'Je connais bien le centre de Phnom Penh.', conj: [
    ['connais','connais','connaît','connaissons','connaissez','connaissent'],
    ['connaissais','connaissais','connaissait','connaissions','connaissiez','connaissaient'],
    ['ai connu','as connu','a connu','avons connu','avez connu','ont connu'],
    ['connaîtrai','connaîtras','connaîtra','connaîtrons','connaîtrez','connaîtront'],
    ['vais connaître','vas connaître','va connaître','allons connaître','allez connaître','vont connaître'],
    ['connaîtrais','connaîtrais','connaîtrait','connaîtrions','connaîtriez','connaîtraient']
  ]),

  // 54. croire
  Word( type: 'verb', level: 'A2', fr: 'croire', en: 'to believe, to think', example: 'Je crois que mon niveau de français s\'améliore.', conj: [
    ['crois','crois','croit','croyons','croyez','croient'],
    ['croyais','croyais','croyait','croyions','croyiez','croyaient'],
    ['ai cru','as cru','a cru','avons cru','avez cru','ont cru'],
    ['croirai','croiras','croira','croirons','croirez','croiront'],
    ['vais croire','vas croire','va croire','allons croire','allez croire','vont croire'],
    ['croirais','croirais','croirait','croirions','croiriez','croiraient']
  ]),

  // 55. réussir
  Word( type: 'verb', level: 'A2', fr: 'réussir', en: 'to succeed, to pass (an exam)', example: 'J\'ai réussi mon examen de français.', conj: [
    ['réussis','réussis','réussit','réussissons','réussissez','réussissent'],
    ['réussissais','réussissais','réussissait','réussissions','réussissiez','réussissaient'],
    ['ai réussi','as réussi','a réussi','avons réussi','avez réussi','ont réussi'],
    ['réussirai','réussiras','réussira','réussirons','réussirez','réussiront'],
    ['vais réussir','vas réussir','va réussir','allons réussir','allez réussir','vont réussir'],
    ['réussirais','réussirais','réussirait','réussirions','réussiriez','réussiraient']
  ]),

  // 56. rater
  Word( type: 'verb', level: 'A2', fr: 'rater', en: 'to fail, to miss', example: 'J\'ai raté le bus ce matin.', conj: [
    ['rate','rates','rate','ratons','ratez','ratent'],
    ['ratais','ratais','ratait','rations','ratiez','rataient'],
    ['ai raté','as raté','a raté','avons raté','avez raté','ont raté'],
    ['raterai','rateras','ratera','raterons','raterez','rateront'],
    ['vais rater','vas rater','va rater','allons rater','allez rater','vont rater'],
    ['raterais','raterais','raterait','raterions','rateriez','rateraient']
  ]),

  // 57. attendre
  Word( type: 'verb', level: 'A2', fr: 'attendre', en: 'to wait', example: 'J\'attends mon ami devant la bibliothèque.', conj: [
    ['attends','attends','attend','attendons','attendez','attendent'],
    ['attendais','attendais','attendait','attendions','attendiez','attendaient'],
    ['ai attendu','as attendu','a attendu','avons attendu','avez attendu','ont attendu'],
    ['attendrai','attendras','attendra','attendrons','attendrez','attendront'],
    ['vais attendre','vas attendre','va attendre','allons attendre','allez attendre','vont attendre'],
    ['attendrais','attendrais','attendrait','attendrions','attendriez','attendraient']
  ]),

  // 58. suivre
  Word( type: 'verb', level: 'A2', fr: 'suivre', en: 'to follow, to take (a course)', example: 'Je suis un cours de français intensif.', conj: [
    ['suis','suis','suit','suivons','suivez','suivent'],
    ['suivais','suivais','suivait','suivions','suiviez','suivaient'],
    ['ai suivi','as suivi','a suivi','avons suivi','avez suivi','ont suivi'],
    ['suivrai','suivras','suivra','suivrons','suivrez','suivront'],
    ['vais suivre','vas suivre','va suivre','allons suivre','allez suivre','vont suivre'],
    ['suivrais','suivrais','suivrait','suivrions','suivriez','suivraient']
  ]),

  // 59. acheter
  Word( type: 'verb', level: 'A2', fr: 'acheter', en: 'to buy', example: 'J\'achète des légumes frais au marché.', conj: [
    ['achète','achètes','achète','achetons','achetez','achètent'],
    ['achetais','achetais','achetait','achetions','achetiez','achetaient'],
    ['ai acheté','as acheté','a acheté','avons acheté','avez acheté','ont acheté'],
    ['achèterai','achèteras','achètera','achèterons','achèterez','achèteront'],
    ['vais acheter','vas acheter','va acheter','allons acheter','allez acheter','vont acheter'],
    ['achèterais','achèterais','achèterait','achèterions','achèteriez','achèteraient']
  ]),

  // 60. vendre
  Word( type: 'verb', level: 'A2', fr: 'vendre', en: 'to sell', example: 'Il vend des fruits au bord de la route.', conj: [
    ['vends','vends','vend','vendons','vendez','vendent'],
    ['vendais','vendais','vendait','vendions','vendiez','vendaient'],
    ['ai vendu','as vendu','a vendu','avons vendu','avez vendu','ont vendu'],
    ['vendrai','vendras','vendra','vendrons','vendrez','vendront'],
    ['vais vendre','vas vendre','va vendre','allons vendre','allez vendre','vont vendre'],
    ['vendrais','vendrais','vendrait','vendrions','vendriez','vendraient']
  ]),

  // 61. coûter
  Word( type: 'verb', level: 'A2', fr: 'coûter', en: 'to cost', example: 'Ce billet d\'avion coûte très cher.', conj: [
    ['coûte','coûtes','coûte','coûtons','coûtez','coûtent'],
    ['coûtais','coûtais','coûtait','coûtions','coûtiez','coûtaient'],
    ['ai coûté','as coûté','a coûté','avons coûté','avez coûté','ont coûté'],
    ['coûterai','coûteras','coûtera','coûterons','coûterez','coûteront'],
    ['vais coûter','vas coûter','va coûter','allons coûter','allez coûter','vont coûter'],
    ['coûterais','coûterais','coûterait','coûterions','coûteriez','coûteraient']
  ]),

  // 62. payer
  Word( type: 'verb', level: 'A2', fr: 'payer', en: 'to pay', example: 'Je paie mes études grâce à une bourse.', conj: [
    ['paie','paies','paie','payons','payez','paient'],
    ['payais','payais','payait','payions','payiez','payaient'],
    ['ai payé','as payé','a payé','avons payé','avez payé','ont payé'],
    ['paierai','paieras','paiera','paierons','paierez','paieront'],
    ['vais payer','vas payer','va payer','allons payer','allez payer','vont payer'],
    ['paierais','paierais','paierait','paierions','paieriez','paieraient']
  ]),

  // 63. réserver
  Word( type: 'verb', level: 'A2', fr: 'réserver', en: 'to reserve, to book', example: 'J\'ai réservé une table au restaurant.', conj: [
    ['réserve','réserves','réserve','réservons','réservez','réservent'],
    ['réservais','réservais','réservait','réservions','réserviez','réservaient'],
    ['ai réservé','as réservé','a réservé','avons réservé','avez réservé','ont réservé'],
    ['réserverai','réserveras','réservera','réserverons','réserverez','réserveront'],
    ['vais réserver','vas réserver','va réserver','allons réserver','allez réserver','vont réserver'],
    ['réserverais','réserverais','réserverait','réserverions','réserveriez','réserveraient']
  ]),

  // 64. commander
  Word( type: 'verb', level: 'A2', fr: 'commander', en: 'to order', example: 'Je commande un café et un croissant.', conj: [
    ['commande','commandes','commande','commandons','commandez','commandent'],
    ['commandais','commandais','commandait','commandions','commandiez','commandaient'],
    ['ai commandé','as commandé','a commandé','avons commandé','avez commandé','ont commandé'],
    ['commanderai','commanderas','commandera','commanderons','commanderez','commanderont'],
    ['vais commander','vas commander','va commander','allons commander','allez commander','vont commander'],
    ['commanderais','commanderais','commanderait','commanderions','commanderiez','commanderaient']
  ]),

  // 65. essayer
  Word( type: 'verb', level: 'A2', fr: 'essayer', en: 'to try', example: 'J\'essaie de parler français sans accent.', conj: [
    ['essaie','essaies','essaie','essayons','essayez','essaient'],
    ['essayais','essayais','essayait','essayions','essayiez','essayaient'],
    ['ai essayé','as essayé','a essayé','avons essayé','avez essayé','ont essayé'],
    ['essaierai','essaieras','essaiera','essaierons','essaierez','essaieront'],
    ['vais essayer','vas essayer','va essayer','allons essayer','allez essayer','vont essayer'],
    ['essaierais','essaierais','essaierait','essaierions','essaieriez','essaieraient']
  ]),

  // 66. porter
  Word( type: 'verb', level: 'A2', fr: 'porter', en: 'to wear, to carry', example: 'Je porte un uniforme à l\'ITC.', conj: [
    ['porte','portes','porte','portons','portez','portent'],
    ['portais','portais','portait','portions','portiez','portaient'],
    ['ai porté','as porté','a porté','avons porté','avez porté','ont porté'],
    ['porterai','porteras','portera','porterons','porterez','porteront'],
    ['vais porter','vas porter','va porter','allons porter','allez porter','vont porter'],
    ['porterais','porterais','porterait','porterions','porteriez','porteraient']
  ]),

  // 67. mettre
  Word( type: 'verb', level: 'A2', fr: 'mettre', en: 'to put on, to put', example: 'Je mets mon sac sur la table.', conj: [
    ['mets','mets','met','mettons','mettez','mettent'],
    ['mettais','mettais','mettait','mettions','mettiez','mettaient'],
    ['ai mis','as mis','a mis','avons mis','avez mis','ont mis'],
    ['mettrai','mettras','mettra','mettrons','mettrez','mettront'],
    ['vais mettre','vas mettre','va mettre','allons mettre','allez mettre','vont mettre'],
    ['mettrais','mettrais','mettrait','mettrions','mettriez','mettraient']
  ]),

  // 68. ouvrir
  Word( type: 'verb', level: 'A2', fr: 'ouvrir', en: 'to open', example: 'J\'ouvre la fenêtre pour faire entrer l\'air frais.', conj: [
    ['ouvre','ouvres','ouvre','ouvrons','ouvrez','ouvrent'],
    ['ouvrais','ouvrais','ouvrait','ouvrions','ouvriez','ouvraient'],
    ['ai ouvert','as ouvert','a ouvert','avons ouvert','avez ouvert','ont ouvert'],
    ['ouvrirai','ouvriras','ouvrira','ouvrirons','ouvrirez','ouvriront'],
    ['vais ouvrir','vas ouvrir','va ouvrir','allons ouvrir','allez ouvrir','vont ouvrir'],
    ['ouvrirais','ouvrirais','ouvrirait','ouvririons','ouvririez','ouvriraient']
  ]),

  // 69. fermer
  Word( type: 'verb', level: 'A2', fr: 'fermer', en: 'to close', example: 'Je ferme la porte avant de partir.', conj: [
    ['ferme','fermes','ferme','fermons','fermez','ferment'],
    ['fermais','fermais','fermait','fermions','fermiez','fermaient'],
    ['ai fermé','as fermé','a fermé','avons fermé','avez fermé','ont fermé'],
    ['fermerai','fermeras','fermera','fermerons','fermerez','fermeront'],
    ['vais fermer','vas fermer','va fermer','allons fermer','allez fermer','vont fermer'],
    ['fermerais','fermerais','fermerait','fermerions','fermeriez','fermeraient']
  ]),

  // 70. appeler
  Word( type: 'verb', level: 'A2', fr: 'appeler', en: 'to call', example: 'J\'appelle ma famille le dimanche.', conj: [
    ['appelle','appelles','appelle','appelons','appelez','appellent'],
    ['appelais','appelais','appelait','appelions','appeliez','appelaient'],
    ['ai appelé','as appelé','a appelé','avons appelé','avez appelé','ont appelé'],
    ['appellerai','appelleras','appellera','appellerons','appellerez','appelleront'],
    ['vais appeler','vas appeler','va appeler','allons appeler','allez appeler','vont appeler'],
    ['appellerais','appellerais','appellerait','appellerions','appelleriez','appelleraient']
  ]),

  // 71. envoyer
  Word( type: 'verb', level: 'A2', fr: 'envoyer', en: 'to send', example: 'J\'envoie un message à mon professeur.', conj: [
    ['envoie','envoies','envoie','envoyons','envoyez','envoient'],
    ['envoyais','envoyais','envoyait','envoyions','envoyiez','envoyaient'],
    ['ai envoyé','as envoyé','a envoyé','avons envoyé','avez envoyé','ont envoyé'],
    ['enverrai','enverras','enverra','enverrons','enverrez','enverront'],
    ['vais envoyer','vas envoyer','va envoyer','allons envoyer','allez envoyer','vont envoyer'],
    ['enverrais','enverrais','enverrait','enverrions','enverriez','enverraient']
  ]),

  // 72. recevoir
  Word( type: 'verb', level: 'A2', fr: 'recevoir', en: 'to receive', example: 'J\'ai reçu les résultats de mon examen.', conj: [
    ['reçois','reçois','reçoit','recevons','recevez','reçoivent'],
    ['recevais','recevais','recevait','recevions','receviez','recevaient'],
    ['ai reçu','as reçu','a reçu','avons reçu','avez reçu','ont reçu'],
    ['recevrai','recevras','recevra','recevrons','recevrez','recevront'],
    ['vais recevoir','vas recevoir','va recevoir','allons recevoir','allez recevoir','vont recevoir'],
    ['recevrais','recevrais','recevrait','recevrions','recevriez','recevraient']
  ]),

  // 73. aider
  Word( type: 'verb', level: 'A2', fr: 'aider', en: 'to help', example: 'J\'aide mon camarade à comprendre le cours.', conj: [
    ['aide','aides','aide','aidons','aidez','aident'],
    ['aidais','aidais','aidait','aidions','aidiez','aidaient'],
    ['ai aidé','as aidé','a aidé','avons aidé','avez aidé','ont aidé'],
    ['aiderai','aideras','aidera','aiderons','aiderez','aideront'],
    ['vais aider','vas aider','va aider','allons aider','allez aider','vont aider'],
    ['aiderais','aiderais','aiderait','aiderions','aideriez','aideraient']
  ]),

  // 74. remercier
  Word( type: 'verb', level: 'A2', fr: 'remercier', en: 'to thank', example: 'Je remercie mon professeur pour son aide.', conj: [
    ['remercie','remercies','remercie','remercions','remerciez','remercient'],
    ['remerciais','remerciais','remerciait','remerciions','remerciiez','remerciaient'],
    ['ai remercié','as remercié','a remercié','avons remercié','avez remercié','ont remercié'],
    ['remercierai','remercieras','remerciera','remercierons','remercierez','remercieront'],
    ['vais remercier','vas remercier','va remercier','allons remercier','allez remercier','vont remercier'],
    ['remercierais','remercierais','remercierait','remercierions','remercieriez','remercieraient']
  ]),

  // 75. s\'excuser (reflexive, être aux)
  Word( type: 'verb', level: 'A2', fr: 's\'excuser', en: 'to apologize', example: 'Je m\'excuse d\'être en retard.', conj: [
    ['m\'excuse','t\'excuses','s\'excuse','nous excusons','vous excusez','s\'excusent'],
    ['m\'excusais','t\'excusais','s\'excusait','nous excusions','vous excusiez','s\'excusaient'],
    ['me suis excusé(e)','t\'es excusé(e)','s\'est excusé(e)','nous sommes excusé(e)s','vous êtes excusé(e)s','se sont excusé(e)s'],
    ['m\'excuserai','t\'excuseras','s\'excusera','nous excuserons','vous excuserez','s\'excuseront'],
    ['vais m\'excuser','vas t\'excuser','va s\'excuser','allons nous excuser','allez vous excuser','vont s\'excuser'],
    ['m\'excuserais','t\'excuserais','s\'excuserait','nous excuserions','vous excuseriez','s\'excuseraient']
  ]),

  // 76. se souvenir (reflexive, être aux)
  Word( type: 'verb', level: 'A2', fr: 'se souvenir', en: 'to remember', example: 'Je me souviens de mon premier cours de français.', conj: [
    ['me souviens','te souviens','se souvient','nous souvenons','vous souvenez','se souviennent'],
    ['me souvenais','te souvenais','se souvenait','nous souvenions','vous souveniez','se souvenaient'],
    ['me suis souvenu(e)','t\'es souvenu(e)','s\'est souvenu(e)','nous sommes souvenu(e)s','vous êtes souvenu(e)s','se sont souvenu(e)s'],
    ['me souviendrai','te souviendras','se souviendra','nous souviendrons','vous souviendrez','se souviendront'],
    ['vais me souvenir','vas te souvenir','va se souvenir','allons nous souvenir','allez vous souvenir','vont se souvenir'],
    ['me souviendrais','te souviendrais','se souviendrait','nous souviendrions','vous souviendriez','se souviendraient']
  ]),

  // 77. se reposer (reflexive, être aux)
  Word( type: 'verb', level: 'A2', fr: 'se reposer', en: 'to rest', example: 'Je me repose un peu après les cours.', conj: [
    ['me repose','te reposes','se repose','nous reposons','vous reposez','se reposent'],
    ['me reposais','te reposais','se reposait','nous reposions','vous reposiez','se reposaient'],
    ['me suis reposé(e)','t\'es reposé(e)','s\'est reposé(e)','nous sommes reposé(e)s','vous êtes reposé(e)s','se sont reposé(e)s'],
    ['me reposerai','te reposeras','se reposera','nous reposerons','vous reposerez','se reposeront'],
    ['vais me reposer','vas te reposer','va se reposer','allons nous reposer','allez vous reposer','vont se reposer'],
    ['me reposerais','te reposerais','se reposerait','nous reposerions','vous reposeriez','se reposeraient']
  ]),

  // 78. améliorer
  Word( type: 'verb', level: 'A2', fr: 'améliorer', en: 'to improve', example: 'Je veux améliorer mon accent français.', conj: [
    ['améliore','améliores','améliore','améliorons','améliorez','améliorent'],
    ['améliorais','améliorais','améliorait','améliorions','amélioriez','amélioraient'],
    ['ai amélioré','as amélioré','a amélioré','avons amélioré','avez amélioré','ont amélioré'],
    ['améliorerai','amélioreras','améliorera','améliorerons','améliorerez','amélioreront'],
    ['vais améliorer','vas améliorer','va améliorer','allons améliorer','allez améliorer','vont améliorer'],
    ['améliorerais','améliorerais','améliorerait','améliorerions','amélioreriez','amélioreraient']
  ]),

  // 79. pratiquer
  Word( type: 'verb', level: 'A2', fr: 'pratiquer', en: 'to practice', example: 'Je pratique le français tous les jours.', conj: [
    ['pratique','pratiques','pratique','pratiquons','pratiquez','pratiquent'],
    ['pratiquais','pratiquais','pratiquait','pratiquions','pratiquiez','pratiquaient'],
    ['ai pratiqué','as pratiqué','a pratiqué','avons pratiqué','avez pratiqué','ont pratiqué'],
    ['pratiquerai','pratiqueras','pratiquera','pratiquerons','pratiquerez','pratiqueront'],
    ['vais pratiquer','vas pratiquer','va pratiquer','allons pratiquer','allez pratiquer','vont pratiquer'],
    ['pratiquerais','pratiquerais','pratiquerait','pratiquerions','pratiqueriez','pratiqueraient']
  ]),

  // 80. répéter
  Word( type: 'verb', level: 'A2', fr: 'répéter', en: 'to repeat', example: 'Je répète les mots nouveaux à voix haute.', conj: [
    ['répète','répètes','répète','répétons','répétez','répètent'],
    ['répétais','répétais','répétait','répétions','répétiez','répétaient'],
    ['ai répété','as répété','a répété','avons répété','avez répété','ont répété'],
    ['répéterai','répéteras','répétera','répéterons','répéterez','répéteront'],
    ['vais répéter','vas répéter','va répéter','allons répéter','allez répéter','vont répéter'],
    ['répéterais','répéterais','répéterait','répéterions','répéteriez','répéteraient']
  ]),

  // 81. préparer
  Word( type: 'verb', level: 'A2', fr: 'préparer', en: 'to prepare', example: 'Je prépare mon examen la veille.', conj: [
    ['prépare','prépares','prépare','préparons','préparez','préparent'],
    ['préparais','préparais','préparait','préparions','prépariez','préparaient'],
    ['ai préparé','as préparé','a préparé','avons préparé','avez préparé','ont préparé'],
    ['préparerai','prépareras','préparera','préparerons','préparerez','prépareront'],
    ['vais préparer','vas préparer','va préparer','allons préparer','allez préparer','vont préparer'],
    ['préparerais','préparerais','préparerait','préparerions','prépareriez','prépareraient']
  ]),

  // 82. organiser
  Word( type: 'verb', level: 'A2', fr: 'organiser', en: 'to organize', example: 'Nous organisons une fête pour la fin du semestre.', conj: [
    ['organise','organises','organise','organisons','organisez','organisent'],
    ['organisais','organisais','organisait','organisions','organisiez','organisaient'],
    ['ai organisé','as organisé','a organisé','avons organisé','avez organisé','ont organisé'],
    ['organiserai','organiseras','organisera','organiserons','organiserez','organiseront'],
    ['vais organiser','vas organiser','va organiser','allons organiser','allez organiser','vont organiser'],
    ['organiserais','organiserais','organiserait','organiserions','organiseriez','organiseraient']
  ]),

  // 83. décrire
  Word( type: 'verb', level: 'A2', fr: 'décrire', en: 'to describe', example: 'Je décris ma ville natale à mes amis français.', conj: [
    ['décris','décris','décrit','décrivons','décrivez','décrivent'],
    ['décrivais','décrivais','décrivait','décrivions','décriviez','décrivaient'],
    ['ai décrit','as décrit','a décrit','avons décrit','avez décrit','ont décrit'],
    ['décrirai','décriras','décrira','décrirons','décrirez','décriront'],
    ['vais décrire','vas décrire','va décrire','allons décrire','allez décrire','vont décrire'],
    ['décrirais','décrirais','décrirait','décririons','décririez','décriraient']
  ]),

  // 84. recommander
  Word( type: 'verb', level: 'A2', fr: 'recommander', en: 'to recommend', example: 'Je recommande ce restaurant à mes amis.', conj: [
    ['recommande','recommandes','recommande','recommandons','recommandez','recommandent'],
    ['recommandais','recommandais','recommandait','recommandions','recommandiez','recommandaient'],
    ['ai recommandé','as recommandé','a recommandé','avons recommandé','avez recommandé','ont recommandé'],
    ['recommanderai','recommanderas','recommandera','recommanderons','recommanderez','recommanderont'],
    ['vais recommander','vas recommander','va recommander','allons recommander','allez recommander','vont recommander'],
    ['recommanderais','recommanderais','recommanderait','recommanderions','recommanderiez','recommanderaient']
  ]),

  // 85. permettre
  Word( type: 'verb', level: 'A2', fr: 'permettre', en: 'to allow, to permit', example: 'Ce diplôme me permettra de trouver un bon travail.', conj: [
    ['permets','permets','permet','permettons','permettez','permettent'],
    ['permettais','permettais','permettait','permettions','permettiez','permettaient'],
    ['ai permis','as permis','a permis','avons permis','avez permis','ont permis'],
    ['permettrai','permettras','permettra','permettrons','permettrez','permettront'],
    ['vais permettre','vas permettre','va permettre','allons permettre','allez permettre','vont permettre'],
    ['permettrais','permettrais','permettrait','permettrions','permettriez','permettraient']
  ]),

  // 86. voyager
  Word( type: 'verb', level: 'A2', fr: 'voyager', en: 'to travel', example: 'Je veux voyager en France après mes études.', conj: [
    ['voyage','voyages','voyage','voyageons','voyagez','voyagent'],
    ['voyageais','voyageais','voyageait','voyagions','voyagiez','voyageaient'],
    ['ai voyagé','as voyagé','a voyagé','avons voyagé','avez voyagé','ont voyagé'],
    ['voyagerai','voyageras','voyagera','voyagerons','voyagerez','voyageront'],
    ['vais voyager','vas voyager','va voyager','allons voyager','allez voyager','vont voyager'],
    ['voyagerais','voyagerais','voyagerait','voyagerions','voyageriez','voyageraient']
  ]),

  // 87. visiter
  Word( type: 'verb', level: 'A2', fr: 'visiter', en: 'to visit (a place)', example: 'J\'ai visité le musée national de Phnom Penh.', conj: [
    ['visite','visites','visite','visitons','visitez','visitent'],
    ['visitais','visitais','visitait','visitions','visitiez','visitaient'],
    ['ai visité','as visité','a visité','avons visité','avez visité','ont visité'],
    ['visiterai','visiteras','visitera','visiterons','visiterez','visiteront'],
    ['vais visiter','vas visiter','va visiter','allons visiter','allez visiter','vont visiter'],
    ['visiterais','visiterais','visiterait','visiterions','visiteriez','visiteraient']
  ]),

  // 88. rester (être aux)
  Word( type: 'verb', level: 'A2', fr: 'rester', en: 'to stay, to remain', example: 'Je reste à la bibliothèque pour étudier.', conj: [
    ['reste','restes','reste','restons','restez','restent'],
    ['restais','restais','restait','restions','restiez','restaient'],
    ['suis resté(e)','es resté(e)','est resté(e)','sommes resté(e)s','êtes resté(e)s','sont resté(e)s'],
    ['resterai','resteras','restera','resterons','resterez','resteront'],
    ['vais rester','vas rester','va rester','allons rester','allez rester','vont rester'],
    ['resterais','resterais','resterait','resterions','resteriez','resteraient']
  ]),

  // 89. quitter
  Word( type: 'verb', level: 'A2', fr: 'quitter', en: 'to leave (a place or person)', example: 'Je quitte la maison à sept heures.', conj: [
    ['quitte','quittes','quitte','quittons','quittez','quittent'],
    ['quittais','quittais','quittait','quittions','quittiez','quittaient'],
    ['ai quitté','as quitté','a quitté','avons quitté','avez quitté','ont quitté'],
    ['quitterai','quitteras','quittera','quitterons','quitterez','quitteront'],
    ['vais quitter','vas quitter','va quitter','allons quitter','allez quitter','vont quitter'],
    ['quitterais','quitterais','quitterait','quitterions','quitteriez','quitteraient']
  ]),

  // 90. changer
  Word( type: 'verb', level: 'A2', fr: 'changer', en: 'to change', example: 'Je change de bus à l\'arrêt central.', conj: [
    ['change','changes','change','changeons','changez','changent'],
    ['changeais','changeais','changeait','changions','changiez','changeaient'],
    ['ai changé','as changé','a changé','avons changé','avez changé','ont changé'],
    ['changerai','changeras','changera','changerons','changerez','changeront'],
    ['vais changer','vas changer','va changer','allons changer','allez changer','vont changer'],
    ['changerais','changerais','changerait','changerions','changeriez','changeraient']
  ]),

  // 91. se dépêcher (reflexive, être aux)
  Word( type: 'verb', level: 'A2', fr: 'se dépêcher', en: 'to hurry', example: 'Je me dépêche pour ne pas rater le bus.', conj: [
    ['me dépêche','te dépêches','se dépêche','nous dépêchons','vous dépêchez','se dépêchent'],
    ['me dépêchais','te dépêchais','se dépêchait','nous dépêchions','vous dépêchiez','se dépêchaient'],
    ['me suis dépêché(e)','t\'es dépêché(e)','s\'est dépêché(e)','nous sommes dépêché(e)s','vous êtes dépêché(e)s','se sont dépêché(e)s'],
    ['me dépêcherai','te dépêcheras','se dépêchera','nous dépêcherons','vous dépêcherez','se dépêcheront'],
    ['vais me dépêcher','vas te dépêcher','va se dépêcher','allons nous dépêcher','allez vous dépêcher','vont se dépêcher'],
    ['me dépêcherais','te dépêcherais','se dépêcherait','nous dépêcherions','vous dépêcheriez','se dépêcheraient']
  ]),

  // 92. s\'inquiéter (reflexive, être aux)
  Word( type: 'verb', level: 'A2', fr: 's\'inquiéter', en: 'to worry', example: 'Je m\'inquiète pour les résultats de mon examen.', conj: [
    ['m\'inquiète','t\'inquiètes','s\'inquiète','nous inquiétons','vous inquiétez','s\'inquiètent'],
    ['m\'inquiétais','t\'inquiétais','s\'inquiétait','nous inquiétions','vous inquiétiez','s\'inquiétaient'],
    ['me suis inquiété(e)','t\'es inquiété(e)','s\'est inquiété(e)','nous sommes inquiété(e)s','vous êtes inquiété(e)s','se sont inquiété(e)s'],
    ['m\'inquiéterai','t\'inquiéteras','s\'inquiétera','nous inquiéterons','vous inquiéterez','s\'inquiéteront'],
    ['vais m\'inquiéter','vas t\'inquiéter','va s\'inquiéter','allons nous inquiéter','allez vous inquiéter','vont s\'inquiéter'],
    ['m\'inquiéterais','t\'inquiéterais','s\'inquiéterait','nous inquiéterions','vous inquiéteriez','s\'inquiéteraient']
  ]),

  // 93. tomber (être aux)
  Word( type: 'verb', level: 'A2', fr: 'tomber', en: 'to fall', example: 'Je suis tombé(e) à cause de la route mouillée.', conj: [
    ['tombe','tombes','tombe','tombons','tombez','tombent'],
    ['tombais','tombais','tombait','tombions','tombiez','tombaient'],
    ['suis tombé(e)','es tombé(e)','est tombé(e)','sommes tombé(e)s','êtes tombé(e)s','sont tombé(e)s'],
    ['tomberai','tomberas','tombera','tomberons','tomberez','tomberont'],
    ['vais tomber','vas tomber','va tomber','allons tomber','allez tomber','vont tomber'],
    ['tomberais','tomberais','tomberait','tomberions','tomberiez','tomberaient']
  ]),

  // 94. conduire
  Word( type: 'verb', level: 'A2', fr: 'conduire', en: 'to drive', example: 'Mon père conduit prudemment dans la ville.', conj: [
    ['conduis','conduis','conduit','conduisons','conduisez','conduisent'],
    ['conduisais','conduisais','conduisait','conduisions','conduisiez','conduisaient'],
    ['ai conduit','as conduit','a conduit','avons conduit','avez conduit','ont conduit'],
    ['conduirai','conduiras','conduira','conduirons','conduirez','conduiront'],
    ['vais conduire','vas conduire','va conduire','allons conduire','allez conduire','vont conduire'],
    ['conduirais','conduirais','conduirait','conduirions','conduiriez','conduiraient']
  ]),

  // 95. nager
  Word( type: 'verb', level: 'A2', fr: 'nager', en: 'to swim', example: 'Je nage dans la piscine deux fois par semaine.', conj: [
    ['nage','nages','nage','nageons','nagez','nagent'],
    ['nageais','nageais','nageait','nagions','nagiez','nageaient'],
    ['ai nagé','as nagé','a nagé','avons nagé','avez nagé','ont nagé'],
    ['nagerai','nageras','nagera','nagerons','nagerez','nageront'],
    ['vais nager','vas nager','va nager','allons nager','allez nager','vont nager'],
    ['nagerais','nagerais','nagerait','nagerions','nageriez','nageraient']
  ]),

  // 96. courir
  Word( type: 'verb', level: 'A2', fr: 'courir', en: 'to run', example: 'Je cours trente minutes chaque matin.', conj: [
    ['cours','cours','court','courons','courez','courent'],
    ['courais','courais','courait','courions','couriez','couraient'],
    ['ai couru','as couru','a couru','avons couru','avez couru','ont couru'],
    ['courrai','courras','courra','courrons','courrez','courront'],
    ['vais courir','vas courir','va courir','allons courir','allez courir','vont courir'],
    ['courrais','courrais','courrait','courrions','courriez','courraient']
  ]),

  // 97. marcher
  Word( type: 'verb', level: 'A2', fr: 'marcher', en: 'to walk', example: 'Je marche jusqu\'à l\'université quand il fait beau.', conj: [
    ['marche','marches','marche','marchons','marchez','marchent'],
    ['marchais','marchais','marchait','marchions','marchiez','marchaient'],
    ['ai marché','as marché','a marché','avons marché','avez marché','ont marché'],
    ['marcherai','marcheras','marchera','marcherons','marcherez','marcheront'],
    ['vais marcher','vas marcher','va marcher','allons marcher','allez marcher','vont marcher'],
    ['marcherais','marcherais','marcherait','marcherions','marcheriez','marcheraient']
  ]),

  // 98. cuisiner
  Word( type: 'verb', level: 'A2', fr: 'cuisiner', en: 'to cook', example: 'Je cuisine des plats khmers pour mes amis.', conj: [
    ['cuisine','cuisines','cuisine','cuisinons','cuisinez','cuisinent'],
    ['cuisinais','cuisinais','cuisinait','cuisinions','cuisiniez','cuisinaient'],
    ['ai cuisiné','as cuisiné','a cuisiné','avons cuisiné','avez cuisiné','ont cuisiné'],
    ['cuisinerai','cuisineras','cuisinera','cuisinerons','cuisinerez','cuisineront'],
    ['vais cuisiner','vas cuisiner','va cuisiner','allons cuisiner','allez cuisiner','vont cuisiner'],
    ['cuisinerais','cuisinerais','cuisinerait','cuisinerions','cuisineriez','cuisineraient']
  ]),

  // 99. nettoyer
  Word( type: 'verb', level: 'A2', fr: 'nettoyer', en: 'to clean', example: 'Je nettoie ma chambre chaque week-end.', conj: [
    ['nettoie','nettoies','nettoie','nettoyons','nettoyez','nettoient'],
    ['nettoyais','nettoyais','nettoyait','nettoyions','nettoyiez','nettoyaient'],
    ['ai nettoyé','as nettoyé','a nettoyé','avons nettoyé','avez nettoyé','ont nettoyé'],
    ['nettoierai','nettoieras','nettoiera','nettoierons','nettoierez','nettoieront'],
    ['vais nettoyer','vas nettoyer','va nettoyer','allons nettoyer','allez nettoyer','vont nettoyer'],
    ['nettoierais','nettoierais','nettoierait','nettoierions','nettoieriez','nettoieraient']
  ]),

  // 100. ranger
  Word( type: 'verb', level: 'A2', fr: 'ranger', en: 'to tidy up, to put away', example: 'Je range mes affaires avant d\'aller dormir.', conj: [
    ['range','ranges','range','rangeons','rangez','rangent'],
    ['rangeais','rangeais','rangeait','rangions','rangiez','rangeaient'],
    ['ai rangé','as rangé','a rangé','avons rangé','avez rangé','ont rangé'],
    ['rangerai','rangeras','rangera','rangerons','rangerez','rangeront'],
    ['vais ranger','vas ranger','va ranger','allons ranger','allez ranger','vont ranger'],
    ['rangerais','rangerais','rangerait','rangerions','rangeriez','rangeraient']
  ]),

  // ============================================================
  // A1 NOUNS (101–150)
  // ============================================================

  // 101. la famille
  Word( type: 'noun', level: 'A1', fr: 'la famille', en: 'family', example: 'Ma famille habite à Siem Reap.' ),

  // 102. le père
  Word( type: 'noun', level: 'A1', fr: 'le père', en: 'father', example: 'Mon père travaille dans une entreprise de construction.' ),

  // 103. la mère
  Word( type: 'noun', level: 'A1', fr: 'la mère', en: 'mother', example: 'Ma mère cuisine très bien les plats khmers.' ),

  // 104. le frère
  Word( type: 'noun', level: 'A1', fr: 'le frère', en: 'brother', example: 'Mon frère étudie l\'informatique à l\'ITC.' ),

  // 105. la sœur
  Word( type: 'noun', level: 'A1', fr: 'la sœur', en: 'sister', example: 'Ma sœur est au lycée et elle apprend le français.' ),

  // 106. l\'ami / l\'amie
  Word( type: 'noun', level: 'A1', fr: 'l\'ami / l\'amie', en: 'friend', example: 'Mon ami Dara parle très bien le français.' ),

  // 107. la maison
  Word( type: 'noun', level: 'A1', fr: 'la maison', en: 'house', example: 'Ma maison est grande et confortable.' ),

  // 108. la chambre
  Word( type: 'noun', level: 'A1', fr: 'la chambre', en: 'bedroom', example: 'Ma chambre est petite mais bien rangée.' ),

  // 109. le lit
  Word( type: 'noun', level: 'A1', fr: 'le lit', en: 'bed', example: 'Mon lit est très confortable.' ),

  // 110. la table
  Word( type: 'noun', level: 'A1', fr: 'la table', en: 'table', example: 'Il y a des livres sur ma table.' ),

  // 111. la chaise
  Word( type: 'noun', level: 'A1', fr: 'la chaise', en: 'chair', example: 'Je m\'assieds sur ma chaise pour étudier.' ),

  // 112. la fenêtre
  Word( type: 'noun', level: 'A1', fr: 'la fenêtre', en: 'window', example: 'La fenêtre de ma chambre donne sur le jardin.' ),

  // 113. la porte
  Word( type: 'noun', level: 'A1', fr: 'la porte', en: 'door', example: 'Je ferme la porte quand je pars.' ),

  // 114. le livre
  Word( type: 'noun', level: 'A1', fr: 'le livre', en: 'book', example: 'J\'ai un livre de grammaire française.' ),

  // 115. le cahier
  Word( type: 'noun', level: 'A1', fr: 'le cahier', en: 'notebook', example: 'J\'écris mes notes de cours dans mon cahier.' ),

  // 116. le stylo
  Word( type: 'noun', level: 'A1', fr: 'le stylo', en: 'pen', example: 'J\'ai oublié mon stylo à la maison.' ),

  // 117. l\'école
  Word( type: 'noun', level: 'A1', fr: 'l\'école', en: 'school', example: 'L\'école commence à sept heures trente.' ),

  // 118. la classe
  Word( type: 'noun', level: 'A1', fr: 'la classe', en: 'class, classroom', example: 'Notre classe de français a vingt étudiants.' ),

  // 119. le professeur
  Word( type: 'noun', level: 'A1', fr: 'le professeur', en: 'teacher, professor', example: 'Mon professeur de français est très patient.' ),

  // 120. l\'université
  Word( type: 'noun', level: 'A1', fr: 'l\'université', en: 'university', example: 'Mon université se trouve au centre de Phnom Penh.' ),

  // 121. le repas
  Word( type: 'noun', level: 'A1', fr: 'le repas', en: 'meal', example: 'Le repas en famille est important dans la culture khmère.' ),

  // 122. le petit-déjeuner
  Word( type: 'noun', level: 'A1', fr: 'le petit-déjeuner', en: 'breakfast', example: 'Je prends mon petit-déjeuner à six heures et demie.' ),

  // 123. le déjeuner
  Word( type: 'noun', level: 'A1', fr: 'le déjeuner', en: 'lunch', example: 'Je mange mon déjeuner à la cantine de l\'université.' ),

  // 124. le dîner
  Word( type: 'noun', level: 'A1', fr: 'le dîner', en: 'dinner', example: 'Nous prenons le dîner ensemble en famille à dix-neuf heures.' ),

  // 125. la nourriture
  Word( type: 'noun', level: 'A1', fr: 'la nourriture', en: 'food', example: 'La nourriture khmère est délicieuse et variée.' ),

  // 126. le pain
  Word( type: 'noun', level: 'A1', fr: 'le pain', en: 'bread', example: 'J\'achète du pain frais le matin.' ),

  // 127. l\'eau
  Word( type: 'noun', level: 'A1', fr: 'l\'eau', en: 'water', example: 'Je bois beaucoup d\'eau quand il fait chaud.' ),

  // 128. le pays
  Word( type: 'noun', level: 'A1', fr: 'le pays', en: 'country', example: 'Le Cambodge est mon pays natal.' ),

  // 129. la ville
  Word( type: 'noun', level: 'A1', fr: 'la ville', en: 'city, town', example: 'Phnom Penh est la plus grande ville du Cambodge.' ),

  // 130. la rue
  Word( type: 'noun', level: 'A1', fr: 'la rue', en: 'street', example: 'Il y a beaucoup de motos dans les rues de Phnom Penh.' ),

  // 131. le bus
  Word( type: 'noun', level: 'A1', fr: 'le bus', en: 'bus', example: 'Je prends le bus pour aller à l\'université.' ),

  // 132. la voiture
  Word( type: 'noun', level: 'A1', fr: 'la voiture', en: 'car', example: 'Mon père a une voiture bleue.' ),

  // 133. le téléphone
  Word( type: 'noun', level: 'A1', fr: 'le téléphone', en: 'phone', example: 'J\'utilise mon téléphone pour apprendre le français.' ),

  // 134. le jour
  Word( type: 'noun', level: 'A1', fr: 'le jour', en: 'day', example: 'Il y a sept jours dans une semaine.' ),

  // 135. la semaine
  Word( type: 'noun', level: 'A1', fr: 'la semaine', en: 'week', example: 'La semaine prochaine, j\'ai un examen.' ),

  // 136. le mois
  Word( type: 'noun', level: 'A1', fr: 'le mois', en: 'month', example: 'Il y a douze mois dans une année.' ),

  // 137. l\'année
  Word( type: 'noun', level: 'A1', fr: 'l\'année', en: 'year', example: 'Cette année, je suis en deuxième année à l\'ITC.' ),

  // 138. le matin
  Word( type: 'noun', level: 'A1', fr: 'le matin', en: 'morning', example: 'Le matin, je fais du sport avant d\'aller à l\'université.' ),

  // 139. l\'après-midi
  Word( type: 'noun', level: 'A1', fr: 'l\'après-midi', en: 'afternoon', example: 'L\'après-midi, j\'ai des cours de mathématiques.' ),

  // 140. le soir
  Word( type: 'noun', level: 'A1', fr: 'le soir', en: 'evening', example: 'Le soir, j\'étudie mes leçons de français.' ),

  // 141. la nuit
  Word( type: 'noun', level: 'A1', fr: 'la nuit', en: 'night', example: 'La nuit, il fait frais à Phnom Penh en décembre.' ),

  // 142. le travail
  Word( type: 'noun', level: 'A1', fr: 'le travail', en: 'work, job', example: 'Mon père aime son travail.' ),

  // 143. l\'argent
  Word( type: 'noun', level: 'A1', fr: 'l\'argent', en: 'money', example: 'Je n\'ai pas beaucoup d\'argent ce mois-ci.' ),

  // 144. le sport
  Word( type: 'noun', level: 'A1', fr: 'le sport', en: 'sport', example: 'Je fais du sport trois fois par semaine.' ),

  // 145. la musique
  Word( type: 'noun', level: 'A1', fr: 'la musique', en: 'music', example: 'J\'écoute de la musique pour me détendre.' ),

  // 146. le nom
  Word( type: 'noun', level: 'A1', fr: 'le nom', en: 'surname, name', example: 'Mon nom de famille est Sok.' ),

  // 147. le prénom
  Word( type: 'noun', level: 'A1', fr: 'le prénom', en: 'first name', example: 'Mon prénom est Dara.' ),

  // 148. l\'âge
  Word( type: 'noun', level: 'A1', fr: 'l\'âge', en: 'age', example: 'Quel est votre âge ? J\'ai vingt ans.' ),

  // 149. le numéro
  Word( type: 'noun', level: 'A1', fr: 'le numéro', en: 'number', example: 'Quel est votre numéro de téléphone ?' ),

  // 150. la question
  Word( type: 'noun', level: 'A1', fr: 'la question', en: 'question', example: 'Je pose une question au professeur.' ),

  // ============================================================
  // A2 NOUNS (151–220)
  // ============================================================

  // 151. le musée
  Word( type: 'noun', level: 'A2', fr: 'le musée', en: 'museum', example: 'J\'ai visité le musée national ce week-end.' ),

  // 152. la bibliothèque
  Word( type: 'noun', level: 'A2', fr: 'la bibliothèque', en: 'library', example: 'J\'étudie souvent à la bibliothèque de l\'université.' ),

  // 153. le marché
  Word( type: 'noun', level: 'A2', fr: 'le marché', en: 'market', example: 'Ma mère achète des légumes frais au marché.' ),

  // 154. le restaurant
  Word( type: 'noun', level: 'A2', fr: 'le restaurant', en: 'restaurant', example: 'Nous allons au restaurant pour fêter mon anniversaire.' ),

  // 155. la boulangerie
  Word( type: 'noun', level: 'A2', fr: 'la boulangerie', en: 'bakery', example: 'J\'achète du pain frais à la boulangerie chaque matin.' ),

  // 156. la pharmacie
  Word( type: 'noun', level: 'A2', fr: 'la pharmacie', en: 'pharmacy', example: 'Je vais à la pharmacie pour acheter des médicaments.' ),

  // 157. l\'hôtel
  Word( type: 'noun', level: 'A2', fr: 'l\'hôtel', en: 'hotel', example: 'Les touristes restent dans un hôtel près du Palais Royal.' ),

  // 158. l\'aéroport
  Word( type: 'noun', level: 'A2', fr: 'l\'aéroport', en: 'airport', example: 'L\'aéroport de Phnom Penh est très moderne.' ),

  // 159. la gare
  Word( type: 'noun', level: 'A2', fr: 'la gare', en: 'train station', example: 'Nous prenons le train à la gare.' ),

  // 160. le cinéma
  Word( type: 'noun', level: 'A2', fr: 'le cinéma', en: 'cinema, movie theater', example: 'Je vais au cinéma le samedi soir avec mes amis.' ),

  // 161. le quartier
  Word( type: 'noun', level: 'A2', fr: 'le quartier', en: 'neighborhood, district', example: 'Mon quartier est calme et agréable.' ),

  // 162. le médecin
  Word( type: 'noun', level: 'A2', fr: 'le médecin', en: 'doctor', example: 'Je consulte mon médecin quand je suis malade.' ),

  // 163. l\'infirmier / l\'infirmière
  Word( type: 'noun', level: 'A2', fr: 'l\'infirmier / l\'infirmière', en: 'nurse', example: 'L\'infirmière est très gentille avec les patients.' ),

  // 164. le vendeur / la vendeuse
  Word( type: 'noun', level: 'A2', fr: 'le vendeur / la vendeuse', en: 'salesperson', example: 'Le vendeur m\'aide à choisir des chaussures.' ),

  // 165. l\'étudiant / l\'étudiante
  Word( type: 'noun', level: 'A2', fr: 'l\'étudiant / l\'étudiante', en: 'student', example: 'Je suis étudiant(e) en première année à l\'ITC.' ),

  // 166. l\'examen
  Word( type: 'noun', level: 'A2', fr: 'l\'examen', en: 'exam', example: 'J\'ai un examen de français la semaine prochaine.' ),

  // 167. les notes
  Word( type: 'noun', level: 'A2', fr: 'les notes', en: 'grades, notes', example: 'Mes notes de français s\'améliorent chaque mois.' ),

  // 168. le stage
  Word( type: 'noun', level: 'A2', fr: 'le stage', en: 'internship, training', example: 'Je fais un stage dans une entreprise française cet été.' ),

  // 169. le métier
  Word( type: 'noun', level: 'A2', fr: 'le métier', en: 'profession, job, trade', example: 'Mon métier futur sera ingénieur civil.' ),

  // 170. le voyage
  Word( type: 'noun', level: 'A2', fr: 'le voyage', en: 'trip, journey', example: 'Mon premier voyage en France sera inoubliable.' ),

  // 171. la destination
  Word( type: 'noun', level: 'A2', fr: 'la destination', en: 'destination', example: 'La destination de mon prochain voyage est Paris.' ),

  // 172. le billet
  Word( type: 'noun', level: 'A2', fr: 'le billet', en: 'ticket', example: 'J\'ai acheté un billet d\'avion pour la France.' ),

  // 173. le passeport
  Word( type: 'noun', level: 'A2', fr: 'le passeport', en: 'passport', example: 'Mon passeport est valable cinq ans.' ),

  // 174. les vêtements
  Word( type: 'noun', level: 'A2', fr: 'les vêtements', en: 'clothes, clothing', example: 'J\'achète de nouveaux vêtements pour la rentrée.' ),

  // 175. la robe
  Word( type: 'noun', level: 'A2', fr: 'la robe', en: 'dress', example: 'Ma sœur porte une belle robe pour la fête.' ),

  // 176. le pantalon
  Word( type: 'noun', level: 'A2', fr: 'le pantalon', en: 'pants, trousers', example: 'Je mets un pantalon noir pour aller au cours.' ),

  // 177. la chemise
  Word( type: 'noun', level: 'A2', fr: 'la chemise', en: 'shirt', example: 'Mon père porte toujours une chemise blanche au bureau.' ),

  // 178. les chaussures
  Word( type: 'noun', level: 'A2', fr: 'les chaussures', en: 'shoes', example: 'J\'ai des chaussures neuves pour la cérémonie.' ),

  // 179. le prix
  Word( type: 'noun', level: 'A2', fr: 'le prix', en: 'price', example: 'Le prix de ce livre est raisonnable.' ),

  // 180. le produit
  Word( type: 'noun', level: 'A2', fr: 'le produit', en: 'product', example: 'Ce produit est fabriqué en France.' ),

  // 181. l\'habitude
  Word( type: 'noun', level: 'A2', fr: 'l\'habitude', en: 'habit', example: 'J\'ai l\'habitude d\'étudier le soir.' ),

  // 182. le problème
  Word( type: 'noun', level: 'A2', fr: 'le problème', en: 'problem', example: 'J\'ai un problème avec cet exercice de grammaire.' ),

  // 183. la solution
  Word( type: 'noun', level: 'A2', fr: 'la solution', en: 'solution', example: 'Le professeur m\'explique la solution du problème.' ),

  // 184. le rendez-vous
  Word( type: 'noun', level: 'A2', fr: 'le rendez-vous', en: 'appointment, meeting', example: 'J\'ai un rendez-vous chez le médecin demain.' ),

  // 185. l\'opinion
  Word( type: 'noun', level: 'A2', fr: 'l\'opinion', en: 'opinion', example: 'À mon opinion, étudier le français est très utile.' ),

  // 186. la raison
  Word( type: 'noun', level: 'A2', fr: 'la raison', en: 'reason', example: 'La raison de mon choix est l\'amour des langues.' ),

  // 187. le souvenir
  Word( type: 'noun', level: 'A2', fr: 'le souvenir', en: 'memory, souvenir', example: 'J\'ai un beau souvenir de ma visite à Angkor Wat.' ),

  // 188. l\'histoire
  Word( type: 'noun', level: 'A2', fr: 'l\'histoire', en: 'history, story', example: 'L\'histoire du Cambodge est très intéressante.' ),

  // 189. la culture
  Word( type: 'noun', level: 'A2', fr: 'la culture', en: 'culture', example: 'La culture française est riche et variée.' ),

  // 190. la tradition
  Word( type: 'noun', level: 'A2', fr: 'la tradition', en: 'tradition', example: 'La tradition khmère est célébrée pendant le Nouvel An.' ),

  // 191. la fête
  Word( type: 'noun', level: 'A2', fr: 'la fête', en: 'party, celebration, holiday', example: 'La fête du Nouvel An khmer est très animée.' ),

  // 192. le cadeau
  Word( type: 'noun', level: 'A2', fr: 'le cadeau', en: 'gift, present', example: 'J\'offre un cadeau à mon professeur en fin d\'année.' ),

  // 193. le message
  Word( type: 'noun', level: 'A2', fr: 'le message', en: 'message', example: 'J\'ai reçu un message de mon correspondant français.' ),

  // 194. la lettre
  Word( type: 'noun', level: 'A2', fr: 'la lettre', en: 'letter', example: 'J\'écris une lettre à mon ami en France.' ),

  // 195. l\'adresse
  Word( type: 'noun', level: 'A2', fr: 'l\'adresse', en: 'address', example: 'Quelle est l\'adresse de l\'université ?' ),

  // 196. la réponse
  Word( type: 'noun', level: 'A2', fr: 'la réponse', en: 'answer, reply', example: 'Je vérifie ma réponse avant de rendre l\'examen.' ),

  // 197. le conseil
  Word( type: 'noun', level: 'A2', fr: 'le conseil', en: 'advice', example: 'Mon professeur me donne de bons conseils pour progresser.' ),

  // 198. le projet
  Word( type: 'noun', level: 'A2', fr: 'le projet', en: 'project', example: 'Notre projet de groupe est sur les énergies renouvelables.' ),

  // 199. le futur
  Word( type: 'noun', level: 'A2', fr: 'le futur', en: 'future', example: 'Dans le futur, je voudrais travailler à l\'étranger.' ),

  // 200. le passé
  Word( type: 'noun', level: 'A2', fr: 'le passé', en: 'past', example: 'Dans le passé, je ne parlais pas français du tout.' ),

  // 201. la chance
  Word( type: 'noun', level: 'A2', fr: 'la chance', en: 'luck, chance', example: 'J\'ai la chance d\'étudier le français à l\'ITC.' ),

  // 202. le bruit
  Word( type: 'noun', level: 'A2', fr: 'le bruit', en: 'noise', example: 'Il y a beaucoup de bruit dans la rue le matin.' ),

  // 203. la lumière
  Word( type: 'noun', level: 'A2', fr: 'la lumière', en: 'light', example: 'La lumière dans la salle de classe est très bonne.' ),

  // 204. la couleur
  Word( type: 'noun', level: 'A2', fr: 'la couleur', en: 'color', example: 'Ma couleur préférée est le bleu.' ),

  // 205. le rêve
  Word( type: 'noun', level: 'A2', fr: 'le rêve', en: 'dream', example: 'Mon rêve est de visiter Paris un jour.' ),

  // 206. l\'effort
  Word( type: 'noun', level: 'A2', fr: 'l\'effort', en: 'effort', example: 'Avec beaucoup d\'efforts, je progresse en français.' ),

  // 207. le succès
  Word( type: 'noun', level: 'A2', fr: 'le succès', en: 'success', example: 'Mon succès à l\'examen me rend très heureux.' ),

  // 208. le progrès
  Word( type: 'noun', level: 'A2', fr: 'le progrès', en: 'progress', example: 'Je vois mes progrès en français chaque semaine.' ),

  // 209. l\'expérience
  Word( type: 'noun', level: 'A2', fr: 'l\'expérience', en: 'experience', example: 'Ce stage est une expérience très enrichissante.' ),

  // 210. la différence
  Word( type: 'noun', level: 'A2', fr: 'la différence', en: 'difference', example: 'Il y a des différences entre la culture française et la culture khmère.' ),

  // 211. l\'importance
  Word( type: 'noun', level: 'A2', fr: 'l\'importance', en: 'importance', example: 'L\'importance du français dans ma carrière est évidente.' ),

  // 212. le résultat
  Word( type: 'noun', level: 'A2', fr: 'le résultat', en: 'result', example: 'Les résultats de l\'examen arrivent demain.' ),

  // 213. le chemin
  Word( type: 'noun', level: 'A2', fr: 'le chemin', en: 'path, way', example: 'Je connais le chemin pour aller à l\'université.' ),

  // 214. le centre
  Word( type: 'noun', level: 'A2', fr: 'le centre', en: 'center', example: 'Le centre de Phnom Penh est très animé.' ),

  // 215. la direction
  Word( type: 'noun', level: 'A2', fr: 'la direction', en: 'direction', example: 'Dans quelle direction se trouve la gare ?' ),

  // 216. le fleuve (replacing duplicate 'le bruit')
  Word( type: 'noun', level: 'A2', fr: 'le fleuve', en: 'river', example: 'Le Mékong est un grand fleuve qui traverse le Cambodge.' ),

  // 217. la frontière
  Word( type: 'noun', level: 'A2', fr: 'la frontière', en: 'border', example: 'La frontière entre le Cambodge et le Vietnam est proche.' ),

  // 218. le voisin (replacing duplicate 'le marché')
  Word( type: 'noun', level: 'A2', fr: 'le voisin', en: 'neighbor', example: 'Mon voisin est très sympathique et serviable.' ),

  // 219. la carte
  Word( type: 'noun', level: 'A2', fr: 'la carte', en: 'map, card', example: 'J\'utilise la carte pour trouver mon chemin dans la ville.' ),

  // 220. le plan
  Word( type: 'noun', level: 'A2', fr: 'le plan', en: 'plan, city map', example: 'J\'ai un plan de la ville de Paris pour mon voyage.' ),

  // ============================================================
  // A1 ADJECTIVES (221–250)
  // ============================================================

  // 221. grand / grande
  Word( type: 'adjective', level: 'A1', fr: 'grand / grande', en: 'big, tall', example: 'Mon frère est très grand pour son âge.' ),

  // 222. petit / petite
  Word( type: 'adjective', level: 'A1', fr: 'petit / petite', en: 'small, short', example: 'Ma sœur est petite mais très courageuse.' ),

  // 223. bon / bonne
  Word( type: 'adjective', level: 'A1', fr: 'bon / bonne', en: 'good', example: 'Ce restaurant a une très bonne cuisine.' ),

  // 224. mauvais / mauvaise
  Word( type: 'adjective', level: 'A1', fr: 'mauvais / mauvaise', en: 'bad', example: 'J\'ai eu une mauvaise note à cet examen.' ),

  // 225. beau / belle
  Word( type: 'adjective', level: 'A1', fr: 'beau / belle', en: 'beautiful, handsome', example: 'Angkor Wat est un très beau temple.' ),

  // 226. vieux / vieille
  Word( type: 'adjective', level: 'A1', fr: 'vieux / vieille', en: 'old', example: 'Ce temple est très vieux mais encore magnifique.' ),

  // 227. jeune
  Word( type: 'adjective', level: 'A1', fr: 'jeune', en: 'young', example: 'Mon professeur est jeune et dynamique.' ),

  // 228. nouveau / nouvelle
  Word( type: 'adjective', level: 'A1', fr: 'nouveau / nouvelle', en: 'new', example: 'J\'ai un nouveau dictionnaire français-khmer.' ),

  // 229. heureux / heureuse
  Word( type: 'adjective', level: 'A1', fr: 'heureux / heureuse', en: 'happy', example: 'Je suis heureux quand j\'apprends quelque chose de nouveau.' ),

  // 230. triste
  Word( type: 'adjective', level: 'A1', fr: 'triste', en: 'sad', example: 'Je suis triste quand je rate un examen.' ),

  // 231. fatigué / fatiguée
  Word( type: 'adjective', level: 'A1', fr: 'fatigué / fatiguée', en: 'tired', example: 'Je suis fatigué après une longue journée de cours.' ),

  // 232. content / contente
  Word( type: 'adjective', level: 'A1', fr: 'content / contente', en: 'pleased, happy', example: 'Je suis content de mes résultats ce semestre.' ),

  // 233. facile
  Word( type: 'adjective', level: 'A1', fr: 'facile', en: 'easy', example: 'Cet exercice de vocabulaire est facile pour moi.' ),

  // 234. difficile
  Word( type: 'adjective', level: 'A1', fr: 'difficile', en: 'difficult', example: 'La grammaire française est parfois difficile.' ),

  // 235. important / importante
  Word( type: 'adjective', level: 'A1', fr: 'important / importante', en: 'important', example: 'Il est important de pratiquer le français tous les jours.' ),

  // 236. intéressant / intéressante
  Word( type: 'adjective', level: 'A1', fr: 'intéressant / intéressante', en: 'interesting', example: 'Ce cours de culture française est très intéressant.' ),

  // 237. ennuyeux / ennuyeuse
  Word( type: 'adjective', level: 'A1', fr: 'ennuyeux / ennuyeuse', en: 'boring', example: 'Ce film est trop ennuyeux pour moi.' ),

  // 238. rapide
  Word( type: 'adjective', level: 'A1', fr: 'rapide', en: 'fast, quick', example: 'Mon ami est très rapide pour finir les exercices.' ),

  // 239. lent / lente
  Word( type: 'adjective', level: 'A1', fr: 'lent / lente', en: 'slow', example: 'Je parle lentement pour être mieux compris.' ),

  // 240. chaud / chaude
  Word( type: 'adjective', level: 'A1', fr: 'chaud / chaude', en: 'hot, warm', example: 'Il fait très chaud en avril à Phnom Penh.' ),

  // 241. froid / froide
  Word( type: 'adjective', level: 'A1', fr: 'froid / froide', en: 'cold', example: 'En décembre, les nuits sont froides.' ),

  // 242. propre
  Word( type: 'adjective', level: 'A1', fr: 'propre', en: 'clean', example: 'Ma chambre est propre et bien organisée.' ),

  // 243. sale
  Word( type: 'adjective', level: 'A1', fr: 'sale', en: 'dirty', example: 'Mes chaussures sont sales après la pluie.' ),

  // 244. premier / première
  Word( type: 'adjective', level: 'A1', fr: 'premier / première', en: 'first', example: 'C\'est mon premier cours de français à l\'ITC.' ),

  // 245. dernier / dernière
  Word( type: 'adjective', level: 'A1', fr: 'dernier / dernière', en: 'last', example: 'La dernière leçon du semestre est vendredi.' ),

  // 246. même
  Word( type: 'adjective', level: 'A1', fr: 'même', en: 'same', example: 'Nous avons le même livre de grammaire.' ),

  // 247. autre
  Word( type: 'adjective', level: 'A1', fr: 'autre', en: 'other, another', example: 'Je veux apprendre une autre langue après le français.' ),

  // 248. seul / seule
  Word( type: 'adjective', level: 'A1', fr: 'seul / seule', en: 'alone, only', example: 'Je vis seul dans un appartement près de l\'ITC.' ),

  // 249. simple
  Word( type: 'adjective', level: 'A1', fr: 'simple', en: 'simple', example: 'Cet exercice est simple et rapide à faire.' ),

  // 250. fort / forte
  Word( type: 'adjective', level: 'A1', fr: 'fort / forte', en: 'strong, good at', example: 'Mon ami est fort en mathématiques.' ),

  // ============================================================
  // A2 ADJECTIVES AND ADVERBS (251–300)
  // ============================================================

  // 251. sympathique
  Word( type: 'adjective', level: 'A2', fr: 'sympathique', en: 'nice, likeable', example: 'Mon professeur de français est très sympathique.' ),

  // 252. agréable
  Word( type: 'adjective', level: 'A2', fr: 'agréable', en: 'pleasant', example: 'L\'ambiance de notre classe est très agréable.' ),

  // 253. magnifique
  Word( type: 'adjective', level: 'A2', fr: 'magnifique', en: 'magnificent, stunning', example: 'Le coucher de soleil sur le Mékong est magnifique.' ),

  // 254. merveilleux / merveilleuse
  Word( type: 'adjective', level: 'A2', fr: 'merveilleux / merveilleuse', en: 'wonderful, marvelous', example: 'C\'est une merveilleuse opportunité d\'étudier le français.' ),

  // 255. calme
  Word( type: 'adjective', level: 'A2', fr: 'calme', en: 'calm, quiet', example: 'La bibliothèque est un endroit calme pour étudier.' ),

  // 256. bruyant / bruyante
  Word( type: 'adjective', level: 'A2', fr: 'bruyant / bruyante', en: 'noisy, loud', example: 'Le marché du matin est très bruyant.' ),

  // 257. moderne
  Word( type: 'adjective', level: 'A2', fr: 'moderne', en: 'modern', example: 'Notre université est équipée de salles modernes.' ),

  // 258. traditionnel / traditionnelle
  Word( type: 'adjective', level: 'A2', fr: 'traditionnel / traditionnelle', en: 'traditional', example: 'Le costume traditionnel khmer est très beau.' ),

  // 259. possible
  Word( type: 'adjective', level: 'A2', fr: 'possible', en: 'possible', example: 'Il est possible de parler français couramment en deux ans.' ),

  // 260. impossible
  Word( type: 'adjective', level: 'A2', fr: 'impossible', en: 'impossible', example: 'Rien n\'est impossible si on travaille dur.' ),

  // 261. nécessaire
  Word( type: 'adjective', level: 'A2', fr: 'nécessaire', en: 'necessary', example: 'Il est nécessaire de faire ses devoirs chaque soir.' ),

  // 262. utile
  Word( type: 'adjective', level: 'A2', fr: 'utile', en: 'useful', example: 'Ce dictionnaire est très utile pour apprendre le vocabulaire.' ),

  // 263. inutile
  Word( type: 'adjective', level: 'A2', fr: 'inutile', en: 'useless, pointless', example: 'Il est inutile d\'apprendre sans pratiquer.' ),

  // 264. dangereux / dangereuse
  Word( type: 'adjective', level: 'A2', fr: 'dangereux / dangereuse', en: 'dangerous', example: 'Il est dangereux de traverser la rue sans regarder.' ),

  // 265. sûr / sûre
  Word( type: 'adjective', level: 'A2', fr: 'sûr / sûre', en: 'safe, sure, certain', example: 'Je suis sûr(e) de réussir mon examen cette fois.' ),

  // 266. libre
  Word( type: 'adjective', level: 'A2', fr: 'libre', en: 'free, available', example: 'Je suis libre le week-end pour réviser.' ),

  // 267. occupé / occupée
  Word( type: 'adjective', level: 'A2', fr: 'occupé / occupée', en: 'busy', example: 'Je suis très occupé(e) pendant la période des examens.' ),

  // 268. surpris / surprise
  Word( type: 'adjective', level: 'A2', fr: 'surpris / surprise', en: 'surprised', example: 'Je suis surpris par les bonnes nouvelles.' ),

  // 269. désolé / désolée
  Word( type: 'adjective', level: 'A2', fr: 'désolé / désolée', en: 'sorry', example: 'Je suis désolé(e) d\'être en retard au cours.' ),

  // 270. inquiet / inquiète
  Word( type: 'adjective', level: 'A2', fr: 'inquiet / inquiète', en: 'worried', example: 'Je suis inquiet avant chaque examen important.' ),

  // 271. fier / fière
  Word( type: 'adjective', level: 'A2', fr: 'fier / fière', en: 'proud', example: 'Je suis fier(ière) de mes progrès en français.' ),

  // 272. reconnaissant / reconnaissante
  Word( type: 'adjective', level: 'A2', fr: 'reconnaissant / reconnaissante', en: 'grateful, thankful', example: 'Je suis reconnaissant(e) envers mes professeurs.' ),

  // 273. vraiment (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'vraiment', en: 'truly, really', example: 'J\'aime vraiment apprendre le français.' ),

  // 274. seulement (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'seulement', en: 'only', example: 'Je parle seulement un peu de français pour l\'instant.' ),

  // 275. souvent (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'souvent', en: 'often', example: 'Je vais souvent à la bibliothèque pour étudier.' ),

  // 276. parfois (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'parfois', en: 'sometimes', example: 'Parfois, je parle français avec mes camarades.' ),

  // 277. toujours (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'toujours', en: 'always, still', example: 'Je travaille toujours dur pour améliorer mon français.' ),

  // 278. jamais (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'jamais', en: 'never', example: 'Je ne rate jamais un cours de français.' ),

  // 279. déjà (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'déjà', en: 'already', example: 'J\'ai déjà fini mes devoirs pour demain.' ),

  // 280. encore (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'encore', en: 'again, still', example: 'Je relis encore le texte pour mieux comprendre.' ),

  // 281. beaucoup (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'beaucoup', en: 'a lot, much', example: 'J\'aime beaucoup la culture française.' ),

  // 282. peu (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'peu', en: 'a little, few', example: 'Je parle encore peu, mais je comprends bien.' ),

  // 283. trop (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'trop', en: 'too much, too many', example: 'Ce cours est trop difficile pour les débutants.' ),

  // 284. assez (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'assez', en: 'enough, quite', example: 'Je n\'ai pas assez dormi cette nuit.' ),

  // 285. très (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'très', en: 'very', example: 'Je suis très content de mon progrès en français.' ),

  // 286. bien (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'bien', en: 'well', example: 'Je parle bien le français après six mois d\'étude.' ),

  // 287. mal (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'mal', en: 'badly, poorly', example: 'Je dors mal avant les examens importants.' ),

  // 288. vite (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'vite', en: 'quickly, fast', example: 'Mon ami apprend le français très vite.' ),

  // 289. lentement (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'lentement', en: 'slowly', example: 'Je parle lentement pour être bien compris.' ),

  // 290. ensemble (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'ensemble', en: 'together', example: 'Nous travaillons ensemble sur ce projet de groupe.' ),

  // 291. surtout (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'surtout', en: 'especially, above all', example: 'J\'aime surtout la phonétique française.' ),

  // 292. pourtant (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'pourtant', en: 'however, yet, nevertheless', example: 'C\'est difficile, pourtant je ne vais pas abandonner.' ),

  // 293. cependant (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'cependant', en: 'however, nevertheless', example: 'Je travaille beaucoup ; cependant, j\'ai du mal à mémoriser.' ),

  // 294. enfin (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'enfin', en: 'finally, at last', example: 'J\'ai enfin compris cette règle de grammaire difficile.' ),

  // 295. donc (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'donc', en: 'so, therefore', example: 'Je travaille dur, donc j\'espère réussir.' ),

  // 296. alors (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'alors', en: 'so, then, at that time', example: 'Il était tard, alors j\'ai décidé de rentrer.' ),

  // 297. peut-être (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'peut-être', en: 'maybe, perhaps', example: 'Peut-être que je vais étudier en France l\'année prochaine.' ),

  // 298. probablement (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'probablement', en: 'probably', example: 'Je vais probablement réussir cet examen.' ),

  // 299. exactement (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'exactement', en: 'exactly', example: 'C\'est exactement ce que voulait dire le professeur.' ),

  // 300. complètement (adverb)
  Word( type: 'adverb', level: 'A2', fr: 'complètement', en: 'completely', example: 'Je suis complètement d\'accord avec toi.' ),
]; // END OF VOCAB DATA
