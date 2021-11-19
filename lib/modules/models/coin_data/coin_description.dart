
class CoinDescription {
  final String?  en, de, es, fr, it, pl, ro, hu, nl, pt, sv, vi, tr, ru, ja, zh,
      zhTw, ko, ar, th, id;

  CoinDescription({
    this.en, this.de, this.es, this.fr, this.it, this.pl,
    this.ro, this.hu, this.nl, this.pt, this.sv, this.vi,
    this.tr, this.ru, this.ja, this.zh, this.zhTw, this.ko,
    this.ar, this.th, this.id,
  });

  static CoinDescription fromJson(dynamic _json) {
    final json = _json as Map<String, dynamic>;
    return CoinDescription(
      en: json['en'], de: json['de'], es: json['es'], fr: json['fr'],
      it: json['it'], pl: json['pl'], ro: json['ro'], hu: json['hu'],
      nl: json['nl'], pt: json['pt'], sv: json['sv'], vi: json['vi'],
      tr: json['tr'], ru: json['ru'], ja: json['ja'], zh: json['zh'],
      zhTw: json['zh-tw'], ko: json['ko'], ar: json['ar'], th: json['th'],
      id: json['id'],
    );
  }
}