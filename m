Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.131]:63212 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752167AbdIYTyO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 Sep 2017 15:54:14 -0400
Received: from localhost ([217.87.201.56]) by mrelayeu.kundenserver.de
 (mreue003 [212.227.15.129]) with ESMTPSA (Nemesis) id
 0Ld1ZU-1dWLNE2Ay0-00iFRy for <util-linux@vger.kernel.org>; Mon, 25 Sep 2017
 21:54:12 +0200
Date: Mon, 25 Sep 2017 21:54:11 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] login: fix signal race
Message-ID: <20170925195411.GA25565@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The functions warnx(3) and gettext(3) are not safe to use within signal
handlers and should be avoided. Preparing the message beforehand and
calling write(2) as well as calling _exit(2) solves the problem.
---
 login-utils/login.c | 17 ++++++++++-------
 po/ca.po            |  6 +++---
 po/cs.po            |  6 +++---
 po/da.po            |  6 +++---
 po/de.po            |  6 +++---
 po/es.po            |  6 +++---
 po/et.po            |  6 +++---
 po/eu.po            |  4 ++--
 po/fi.po            |  6 +++---
 po/fr.po            |  6 +++---
 po/gl.po            |  4 ++--
 po/hr.po            |  4 ++--
 po/hu.po            |  6 +++---
 po/id.po            |  6 +++---
 po/it.po            |  6 +++---
 po/ja.po            |  6 +++---
 po/nl.po            |  6 +++---
 po/pl.po            |  6 +++---
 po/pt_BR.po         |  6 +++---
 po/ru.po            |  6 +++---
 po/sl.po            |  6 +++---
 po/sv.po            |  6 +++---
 po/tr.po            |  6 +++---
 po/uk.po            |  6 +++---
 po/util-linux.pot   |  4 ++--
 po/vi.po            |  6 +++---
 po/zh_CN.po         |  6 +++---
 po/zh_TW.po         |  6 +++---
 28 files changed, 87 insertions(+), 84 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 7f311536e..7cccd1a0f 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -139,6 +139,7 @@ struct login_context {
 static unsigned int timeout = LOGIN_TIMEOUT;
 static int child_pid = 0;
 static volatile int got_sig = 0;
+static char timeout_msg[128];
 
 #ifdef LOGIN_CHOWN_VCS
 /* true if the filedescriptor fd is a console tty, very Linux specific */
@@ -174,15 +175,14 @@ timedout2(int sig __attribute__ ((__unused__)))
 	tcgetattr(0, &ti);
 	ti.c_lflag |= ECHO;
 	tcsetattr(0, TCSANOW, &ti);
-	exit(EXIT_SUCCESS);	/* %% */
+	_exit(EXIT_SUCCESS);	/* %% */
 }
 
 static void timedout(int sig __attribute__ ((__unused__)))
 {
 	signal(SIGALRM, timedout2);
 	alarm(10);
-	/* TRANSLATORS: The standard value for %u is 60. */
-	warnx(_("timed out after %u seconds"), timeout);
+	write(STDERR_FILENO, timeout_msg, strlen(timeout_msg));
 	signal(SIGALRM, SIG_IGN);
 	alarm(0);
 	timedout2(0);
@@ -1134,6 +1134,13 @@ int main(int argc, char **argv)
 
 	timeout = (unsigned int)getlogindefs_num("LOGIN_TIMEOUT", LOGIN_TIMEOUT);
 
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+
+	/* TRANSLATORS: The standard value for %u is 60. */
+	snprintf(timeout_msg, sizeof(timeout_msg),
+	    _("%s: timed out after %u seconds"), argv[0], timeout);
 	signal(SIGALRM, timedout);
 	(void) sigaction(SIGALRM, NULL, &act);
 	act.sa_flags &= ~SA_RESTART;
@@ -1142,10 +1149,6 @@ int main(int argc, char **argv)
 	signal(SIGQUIT, SIG_IGN);
 	signal(SIGINT, SIG_IGN);
 
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-
 	setpriority(PRIO_PROCESS, 0, 0);
 	initproctitle(argc, argv);
 
diff --git a/po/ca.po b/po/ca.po
index 40fa73801..cdceefd22 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -7913,10 +7913,10 @@ msgid "user attribute not changed: %s"
 msgstr ""
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, fuzzy, c-format
-msgid "timed out after %u seconds"
-msgstr "S'ha excedit el temps d'espera per a l'entrada al cap de %d segons.\n"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: S'ha excedit el temps d'espera per a l'entrada al cap de %u segons."
 
 #: login-utils/login.c:291
 #, fuzzy, c-format
diff --git a/po/cs.po b/po/cs.po
index c1cfa90e3..f1ad5d7a1 100644
--- a/po/cs.po
+++ b/po/cs.po
@@ -7501,10 +7501,10 @@ msgid "user attribute not changed: %s"
 msgstr "vlastnost uživatele nezměněna: %s"
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
-msgstr "vypršel časový limit %u sekund"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: vypršel časový limit %u sekund"
 
 #: login-utils/login.c:291
 #, c-format
diff --git a/po/da.po b/po/da.po
index bc5425afd..00fd1ce98 100644
--- a/po/da.po
+++ b/po/da.po
@@ -7488,10 +7488,10 @@ msgid "user attribute not changed: %s"
 msgstr "brugerattribut blev ikke ændret: %s"
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
-msgstr "udløb efter %u sekunder"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: udløb efter %u sekunder"
 
 #: login-utils/login.c:291
 #, c-format
diff --git a/po/de.po b/po/de.po
index 7caa444e2..638509cd3 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7522,10 +7522,10 @@ msgid "user attribute not changed: %s"
 msgstr "Benutzerattribut wurde nicht geändert: %s"
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
-msgstr "Zeit überschritten nach %u Sekunden"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: Zeit überschritten nach %u Sekunden"
 
 #: login-utils/login.c:291
 #, c-format
diff --git a/po/es.po b/po/es.po
index f5901346c..595a1969d 100644
--- a/po/es.po
+++ b/po/es.po
@@ -7400,10 +7400,10 @@ msgid "user attribute not changed: %s"
 msgstr "atributo de usuario no modificado: %s"
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
-msgstr "superado el tiempo de espera tras %u segundos"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: superado el tiempo de espera tras %u segundos"
 
 #: login-utils/login.c:291
 #, c-format
diff --git a/po/et.po b/po/et.po
index 12d61e7d5..cebc95d77 100644
--- a/po/et.po
+++ b/po/et.po
@@ -7833,10 +7833,10 @@ msgid "user attribute not changed: %s"
 msgstr ""
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, fuzzy, c-format
-msgid "timed out after %u seconds"
-msgstr "Login timed out after %d seconds\n"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: Login timed out after %u seconds"
 
 #: login-utils/login.c:291
 #, fuzzy, c-format
diff --git a/po/eu.po b/po/eu.po
index e07e5d960..ce7632fdb 100644
--- a/po/eu.po
+++ b/po/eu.po
@@ -7693,9 +7693,9 @@ msgid "user attribute not changed: %s"
 msgstr ""
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
+msgid "%s: timed out after %u seconds"
 msgstr ""
 
 #: login-utils/login.c:291
diff --git a/po/fi.po b/po/fi.po
index ecf1ba436..ae4e3c71b 100644
--- a/po/fi.po
+++ b/po/fi.po
@@ -7720,10 +7720,10 @@ msgid "user attribute not changed: %s"
 msgstr "%s: käyttäjää ei ole"
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, fuzzy, c-format
-msgid "timed out after %u seconds"
-msgstr "Kirjautuminen aikakatkaistiin %d sekunnin jälkeen\n"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: Kirjautuminen aikakatkaistiin %u sekunnin jälkeen"
 
 #: login-utils/login.c:291
 #, fuzzy, c-format
diff --git a/po/fr.po b/po/fr.po
index 7b1500831..d115e7b0d 100644
--- a/po/fr.po
+++ b/po/fr.po
@@ -7400,10 +7400,10 @@ msgid "user attribute not changed: %s"
 msgstr "attribut d'utilisateur non modifié : %s"
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
-msgstr "expiration du délai après %u secondes"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: expiration du délai après %u secondes"
 
 #: login-utils/login.c:291
 #, c-format
diff --git a/po/gl.po b/po/gl.po
index 464a97700..d42cd686e 100644
--- a/po/gl.po
+++ b/po/gl.po
@@ -7565,9 +7565,9 @@ msgid "user attribute not changed: %s"
 msgstr ""
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
+msgid "%s: timed out after %u seconds"
 msgstr ""
 
 #: login-utils/login.c:291
diff --git a/po/hr.po b/po/hr.po
index 4d1611d39..9170512a1 100644
--- a/po/hr.po
+++ b/po/hr.po
@@ -7409,9 +7409,9 @@ msgid "user attribute not changed: %s"
 msgstr ""
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
+msgid "%s: timed out after %u seconds"
 msgstr ""
 
 #: login-utils/login.c:291
diff --git a/po/hu.po b/po/hu.po
index 04dbd0db8..58209e761 100644
--- a/po/hu.po
+++ b/po/hu.po
@@ -7875,10 +7875,10 @@ msgid "user attribute not changed: %s"
 msgstr ""
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, fuzzy, c-format
-msgid "timed out after %u seconds"
-msgstr "A bejelentkezés %d másodperc után túllépte az időkorlátot\n"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: A bejelentkezés %u másodperc után túllépte az időkorlátot"
 
 #: login-utils/login.c:291
 #, fuzzy, c-format
diff --git a/po/id.po b/po/id.po
index eb73491f1..edd37137f 100644
--- a/po/id.po
+++ b/po/id.po
@@ -7876,10 +7876,10 @@ msgid "user attribute not changed: %s"
 msgstr ""
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, fuzzy, c-format
-msgid "timed out after %u seconds"
-msgstr "Waktu habis untuk Login sesudah %d detik\n"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: Waktu habis untuk Login sesudah %u detik"
 
 #: login-utils/login.c:291
 #, fuzzy, c-format
diff --git a/po/it.po b/po/it.po
index 29ba33f6f..fdccaee98 100644
--- a/po/it.po
+++ b/po/it.po
@@ -7869,10 +7869,10 @@ msgid "user attribute not changed: %s"
 msgstr ""
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, fuzzy, c-format
-msgid "timed out after %u seconds"
-msgstr "Login scaduto dopo %d secondi\n"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: Login scaduto dopo %u secondi"
 
 #: login-utils/login.c:291
 #, fuzzy, c-format
diff --git a/po/ja.po b/po/ja.po
index 630727f00..5b8abf790 100644
--- a/po/ja.po
+++ b/po/ja.po
@@ -7420,10 +7420,10 @@ msgid "user attribute not changed: %s"
 msgstr "ユーザ属性を変更しませんでした: %s"
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
-msgstr "%u 秒で時間切れになりました"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: %u 秒で時間切れになりました"
 
 #: login-utils/login.c:291
 #, c-format
diff --git a/po/nl.po b/po/nl.po
index 0184c8ce7..30939df5e 100644
--- a/po/nl.po
+++ b/po/nl.po
@@ -7510,10 +7510,10 @@ msgid "user attribute not changed: %s"
 msgstr "gebruikerseigenschap is niet gewijzigd: %s"
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
-msgstr "afgebroken na %u seconden"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: afgebroken na %u seconden"
 
 #: login-utils/login.c:291
 #, c-format
diff --git a/po/pl.po b/po/pl.po
index 625201b11..d7a430f97 100644
--- a/po/pl.po
+++ b/po/pl.po
@@ -7381,10 +7381,10 @@ msgid "user attribute not changed: %s"
 msgstr "atrybut użytkownika nie zmieniony: %s"
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
-msgstr "przekroczony limit czasu logowania (%u s)"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: przekroczony limit czasu logowania (%u s)"
 
 #: login-utils/login.c:291
 #, c-format
diff --git a/po/pt_BR.po b/po/pt_BR.po
index 2b05cb79b..394230a75 100644
--- a/po/pt_BR.po
+++ b/po/pt_BR.po
@@ -7435,10 +7435,10 @@ msgid "user attribute not changed: %s"
 msgstr "atributo de usuário não alterado: %s"
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
-msgstr "tempo esgotado após %u segundos"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: tempo esgotado após %u segundos"
 
 #: login-utils/login.c:291
 #, c-format
diff --git a/po/ru.po b/po/ru.po
index 1ef1d8218..b90e68e5d 100644
--- a/po/ru.po
+++ b/po/ru.po
@@ -7497,10 +7497,10 @@ msgid "user attribute not changed: %s"
 msgstr "атрибуты пользователя не изменены: %s"
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
-msgstr "истекло время ожидания в %u секунд"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: истекло время ожидания в %u секунд"
 
 #: login-utils/login.c:291
 #, c-format
diff --git a/po/sl.po b/po/sl.po
index 2b06573d8..9820e5b78 100644
--- a/po/sl.po
+++ b/po/sl.po
@@ -7885,10 +7885,10 @@ msgid "user attribute not changed: %s"
 msgstr ""
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, fuzzy, c-format
-msgid "timed out after %u seconds"
-msgstr "Prijava je potekla po %d sekundah.\n"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: Prijava je potekla po %u sekundah."
 
 #: login-utils/login.c:291
 #, fuzzy, c-format
diff --git a/po/sv.po b/po/sv.po
index c2fea3598..6e6d71a4b 100644
--- a/po/sv.po
+++ b/po/sv.po
@@ -7370,10 +7370,10 @@ msgid "user attribute not changed: %s"
 msgstr "användarattribut inte ändrat: %s"
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
-msgstr "tidutlösare efter %u sekunder"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: tidutlösare efter %u sekunder"
 
 #: login-utils/login.c:291
 #, c-format
diff --git a/po/tr.po b/po/tr.po
index 939650f21..1fb6dcd57 100644
--- a/po/tr.po
+++ b/po/tr.po
@@ -7386,10 +7386,10 @@ msgid "user attribute not changed: %s"
 msgstr "kullanıcı özniteliği değişmedi: %s"
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
-msgstr "%u saniye sonra zaman aşımı"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: %u saniye sonra zaman aşımı"
 
 #: login-utils/login.c:291
 #, c-format
diff --git a/po/uk.po b/po/uk.po
index 78e79db63..2f7a03df9 100644
--- a/po/uk.po
+++ b/po/uk.po
@@ -7393,10 +7393,10 @@ msgid "user attribute not changed: %s"
 msgstr "атрибут користувача не змінено: %s"
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
-msgstr "час очікування було вичерпано за %u секунд"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: час очікування було вичерпано за %u секунд"
 
 #: login-utils/login.c:291
 #, c-format
diff --git a/po/util-linux.pot b/po/util-linux.pot
index 949932903..475816bdf 100644
--- a/po/util-linux.pot
+++ b/po/util-linux.pot
@@ -7318,9 +7318,9 @@ msgid "user attribute not changed: %s"
 msgstr ""
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
+msgid "%s: timed out after %u seconds"
 msgstr ""
 
 #: login-utils/login.c:291
diff --git a/po/vi.po b/po/vi.po
index 6d2e23fad..d07086bd9 100644
--- a/po/vi.po
+++ b/po/vi.po
@@ -7499,10 +7499,10 @@ msgid "user attribute not changed: %s"
 msgstr "thuộc tính người dùng không thay đổi: %s"
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
-msgstr "lỗi quá lâu sau %u giây"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: lỗi quá lâu sau %u giây"
 
 #: login-utils/login.c:291
 #, c-format
diff --git a/po/zh_CN.po b/po/zh_CN.po
index ed6aee077..64a596446 100644
--- a/po/zh_CN.po
+++ b/po/zh_CN.po
@@ -7365,10 +7365,10 @@ msgid "user attribute not changed: %s"
 msgstr "用户属性未更改：%s"
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, c-format
-msgid "timed out after %u seconds"
-msgstr "%u 秒后超时"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: %u 秒后超时"
 
 #: login-utils/login.c:291
 #, c-format
diff --git a/po/zh_TW.po b/po/zh_TW.po
index 3d08f23da..f4b64611a 100644
--- a/po/zh_TW.po
+++ b/po/zh_TW.po
@@ -7899,10 +7899,10 @@ msgid "user attribute not changed: %s"
 msgstr ""
 
 #. TRANSLATORS: The standard value for %u is 60.
-#: login-utils/login.c:185
+#: login-utils/login.c:1142
 #, fuzzy, c-format
-msgid "timed out after %u seconds"
-msgstr "已逾時之後 %u 秒"
+msgid "%s: timed out after %u seconds"
+msgstr "%s: 已逾時之後 %u 秒"
 
 #: login-utils/login.c:291
 #, fuzzy, c-format
-- 
2.14.1

