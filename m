Return-Path: <SRS0=5WUB=YC=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ED4C47404
	for <util-linux@archiver.kernel.org>; Wed,  9 Oct 2019 23:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE106206BB
	for <util-linux@archiver.kernel.org>; Wed,  9 Oct 2019 23:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732255AbfJIXI1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 9 Oct 2019 19:08:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:33620 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731959AbfJIXI1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 9 Oct 2019 19:08:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 58D1CAC2F
        for <util-linux@vger.kernel.org>; Wed,  9 Oct 2019 23:08:25 +0000 (UTC)
To:     util-linux@vger.kernel.org
From:   Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] nologin: Prevent error from su -c
Autocrypt: addr=sbrabec@suse.cz; prefer-encrypt=mutual; keydata=
 mQGiBD6v2X0RBAD3rKn9S5s4iKX9KwKPIE1GCEG0qE1UomcIxYhey5oKEVoQoHtJkKvZpOVH
 zXNoPIMdwegZI++89UqY1jz6gI1pyBYRs4qmdnltXToO7NXdCr+LC5XNCStewoCE46gJIsb+
 8DpgK+wPoK/k1bF4HbnImTmkWaRLZKjaFsU4dR3+zwCgxqZXdZMiAYA+1mIjiGRZubOctQUE
 AIZ51+tT+FPkpR8ld+qjHNh1F42y0nCj4dL1oHjWpcq2tzuK+BHzpePsM4rM9ZeYqDSsZIFC
 5ol61NYmKaKDMRjwY5KK+tABm/ha+OCl4twcxtHCoLOcK1N/8/kqZ75x3/NLJwL/BRwaoE0Y
 NsD+BxCW0Rjbiztg2KwkdDWFcCVmBADc/Ka7mKdimHzY6XJ3gIHgFS9fa2rcxKaleajH+dXh
 SPRW8Qil2n/FaAdUIBWL/woF78BAgDfaOGt7Ize+pRVia0e6KD9aUBjRz3ZXmvG17xv83UmW
 ZRP0fpVqA28ou+NvjRNKJtd144OUeMLyEhy82YlkGPwn7r6WhaWo6UIpSLQsU3RhbmlzbGF2
 IEJyYWJlYyAoU3VTRSBDUikgPHNicmFiZWNAc3VzZS5jej6IXwQTEQIAHwQLBwMCAxUCAwMW
 AgECHgECF4AFAlHS/kkFCSE/csAACgkQcXwgn6BPzXZY/gCghbxE4uexFHVP7qho9TDNxGGR
 xxgAoKCipPrJQrnXKhFG4RDeRcVE0PoBuQENBD6v2YIQBACt62O2lXle2CPxw2LpdT557Rvr
 UdoYJ1AeLAn1iDy67rDsGumxJxW254x9CKVsU3609PG58gDKSQ7CvHzErtOdz9xsJLfCCxbk
 6LsOhBdCWgYs7HV2xYCkUvKSVQGZN95skfv1aSsO6dXzXISXen4KqY5AnFa+pXDAqMJTGLwp
 GwADBgQAkZ2/zz99L224sNcFgM+6TuGIQ57fNhKJxYG2HbBqh3oBiiZI9224dKLNCv/2aoV8
 qd9QUMKQCO7kQKkSH7+Ti1KnCyaDi3SoeFcsV4Z99Xb1bN2EBS1C4qohNUbouTsYEG5qsZPe
 uRDKekFTiilRRVyiXWDt+zY2aNNMknKBACeIRgQYEQIABgUCPq/ZggAKCRBxfCCfoE/Ndi+t
 AJ958OvQedgG0gsRG1wX/HKXmRZ0dwCfUk0F4qeP5dCiETIHh3gxNIsx8YQ=
Organization: SUSE Linux, s. r. o.
Message-ID: <f3a10c86-77a3-06ff-bde0-7822c37292e4@suse.cz>
Date:   Thu, 10 Oct 2019 01:08:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

"su -c" can pass "-c" to nologin. It causes ugly error:

su -c "echo OK" - man
-nologin: invalid option -- 'c'
Try '-nologin --help' for more information.

Accept -c to prevent this error.

Signed-off-by: Josef Cejka <jcejka@suse.com>
Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 login-utils/nologin.8 | 11 +++++++++--
 login-utils/nologin.c |  9 +++++++--
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/login-utils/nologin.8 b/login-utils/nologin.8
index ee5948443..9389a86c6 100644
--- a/login-utils/nologin.8
+++ b/login-utils/nologin.8
@@ -18,9 +18,16 @@ The exit code returned by
 is always 1.
 .PP
 .SH OPTIONS
-.IP "\fB\-h, \-\-help\fP"
+
+
+.TP
+.IP "\fB\-c\fR, \fB\-\-command\fR \fIcommand\fR"
+Ignored. For compatibility with
+.I su -c "command" - user
+that would cause error otherwise.
+.IP "\fB\-h\fR, \fB\-\-help\fR"
 Display help text and exit.
-.IP "\fB-V, \-\-version"
+.IP "\fB-V\fR, \fB\-\-version\fR"
 Display version information and exit.
 .SH NOTES
 .B nologin
diff --git a/login-utils/nologin.c b/login-utils/nologin.c
index 14a091715..2fc1cd3cf 100644
--- a/login-utils/nologin.c
+++ b/login-utils/nologin.c
@@ -30,7 +30,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_("Politely refuse a login.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	printf(USAGE_HELP_OPTIONS(16));
+	fputs(_(" -c, --command <command>  does nothing (for compatibility with su -c)\n"), out);
+	printf(USAGE_HELP_OPTIONS(26));
 
 	printf(USAGE_MAN_TAIL("nologin(8)"));
 	exit(EXIT_FAILURE);
@@ -41,6 +42,7 @@ int main(int argc, char *argv[])
 	int c, fd = -1;
 	struct stat st;
 	static const struct option longopts[] = {
+		{ "command", required_argument, NULL, 'c' },
 		{ "help",    0, NULL, 'h' },
 		{ "version", 0, NULL, 'V' },
 		{ NULL, 0, NULL, 0 }
@@ -50,8 +52,11 @@ int main(int argc, char *argv[])
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 
-	while ((c = getopt_long(argc, argv, "hV", longopts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, "c:hV", longopts, NULL)) != -1) {
 		switch (c) {
+		case 'c':
+			/* Ignore the command, just don't print unknown option error. */
+			break;
 		case 'h':
 			usage();
 		case 'V':
-- 
2.23.0

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                    tel: +420 284 084 060
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
