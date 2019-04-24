Return-Path: <SRS0=0AAi=S2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C4DC10F11
	for <util-linux@archiver.kernel.org>; Wed, 24 Apr 2019 04:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FA8218D3
	for <util-linux@archiver.kernel.org>; Wed, 24 Apr 2019 04:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725913AbfDXEDY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 24 Apr 2019 00:03:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:53324 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbfDXEDY (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 Apr 2019 00:03:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2552CAE33
        for <util-linux@vger.kernel.org>; Wed, 24 Apr 2019 04:03:22 +0000 (UTC)
To:     util-linux@vger.kernel.org
From:   Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] lslogins: Fix discrepancies of SYS_UID_MIN
Openpgp: preference=signencrypt
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
 AKCrirgQ963gLN3DlBRlvFPIOZ01WACglN5nhY7wyyhIjQP3k4eVfBY+WV4=
Organization: SUSE Linux, s. r. o.
Message-ID: <65c908ef-6c16-0b24-c169-0448b3bd3aaa@suse.cz>
Date:   Wed, 24 Apr 2019 06:03:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

util-linux does not contain useradd. Its most popular implementation
comes from shadow. SYS_UID_MIN is one of common parameters. Its hardcoded
fallback value is equal to 101 in shadow useradd (see
shadow-4.6/libmisc/find_new_uid.c: get_ranges()), but 201 in
login-utils/lslogins.c.

Let lslogins use the same fallback as useradd from shadow.

Hopefully most distros define its custom value of SYS_UID_MIN in
/etc/login.defs, so this problem is not visible.

login-utils/lslogins.1 does not mention its default at all. Add a
reference and improve text of lslogins(1) to prevent off-by-one
interpretation.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 login-utils/lslogins.1 | 6 +++---
 login-utils/lslogins.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/login-utils/lslogins.1 b/login-utils/lslogins.1
index 5aa14c706..857d2dffd 100644
--- a/login-utils/lslogins.1
+++ b/login-utils/lslogins.1
@@ -92,9 +92,9 @@ Display information related to login by password (see
also \fB\-afL).
 Raw output (no columnation).
 .TP
 \fB\-s\fR, \fB\-\-system\-accs\fR
-Show system accounts.  These are by default all accounts with a UID
below 1000
-(non-inclusive), with the exception of either nobody or nfsnobody (UID
65534).
-This hardcoded default maybe overwritten by parameters SYS_UID_MIN and
SYS_UID_MAX in
+Show system accounts.  These are by default all accounts with a UID
between 101 and 999
+(inclusive), with the exception of either nobody or nfsnobody (UID 65534).
+This hardcoded default may be overwritten by parameters SYS_UID_MIN and
SYS_UID_MAX in
 the file /etc/login.defs.
 .TP
 \fB\-\-time\-format\fR \fItype\fP
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index c913cf2d8..0c558f24f 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -74,7 +74,7 @@ static int lslogins_flag;
 
 #define UL_UID_MIN 1000
 #define UL_UID_MAX 60000
-#define UL_SYS_UID_MIN 201
+#define UL_SYS_UID_MIN 101
 #define UL_SYS_UID_MAX 999
 
 /* we use the value of outmode to determine
-- 
2.21.0

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

