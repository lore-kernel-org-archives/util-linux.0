Return-Path: <SRS0=AFk+=MW=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6934DC43441
	for <util-linux@archiver.kernel.org>; Wed, 10 Oct 2018 17:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282172085B
	for <util-linux@archiver.kernel.org>; Wed, 10 Oct 2018 17:26:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 282172085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbeJKAtp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:49:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:42892 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726883AbeJKAtp (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 10 Oct 2018 20:49:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 64515B035
        for <util-linux@vger.kernel.org>; Wed, 10 Oct 2018 17:26:34 +0000 (UTC)
To:     util-linux@vger.kernel.org
From:   Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 3/3] agetty: Reload only if it is really needed
Openpgp: preference=signencrypt
Autocrypt: addr=sbrabec@suse.cz; prefer-encrypt=mutual; keydata=
 xsDiBD6v2X0RBAD3rKn9S5s4iKX9KwKPIE1GCEG0qE1UomcIxYhey5oKEVoQoHtJkKvZpOVH
 zXNoPIMdwegZI++89UqY1jz6gI1pyBYRs4qmdnltXToO7NXdCr+LC5XNCStewoCE46gJIsb+
 8DpgK+wPoK/k1bF4HbnImTmkWaRLZKjaFsU4dR3+zwCgxqZXdZMiAYA+1mIjiGRZubOctQUE
 AIZ51+tT+FPkpR8ld+qjHNh1F42y0nCj4dL1oHjWpcq2tzuK+BHzpePsM4rM9ZeYqDSsZIFC
 5ol61NYmKaKDMRjwY5KK+tABm/ha+OCl4twcxtHCoLOcK1N/8/kqZ75x3/NLJwL/BRwaoE0Y
 NsD+BxCW0Rjbiztg2KwkdDWFcCVmBADc/Ka7mKdimHzY6XJ3gIHgFS9fa2rcxKaleajH+dXh
 SPRW8Qil2n/FaAdUIBWL/woF78BAgDfaOGt7Ize+pRVia0e6KD9aUBjRz3ZXmvG17xv83UmW
 ZRP0fpVqA28ou+NvjRNKJtd144OUeMLyEhy82YlkGPwn7r6WhaWo6UIpSM0tU3RhbmlzbGF2
 IEJyYWJlYyA8c3RhbmlzbGF2LmJyYWJlY0BnbWFpbC5jb20+wmwEExECACwCGwMHCwkIBwMC
 AQYVCAIJCgsEFgIDAQIeAQIXgAUJIT9ywAUCUdMF/QIZAQAKCRBxfCCfoE/NdgreAKCEwh0S
 bgGDPUFG9HaToZUp+lkzNACbBSazK57hL2hGrJ5K3PVlEpWVAwHOwE0EPq/ZghAEAK3rY7aV
 eV7YI/HDYul1PnntG+tR2hgnUB4sCfWIPLrusOwa6bEnFbbnjH0IpWxTfrT08bnyAMpJDsK8
 fMSu053P3Gwkt8ILFuTouw6EF0JaBizsdXbFgKRS8pJVAZk33myR+/VpKw7p1fNchJd6fgqp
 jkCcVr6lcMCowlMYvCkbAAMGBACRnb/PP30vbbiw1wWAz7pO4YhDnt82EonFgbYdsGqHegGK
 Jkj3bbh0os0K//ZqhXyp31BQwpAI7uRAqRIfv5OLUqcLJoOLdKh4VyxXhn31dvVs3YQFLULi
 qiE1Rui5OxgQbmqxk965EMp6QVOKKVFFXKJdYO37NjZo00yScoEAJ8JGBBgRAgAGBQI+r9mC
 AAoJEHF8IJ+gT812L60An3nw69B52AbSCxEbXBf8cpeZFnR3AJ9STQXip4/l0KIRMgeHeDE0
 izHxhA==
Organization: SUSE Linux, s. r. o.
Message-ID: <6970a2cd-b392-ae40-8f10-65188594e88b@suse.cz>
Date:   Wed, 10 Oct 2018 19:26:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

If netlink event arrives and related escapes are part of issue, agetty
reloads and re-display the prompt. Reload is triggered not only by IP
address change, but also by IPv6 RAs. In some environments it causes
reload several times in a minute, and even complicates the login.

To prevent this, reload only if a real change appears.

This consists of:
split print_issue_file() to several functions:

eval_issue_file() prints issue to memory. It does not affect terminal in
any way.

print_issue_file() prints issue file from memory.

cmp_issue_file() compares the issue file and returns true, if reload is
needed.

The implementation requires additional change:

