Return-Path: <SRS0=K1B8=M7=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64B4DECDE43
	for <util-linux@archiver.kernel.org>; Fri, 19 Oct 2018 20:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F84121470
	for <util-linux@archiver.kernel.org>; Fri, 19 Oct 2018 20:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F84121470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbeJTEPy (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 20 Oct 2018 00:15:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:36944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726027AbeJTEPy (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 20 Oct 2018 00:15:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 41A09AEF3;
        Fri, 19 Oct 2018 20:08:18 +0000 (UTC)
Subject: Re: [PATCH v2] agetty: don't put the VC into canonical mode
To:     Lubomir Rintel <lkundrak@v3.sk>, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <20181016064149.2698-1-lkundrak@v3.sk>
 <20181016074053.dea6ydle26y37uva@ws.net.home>
 <52ebddaca50ed8d5f498bdf56b02ae4640af369a.camel@v3.sk>
 <cc6f95bb-6dc6-cb34-fb7e-505da29e61f1@suse.cz>
 <0d9d07b6b3f45e069fefa4e9e008822a3aa7a135.camel@v3.sk>
From:   Stanislav Brabec <sbrabec@suse.cz>
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
Message-ID: <b7a4fca3-6ee1-f81d-7db1-0c069cd4e56b@suse.cz>
Date:   Fri, 19 Oct 2018 22:08:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <0d9d07b6b3f45e069fefa4e9e008822a3aa7a135.camel@v3.sk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

I just ported your patch to the current head and did some experiments.

I verified that input indeed works in the non-canonical mode, and
Backspace is handled. I didn't understand why it works and why my
implementation did not work.

So I started to debug it in deep. We all overseen that the non-canonical +
non-echo mode processing is already implemented in agetty.c: get_logname()
in a previously dead part of the code that was never called:

2180					if ((tp->c_lflag & ECHO) == 0)

This code implements both echo and Backspace processing!

There is one small piece for improvement:
When you press letter and then Backspace, reloads remain blocked.
I guess it is acceptable and fixable later.

Many thanks for your patch!

Note that the patch works even with less aggressive
+		tp->c_lflag &= ~(ICANON | ECHO | ECHOE | ECHOK | ECHOKE);
I am not sure whether setting c_lflag to 0 is completely safe.

Subject: [PATCH] agetty: don't put the VC into canonical mode

The wait_for_term_input()'s select() needs to be tripped when the user
starts typing. Otherwise the reloads can abort an already in-progress login.

Coupled with \4 and \6 expansions that happen to be there on Fedora Server,
this means reload on every netlink event. With a couple of IPv6 routers
announcing their networks and temporary addresses in use can make it
sometimes virtually impossible to log in.

Seems like zero lflags do the job just fine on a Linux VT. Reset it to
canonical mode before running login.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>

---
Changes since v1:
- Unreversed the logic in termio_final()/reset_vc() conditional

Tested on a vc and serial console on a stock Fedora installation:

  /sbin/agetty -o -p -- \u --noclear tty1 linux
  /sbin/agetty -o -p -- \u --keep-baud 115200,38400,9600 ttyS2 vt220
---
 term-utils/agetty.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 59122ca45..cfcdffe93 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -316,7 +316,7 @@ static void parse_speeds(struct options *op, char *arg);
 static void update_utmp(struct options *op);
 static void open_tty(char *tty, struct termios *tp, struct options *op);
 static void termio_init(struct options *op, struct termios *tp);
-static void reset_vc (const struct options *op, struct termios *tp);
+static void reset_vc(const struct options *op, struct termios *tp, int canon);
 static void auto_baud(struct termios *tp);
 static void list_speeds(void);
 static void output_special_char (struct issue *ie, unsigned char c, struct options *op,
@@ -501,13 +501,14 @@ int main(int argc, char **argv)
 	if (options.timeout)
 		alarm(0);
 
-	if ((options.flags & F_VCONSOLE) == 0) {
-		/* Finalize the termios settings. */
+	/* Finalize the termios settings. */
+	if ((options.flags & F_VCONSOLE) == 0)
 		termio_final(&options, &termios, &chardata);
+	else
+		reset_vc(&options, &termios, 1);
 
-		/* Now the newline character should be properly written. */
-		write_all(STDOUT_FILENO, "\r\n", 2);
-	}
+	/* Now the newline character should be properly written. */
+	write_all(STDOUT_FILENO, "\r\n", 2);
 
 	sigaction(SIGQUIT, &sa_quit, NULL);
 	sigaction(SIGINT, &sa_int, NULL);
@@ -1250,7 +1251,7 @@ static void termio_init(struct options *op, struct termios *tp)
 		setlocale(LC_CTYPE, "POSIX");
 		op->flags &= ~F_UTF8;
 #endif
-		reset_vc(op, tp);
+		reset_vc(op, tp, 0);
 
 		if ((tp->c_cflag & (CS8|PARODD|PARENB)) == CS8)
 			op->flags |= F_EIGHTBITS;
@@ -1360,7 +1361,7 @@ static void termio_init(struct options *op, struct termios *tp)
 }
 
 /* Reset virtual console on stdin to its defaults */
-static void reset_vc(const struct options *op, struct termios *tp)
+static void reset_vc(const struct options *op, struct termios *tp, int canon)
 {
 	int fl = 0;
 
@@ -1369,6 +1370,15 @@ static void reset_vc(const struct options *op, struct termios *tp)
 
 	reset_virtual_console(tp, fl);
 
+#ifdef AGETTY_RELOAD
+	/*
+	 * Discard all the flags that makes the line go canonical with echoing.
+	 * We need to know when the user starts typing.
+	 */
+	if (canon == 0)
+		tp->c_lflag = 0;
+#endif
+
 	if (tcsetattr(STDIN_FILENO, TCSADRAIN, tp))
 		log_warn(_("setting terminal attributes failed: %m"));
 
-- 
2.19.1

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Křižíkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
