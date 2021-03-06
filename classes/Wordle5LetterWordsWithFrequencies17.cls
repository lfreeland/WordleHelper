public with sharing class Wordle5LetterWordsWithFrequencies17 {
    /*
     * 5 Letter Words and their frequencies from https://www.kaggle.com/datasets/rtatman/english-word-frequency
     */ 
    public static Map<String, Long> wordsWithFrequencies = new Map<String, Long> {
        'selpa'=>40536,
        'issam'=>40527,
        'taner'=>40524,
        'heier'=>40522,
        'dryed'=>40522,
        'colca'=>40517,
        'laube'=>40508,
        'spiss'=>40502,
        'algun'=>40499,
        'eubie'=>40497,
        'vitry'=>40494,
        'uncon'=>40494,
        'amera'=>40494,
        'orcia'=>40490,
        'cedis'=>40486,
        'pyssy'=>40476,
        'patin'=>40474,
        'leick'=>40467,
        'dosis'=>40458,
        'sprot'=>40453,
        'telok'=>40451,
        'ldots'=>40447,
        'geren'=>40440,
        'dicen'=>40439,
        'caida'=>40438,
        'nemco'=>40432,
        'climo'=>40426,
        'qurei'=>40412,
        'khoon'=>40412,
        'niscc'=>40402,
        'tutos'=>40399,
        'wakey'=>40395,
        'pugin'=>40387,
        'fatta'=>40385,
        'ecorv'=>40381,
        'chaep'=>40381,
        'uulib'=>40378,
        'imado'=>40377,
        'drear'=>40377,
        'chaux'=>40368,
        'swapo'=>40366,
        'demko'=>40366,
        'dnepr'=>40362,
        'laggy'=>40361,
        'noton'=>40358,
        'nacdl'=>40358,
        'antiq'=>40358,
        'bcron'=>40353,
        'insat'=>40352,
        'novar'=>40351,
        'hivos'=>40351,
        'solco'=>40339,
        'uchod'=>40337,
        'erotc'=>40333,
        'sluis'=>40331,
        'actfl'=>40329,
        'gecco'=>40326,
        'yehey'=>40321,
        'bokeh'=>40320,
        'eshte'=>40318,
        'ifrss'=>40316,
        'peppe'=>40315,
        'hasim'=>40298,
        'choux'=>40291,
        'hemis'=>40290,
        'canoa'=>40287,
        'chale'=>40282,
        'touby'=>40281,
        'aipge'=>40267,
        'pilla'=>40255,
        'diamo'=>40255,
        'pompa'=>40254,
        'dieth'=>40246,
        'dessy'=>40246,
        'icuii'=>40237,
        'foola'=>40231,
        'satta'=>40225,
        'nenas'=>40216,
        'wwood'=>40213,
        'eyler'=>40213,
        'abetz'=>40213,
        'nogin'=>40204,
        'modin'=>40203,
        'aacom'=>40202,
        'possa'=>40201,
        'maina'=>40200,
        'ezrin'=>40200,
        'ariga'=>40198,
        'adyar'=>40195,
        'jills'=>40192,
        'kasih'=>40190,
        'tbone'=>40186,
        'plock'=>40185,
        'kefka'=>40176,
        'atomz'=>40168,
        'slunk'=>40167,
        'doubs'=>40167,
        'sibly'=>40153,
        'manch'=>40153,
        'suppy'=>40149,
        'inada'=>40146,
        'yelps'=>40144,
        'redex'=>40142,
        'virga'=>40140,
        'wustl'=>40134,
        'bhanu'=>40131,
        'teitl'=>40130,
        'nzoss'=>40127,
        'muray'=>40126,
        'hemin'=>40119,
        'neate'=>40118,
        'qsize'=>40116,
        'pjpeg'=>40113,
        'ossur'=>40111,
        'katan'=>40110,
        'chann'=>40108,
        'msecs'=>40105,
        'laron'=>40103,
        'cellu'=>40103,
        'usphs'=>40102,
        'fcode'=>40100,
        'radvd'=>40096,
        'avgas'=>40092,
        'qstat'=>40088,
        'raita'=>40083,
        'hedon'=>40076,
        'inlaw'=>40071,
        'tonet'=>40066,
        'hablo'=>40061,
        'subif'=>40059,
        'rense'=>40057,
        'hylan'=>40057,
        'saheb'=>40056,
        'pymca'=>40055,
        'latka'=>40054,
        'jumpn'=>40051,
        'troys'=>40050,
        'stria'=>40045,
        'dapto'=>40041,
        'fcron'=>40033,
        'zafon'=>40030,
        'razin'=>40028,
        'vaddr'=>40025,
        'firmy'=>40024,
        'eligi'=>40019,
        'khufu'=>40013,
        'halma'=>40013,
        'easts'=>40013,
        'strid'=>40006,
        'heriz'=>40004,
        'pusys'=>40003,
        'lapto'=>40002,
        'pirsa'=>40001,
        'dolch'=>39999,
        'avita'=>39999,
        'deras'=>39987,
        'tname'=>39978,
        'tarmo'=>39965,
        'chene'=>39961,
        'conns'=>39954,
        'tblsp'=>39951,
        'cowls'=>39950,
        'golla'=>39949,
        'carme'=>39942,
        'munck'=>39932,
        'racey'=>39931,
        'qfont'=>39931,
        'pippo'=>39928,
        'nyseg'=>39925,
        'certa'=>39923,
        'bolte'=>39920,
        'strib'=>39919,
        'khung'=>39918,
        'noren'=>39915,
        'jacka'=>39915,
        'ducat'=>39914,
        'wurth'=>39911,
        'nchar'=>39909,
        'kenta'=>39908,
        'tenba'=>39895,
        'suuri'=>39894,
        'propp'=>39893,
        'allam'=>39893,
        'oscom'=>39892,
        'anole'=>39883,
        'iftar'=>39882,
        'juggy'=>39881,
        'coved'=>39880,
        'novex'=>39879,
        'nazwa'=>39875,
        'etzel'=>39875,
        'idate'=>39870,
        'poing'=>39869,
        'murti'=>39866,
        'talin'=>39863,
        'gatta'=>39855,
        'bryer'=>39855,
        'fiers'=>39852,
        'donen'=>39851,
        'icers'=>39847,
        'gauld'=>39847,
        'lexey'=>39843,
        'tuffs'=>39840,
        'moshu'=>39839,
        'buser'=>39838,
        'vevay'=>39833,
        'allel'=>39827,
        'rusby'=>39824,
        'tsuba'=>39823,
        'ffeil'=>39823,
        'torok'=>39820,
        'sudsy'=>39819,
        'kairi'=>39817,
        'bleem'=>39814,
        'rimer'=>39811,
        'addit'=>39800,
        'bahay'=>39784,
        'gjort'=>39781,
        'huose'=>39779,
        'edhec'=>39779,
        'homma'=>39778,
        'neers'=>39772,
        'iapmo'=>39772,
        'tomaz'=>39766,
        'kisan'=>39762,
        'stari'=>39759,
        'ahler'=>39759,
        'micas'=>39750,
        'nager'=>39745,
        'reinf'=>39740,
        'letit'=>39730,
        'gbits'=>39730,
        'stumm'=>39724,
        'trael'=>39723,
        'elute'=>39723,
        'ranji'=>39721,
        'veldt'=>39718,
        'jguru'=>39718,
        'moros'=>39710,
        'tinct'=>39709,
        'gjdoc'=>39705,
        'mozal'=>39703,
        'copag'=>39696,
        'revio'=>39694,
        'himal'=>39693,
        'eorum'=>39689,
        'brevi'=>39688,
        'randr'=>39677,
        'scuds'=>39676,
        'arlis'=>39668,
        'belum'=>39666,
        'artix'=>39661,
        'pshaw'=>39660,
        'yngve'=>39657,
        'bunia'=>39646,
        'sadan'=>39645,
        'vokal'=>39643,
        'allos'=>39639,
        'lordi'=>39631,
        'goyim'=>39630,
        'bigga'=>39628,
        'tated'=>39625,
        'talli'=>39625,
        'ruban'=>39618,
        'rosho'=>39618,
        'nativ'=>39617,
        'bushi'=>39617,
        'mkdep'=>39614,
        'klugh'=>39609,
        'amedd'=>39607,
        'cenla'=>39606,
        'lehar'=>39603,
        'gropp'=>39598,
        'veach'=>39581,
        'shaya'=>39577,
        'ephod'=>39569,
        'fitly'=>39568,
        'limas'=>39567,
        'jazze'=>39567,
        'gnoll'=>39563,
        'hiren'=>39553,
        'naspa'=>39544,
        'dlsym'=>39534,
        'berol'=>39527,
        'speas'=>39524,
        'gines'=>39521,
        'ghood'=>39516,
        'wsabi'=>39511,
        'uttam'=>39509,
        'xylan'=>39507,
        'nehrp'=>39506,
        'coman'=>39503,
        'taren'=>39499,
        'honus'=>39496,
        'frani'=>39495,
        'tefft'=>39493,
        'mench'=>39492,
        'wonko'=>39489,
        'bassy'=>39488,
        'melby'=>39486,
        'pnnoc'=>39480,
        'sonik'=>39479,
        'matai'=>39476,
        'zorin'=>39469,
        'sarne'=>39466,
        'pedis'=>39462,
        'buist'=>39457,
        'tatas'=>39456,
        'drood'=>39450,
        'asymp'=>39450,
        'corvo'=>39449,
        'kouga'=>39446,
        'eglug'=>39445,
        'luken'=>39442,
        'newbb'=>39439,
        'pread'=>39438,
        'criar'=>39438,
        'coppi'=>39416,
        'hyjal'=>39414,
        'yoong'=>39413,
        'havea'=>39413,
        'gompa'=>39410,
        'igetc'=>39407,
        'rissa'=>39406,
        'waeco'=>39403,
        'weale'=>39394,
        'koine'=>39394,
        'mausb'=>39391,
        'corpn'=>39390,
        'batre'=>39387,
        'elion'=>39385,
        'miaka'=>39365,
        'zirin'=>39357,
        'medex'=>39354,
        'micco'=>39352,
        'sivun'=>39351,
        'kolya'=>39349,
        'apers'=>39349,
        'lipil'=>39344,
        'cipal'=>39333,
        'wiltz'=>39330,
        'dreds'=>39329,
        'saiki'=>39328,
        'shifa'=>39323,
        'couns'=>39320,
        'leamy'=>39318,
        'glina'=>39317,
        'hoppa'=>39315,
        'opirg'=>39312,
        'pelem'=>39307,
        'sprep'=>39300,
        'auran'=>39300,
        'sauli'=>39297,
        'bluet'=>39292,
        'sakae'=>39290,
        'tesar'=>39289,
        'freeb'=>39289,
        'elize'=>39286,
        'salla'=>39284,
        'joice'=>39283,
        'akoma'=>39272,
        'mutuo'=>39265,
        'balug'=>39263,
        'proso'=>39260,
        'cayes'=>39260,
        'gersh'=>39251,
        'saket'=>39249,
        'tsien'=>39247,
        'iosif'=>39239,
        'blauw'=>39234,
        'spacy'=>39233,
        'getch'=>39232,
        'unifi'=>39221,
        'josse'=>39215,
        'greil'=>39215,
        'corri'=>39208,
        'loung'=>39197,
        'ucisa'=>39190,
        'joyas'=>39189,
        'beppu'=>39185,
        'nvocc'=>39184,
        'peoms'=>39182,
        'pokrr'=>39172,
        'boylh'=>39169,
        'rebif'=>39168,
        'scops'=>39159,
        'helds'=>39155,
        'balam'=>39153,
        'sfpuc'=>39151,
        'adilt'=>39150,
        'alvah'=>39149,
        'shews'=>39148,
        'yaffa'=>39134,
        'gotel'=>39124,
        'akkad'=>39124,
        'salai'=>39123,
        'deuda'=>39113,
        'aytes'=>39112,
        'bruss'=>39111,
        'brizo'=>39110,
        'zarko'=>39108,
        'sirol'=>39108,
        'vedeo'=>39104,
        'perte'=>39095,
        'suazo'=>39094,
        'alsup'=>39090,
        'narra'=>39086,
        'decis'=>39086,
        'volpi'=>39085,
        'gamow'=>39078,
        'rieck'=>39067,
        'phakt'=>39062,
        'quigg'=>39057,
        'krier'=>39055,
        'gigot'=>39052,
        'ceeds'=>39050,
        'feeny'=>39046,
        'fluno'=>39044,
        'naill'=>39043,
        'flobo'=>39041,
        'chems'=>39037,
        'romar'=>39033,
        'atget'=>39032,
        'umoja'=>39029,
        'levet'=>39029,
        'gigue'=>39029,
        'ptime'=>39022,
        'osaki'=>39021,
        'silja'=>39018,
        'bleck'=>39018,
        'khadr'=>39010,
        'tious'=>39005,
        'yukai'=>39004,
        'peabo'=>39002,
        'yamal'=>38999,
        'sedia'=>38993,
        'tites'=>38991,
        'kynar'=>38986,
        'porat'=>38985,
        'ebano'=>38985,
        'sigla'=>38984,
        'pouts'=>38976,
        'ruark'=>38968,
        'seigo'=>38943,
        'dntps'=>38943,
        'ryals'=>38933,
        'johnl'=>38932,
        'etape'=>38928,
        'hanis'=>38923,
        'bunds'=>38923,
        'bulga'=>38923,
        'jeugd'=>38918,
        'alack'=>38913,
        'bisse'=>38909,
        'piter'=>38908,
        'yeley'=>38905,
        'psoas'=>38903,
        'scort'=>38899,
        'miaow'=>38898,
        'fenny'=>38897,
        'garen'=>38895,
        'onoma'=>38892,
        'kengo'=>38892,
        'devia'=>38885,
        'lized'=>38881,
        'aruch'=>38881,
        'truby'=>38879,
        'madri'=>38878,
        'raviv'=>38874,
        'erinn'=>38870,
        'khans'=>38869,
        'satou'=>38867,
        'aicha'=>38866,
        'kwesi'=>38863,
        'susse'=>38861,
        'tymor'=>38858,
        'mclay'=>38858,
        'daunt'=>38855,
        'grobe'=>38850,
        'afcee'=>38845,
        'topup'=>38841,
        'cires'=>38841,
        'gsbca'=>38838,
        'pimms'=>38836,
        'solli'=>38832,
        'okuji'=>38825,
        'tarim'=>38821,
        'rente'=>38816,
        'espon'=>38815,
        'fordf'=>38808,
        'socia'=>38805,
        'ducha'=>38797,
        'ixion'=>38796,
        'zakah'=>38781,
        'skola'=>38779,
        'deuba'=>38777,
        'eljer'=>38775,
        'froom'=>38770,
        'vavra'=>38768,
        'choos'=>38768,
        'aquae'=>38767,
        'doser'=>38761,
        'puhca'=>38759,
        'shome'=>38749,
        'hoeft'=>38749,
        'lueck'=>38744,
        'schev'=>38742,
        'dwsrf'=>38740,
        'dijet'=>38736,
        'aetec'=>38735,
        'okrug'=>38733,
        'laith'=>38732,
        'hymer'=>38731,
        'serin'=>38729,
        'meete'=>38727,
        'ninny'=>38726,
        'becoz'=>38720,
        'affid'=>38719,
        'echam'=>38717,
        'hydel'=>38715,
        'puaka'=>38713,
        'capet'=>38709,
        'thair'=>38707,
        'kalyn'=>38701,
        'eboot'=>38701,
        'dofus'=>38698,
        'cimon'=>38695,
        'gater'=>38694,
        'brujo'=>38693,
        'hunka'=>38692,
        'nemen'=>38689,
        'lucks'=>38688,
        'denio'=>38687,
        'arxes'=>38686,
        'toper'=>38676,
        'hinfo'=>38673,
        'suphp'=>38665,
        'mthfr'=>38663,
        'sunde'=>38661,
        'sobey'=>38660,
        'looke'=>38660,
        'avvid'=>38656,
        'jagat'=>38654,
        'swana'=>38634,
        'senin'=>38631,
        'feare'=>38620,
        'ombud'=>38617,
        'fakta'=>38617,
        'annce'=>38616,
        'neder'=>38615,
        'vider'=>38610,
        'juifs'=>38607,
        'myerz'=>38605,
        'ticky'=>38595,
        'iscan'=>38594,
        'cyfra'=>38587,
        'alecm'=>38587,
        'deroy'=>38585,
        'bollo'=>38585,
        'bargy'=>38581,
        'bglii'=>38577,
        'amami'=>38573,
        'beber'=>38567,
        'tattt'=>38555,
        'romas'=>38553,
        'yundi'=>38547,
        'chiyo'=>38547,
        'hymes'=>38539,
        'kalka'=>38537,
        'saros'=>38529,
        'civit'=>38516,
        'lents'=>38512,
        'kohei'=>38512,
        'namba'=>38510
    };
}
