Return-Path: <SRS0=LbFG=PS=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB13C43387
	for <util-linux@archiver.kernel.org>; Thu, 10 Jan 2019 00:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FBF214C6
	for <util-linux@archiver.kernel.org>; Thu, 10 Jan 2019 00:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfAJA25 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 9 Jan 2019 19:28:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:46946 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726590AbfAJA24 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 9 Jan 2019 19:28:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F004FAB9D
        for <util-linux@vger.kernel.org>; Thu, 10 Jan 2019 00:28:54 +0000 (UTC)
To:     util-linux@vger.kernel.org
From:   Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 2/2] su-common.c: prefer ENV_SUPATH over ENV_ROOTPATH
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
 AJ958OvQedgG0gsRG1wX/HKXmRZ0dwCfUk0F4qeP5dCiETIHh3gxNIsx8YQ=
Organization: SUSE Linux, s. r. o.
Message-ID: <6de7ab5f-7056-50fc-0b47-864efa82ee8b@suse.cz>
Date:   Thu, 10 Jan 2019 01:28:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

ENV_SUPATH and ENV_ROOTPATH are equivalent and ENV_ROOTPATH takes
precedence in both login and su. It makes no sense. More logical would be
precedence of ENV_SUPATH in su and ENV_ROOTPATH in login.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 login-utils/login.1     | 2 +-
 login-utils/runuser.1   | 2 +-
 login-utils/su-common.c | 4 ++--
 login-utils/su.1        | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/login-utils/login.1 b/login-utils/login.1
index cb8addec3..b73eae147 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -282,7 +282,7 @@ a regular user logs in.  The default value is
 (string)
 .RS 4
 If set, it will be used to define the PATH environment variable when
-the superuser logs in.  The default value is
+the superuser logs in.  ENV_ROOTPATH takes precedence.  The default value is
 .I /usr\:/local\:/sbin:\:/usr\:/local\:/bin:\:/sbin:\:/bin:\:/usr\:/sbin:\:/usr\:/bin
 .RE
 .SH FILES
diff --git a/login-utils/runuser.1 b/login-utils/runuser.1
index bf0d02471..221672200 100644
--- a/login-utils/runuser.1
+++ b/login-utils/runuser.1
@@ -183,7 +183,7 @@ default value is
 .B ENV_SUPATH
 (string)
 .RS 4
-Defines the PATH environment variable for root. The default value is
+Defines the PATH environment variable for root.  ENV_SUPATH takes precedence.  The default value is
 .IR /usr/local/sbin:\:/usr/local/bin:\:/sbin:\:/bin:\:/usr/sbin:\:/usr/bin .
 .RE
 .PP
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 19074247c..0e44eb87c 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -989,8 +989,8 @@ static void setenv_path(const struct passwd *pw)
 	if (pw->pw_uid)
 		rc = logindefs_setenv("PATH", "ENV_PATH", _PATH_DEFPATH);
 
-	else if ((rc = logindefs_setenv("PATH", "ENV_ROOTPATH", NULL)) != 0)
-		rc = logindefs_setenv("PATH", "ENV_SUPATH", _PATH_DEFPATH_ROOT);
+	else if ((rc = logindefs_setenv("PATH", "ENV_SUPATH", NULL)) != 0)
+		rc = logindefs_setenv("PATH", "ENV_ROOTPATH", _PATH_DEFPATH_ROOT);
 
 	if (rc)
 		err(EXIT_FAILURE, _("failed to set the PATH environment variable"));
diff --git a/login-utils/su.1 b/login-utils/su.1
index d6a064fd2..5ae6d6b2d 100644
--- a/login-utils/su.1
+++ b/login-utils/su.1
@@ -209,7 +209,7 @@ default value is
 .B ENV_SUPATH
 (string)
 .RS 4
-Defines the PATH environment variable for root.  The default value is
+Defines the PATH environment variable for root.  ENV_SUPATH takes precedence.  The default value is
 .IR /usr/local/sbin:\:/usr/local/bin:\:/sbin:\:/bin:\:/usr/sbin:\:/usr/bin .
 .RE
 .PP
-- 
2.20.1


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
