Return-Path: <SRS0=haDV=NG=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD58BC6786E
	for <util-linux@archiver.kernel.org>; Fri, 26 Oct 2018 13:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79C59207DD
	for <util-linux@archiver.kernel.org>; Fri, 26 Oct 2018 13:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C59207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbeJZVjT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 26 Oct 2018 17:39:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57172 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726113AbeJZVjT (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 26 Oct 2018 17:39:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 973DDAE5F;
        Fri, 26 Oct 2018 13:02:17 +0000 (UTC)
To:     util-linux@vger.kernel.org
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Karel Zak <kzak@redhat.com>
From:   Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] agetty: when logname is erased, re-enable reloads
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
Message-ID: <30ff9b68-4eab-5c42-22e6-1e84920862f0@suse.cz>
Date:   Fri, 26 Oct 2018 15:02:17 +0200
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

When user starts to enter logname, 8b58ffdd blocks issue reloads.
Reloads remain blocked even if user deletes all typed characters.

Make things visually consistent: If no characters are entered,
re-enable reloads.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
Cc: Lubomir Rintel <lkundrak@v3.sk>
Cc: Karel Zak <kzak@redhat.com>
---
 term-utils/agetty.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index cfcdffe93..05a269abb 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -2182,6 +2182,9 @@ static char *get_logname(struct issue *ie, struct options *op, struct termios *t
 				*bp++ = ascval;			/* and store it */
 				break;
 			}
+			/* Everything was erased. */
+			if (bp == logname)
+				goto no_reload;
 		}
 	}
 
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
