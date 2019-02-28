Return-Path: <SRS0=k+tB=RD=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D27C43381
	for <util-linux@archiver.kernel.org>; Thu, 28 Feb 2019 22:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A812084D
	for <util-linux@archiver.kernel.org>; Thu, 28 Feb 2019 22:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfB1WJm (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 28 Feb 2019 17:09:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:49698 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725918AbfB1WJm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 28 Feb 2019 17:09:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 78D50B136
        for <util-linux@vger.kernel.org>; Thu, 28 Feb 2019 22:09:41 +0000 (UTC)
To:     util-linux@vger.kernel.org
From:   Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] libmount: Recognize more fuse filesystems as pseudofs and
 netfs
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
Message-ID: <34af16dc-6012-bb04-9136-5fbaecdbb369@suse.cz>
Date:   Thu, 28 Feb 2019 23:09:40 +0100
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

Add some fuse filesystems to the list of pseudofs and netfs.

There are still tens of filesystems that should be evaluated and added.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 libmount/src/utils.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index 6d8871717..7f6cc1405 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -283,7 +283,14 @@ int mnt_fstype_is_pseudofs(const char *type)
 		"devtmpfs",
 		"dlmfs",
 		"efivarfs",
-		"fuse.gvfs-fuse-daemon",
+		"fuse", /* Fallback name of fuse used by many poorly written drivers. */
+		"fuse.archivemount", /* Not a true pseudofs (has source), but source is not reported. */
+		"fuse.dumpfs", /* In fact, it is a netfs, but source is not reported. */
+		"fuse.encfs", /* Not a true pseudofs (has source), but source is not reported. */
+		"fuse.gvfs-fuse-daemon", /* Old name, not used by gvfs any more. */
+		"fuse.gvfsd-fuse",
+		"fuse.rofiles-fuse",
+		"fuse.xwmfs",
 		"fusectl",
 		"hugetlbfs",
 		"mqueue",
@@ -323,6 +330,8 @@ int mnt_fstype_is_netfs(const char *type)
 	    strncmp(type,"nfs", 3) == 0 ||
 	    strcmp(type, "afs")    == 0 ||
 	    strcmp(type, "ncpfs")  == 0 ||
+	    strcmp(type, "fuse.curlftpfs") == 0 ||
+	    strcmp(type, "fuse.sshfs") == 0 ||
 	    strncmp(type,"9p", 2)  == 0)
 		return 1;
 	return 0;
-- 
2.20.1

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
