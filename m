Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56879 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753581Ab2JHHIs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2012 03:08:48 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so3225349wib.1
        for <util-linux@vger.kernel.org>; Mon, 08 Oct 2012 00:08:47 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: =?UTF-8?q?=5BPATCH=2001/14=5D=20ddate=3A=20remove=20from=20util-linux?=
Date: Mon,  8 Oct 2012 08:08:07 +0100
Message-Id: <1349680100-18120-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
References: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

See RedHat bug for reasons why the ddate is cleaned up.  The reference is
where to get the command in future.

Bug-Redhat: https://bugzilla.redhat.com/show_bug.cgi?id=823156
References: https://github.com/bo0ts/ddate
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 .gitignore                                      |   1 -
 Documentation/howto-usage-function.txt          |   2 +-
 Makefile.am                                     |   3 +-
 configure.ac                                    |  11 -
 man/ru/ddate.1                                  | 123 --------
 misc-utils/Makemodule.am                        |   7 -
 misc-utils/ddate.1                              | 114 --------
 misc-utils/ddate.c                              | 374 ------------------------
 tests/expected/build-sys/config-all             |   1 -
 tests/expected/build-sys/config-all-devel       |   1 -
 tests/expected/build-sys/config-all-non-nls     |   1 -
 tests/expected/build-sys/config-devel           |   1 -
 tests/expected/build-sys/config-devel-new-mount |   1 -
 tools/checkmans.sh                              |   2 +-
 14 files changed, 3 insertions(+), 639 deletions(-)
 delete mode 100644 man/ru/ddate.1
 delete mode 100644 misc-utils/ddate.1
 delete mode 100644 misc-utils/ddate.c

diff --git a/.gitignore b/.gitignore
index a777d16..e85eb07 100644
--- a/.gitignore
+++ b/.gitignore
@@ -80,7 +80,6 @@ tests/run.sh.trs
 /column
 /ctrlaltdel
 /cytune
-/ddate
 /delpart
 /dmesg
 /eject
diff --git a/Documentation/howto-usage-function.txt b/Documentation/howto-usage-function.txt
index 70116b2..1944bb7 100644
--- a/Documentation/howto-usage-function.txt
+++ b/Documentation/howto-usage-function.txt
@@ -134,7 +134,7 @@ Some commands use peculiar options and arguments. These are supported,
 but such will not be accepted in future. See list bellow for a hint what
 are meant this.
 