do_prompt() does not evaluate the issue file. It is responsibility of
calling function.

Test suite:

Use issue that contais \4 and/or \6 escape.

After installing new instance, restart agetty by typing a letter and then
Enter 6 times.

To check whether reload happens, type a letter. When reload happens,
letter disappears.

1. Unplug network cable. Wait a while and re-plug network cable.
You should see 2 reloads on single stack and 3 reloads on dual stack.

2. Run a loop
while : ; do
	sed -i '$areload_test' /etc/issue
	agetty --reload
	sleep 3
	sed -i '/reload_test/d' /etc/issue
	agetty --reload
	sleep 3
done
You should see regular reload every 3 seconds.

3. Run a loop
while : ; do
	agetty --reload
	sleep 3
done
Before: You see regular reload every 3 seconds.
After: No reloads.

4. Run a loop
while : ; do
	ifconfig lo 127.0.0.1 netmask 255.0.0.0
	sleep 3
	ifconfig lo 127.0.0.2 netmask 255.0.0.0
	sleep 3
done
Before: You see regular reload every 3 seconds.
After: No reloads.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 term-utils/agetty.c | 141 +++++++++++++++++++++++++++++++-------------
 1 file changed, 100 insertions(+), 41 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 27e97091b..94f517419 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -28,6 +28,7 @@
 #include <utmpx.h>
 #include <getopt.h>
 #include <time.h>
+#include <stdbool.h>
 #include <sys/socket.h>
 #include <langinfo.h>
 #include <grp.h>
@@ -328,6 +329,7 @@ static void check_username (const char* nm);
 static void login_options_to_argv(char *argv[], int *argc, char *str, char *username);
 static void reload_agettys(void);
 static void print_issue_file(struct options *op, struct termios *tp);
+static void eval_issue_file(struct options *op, struct termios *tp);
 
 /* Fake hostname for ut_host specified on command line. */
 static char *fakehost;
