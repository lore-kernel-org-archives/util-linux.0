Return-Path: <SRS0=M2R7=OA=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D97C43441
	for <util-linux@archiver.kernel.org>; Wed, 21 Nov 2018 20:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25019214DB
	for <util-linux@archiver.kernel.org>; Wed, 21 Nov 2018 20:04:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25019214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbeKVGkY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 22 Nov 2018 01:40:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:40096 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388669AbeKVGkX (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Nov 2018 01:40:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 46230AF4B
        for <util-linux@vger.kernel.org>; Wed, 21 Nov 2018 20:04:37 +0000 (UTC)
To:     util-linux@vger.kernel.org
From:   Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] rfkill: Add systemd integration
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
Message-ID: <0ad9b6ea-0d46-5ec5-1bfc-0e48be52dae8@suse.cz>
Date:   Wed, 21 Nov 2018 21:04:37 +0100
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

Add rfkill-block@.service and rfkill-unblock@.service templates.
These make rfkill integration to systemd easier.

Files come from openSUSE rfkill package.

Example:
Use `systemctl {start,stop} rfkill-block@bluetooth` to block or unblock
(disable or enable) the bluetooth device.

Author: Jochen Keil <jkeil@suse.de>
Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/Makemodule.am              | 10 +++++++++-
 sys-utils/rfkill-block@.service.in   | 11 +++++++++++
 sys-utils/rfkill-unblock@.service.in | 11 +++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)
 create mode 100644 sys-utils/rfkill-block@.service.in
 create mode 100644 sys-utils/rfkill-unblock@.service.in

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 825a7335b..0baa6e421 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -72,6 +72,11 @@ dist_man_MANS += sys-utils/rfkill.8
 rfkill_SOURCES = sys-utils/rfkill.c
 rfkill_LDADD = $(LDADD) libcommon.la libsmartcols.la
 rfkill_CFLAGS = $(AM_CFLAGS) -I$(ul_libsmartcols_incdir)
+if HAVE_SYSTEMD
+systemdsystemunit_DATA += \
+		sys-utils/rfkill-block@.service \
+		sys-utils/rfkill-unblock@.service
+endif
 endif
 
 if BUILD_SETSID
@@ -106,7 +111,10 @@ systemdsystemunit_DATA += \
 endif
 endif # BUILD_FSTRIM
 
-PATHFILES += sys-utils/fstrim.service
+PATHFILES += \
+	sys-utils/fstrim.service \
+	sys-utils/rfkill-block@.service \
+	sys-utils/rfkill-unblock@.service
 EXTRA_DIST += sys-utils/fstrim.timer
 
 if BUILD_DMESG
diff --git a/sys-utils/rfkill-block@.service.in b/sys-utils/rfkill-block@.service.in
new file mode 100644
index 000000000..c1ee0b467
--- /dev/null
+++ b/sys-utils/rfkill-block@.service.in
@@ -0,0 +1,11 @@
+[Unit]
+Description=Disable Device %I by RFKill
+After=rfkill-unblock@all.service
+Documentation=man:rfkill(8)
+
+[Service]
+Type=oneshot
+ExecStart=@usrsbin_execdir@/rfkill block %I
+
+[Install]
+WantedBy=multi-user.target
diff --git a/sys-utils/rfkill-unblock@.service.in b/sys-utils/rfkill-unblock@.service.in
new file mode 100644
index 000000000..bd9c4befe
--- /dev/null
+++ b/sys-utils/rfkill-unblock@.service.in
@@ -0,0 +1,11 @@
+[Unit]
+Description=Enable Device %I by RFKill
+After=rfkill-block@all.service
+Documentation=man:rfkill(8)
+
+[Service]
+Type=oneshot
+ExecStart=@usrsbin_execdir@/rfkill unblock %I
+
+[Install]
+WantedBy=multi-user.target
-- 
2.19.1

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