-- Other than `-' used to define an option. See `+' for `more' or `ddate'
+- Other than `-' used to define an option. See `+' for `more'
   commands.
 - Option string used as an option argument. See `more' command and `-num'.
 - Short long option. See `setterm'.
diff --git a/Makefile.am b/Makefile.am
index a540f0e..6188f49 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -39,7 +39,6 @@ bin_PROGRAMS =
 sbin_PROGRAMS =
 dist_usrbin_exec_SCRIPTS =
 systemdsystemunit_DATA =
-ruman1_DATA =
 check_PROGRAMS =
 TESTS =
 
@@ -51,7 +50,7 @@ INSTALL_DATA_HOOKS =
 CLEAN_LOCALS =
 CHECK_LOCALS =
 
-EXTRA_DIST = man/ru/ddate.1
+EXTRA_DIST =
 CLEANFILES =
 
 SUBDIRS = po
diff --git a/configure.ac b/configure.ac
index 9d2f589..d0a7b57 100644
--- a/configure.ac
+++ b/configure.ac
@@ -678,7 +678,6 @@ AC_ARG_ENABLE([most-builds],
 )
 if test "x$enable_most_builds" = xyes; then
   enable_arch=check
-  enable_ddate=yes
   enable_elvtune=check
   enable_last=yes
   enable_line=yes
@@ -880,16 +879,6 @@ UL_REQUIRES_LINUX([arch])
 AM_CONDITIONAL(BUILD_ARCH, test "x$build_arch" = xyes)
 
 
-AC_ARG_ENABLE([ddate],
-  AS_HELP_STRING([--enable-ddate], [do build ddate]),
-  [], enable_ddate=no
-)
-UL_BUILD_INIT([ddate])
-AM_CONDITIONAL(BUILD_DDATE, test "x$build_ddate" = xyes)
-ruman1dir='${mandir}/ru/man1'
-AC_SUBST([ruman1dir])
-
-
 AC_ARG_ENABLE([eject],
   AS_HELP_STRING([--disable-eject], [do not build eject]),
   [], enable_eject=check
diff --git a/man/ru/ddate.1 b/man/ru/ddate.1
deleted file mode 100644
index cb10c57..0000000
--- a/man/ru/ddate.1
+++ /dev/null
@@ -1,123 +0,0 @@
-.\" All Rites Reversed.  This file is in the PUBLIC DOMAIN.
-.\" Kallisti.
-.TH DDATE 1 "59 Bureaucracy 3161" "" "Emperor Norton Utilities"
-.SH ИМЯ
-ddate \- преобразует дату в григорианском формате в соответствующую дату в 
-дискордианском формате
-.SH ОБЗОР
-.B ddate
-.RI [ \fB+\fPформат]
-.RI [ дата ]
-.SH ОПИСАНИЕ
-.B ddate
-выводит дату в дискордианском формате.
-.PP
-Если команда 
-.B ddate
-вызвана без параметров, она получает текущую системную дату, преобразует её в
-дискордианский формат и выводит на стандартный вывод. Также можно указать в
-командной строке дату в григорианском формате, указав в числовом виде день, 
-месяц и год.
-.PP
-Если указан спецификатор формата вывода, дата в дискордианском формате будет
-отображена в том виде, как это определено спецификатором. Этот механизм 
-работает подобно механизму форматирования команды
-.B date(1),
-но почти полностью иначе. Поля спецификатора следующие:
-.IP %A
-Полное название дня недели (например, Sweetmorn)
-.IP %a
-День недели в сокращенном формате (например, SM)
-.IP %B
-Полное название сезона (времени года) (например, Chaos)
-.IP %b
-Сокращенное название сезона (например, Chs)
-.IP %d
-Порядковый номер дня в сезоне (например, 23)
-.IP %e
-Числовое представление номера дня в сезоне (например, 23rd)
-.IP %H
-Название текущего праздника, если таковой имеется
-.IP %N
-Волшебный код для предотвращения вывода следующего за ним форматирования,
-в случае, если дата не является праздником.
-.IP %n
-Новая строка
-.IP %t
-Табуляция
-.IP %X
-Число дней до наступления Дня X (X-Day). Опция не действует, если утилита 
-без опции SubGenius.
-.IP %{
-.IP %}
-Используется для указания части строки, которая будет заменена словами 
-"St. Tib's Day", если текущий день является Днем святого Тиба (St. Tib's day).
-.IP %\.
-Попробуйте и увидите.
-.bp
-.SH ПРИМЕРЫ
-.nf
-% ddate
-.br
-Sweetmorn, Bureaucracy 42, 3161 YOLD
-.PP
-% ddate +'Today is %{%A, the %e of %B%}, %Y. %N%nCelebrate %H'
-.br
-Today is Sweetmorn, the 42nd of Bureaucracy, 3161.
-.PP
-% ddate +"It's %{%A, the %e of %B%}, %Y. %N%nCelebrate %H" 26 9 1995
-.br
-It's Prickle-Prickle, the 50th of Bureaucracy, 3161.
-.br
-Celebrate Bureflux
-.PP
-% ddate +"Today's %{%A, the %e of %B%}, %Y. %N%nCelebrate %H" 29 2 1996
-.br
-Today's St. Tib's Day, 3162.
-.br
-
-.SH ОШИБКИ
-
-.B ddate(1)
-будет вести себя непредсказуемо, если попросить вывести дату Дня святого Тиба
-но строка спецификатора форматирования при этом не содержит разделителей,
-предусмотренных специально для этого случая (%{ и %}).
-
-.SH ЗАМЕЧАНИЯ
-
-После того, как День Икс (5 июля 1998 года - прим. пер.) прошел без 
-происшествий, Церковь СубГения (Church of the SubGenius) провозгласила,
-что он должен наступить в 'году вверх тормашками' - День Икс наступит в 8661
-году н. э., а не в 1998 н. э. Таким образом, Истинный День Икс - это 40 день
-сезона Замешательства 9827 года (Cfn 40, 9827).
-
-.SH АВТОРЫ
-.nh
-Автор оригинальной программы Druel the Chaotic aka Jeremy Johnson 
-(mpython@gnu.ai.mit.edu)
-.br
-Переписана преимущественно Lee H:. O:. Smith, KYTP, aka Andrew Bulhak 
-(acb@dev.null.org)
-.br
-Пять тонн льна.
-
-.SH РАСПРОСТРАНЕНИЕ
-
-Свободно распространяемое ПО. Все права защищены.
-
-.SH СМ. ТАКЖЕ
-
-date(1),
-.br
-http://www.subgenius.com/
-.br
-Малаклипс Младший (Malaclypse the Younger),
-.I "Principia Discordia, или Как я нашел Богиню и что я с Ней сделал когда 
-нашел"
-
-.SH ДОСТУПНОСТЬ
-Команда ddate является частью пакета util-linux и доступна по 
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
-
-.SH ПЕРЕВОД
-Перевод Rino_ap_Codkelden <mavladi@gmail.com> 2010
\ No newline at end of file
diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index 910e428..4c88532 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -52,13 +52,6 @@ CLEANFILES += misc-utils/chkdupexe
 dist_man_MANS += misc-utils/chkdupexe.1
 endif
 
-if BUILD_DDATE
-usrbin_exec_PROGRAMS += ddate
-dist_man_MANS += misc-utils/ddate.1
-ddate_SOURCES = misc-utils/ddate.c
-ruman1_DATA += man/ru/ddate.1
-endif
-
 if BUILD_LSLOCKS
 usrbin_exec_PROGRAMS += lslocks
 dist_man_MANS += misc-utils/lslocks.8
diff --git a/misc-utils/ddate.1 b/misc-utils/ddate.1
deleted file mode 100644
index 0b01e09..0000000
--- a/misc-utils/ddate.1
+++ /dev/null
@@ -1,114 +0,0 @@
-.\" All Rites Reversed.  This file is in the PUBLIC DOMAIN.
-.\" Kallisti.
-.TH DDATE 1 "Bureaucracy 3161" "util-linux" "Emperor Norton User Command"
-.SH NAME
-ddate \- convert Gregorian dates to Discordian dates
-.SH SYNOPSIS
-.B ddate
-.RI [ \fB+\fPformat]
-.RI [ date ]
-.SH DESCRIPTION
-.B ddate
-prints the date in Discordian date format.
-.PP
-If called with no arguments,
-.B ddate
-will get the current system date, convert this to the Discordian
-date format and print this on the standard output. Alternatively, a
-Gregorian date may be specified on the command line, in the form of a numerical
-day, month and year.
-.PP
-If a format string is specified, the Discordian date will be printed in
-a format specified by the string. This mechanism works similarly to the
-format string mechanism of
-.B date(1),
-only almost completely differently. The fields are:
-.IP %A
-Full name of the day of the week (i.e., Sweetmorn)
-.IP %a
-Abbreviated name of the day of the week (i.e., SM)
-.IP %B
-Full name of the season (i.e., Chaos)
-.IP %b
-Abbreviated name of the season (i.e., Chs)
-.IP %d
-Ordinal number of day in season (i.e., 23)
-.IP %e
-Cardinal number of day in season (i.e., 23rd)
-.IP %H
-Name of current Holyday, if any
-.IP %N
-Magic code to prevent rest of format from being printed unless today is
-a Holyday.
-.IP %n
-Newline
-.IP %t
-Tab
-.IP %X
-Number of days remaining until X-Day. (Not valid if the SubGenius options
-are not compiled in.)
-.IP %{
-.IP %}
-Used to enclose the part of the string which is to be replaced with the
-words "St. Tib's Day" if the current day is St. Tib's Day.
-.IP %\.
-Try it and see.
-.bp
-.SH EXAMPLES
-.nf
-% ddate
-.br
-Sweetmorn, Bureaucracy 42, 3161 YOLD
-.PP
-% ddate +'Today is %{%A, the %e of %B%}, %Y. %N%nCelebrate %H'
-.br
-Today is Sweetmorn, the 42nd of Bureaucracy, 3161.
-.PP
-% ddate +"It's %{%A, the %e of %B%}, %Y. %N%nCelebrate %H" 26 9 1995
-.br
-It's Prickle-Prickle, the 50th of Bureaucracy, 3161.
-.br
-Celebrate Bureflux
-.PP
-% ddate +"Today's %{%A, the %e of %B%}, %Y. %N%nCelebrate %H" 29 2 1996
-.br
-Today's St. Tib's Day, 3162.
-.br
-
-.SH BUGS
-
-.B ddate(1)
-will produce undefined behavior if asked to produce the date for St. Tib's
-day and its format string does not contain the St. Tib's Day delimiters
-%{ and %}.
-
-.SH NOTE
-
-After `X-Day' passed without incident, the Church of the SubGenius
-declared that it had got the year upside down - X-Day is actually in 8661 AD
-rather than 1998 AD.  Thus, the True X-Day is Cfn 40, 9827.
-
-.SH AUTHOR
-.nh
-Original program by Druel the Chaotic aka Jeremy Johnson (mpython@gnu.ai.mit.edu)
-.br
-Major rewrite by Lee H:. O:. Smith, KYTP, aka Andrew Bulhak (acb@dev.null.org)
-.br
-Five tons of flax.
-
-.SH DISTRIBUTION POLICY
-
-Public domain. All rites reversed.
-
-.SH SEE ALSO
-
-date(1),
-.br
-http://www.subgenius.com/
-.br
-Malaclypse the Younger,
-.I "Principia Discordia, Or How I Found Goddess And What I Did To Her When I Found Her"
-
-.SH AVAILABILITY
-The ddate command is part of the util-linux package and is available from
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
diff --git a/misc-utils/ddate.c b/misc-utils/ddate.c
deleted file mode 100644
index c0b4ce4..0000000
--- a/misc-utils/ddate.c
+++ /dev/null
@@ -1,374 +0,0 @@
-/* $ DVCS ID: $jer|,523/lhos,KYTP!41023161\b"?" <<= DO NOT DELETE! */
-
-/* ddate.c .. converts boring normal dates to fun Discordian Date -><-
-   written  the 65th day of The Aftermath in the Year of Our Lady of 
-   Discord 3157 by Druel the Chaotic aka Jeremy Johnson aka
-   mpython@gnu.ai.mit.edu  
-      28 Sever St Apt #3
-      Worcester MA 01609
-
-   and I'm not responsible if this program messes anything up (except your 
-   mind, I'm responsible for that)
-
-   (k) YOLD 3161 and all time before and after.
-   Reprint, reuse, and recycle what you wish.
-   This program is in the public domain.  Distribute freely.  Or not.
-
-   Majorly hacked, extended and bogotified/debogotified on 
-   Sweetmorn, Bureaucracy 42, 3161 YOLD, by Lee H:. O:. Smith, KYTP, 
-   aka Andrew Bulhak, aka acb@dev.null.org
-
-   and I'm not responsible if this program messes anything up (except your 
-   mind, I'm responsible for that) (and that goes for me as well --lhos)
-
-   Version history:
-   Bureflux 3161:      First release of enhanced ddate with format strings
-   59 Bcy, 3161:       PRAISE_BOB and KILL_BOB options split, other minor
-                       changes.
-
-   1999-02-22 Arkadiusz Miskiewicz <misiek@pld.ORG.PL>
-   - added Native Language Support
-
-   2000-03-17 Burt Holzman <bnh@iname.com>
-   - added range checks for dates
-*/
-
-/* configuration options  VVVVV   READ THIS!!! */
-
-/* If you wish ddate(1) to print the date in the same format as Druel's 
- * original ddate when called in immediate mode, define OLD_IMMEDIATE_FMT 
- */
-
-#define OLD_IMMEDIATE_FMT
-
-/* If you wish to use the US format for aneristic dates (m-d-y), as opposed to
- * the Commonwealth format, define US_FORMAT.
- */
-
-/* #define US_FORMAT */
-
-/* If you are ideologically, theologically or otherwise opposed to the 
- * Church of the SubGenius and do not wish your copy of ddate(1) to contain
- * code for counting down to X-Day, undefine KILL_BOB */
-
-#define KILL_BOB 13013
-
-/* If you wish ddate(1) to contain SubGenius slogans, define PRAISE_BOB */
-
-/*#define PRAISE_BOB 13013*/
-
-#include <stdlib.h>
-#include <string.h>
-#include <time.h>
-#include <stdio.h>
-
-#include "nls.h"
-#include "closestream.h"
-#include "c.h"
-
-#ifndef __GNUC__
-#define inline /* foo */
-#endif
-
-#ifdef KILL_BOB
-int xday_countdown(int yday, int year);
-#endif
-
-
-/* string constants */
-
-char *day_long[5] = { 
-    "Sweetmorn", "Boomtime", "Pungenday", "Prickle-Prickle", "Setting Orange"
-};
-
-char *day_short[5] = {"SM","BT","PD","PP","SO"};
-
-char *season_long[5] = { 
-    "Chaos", "Discord", "Confusion", "Bureaucracy", "The Aftermath"
-};
-
-char *season_short[5] = {"Chs", "Dsc", "Cfn", "Bcy", "Afm"};
-
-char *holyday[5][2] = { 
-    { "Mungday", "Chaoflux" },
-    { "Mojoday", "Discoflux" },
-    { "Syaday",  "Confuflux" },
-    { "Zaraday", "Bureflux" },
-    { "Maladay", "Afflux" }
-};
-
-struct disc_time {
-    int season; /* 0-4 */
-    int day; /* 0-72 */
-    int yday; /* 0-365 */
-    int year; /* 3066- */
-};
-
-char *excl[] = {
-    "Hail Eris!", "All Hail Discordia!", "Kallisti!", "Fnord.", "Or not.",
-    "Wibble.", "Pzat!", "P'tang!", "Frink!",
-#ifdef PRAISE_BOB
-    "Slack!", "Praise \"Bob\"!", "Or kill me.",
-#endif /* PRAISE_BOB */
-    /* randomness, from the Net and other places. Feel free to add (after
-       checking with the relevant authorities, of course). */
-    "Grudnuk demand sustenance!", "Keep the Lasagna flying!",
-    "You are what you see.",
-    "Or is it?", "This statement is false.",
-#if defined(linux) || defined (__linux__) || defined (__linux)
-    "Hail Eris, Hack Linux!",
-#endif
-    ""
-};
-
-char default_fmt[] = "%{%A, %B %d%}, %Y YOLD";
-char *default_immediate_fmt=
-#ifdef OLD_IMMEDIATE_FMT
-"Today is %{%A, the %e day of %B%} in the YOLD %Y%N%nCelebrate %H"
-#else
-default_fmt
-#endif
-;
-
-#define DY(y) (y+1166)
-
-static inline char *ending(int i) {
-	return i/10==1?"th":(i%10==1?"st":(i%10==2?"nd":(i%10==3?"rd":"th")));
-}
-
-static inline int leapp(int i) {
-	return (!(DY(i)%4))&&((DY(i)%100)||(!(DY(i)%400)));
-}
-
-/* select a random string */
-static inline char *sel(char **strings, int num) {
-	return(strings[random()%num]);
-}
-
-void print(struct disc_time,char **); /* old */
-void format(char *buf, const char* fmt, struct disc_time dt);
-/* read a fortune file */
-int load_fortunes(char *fn, char *delim, char** result);
-
-struct disc_time convert(int,int);
-struct disc_time makeday(int,int,int);
-
-int
-main (int argc, char *argv[]) {
-    long t;
-    struct tm *eris;
-    int bob,raw;
-    struct disc_time hastur;
-    char schwa[23*17], *fnord=0;
-    int pi;
-    char *progname, *p;
-
-    progname = argv[0];
-    if ((p = strrchr(progname, '/')) != NULL)
-	progname = p+1;
-
-    setlocale(LC_ALL, "");
-    bindtextdomain(PACKAGE, LOCALEDIR);
-    textdomain(PACKAGE);
-    atexit(close_stdout);
-
-    srandom(time(NULL));
-    /* do args here */
-    for(pi=1; pi<argc; pi++) {
-	switch(argv[pi][0]) {
-	case '+': fnord=argv[pi]+1; break;
-	case '-': 
-	    switch(argv[pi][1]) {
-	    case 'V':
-		printf(_("%s (%s)\n"), progname, PACKAGE_STRING);
-	    default: goto usage;
-	    }
-	default: goto thud;
-	}
-    }
-
-  thud:
-    if (argc-pi==3){ 
-	int moe=atoi(argv[pi]), larry=atoi(argv[pi+1]), curly=atoi(argv[pi+2]);
-	hastur=makeday(
-#ifdef US_FORMAT
-	    moe,larry,
-#else
-	    larry,moe,
-#endif
-	    curly);
-	if (hastur.season == -1) {
-		printf("Invalid date -- out of range\n");
-		return -1;
-	}
-	fnord=fnord?fnord:default_fmt;
-    } else if (argc!=pi) { 
-      usage:
-	fprintf(stderr,_("usage: %s [+format] [day month year]\n"), argv[0]);
-	exit(1);
-    } else {
-	t= time(NULL);
-	eris=localtime(&t);
-	bob=eris->tm_yday; /* days since Jan 1. */
-	raw=eris->tm_year; /* years since 1980 */
-	hastur=convert(bob,raw);
-	fnord=fnord?fnord:default_immediate_fmt;
-    }
-    format(schwa, fnord, hastur);
-    printf("%s\n", schwa);
-   
-    return 0;
-}
-
-void format(char *buf, const char* fmt, struct disc_time dt)
-{
-    int tib_start=-1, tib_end=0;
-    int i, fmtlen=strlen(fmt);
-    char *bufptr=buf;
-
-/*    fprintf(stderr, "format(%p, \"%s\", dt)\n", buf, fmt);*/
-
-    /* first, find extents of St. Tib's Day area, if defined */
-    for(i=0; i<fmtlen; i++) {
-	if(fmt[i]=='%') {
-	    switch(fmt[i+1]) {
-	    case 'A':
-	    case 'a':
-	    case 'd':
-	    case 'e':
-		if(tib_start>0)	    tib_end=i+1;
-		else		    tib_start=i;
-		break;
-	    case '{': tib_start=i; break;
-	    case '}': tib_end=i+1; break;
-	    }
-	}
-    }
-
-    /* now do the formatting */
-    buf[0]=0;
-
-    for(i=0; i<fmtlen; i++) {
-	if((i==tib_start) && (dt.day==-1)) {
-	    /* handle St. Tib's Day */
-	    strcpy(bufptr, _("St. Tib's Day"));
-	    bufptr += strlen(bufptr);
-	    i=tib_end;
-	} else {
-	    if(fmt[i]=='%') {
-		char *wibble=0, snarf[23];
-		switch(fmt[++i]) {
-		case 'A': wibble=day_long[dt.yday%5]; break;
-		case 'a': wibble=day_short[dt.yday%5]; break;
-		case 'B': wibble=season_long[dt.season]; break;
-		case 'b': wibble=season_short[dt.season]; break;
-		case 'd': sprintf(snarf, "%d", dt.day+1); wibble=snarf; break;
-		case 'e': sprintf(snarf, "%d%s", dt.day+1, ending(dt.day+1)); 
-		    wibble=snarf; break;
-		case 'H': if(dt.day==4||dt.day==49)
-		    wibble=holyday[dt.season][dt.day==49]; break;
-		case 'N': if(dt.day!=4&&dt.day!=49) goto eschaton; break;
-		case 'n': *(bufptr++)='\n'; break;
-		case 't': *(bufptr++)='\t'; break;
-
-		case 'Y': sprintf(snarf, "%d", dt.year); wibble=snarf; break;
-		case '.': wibble=sel(excl, ARRAY_SIZE(excl));
-		    break;
-#ifdef KILL_BOB
-		case 'X': sprintf(snarf, "%d", 
-				  xday_countdown(dt.yday, dt.year));
-				  wibble = snarf; break;
-#endif /* KILL_BOB */
-		}
-		if(wibble) {
-/*		    fprintf(stderr, "wibble = (%s)\n", wibble);*/
-		    strcpy(bufptr, wibble); bufptr+=strlen(wibble);
-		}
-	    } else {
-		*(bufptr++) = fmt[i];
-	    }
-	}
-    }
-  eschaton:
-    *(bufptr)=0;
-}
-
-struct disc_time makeday(int imonth,int iday,int iyear) /*i for input */
-{ 
-    struct disc_time funkychickens;
-    
-    int cal[12] = { 31,28,31,30,31,30,31,31,30,31,30,31 };
-    int dayspast=0;
-
-    memset(&funkychickens,0,sizeof(funkychickens));
-    /* basic range checks */
-    if (imonth < 1 || imonth > 12) {
-	    funkychickens.season = -1;
-	    return funkychickens;
-    }
-    if (iday < 1 || iday > cal[imonth-1]) {
-	    if (!(imonth == 2 && iday == 29 && iyear%4 == 0 &&
-		  (iyear%100 != 0 || iyear%400 == 0))) {
-		    funkychickens.season = -1;
-		    return funkychickens;
-	    }
-    }
-    
-    imonth--;
-    funkychickens.year= iyear+1166;
-    while(imonth>0) { dayspast+=cal[--imonth]; }
-    funkychickens.day=dayspast+iday-1;
-    funkychickens.season=0;
-    if((funkychickens.year%4)==2) {
-	if (funkychickens.day==59 && iday==29)  funkychickens.day=-1;
-    }
-    funkychickens.yday=funkychickens.day;
-/*               note: EQUAL SIGN...hopefully that fixes it */
-    while(funkychickens.day>=73) {
-	funkychickens.season++;
-	funkychickens.day-=73;
-    }
-    return funkychickens;
-}
-
-struct disc_time convert(int nday, int nyear)
-{  struct disc_time funkychickens;
-   
-   funkychickens.year = nyear+3066;
-   funkychickens.day=nday;
-   funkychickens.season=0;
-   if ((funkychickens.year%4)==2)
-     {if (funkychickens.day==59)
-	funkychickens.day=-1;
-     else if (funkychickens.day >59)
-       funkychickens.day-=1;
-    }
-   funkychickens.yday=funkychickens.day;
-   while (funkychickens.day>=73)
-     { funkychickens.season++;
-       funkychickens.day-=73;
-     }
-   return funkychickens;
-  
- }
-
-#ifdef KILL_BOB
-
-/* Code for counting down to X-Day, X-Day being Cfn 40, 3164 
- *
- * After `X-Day' passed without incident, the CoSG declared that it had 
- * got the year upside down --- X-Day is actually in 8661 AD rather than 
- * 1998 AD.
- *
- * Thus, the True X-Day is Cfn 40, 9827.
- *
- */
-
-int xday_countdown(int yday, int year) {
-    int r=(185-yday)+(((yday<59)&&(leapp(year)))?1:0);
-    while(year<9827) r+=(leapp(++year)?366:365);
-    while(year>9827) r-=(leapp(year--)?366:365);
-    return r;
-}
-
-#endif
diff --git a/tests/expected/build-sys/config-all b/tests/expected/build-sys/config-all
index c31bc40..e5888dd 100644
--- a/tests/expected/build-sys/config-all
+++ b/tests/expected/build-sys/config-all
@@ -36,7 +36,6 @@ colrm:
 column:  
 ctrlaltdel:  
 cytune:  