@@ -463,10 +465,12 @@ int main(int argc, char **argv)
 	}
 
 	if (options.flags & F_NOPROMPT) {	/* --skip-login */
+		eval_issue_file(&options, &termios);
 		print_issue_file(&options, &termios);
 	} else {				/* regular (auto)login */
 		if (options.autolog) {
 			/* Autologin prompt */
+			eval_issue_file(&options, &termios);
 			do_prompt(&options, &termios);
 			printf(_("%s%s (automatic login)\n"), LOGIN, options.autolog);
 		} else {
@@ -1721,9 +1725,66 @@ static void print_issue_file(struct options *op, struct termios *tp __attribute_
 		write_all(STDOUT_FILENO, "\r\n", 2);
 	}
 }
+static void eval_issue_file(struct options *op __attribute__((__unused__)), struct termios *tp __attribute__((__unused__)))
+{
+}
 #else /* ISSUE_SUPPORT */
 
+static FILE *issue_f;
+static char *issue_mem = NULL;
+static size_t issue_mem_sz;
+static bool do_tcsetattr;
+static bool do_tcrestore;
+#ifdef AGETTY_RELOAD
+static char *issue_mem_old = NULL;
+#endif
+static bool cmp_issue_file(void) {
+	if (issue_mem_old && issue_mem) {
+		if (!strcmp(issue_mem_old, issue_mem)) {
+			free(issue_mem_old);
+			issue_mem_old = issue_mem;
+			issue_mem = NULL;
+			return false;
+		}
+	} else
+		return true;
+	return true;
+}
 static void print_issue_file(struct options *op, struct termios *tp)
+{
+	int oflag = tp->c_oflag;	    /* Save current setting. */
+
+	if ((op->flags & F_NONL) == 0) {
+		/* Issue not in use, start with a new line. */
+		write_all(STDOUT_FILENO, "\r\n", 2);
+	}
+
+	if (do_tcsetattr) {
+		if ((op->flags & F_VCONSOLE) == 0) {
+			/* Map new line in output to carriage return & new line. */
+			tp->c_oflag |= (ONLCR | OPOST);
+			tcsetattr(STDIN_FILENO, TCSADRAIN, tp);
+		}
+	}
+
+	write_all(STDOUT_FILENO, issue_mem, issue_mem_sz);
+	if (do_tcrestore) {
+		/* Restore settings. */
+		tp->c_oflag = oflag;
+		/* Wait till output is gone. */
+		tcsetattr(STDIN_FILENO, TCSADRAIN, tp);
+	}
+#ifdef AGETTY_RELOAD
+	free(issue_mem_old);
+	issue_mem_old = issue_mem;
+	issue_mem = NULL;
+#else
+	free(issue_mem);
+	issue_mem = NULL;
+#endif
+}
+
+static void eval_issue_file(struct options *op, struct termios *tp)
 {
 	const char *filename, *dirname = NULL;
 	FILE *f = NULL;
@@ -1734,10 +1795,6 @@ static void print_issue_file(struct options *op, struct termios *tp)
 #ifdef AGETTY_RELOAD
 	netlink_groups = 0;
 #endif
-	if ((op->flags & F_NONL) == 0) {
-		/* Issue not in use, start with a new line. */
-		write_all(STDOUT_FILENO, "\r\n", 2);
-	}
 
 	if (!(op->flags & F_ISSUE))
 		return;
@@ -1768,6 +1825,7 @@ static void print_issue_file(struct options *op, struct termios *tp)
 		dirname = _PATH_ISSUEDIR;
 	}
 
+	issue_f = open_memstream(&issue_mem, &issue_mem_sz);
 #ifdef ISSUEDIR_SUPPORT
 	if (dirname) {
 		dd = open(dirname, O_RDONLY|O_CLOEXEC|O_DIRECTORY);
@@ -1782,13 +1840,9 @@ static void print_issue_file(struct options *op, struct termios *tp)
 		f = fopen(filename, "r");
 
 	if (f || dirname) {
-		int c, oflag = tp->c_oflag;	    /* Save current setting. */
+		int c;
 
-		if ((op->flags & F_VCONSOLE) == 0) {
-			/* Map new line in output to carriage return & new line. */
-			tp->c_oflag |= (ONLCR | OPOST);
-			tcsetattr(STDIN_FILENO, TCSADRAIN, tp);
-		}
+		do_tcsetattr = true;
 
 		do {
 #ifdef ISSUEDIR_SUPPORT
@@ -1801,7 +1855,7 @@ static void print_issue_file(struct options *op, struct termios *tp)
 				if (c == '\\')
 					output_special_char(getc(f), op, tp, f);
 				else
-					putchar(c);
+					putc(c, issue_f);
 			}
 			fclose(f);
 			f = NULL;
@@ -1809,12 +1863,8 @@ static void print_issue_file(struct options *op, struct termios *tp)
 
 		fflush(stdout);
 
-		if ((op->flags & F_VCONSOLE) == 0) {
-			/* Restore settings. */
-			tp->c_oflag = oflag;
-			/* Wait till output is gone. */
-			tcsetattr(STDIN_FILENO, TCSADRAIN, tp);
-		}
+		if ((op->flags & F_VCONSOLE) == 0)
+			do_tcrestore = true;
 	}
 
 #ifdef ISSUEDIR_SUPPORT
@@ -1828,6 +1878,7 @@ static void print_issue_file(struct options *op, struct termios *tp)
 	if (netlink_groups != 0)
 		open_netlink();
 #endif
+	fclose(issue_f);
 }
 #endif /* ISSUE_SUPPORT */
 
@@ -1842,11 +1893,14 @@ again:
 	if (op->flags & F_LOGINPAUSE) {
 		puts(_("[press ENTER to login]"));
 #ifdef AGETTY_RELOAD
+		/* reload issue */
 		if (!wait_for_term_input(STDIN_FILENO)) {
-			/* reload issue */
-			if (op->flags & F_VCONSOLE)
-				termio_clear(STDOUT_FILENO);
-			goto again;
+			eval_issue_file(op, tp);
+			if (cmp_issue_file()) {
+				if (op->flags & F_VCONSOLE)
+					termio_clear(STDOUT_FILENO);
+				goto again;
+			}
 		}
 #endif
 		getc(stdin);
@@ -1967,17 +2021,22 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
 	bp = logname;
 	*bp = '\0';
 
+	eval_issue_file(op, tp);
 	while (*logname == '\0') {
 		/* Write issue file and prompt */
 		do_prompt(op, tp);
 
 #ifdef AGETTY_RELOAD
+	no_reload:
 		if (!wait_for_term_input(STDIN_FILENO)) {
 			/* refresh prompt -- discard input data, clear terminal
 			 * and call do_prompt() again
 			 */
 			if ((op->flags & F_VCONSOLE) == 0)
 				sleep(1);
+			eval_issue_file(op, tp);
+			if (!cmp_issue_file())
+				goto no_reload;
 			tcflush(STDIN_FILENO, TCIFLUSH);
 			if (op->flags & F_VCONSOLE)
 				termio_clear(STDOUT_FILENO);
@@ -2365,7 +2424,7 @@ static void print_addr(sa_family_t family, void *addr)
 	char buff[INET6_ADDRSTRLEN + 1];
 
 	inet_ntop(family, addr, buff, sizeof(buff));
-	printf("%s", buff);
+	fprintf(issue_f, "%s", buff);
 }
 
 /*
@@ -2487,36 +2546,36 @@ static void output_special_char(unsigned char c, struct options *op,
 		if (get_escape_argument(fp, escname, sizeof(escname))) {
 			const char *esc = color_sequence_from_colorname(escname);
 			if (esc)
-				fputs(esc, stdout);
+				fputs(esc, issue_f);
 		} else
-			fputs("\033", stdout);
+			fputs("\033", issue_f);
 		break;
 	}
 	case 's':
 		uname(&uts);
-		printf("%s", uts.sysname);
+		fprintf(issue_f, "%s", uts.sysname);
 		break;
 	case 'n':
 		uname(&uts);
-		printf("%s", uts.nodename);
+		fprintf(issue_f, "%s", uts.nodename);
 		break;
 	case 'r':
 		uname(&uts);
-		printf("%s", uts.release);
+		fprintf(issue_f, "%s", uts.release);
 		break;
 	case 'v':
 		uname(&uts);
-		printf("%s", uts.version);
+		fprintf(issue_f, "%s", uts.version);
 		break;
 	case 'm':
 		uname(&uts);
-		printf("%s", uts.machine);
+		fprintf(issue_f, "%s", uts.machine);
 		break;
 	case 'o':
 	{
 		char *dom = xgetdomainname();
 
-		fputs(dom ? dom : "unknown_domain", stdout);
+		fputs(dom ? dom : "unknown_domain", issue_f);
 		free(dom);
 		break;
 	}
@@ -2536,7 +2595,7 @@ static void output_special_char(unsigned char c, struct options *op,
 			    (canon = strchr(info->ai_canonname, '.')))
 				dom = canon + 1;
 		}
-		fputs(dom ? dom : "unknown_domain", stdout);
+		fputs(dom ? dom : "unknown_domain", issue_f);
 		if (info)
 			freeaddrinfo(info);
 		free(host);
@@ -2555,19 +2614,19 @@ static void output_special_char(unsigned char c, struct options *op,
 			break;
 
 		if (c == 'd') /* ISO 8601 */
-			printf("%s %s %d  %d",
+			fprintf(issue_f, "%s %s %d  %d",
 				      nl_langinfo(ABDAY_1 + tm->tm_wday),
 				      nl_langinfo(ABMON_1 + tm->tm_mon),
 				      tm->tm_mday,
 				      tm->tm_year < 70 ? tm->tm_year + 2000 :
 				      tm->tm_year + 1900);
 		else
-			printf("%02d:%02d:%02d",
+			fprintf(issue_f, "%02d:%02d:%02d",
 				      tm->tm_hour, tm->tm_min, tm->tm_sec);
 		break;
 	}
 	case 'l':
-		printf ("%s", op->tty);
+		fprintf (issue_f, "%s", op->tty);
 		break;
 	case 'b':
 	{
@@ -2576,7 +2635,7 @@ static void output_special_char(unsigned char c, struct options *op,
 
 		for (i = 0; speedtab[i].speed; i++) {
 			if (speedtab[i].code == speed) {
-				printf("%ld", speedtab[i].speed);
+				fprintf(issue_f, "%ld", speedtab[i].speed);
 				break;
 			}
 		}
@@ -2591,18 +2650,18 @@ static void output_special_char(unsigned char c, struct options *op,
 			var = read_os_release(op, varname);
 			if (var) {
 				if (strcmp(varname, "ANSI_COLOR") == 0)
-					printf("\033[%sm", var);
+					fprintf(issue_f, "\033[%sm", var);
 				else
-					fputs(var, stdout);
+					fputs(var, issue_f);
 			}
 		/* \S */
 		} else if ((var = read_os_release(op, "PRETTY_NAME"))) {
-			fputs(var, stdout);
+			fputs(var, issue_f);
 
 		/* \S and PRETTY_NAME not found */
 		} else {
 			uname(&uts);
-			fputs(uts.sysname, stdout);
+			fputs(uts.sysname, issue_f);
 		}
 
 		free(var);
@@ -2620,9 +2679,9 @@ static void output_special_char(unsigned char c, struct options *op,
 				users++;
 		endutxent();
 		if (c == 'U')
-			printf(P_("%d user", "%d users", users), users);
+			fprintf(issue_f, P_("%d user", "%d users", users), users);
 		else
-			printf ("%d ", users);
+			fprintf (issue_f, "%d ", users);
 		break;
 	}
 	case '4':
-- 
2.19.0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
