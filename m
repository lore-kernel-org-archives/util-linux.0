Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03794C5519F
	for <util-linux@archiver.kernel.org>; Wed, 25 Nov 2020 09:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8199D206F9
	for <util-linux@archiver.kernel.org>; Wed, 25 Nov 2020 09:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7X+mKVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728834AbgKYJpY (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 25 Nov 2020 04:45:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29090 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728831AbgKYJpX (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 25 Nov 2020 04:45:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606297522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=G7gdVb1ZCNOSDe2dWXtYqEU/K7iYvavTZ6brjgE58uI=;
        b=L7X+mKVW/1CSR1+E06fhSeV3NdeLHflpgWkCnD37niljOHDaaWN4tA9Mug0+rTY57wcb2b
        EnX75SO64O8QyyFCaBR1x2H4mF1xFOrCtnp0TT+skb3zeXX6iXYRD+SRRP+4h5MkcRc+CT
        GG+zoztAxSho+fgnZVtNU85xXiY6Pko=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-zUVPjcA_OsCQIkUGUxJbKw-1; Wed, 25 Nov 2020 04:45:20 -0500
X-MC-Unique: zUVPjcA_OsCQIkUGUxJbKw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C37F6106F8F7
        for <util-linux@vger.kernel.org>; Wed, 25 Nov 2020 09:45:13 +0000 (UTC)
Received: from idlethread.redhat.com (unknown [10.40.193.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A5FD05D9C2
        for <util-linux@vger.kernel.org>; Wed, 25 Nov 2020 09:45:12 +0000 (UTC)
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] findmnt: add option to list all statvfs f_flags
Date:   Wed, 25 Nov 2020 10:45:11 +0100
Message-Id: <20201125094511.11225-1-rbergant@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

It might be useful for security auditing purposes list all possible
mount flags/options including default set which are normally not listed.

Given that we already call statvfs to retrieve i.e. filesystem size,
add an extra column to list all possible f_flags, default or not.

Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
---
 misc-utils/findmnt.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 43b4dc7d6..da9f42020 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -56,6 +56,7 @@ enum {
 	COL_FSTYPE,
 	COL_OPTIONS,
 	COL_VFS_OPTIONS,
+	COL_MNT_OPTIONS,
 	COL_FS_OPTIONS,
 	COL_LABEL,
 	COL_UUID,
@@ -101,6 +102,7 @@ static struct colinfo infos[] = {
 	[COL_FSTYPE]       = { "FSTYPE",       0.10, SCOLS_FL_TRUNC, N_("filesystem type") },
 	[COL_OPTIONS]      = { "OPTIONS",      0.10, SCOLS_FL_TRUNC, N_("all mount options") },
 	[COL_VFS_OPTIONS]  = { "VFS-OPTIONS",  0.20, SCOLS_FL_TRUNC, N_("VFS specific mount options") },
+	[COL_MNT_OPTIONS]  = { "MNT-OPTIONS",  0.20, SCOLS_FL_TRUNC, N_("All statvfs f_flags from mount") },
 	[COL_FS_OPTIONS]   = { "FS-OPTIONS",   0.10, SCOLS_FL_TRUNC, N_("FS specific mount options") },
 	[COL_LABEL]        = { "LABEL",        0.10, 0, N_("filesystem label") },
 	[COL_UUID]         = { "UUID",           36, 0, N_("filesystem UUID") },
@@ -490,6 +492,26 @@ static char *get_vfs_attr(struct libmnt_fs *fs, int sizetype)
 				(double)(buf.f_blocks - buf.f_bfree) /
 				buf.f_blocks * 100);
 		return sizestr;
+	case COL_MNT_OPTIONS:
+		if (mnt_fs_get_vfs_options(fs)) {
+			sizestr = xstrdup(mnt_fs_get_vfs_options(fs));
+			if (!(buf.f_flag & MS_NOEXEC))
+				mnt_optstr_append_option(&sizestr, "exec", NULL);
+			if (!(buf.f_flag & MS_NOSUID))
+				mnt_optstr_append_option(&sizestr, "suid", NULL);
+			if (!(buf.f_flag & MS_NODEV))
+				mnt_optstr_append_option(&sizestr, "dev", NULL);
+			if (!(buf.f_flag & MS_SYNCHRONOUS))
+				mnt_optstr_append_option(&sizestr, "async", NULL);
+			if (!(buf.f_flag & MS_MANDLOCK))
+				mnt_optstr_append_option(&sizestr, "nomand", NULL);
+			if (!(buf.f_flag & MS_NOATIME))
+				mnt_optstr_append_option(&sizestr, "atime", NULL);
+			if (!(buf.f_flag & MS_NODIRATIME))
+				mnt_optstr_append_option(&sizestr, "diratime", NULL);
+			return sizestr;
+		} else
+			return NULL;
 	}
 
 	if (!vfs_attr)
@@ -585,6 +607,7 @@ static char *get_data(struct libmnt_fs *fs, int num)
 	case COL_AVAIL:
 	case COL_USED:
 	case COL_USEPERC:
+	case COL_MNT_OPTIONS:
 		str = get_vfs_attr(fs, col_id);
 		break;
 	case COL_FSROOT:
-- 
2.21.0