-ddate:  
 delpart:  
 dmesg:  
 elvtune:  
diff --git a/tests/expected/build-sys/config-all-devel b/tests/expected/build-sys/config-all-devel
index 4b31e7e..1be319b 100644
--- a/tests/expected/build-sys/config-all-devel
+++ b/tests/expected/build-sys/config-all-devel
@@ -54,7 +54,6 @@ uuidd:  libuuid
 uuidgen:  libuuid 
 wipefs:  libblkid libuuid 
 cal:  libncursesw libtinfo 
-ddate:  
 kill:  
 logger:  
 look:  
diff --git a/tests/expected/build-sys/config-all-non-nls b/tests/expected/build-sys/config-all-non-nls
index c31bc40..e5888dd 100644
--- a/tests/expected/build-sys/config-all-non-nls
+++ b/tests/expected/build-sys/config-all-non-nls
@@ -36,7 +36,6 @@ colrm:
 column:  
 ctrlaltdel:  
 cytune:  
-ddate:  
 delpart:  
 dmesg:  
 elvtune:  
diff --git a/tests/expected/build-sys/config-devel b/tests/expected/build-sys/config-devel
index a2e0411..cb7fad3 100644
--- a/tests/expected/build-sys/config-devel
+++ b/tests/expected/build-sys/config-devel
@@ -36,7 +36,6 @@ colrm:
 column:  
 ctrlaltdel:  
 cytune:  
