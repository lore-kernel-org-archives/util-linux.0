Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50696 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751886AbaEETU4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 May 2014 15:20:56 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id ABBA8AAF1
	for <util-linux@vger.kernel.org>; Mon,  5 May 2014 19:20:54 +0000 (UTC)
Message-ID: <1399317654.11780.43.camel@oct.suse.cz>
Subject: [PATCH] hwclock: Warning typo fix
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Date: Mon, 05 May 2014 21:20:54 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Trailing '\n' is missing in:
"Not setting clock because last adjustment time is zero, so history is bad."

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/hwclock.c | 2 +-
 po/ca.po            | 2 +-
 po/cs.po            | 4 ++--
 po/da.po            | 4 ++--
 po/de.po            | 2 +-
 po/es.po            | 2 +-
 po/et.po            | 2 +-
 po/eu.po            | 2 +-
 po/fi.po            | 4 ++--
 po/fr.po            | 4 ++--
 po/gl.po            | 2 +-
 po/hr.po            | 2 +-
 po/hu.po            | 2 +-
 po/id.po            | 4 ++--
 po/it.po            | 2 +-
 po/ja.po            | 2 +-
 po/nl.po            | 4 ++--
 po/pl.po            | 4 ++--
 po/pt_BR.po         | 4 ++--
 po/ru.po            | 2 +-
 po/sl.po            | 2 +-
 po/sv.po            | 2 +-
 po/tr.po            | 2 +-
 po/uk.po            | 4 ++--
 po/vi.po            | 4 ++--
 po/zh_CN.po         | 4 ++--
 po/zh_TW.po         | 4 ++--
 27 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index fe97fcb..beb2845 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1210,7 +1210,7 @@ do_adjustment(struct adjtime *adjtime_p,
 		if (debug)
 			printf(_
 			       ("Not setting clock because last adjustment time is zero, "
-				"so history is bad."));
+				"so history is bad.\n"));
 	} else if (abs(adjtime_p->drift_factor) > MAX_DRIFT) {
 		if (debug)
 		printf(_("Not setting clock because drift factor %f is far too high.\n"),
diff --git a/po/ca.po b/po/ca.po
index e38952b..7cd54e3 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -12517,7 +12517,7 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, fuzzy, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "No s'ha ajustat el factor de desfasament perquè la data de l'última\n"
 "calibració és zero, així que l'historial és dolent, i és necessària\n"
diff --git a/po/cs.po b/po/cs.po
index 3f6d6ad..2fdb40b 100644
--- a/po/cs.po
+++ b/po/cs.po
@@ -12324,10 +12324,10 @@ msgstr "Hodiny reálného času obsahují neplatný čas, tudíž jej nelze opra
 #: sys-utils/hwclock.c:1096
 #, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "Nenastavuji hodiny, protože čas posledního posunu je nula, takže historie je "
-"nepoužitelná."
+"nepoužitelná.\n"
 
 #: sys-utils/hwclock.c:1118
 #, c-format
diff --git a/po/da.po b/po/da.po
index 6a8bf03..901e3e2 100644
--- a/po/da.po
+++ b/po/da.po
@@ -12187,10 +12187,10 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "Indstiller ikke uret da sidste justeringstidspunkt er nul, så historikken er "
-"ugyldig."
+"ugyldig.\n"
 
 #: sys-utils/hwclock.c:1118
 #, c-format
diff --git a/po/de.po b/po/de.po
index aa9ad55..40d2bb3 100644
--- a/po/de.po
+++ b/po/de.po
@@ -12611,7 +12611,7 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, fuzzy, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "Der Driftfaktor wird nicht verändert, da die Zeit der letzten Kalibrierung "
 "Null\n"
diff --git a/po/es.po b/po/es.po
index d00ba85..853f9ed 100644
--- a/po/es.po
+++ b/po/es.po
@@ -12513,7 +12513,7 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, fuzzy, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "No se ajusta el factor de desfase debido a que la fecha de �ltima\n"
 "calibraci�n es cero, as� que el historial es err�neo y es necesaria una\n"
diff --git a/po/et.po b/po/et.po
index 995a189..ad14102 100644
--- a/po/et.po
+++ b/po/et.po
@@ -12173,7 +12173,7 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, fuzzy, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "Ei paranda korrigeerimistegurit, kuna viimane kalibreerimine toimus v�hem "
 "kui ��p�ev tagasi\n"
diff --git a/po/eu.po b/po/eu.po
index ce11f82..ade60d7 100644
--- a/po/eu.po
+++ b/po/eu.po
@@ -11984,7 +11984,7 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 
 #: sys-utils/hwclock.c:1118
diff --git a/po/fi.po b/po/fi.po
index 2854abe..b4174ea 100644
--- a/po/fi.po
+++ b/po/fi.po
@@ -12357,10 +12357,10 @@ msgstr "Laitteistokellon aika ei ole kelvollinen, joten sitä ei voi säätää.
 #: sys-utils/hwclock.c:1096
 #, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "Ei aseteta kelloa, koska edellinen kalibrointiaika on nolla, joten historia "
-"on virheellinen."
+"on virheellinen.\n"
 
 #: sys-utils/hwclock.c:1118
 #, c-format
diff --git a/po/fr.po b/po/fr.po
index 25497b2..cee210f 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -12519,10 +12519,10 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "Heure non modifiée car le dernier temps de calibration est zéro, donc "
-"mauvais historique."
+"mauvais historique.\n"
 
 #: sys-utils/hwclock.c:1118
 #, c-format
diff --git a/po/gl.po b/po/gl.po
index 05c2948..83c38b8 100644
--- a/po/gl.po
+++ b/po/gl.po
@@ -11750,7 +11750,7 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 
 #: sys-utils/hwclock.c:1118
diff --git a/po/hr.po b/po/hr.po
index 21bbc5e..fa486df 100644
--- a/po/hr.po
+++ b/po/hr.po
@@ -11526,7 +11526,7 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 
 #: sys-utils/hwclock.c:1118
diff --git a/po/hu.po b/po/hu.po
index 90338f9..4017f3d 100644
--- a/po/hu.po
+++ b/po/hu.po
@@ -12462,7 +12462,7 @@ msgstr "A hardveróra nem tartalmaz érvényes időt, így nem lehet igazítani.
 #: sys-utils/hwclock.c:1096
 #, fuzzy, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "A csúsztatási tényező nem kerül beállításra, mert az utolsó kalibráció ideje "
 "0,\n"
diff --git a/po/id.po b/po/id.po
index ccf1751..d76e549 100644
--- a/po/id.po
+++ b/po/id.po
@@ -12506,10 +12506,10 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "Tidak menyesuaikan jam karena waktu kalibrasi terakhir adalah nol, jadi "
-"sejarah buruk."
+"sejarah buruk.\n"
 
 #: sys-utils/hwclock.c:1118
 #, c-format
diff --git a/po/it.po b/po/it.po
index 969fbe0..c482337 100644
--- a/po/it.po
+++ b/po/it.po
@@ -12406,7 +12406,7 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 
 #: sys-utils/hwclock.c:1118
diff --git a/po/ja.po b/po/ja.po
index 6d08ab5..bbfddde 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -12380,7 +12380,7 @@ msgstr "ハードウェア時計が、正常な時刻を含んでいないので
 #: sys-utils/hwclock.c:1096
 #, fuzzy, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr "前回の調整以来、少なくとも一日経過しないと、ずれを修正できません。\n"
 
 #: sys-utils/hwclock.c:1118
diff --git a/po/nl.po b/po/nl.po
index 26c7276..61ebe8d 100644
--- a/po/nl.po
+++ b/po/nl.po
@@ -12327,11 +12327,11 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "De klok wordt niet ingesteld\n"
 "omdat de laatste aanpassingstijd nul is.\n"
-"Er is dus geen bruikbare geschiedenis."
+"Er is dus geen bruikbare geschiedenis.\n"
 
 #: sys-utils/hwclock.c:1118
 #, c-format
diff --git a/po/pl.po b/po/pl.po
index 26b53ef..dc23f74 100644
--- a/po/pl.po
+++ b/po/pl.po
@@ -12298,10 +12298,10 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "Bez ustawiania zegara, ponieważ czas ostatniej poprawki jest zerowy, więc "
-"historia jest błędna."
+"historia jest błędna.\n"
 
 #: sys-utils/hwclock.c:1118
 #, c-format
diff --git a/po/pt_BR.po b/po/pt_BR.po
index ed9207d..d247c0e 100644
--- a/po/pt_BR.po
+++ b/po/pt_BR.po
@@ -12389,10 +12389,10 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "O fator de variação não está sendo ajustado porque a data do último ajuste é "
-"zero, então o histórico é inválido."
+"zero, então o histórico é inválido.\n"
 
 #: sys-utils/hwclock.c:1118
 #, c-format
diff --git a/po/ru.po b/po/ru.po
index 79b0c00..fae5dd1 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -12462,7 +12462,7 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, fuzzy, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "������������� ������������ ���������� �� ���������, ������\n"
 "��� ��������� ���������� ���� �������, ������� �������\n"
diff --git a/po/sl.po b/po/sl.po
index 5b1113b..3cb1ae3 100644
--- a/po/sl.po
+++ b/po/sl.po
@@ -12400,7 +12400,7 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, fuzzy, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "Faktor drsenja ne bo nastavljen, ker ja zadnji kalibracijski �as 0,\n"
 "zgodovina je zato po�kodovana. Potrebna je ponovna kalibracija.\n"
diff --git a/po/sv.po b/po/sv.po
index 4bf594d..ba40a12 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -12431,7 +12431,7 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, fuzzy, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "Justerar inte dragningsfaktorn eftersom senaste kalibreringstiden\n"
 "är noll, så historiken är trasig och en omstart av kalibreringen\n"
diff --git a/po/tr.po b/po/tr.po
index 92c6e13..f2a7a01 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -12449,7 +12449,7 @@ msgstr "Donanım saati geçerli bir zaman içermediğinden ayarlanamıyor.\n"
 #: sys-utils/hwclock.c:1096
 #, fuzzy, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "Son düzeltme zamanı sıfır olduğndan sapma faktörü ayarsız,\n"
 "yani geçmiş hatalı ve bir düzeltme başlangıcı gerekiyor.\n"
diff --git a/po/uk.po b/po/uk.po
index ac6c90f..5e5e731 100644
--- a/po/uk.po
+++ b/po/uk.po
@@ -12471,10 +12471,10 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "Значення годинника не встановлено, оскільки останнє коригування було "
-"нульовим, отже журнал змін пошкоджено."
+"нульовим, отже журнал змін пошкоджено.\n"
 
 #: sys-utils/hwclock.c:1118
 #, c-format
diff --git a/po/vi.po b/po/vi.po
index 85e689d..19bce9b 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -12259,10 +12259,10 @@ msgstr ""
 #: sys-utils/hwclock.c:1096
 #, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
 msgstr ""
 "Sẽ không đặt đồng hồ vì thời gian điều chỉnh cuối cùng là số không thì lịch "
-"sử sai."
+"sử sai.\n"
 
 #: sys-utils/hwclock.c:1118
 #, c-format
diff --git a/po/zh_CN.po b/po/zh_CN.po
index f649381..28edceb 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -11947,8 +11947,8 @@ msgstr "硬件时间不包含有效时间，程序无法调整它。"
 #: sys-utils/hwclock.c:1096
 #, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
-msgstr "将不设置时钟，因为上次调整时间为零，历史有误。"
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
+msgstr "将不设置时钟，因为上次调整时间为零，历史有误。\n"
 
 #: sys-utils/hwclock.c:1118
 #, c-format
diff --git a/po/zh_TW.po b/po/zh_TW.po
index 4a546be..edd7902 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -12761,8 +12761,8 @@ msgstr "硬體時鐘不包含有效時間，因而我們無法調整它。"
 #: sys-utils/hwclock.c:1096
 #, c-format
 msgid ""
-"Not setting clock because last adjustment time is zero, so history is bad."
-msgstr "無法設定時鐘因為最後一次調整時間為零，因而歷史記錄是不當的。"
+"Not setting clock because last adjustment time is zero, so history is bad.\n"
+msgstr "無法設定時鐘因為最後一次調整時間為零，因而歷史記錄是不當的。\n"
 
 #: sys-utils/hwclock.c:1118
 #, c-format
-- 
1.8.4.5

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

