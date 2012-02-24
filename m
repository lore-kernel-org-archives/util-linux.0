Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:57442 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753041Ab2BXKvy (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Feb 2012 05:51:54 -0500
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id C38DC8FC92
	for <util-linux@vger.kernel.org>; Fri, 24 Feb 2012 11:51:53 +0100 (CET)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] losetup.8: add --detach-all to the list of options
Date: Fri, 24 Feb 2012 11:51:53 +0100
Message-Id: <1330080713-14987-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 sys-utils/losetup.8 |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sys-utils/losetup.8 b/sys-utils/losetup.8
index a68836e..f50b072 100644
--- a/sys-utils/losetup.8
+++ b/sys-utils/losetup.8
@@ -80,6 +80,8 @@ for non-root users.
 force loop driver to reread size of the file associated with the specified loop device
 .IP "\fB\-d, \-\-detach\fP \fIloopdev\fP..."
 detach the file or device associated with the specified loop device(s)
+.IP "\fB\-D, \-\-detach-all\fP"
+detach all associated loop devices
 .IP "\fB\-e, \-E, \-\-encryption \fIencryption_type\fP"
 enable data encryption with specified name or number
 .IP "\fB\-f, \-\-find\fP"
-- 
1.7.7

