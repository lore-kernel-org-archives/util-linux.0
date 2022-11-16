Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F32AC433FE
	for <util-linux@archiver.kernel.org>; Wed, 16 Nov 2022 02:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230438AbiKPCA6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 15 Nov 2022 21:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiKPCA4 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 15 Nov 2022 21:00:56 -0500
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [121.200.0.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F982B60F
        for <util-linux@vger.kernel.org>; Tue, 15 Nov 2022 18:00:55 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id E5D521003C0
        for <util-linux@vger.kernel.org>; Wed, 16 Nov 2022 13:00:51 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VMCx-2cdQZ4p for <util-linux@vger.kernel.org>;
        Wed, 16 Nov 2022 13:00:51 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id DBBE21003E4; Wed, 16 Nov 2022 13:00:51 +1100 (AEDT)
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 82819100308;
        Wed, 16 Nov 2022 13:00:51 +1100 (AEDT)
Subject: [PATCH 2/2] mount: ignore autofs entries in mount listing
From:   Ian Kent <raven@themaw.net>
To:     util-linux <util-linux@vger.kernel.org>
Cc:     Karel Zak <kzak@redhat.com>, John Westerdale <jwesterd@redhat.com>,
        fhirtz@redhat.com
Date:   Wed, 16 Nov 2022 10:00:51 +0800
Message-ID: <166856405124.472741.12325323586804137946.stgit@donald.themaw.net>
In-Reply-To: <166856374641.472741.1779154765995171105.stgit@donald.themaw.net>
References: <166856374641.472741.1779154765995171105.stgit@donald.themaw.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Use the autofs mount option hint to ignore autofs mount table entries.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 sys-utils/mount.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 283998f3b..29fda6b05 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -124,6 +124,8 @@ static void print_all(struct libmnt_context *cxt, char *pattern, int show_label)
 	struct libmnt_fs *fs;
 	struct libmnt_cache *cache = NULL;
 
+	mnt_context_enable_ignore_autofs(cxt);
+
 	if (mnt_context_get_mtab(cxt, &tb))
 		err(MNT_EX_SYSERR, _("failed to read mtab"));
 