-ddate:  
 delpart:  
 dmesg:  
 elvtune:  
diff --git a/tests/expected/build-sys/config-devel-new-mount b/tests/expected/build-sys/config-devel-new-mount
index 74c35c7..7e83630 100644
--- a/tests/expected/build-sys/config-devel-new-mount
+++ b/tests/expected/build-sys/config-devel-new-mount
@@ -56,7 +56,6 @@ uuidgen:  libuuid
 wipefs:  libblkid libuuid 
 blkid.static: STATIC
 cal:  libncursesw libtinfo 
-ddate:  
 kill:  
 logger:  
 look:  
diff --git a/tools/checkmans.sh b/tools/checkmans.sh
index e54ebed..4b149d0 100755
--- a/tools/checkmans.sh
+++ b/tools/checkmans.sh
@@ -39,7 +39,7 @@ trap "rm -f ${ERROR_FILE}" 0
 
 for I in $(
 	find $(git rev-parse --show-toplevel) -name '*.[1-8]' |
-	egrep -v '(Documentation|.git|/.libs/|autom4te.cache|ru/ddate)'
+	egrep -v '(Documentation|.git|/.libs/|autom4te.cache)'
 ); do
 	# FIXME: the determination whether a manual does include
 	# should probably be somewhat smarter.
-- 
1.7.12.2

