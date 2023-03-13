Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FBBC6FD19
	for <util-linux@archiver.kernel.org>; Mon, 13 Mar 2023 01:50:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjCMBuH (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 12 Mar 2023 21:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCMBuG (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 12 Mar 2023 21:50:06 -0400
X-Greylist: delayed 421 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Mar 2023 18:50:04 PDT
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35D5C231CA
        for <util-linux@vger.kernel.org>; Sun, 12 Mar 2023 18:50:04 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 7DD2A100265
        for <util-linux@vger.kernel.org>; Mon, 13 Mar 2023 12:43:02 +1100 (AEDT)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GY8hAE57W0ce for <util-linux@vger.kernel.org>;
        Mon, 13 Mar 2023 12:43:02 +1100 (AEDT)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 6DE1F100381; Mon, 13 Mar 2023 12:43:02 +1100 (AEDT)
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id E791910024C;
        Mon, 13 Mar 2023 12:43:01 +1100 (AEDT)
Subject: [PATCH 2/2] mount: ignore autofs entries in mount listing
From:   Ian Kent <raven@themaw.net>
To:     util-linux <util-linux@vger.kernel.org>
Cc:     fhirtz@redhat.com, John Westerdale <jwesterd@redhat.com>,
        Frank Sorenson <fsorenso@redhat.com>
Date:   Mon, 13 Mar 2023 09:43:02 +0800
Message-ID: <167867178240.35511.8758222247656534818.stgit@donald.themaw.net>
In-Reply-To: <167867177635.35511.15003989525678735907.stgit@donald.themaw.net>
References: <167867177635.35511.15003989525678735907.stgit@donald.themaw.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Since we can't enable use of ignoring autofs mounts that have the
"ignore" option present by default (systemd could get confused) it's
necessary to enable it for individual applications.

The mount utility is one applcation we need it for so enable it.

Signed-off-by: Ian Kent <raven@themaw.net>
Cc: John Westerdale <jwesterd@redhat.com>
Cc: Frank Hertz <fhirtz@redhat.com>
Cc: Frank Sorenson <fsorenso@redhat.com>
---
 sys-utils/mount.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 6590272c7..dba6fcae9 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -124,6 +124,8 @@ static void print_all(struct libmnt_context *cxt, char *pattern, int show_label)
 	struct libmnt_fs *fs;
 	struct libmnt_cache *cache = NULL;
 
+	mnt_context_enable_noautofs(cxt, 1);
+
 	if (mnt_context_get_mtab(cxt, &tb))
 		err(MNT_EX_SYSERR, _("failed to read mtab"));
 


