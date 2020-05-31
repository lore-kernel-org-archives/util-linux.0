Return-Path: <SRS0=REj1=7N=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC002C433DF
	for <util-linux@archiver.kernel.org>; Sun, 31 May 2020 23:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB786206DA
	for <util-linux@archiver.kernel.org>; Sun, 31 May 2020 23:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728382AbgEaXfr convert rfc822-to-8bit (ORCPT
        <rfc822;util-linux@archiver.kernel.org>);
        Sun, 31 May 2020 19:35:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:37996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgEaXfr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 31 May 2020 19:35:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 0A6BBB188;
        Sun, 31 May 2020 23:35:47 +0000 (UTC)
To:     util-linux@vger.kernel.org
Cc:     Martin Wilck <martin.wilck@suse.com>
From:   Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] blockdev: Don't fail on missing start sector
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
 AAoJEHF8IJ+gT812L60AoKuKuBD3reAs3cOUFGW8U8g5nTVYAKCU3meFjvDLKEiNA/eTh5V8
 Fj5ZXg==
Organization: SUSE Linux, s. r. o.
Message-ID: <a7a4f974-8a32-efb3-0ba3-a25e77145946@suse.cz>
Date:   Mon, 1 Jun 2020 01:35:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Device mapper devices don't provide start sector.

It causes "blockdev --report" error:
blockdev: /dev/dm-9: failed to read partition start from sysfs: No such
file or directory

There is no reliable way to detect a geometry in this case.
Report N/A instead.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
Cc: Martin Wilck <martin.wilck@suse.com>
---
 disk-utils/blockdev.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/disk-utils/blockdev.c b/disk-utils/blockdev.c
index f1067c815..ab18cfa66 100644
--- a/disk-utils/blockdev.c
+++ b/disk-utils/blockdev.c
@@ -455,6 +455,7 @@ static void report_device(char *device, int quiet)
     long ra;
     unsigned long long bytes;
     uint64_t start = 0;
+    char start_str[11] = "";
     struct stat st;
 
     fd = open(device, O_RDONLY | O_NONBLOCK);
@@ -476,19 +477,21 @@ static void report_device(char *device, int quiet)
             disk != st.st_rdev) {
 
             if (ul_path_read_u64(pc, &start, "start") != 0)
-                err(EXIT_FAILURE,
-                    _("%s: failed to read partition start from sysfs"),
-                    device);
+                /* TRANSLATORS: Start sector not available. Max. 10
letters. */
+                sprintf(start_str, "%10s", _("N/A"));
         }
         ul_unref_path(pc);
     }
+    if (start_str[0] == 0)
+        sprintf(start_str, "%10ju", start);
+
     if (ioctl(fd, BLKROGET, &ro) == 0 &&
         ioctl(fd, BLKRAGET, &ra) == 0 &&
         ioctl(fd, BLKSSZGET, &ssz) == 0 &&
         ioctl(fd, BLKBSZGET, &bsz) == 0 &&
         blkdev_get_size(fd, &bytes) == 0) {
-        printf("%s %5ld %5d %5d %10ju %15lld   %s\n",
-               ro ? "ro" : "rw", ra, ssz, bsz, start, bytes, device);
+        printf("%s %5ld %5d %5d %s %15lld   %s\n",
+               ro ? "ro" : "rw", ra, ssz, bsz, start_str, bytes, device);
     } else {
         if (!quiet)
             warnx(_("ioctl error on %s"), device);
-- 
2.25.1

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


