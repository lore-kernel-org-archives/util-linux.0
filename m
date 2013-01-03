Return-Path: util-linux-owner@vger.kernel.org
Received: from mailserver5.natinst.com ([130.164.80.5]:48848 "EHLO
	spamkiller05.natinst.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751038Ab3ACGkA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 Jan 2013 01:40:00 -0500
Received: from mailserv59-us.natinst.com (nb-hsrp-1338.natinst.com [130.164.19.133])
	by spamkiller05.natinst.com (8.14.5/8.14.5) with ESMTP id r0365eRs001132
	for <util-linux@vger.kernel.org>; Thu, 3 Jan 2013 00:05:40 -0600
From: Richard Tollerton <rich.tollerton@ni.com>
To: util-linux@vger.kernel.org
Cc: Richard Tollerton <rich.tollerton@ni.com>
Subject: [PATCH] mount: Fix -t in listing mode when run as non-root
Date: Thu, 3 Jan 2013 00:05:34 -0600
Message-Id: <1357193134-26828-1-git-send-email-rich.tollerton@ni.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Presently, libmount-mount completely prohibits the use of -t by non-root
users.  This breaks using -t in listing mode as a user, which represents
a regression against mount-deprecated, macosx and presumably *BSD.

This commit fixes the issue by deferring the mnt_context_is_restricted
check for -t until we know we're not in listing mode.

Signed-off-by: Rich Tollerton <rich.tollerton@ni.com>
---
 sys-utils/mount.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index e29e34c..fed96eb 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -800,7 +800,7 @@ int main(int argc, char **argv)
 
 		/* only few options are allowed for non-root users */
 		if (mnt_context_is_restricted(cxt) &&
-		    !strchr("hlLUVvpris", c) &&
+		    !strchr("hlLUVvprist", c) &&
 		    c != MOUNT_OPT_TARGET &&
 		    c != MOUNT_OPT_SOURCE)
 			exit_non_root(option_to_longopt(c, longopts));
@@ -950,6 +950,11 @@ int main(int argc, char **argv)
 		goto done;
 	}
 
+	/* Non-root users are allowed to use -t to print_all(),
+	   but not to mount */
+	if (mnt_context_is_restricted(cxt) && types)
+		exit_non_root("types");
+
 	if (oper && (types || all || mnt_context_get_source(cxt)))
 		usage(stderr);
 
-- 
1.8.1

