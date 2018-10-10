Return-Path: <SRS0=AFk+=MW=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A63BC43441
	for <util-linux@archiver.kernel.org>; Wed, 10 Oct 2018 17:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E5B2085B
	for <util-linux@archiver.kernel.org>; Wed, 10 Oct 2018 17:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E5B2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeJKAtj (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 10 Oct 2018 20:49:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:42846 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726886AbeJKAth (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 10 Oct 2018 20:49:37 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 75C71B035
        for <util-linux@vger.kernel.org>; Wed, 10 Oct 2018 17:26:27 +0000 (UTC)
To:     util-linux@vger.kernel.org
From:   Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 2/3] agetty: Watch only protocol requested by issue escapes
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
Message-ID: <f1ced4a3-ea0b-1e88-44a7-24647d7f7571@suse.cz>
Date:   Wed, 10 Oct 2018 19:26:27 +0200
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

To decrease number of reloads, watch only protocol requested by \4 and \6
escapes in issue file.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 term-utils/agetty.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 2f27d7f71..27e97091b 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -153,6 +153,7 @@
 # define AGETTY_RELOAD_FDNONE	-2			/* uninitialized fd */
 static int inotify_fd = AGETTY_RELOAD_FDNONE;
 static int netlink_fd = AGETTY_RELOAD_FDNONE;
+static __u32 netlink_groups;
 #endif
 
 /*
@@ -1546,7 +1547,7 @@ static void open_netlink(void)
 	if (sock >= 0) {
 		addr.nl_family = AF_NETLINK;
 		addr.nl_pid = getpid();
-		addr.nl_groups = RTMGRP_IPV4_IFADDR | RTMGRP_IPV6_IFADDR;
+		addr.nl_groups = netlink_groups;
 		if (bind(sock, (struct sockaddr *)&addr, sizeof(addr)) < 0)
 			close(sock);
 		else
@@ -1729,6 +1730,9 @@ static void print_issue_file(struct options *op, struct termios *tp)
 #ifdef ISSUEDIR_SUPPORT
 	int dd = -1, nfiles = 0, i;
 	struct dirent **namelist = NULL;
+#endif
+#ifdef AGETTY_RELOAD
+	netlink_groups = 0;
 #endif
 	if ((op->flags & F_NONL) == 0) {
 		/* Issue not in use, start with a new line. */
@@ -1820,6 +1824,10 @@ static void print_issue_file(struct options *op, struct termios *tp)
 	if (dd >= 0)
 		close(dd);
 #endif
+#ifdef AGETTY_RELOAD
+	if (netlink_groups != 0)
+		open_netlink();
+#endif
 }
 #endif /* ISSUE_SUPPORT */
 
@@ -2624,10 +2632,6 @@ static void output_special_char(unsigned char c, struct options *op,
 		struct ifaddrs *addrs = NULL;
 		char iface[128];
 
-#ifdef AGETTY_RELOAD
-		open_netlink();
-#endif
-
 		if (getifaddrs(&addrs))
 			break;
 
@@ -2637,6 +2641,11 @@ static void output_special_char(unsigned char c, struct options *op,
 			output_iface_ip(addrs, NULL, family);
 
 		freeifaddrs(addrs);
+
+		if (c == '4')
+			netlink_groups |= RTMGRP_IPV4_IFADDR;
+		else
+			netlink_groups |= RTMGRP_IPV6_IFADDR;
 		break;
 	}
 	default:
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
