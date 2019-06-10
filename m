Return-Path: <SRS0=Vuqk=UJ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5841C4321A
	for <util-linux@archiver.kernel.org>; Mon, 10 Jun 2019 19:59:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86772206E0
	for <util-linux@archiver.kernel.org>; Mon, 10 Jun 2019 19:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389193AbfFJT7U (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 10 Jun 2019 15:59:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:54930 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389170AbfFJT7T (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 10 Jun 2019 15:59:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DB807AF9C
        for <util-linux@vger.kernel.org>; Mon, 10 Jun 2019 19:59:17 +0000 (UTC)
To:     util-linux@vger.kernel.org
From:   Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 2/3] fstrim: properly de-duplicate fstrim -A
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
Message-ID: <c5a32bc2-f819-0245-c2d1-bf473cbff489@suse.cz>
Date:   Mon, 10 Jun 2019 21:59:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

fstab can contain tag based mounts. De-duplication by source has to be
done after resolving the full source path.

Perform the table iteration twice. First time, prepare for
de-duplication, second time perform the TRIM itself.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/fstrim.c | 43 ++++++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 13 deletions(-)

diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
index ff029015e..0491e2b54 100644
--- a/sys-utils/fstrim.c
+++ b/sys-utils/fstrim.c
@@ -241,10 +241,6 @@ static int fstrim_all(struct fstrim_control *ctl)
 	mnt_init_debug(0);
 	ul_path_init_debug();
 
-	itr = mnt_new_iter(MNT_ITER_BACKWARD);
-	if (!itr)
-		err(MNT_EX_FAIL, _("failed to initialize libmount iterator"));
-
 	if (ctl->fstab)
 		filename = mnt_get_fstab_path();
 
@@ -255,9 +251,6 @@ static int fstrim_all(struct fstrim_control *ctl)
 	/* de-duplicate by mountpoints */
 	mnt_table_uniq_fs(tab, 0, uniq_fs_target_cmp);
 
-	/* de-duplicate by source */
-	mnt_table_uniq_fs(tab, MNT_UNIQ_FORWARD, uniq_fs_source_cmp);
-
 	if (ctl->fstab) {
 		char *rootdev = NULL;
 
@@ -281,26 +274,50 @@ static int fstrim_all(struct fstrim_control *ctl)
 		}
 	}
 
+	itr = mnt_new_iter(MNT_ITER_BACKWARD);
+	if (!itr)
+		err(MNT_EX_FAIL, _("failed to initialize libmount iterator"));
+
 	while (mnt_table_next_fs(tab, itr, &fs) == 0) {
 		const char *src = mnt_fs_get_srcpath(fs),
 			   *tgt = mnt_fs_get_target(fs);
-		char *path;
-		int rc = 1;
 
-		if (!tgt || mnt_fs_is_pseudofs(fs) || mnt_fs_is_netfs(fs))
+		if (!tgt || mnt_fs_is_pseudofs(fs) || mnt_fs_is_netfs(fs)) {
+			mnt_table_remove_fs(tab, fs);
 			continue;
+		}
 
 		/* convert LABEL= (etc.) from fstab to paths */
 		if (!src && cache) {
 			const char *spec = mnt_fs_get_source(fs);
 
-			if (!spec)
+			if (!spec) {
+				mnt_table_remove_fs(tab, fs);
 				continue;
+			}
 			src = mnt_resolve_spec(spec, cache);
+			mnt_fs_set_source(fs, src);
 		}
 
-		if (!src || *src != '/')
+		if (!src || *src != '/') {
+			mnt_table_remove_fs(tab, fs);
 			continue;
+		}
+	}
+	mnt_free_iter(itr);
+
+	/* de-duplicate by source */
+	mnt_table_uniq_fs(tab, MNT_UNIQ_FORWARD, uniq_fs_source_cmp);
+
+	itr = mnt_new_iter(MNT_ITER_BACKWARD);
+	if (!itr)
+		err(MNT_EX_FAIL, _("failed to initialize libmount iterator"));
+
+	while (mnt_table_next_fs(tab, itr, &fs) == 0) {
+		const char *src = mnt_fs_get_srcpath(fs),
+			   *tgt = mnt_fs_get_target(fs);
+		char *path;
+		int rc = 1;
 
 		/* Is it really accessible mountpoint? Not all mountpoints are
 		 * accessible (maybe over mounted by another filesystem) */
@@ -329,10 +346,10 @@ static int fstrim_all(struct fstrim_control *ctl)
 		else if (rc == 1 && !ctl->quiet)
 			warnx(_("%s: the discard operation is not supported"), tgt);
 	}
+	mnt_free_iter(itr);
 
 	ul_unref_path(wholedisk);
 	mnt_unref_table(tab);
-	mnt_free_iter(itr);
 	mnt_unref_cache(cache);
 
 	if (cnt && cnt == cnt_err)
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
