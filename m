Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0A4EB64D7
	for <util-linux@archiver.kernel.org>; Sun, 18 Jun 2023 21:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjFRVa2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 18 Jun 2023 17:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRVa2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 18 Jun 2023 17:30:28 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 18 Jun 2023 14:30:26 PDT
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE1DAF
        for <util-linux@vger.kernel.org>; Sun, 18 Jun 2023 14:30:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 497251CDEE
        for <util-linux@vger.kernel.org>; Sun, 18 Jun 2023 17:29:23 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=sasl; bh=oSBy4e+D7eDwg9zRbJIfTXnUrgCZC2rPxRfCYgy1WIo=; b=w6O1
        ySdB5NJWo5hFNq2IxIzEyps4ZhJrS8/hTf1dTcue3QW+d75pUEfuIVvBI+xeVn+L
        iGvWhA/fp73ni+mYgEYDaDouiTfCFIFYfktYLW/6n+Do5jubhy0WSbIadJFWxnst
        8XPO+xrGHMsP7oczvEnOnQhJ+3x6EZoi98hDN1I=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 43C361CDED
        for <util-linux@vger.kernel.org>; Sun, 18 Jun 2023 17:29:23 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from morphine.paradise.teonanacatl.net (unknown [47.204.171.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6131D1CDEC
        for <util-linux@vger.kernel.org>; Sun, 18 Jun 2023 17:29:19 -0400 (EDT)
        (envelope-from tmz@pobox.com)
From:   Todd Zullinger <tmz@pobox.com>
To:     util-linux@vger.kernel.org
Subject: [PATCH] sys-utils: fix SELinux context example in mount.8
Date:   Sun, 18 Jun 2023 17:29:11 -0400
Message-ID: <20230618212911.549645-1-tmz@pobox.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Pobox-Relay-ID: 2F48EA80-0E1F-11EE-9D83-B31D44D1D7AA-09356542!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

In the description of the context option, the example which shows how to
properly quote is displayed incorrectly on terminals > 80 columns.  This
leaves a seemingly needless '\' in the command, e.g.:

    mount -t tmpfs none /mnt -o \ 'context=3D"system_u:...'

The intent is to display the command properly on terminals <=3D 80
columns.  Use a literal block to ensure the code is displayed
consistently, regardless of the terminal width.

Connect the blockquote to the previous indented items in the context
option description to ensure it is properly indented.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
 sys-utils/mount.8.adoc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index bb2e4c911..efff26cfd 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -521,9 +521,12 @@ The *rootcontext=3D* option allows you to explicitly=
 label the root inode of a FS
 Note that the kernel rejects any remount request that includes the conte=
xt option, *even* when unchanged from the current context.
 +
 *Warning: the* _context_ *value might contain commas*, in which case the=
 value has to be properly quoted, otherwise *mount* will interpret the co=
mma as a separator between mount options. Don't forget that the shell str=
ips off quotes and thus *double quoting is required*. For example:
++
 ____
+....
 mount -t tmpfs none /mnt -o \
 'context=3D"system_u:object_r:tmp_t:s0:c127,c456",noexec'
+....
 ____
=20
 For more details, see *selinux*(8).
--=20
2.41.0

