Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34628 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614AbcDPSeR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Apr 2016 14:34:17 -0400
Received: by mail-wm0-f67.google.com with SMTP id n3so14007251wmn.1
        for <util-linux@vger.kernel.org>; Sat, 16 Apr 2016 11:34:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 6/7] dmesg: --notime should not suppress --show-delta
Date: Sat, 16 Apr 2016 19:34:08 +0100
Message-Id: <1460831649-11484-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1460831649-11484-1-git-send-email-kerolasa@iki.fi>
References: <1460831649-11484-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The --show-delta is off by default, which means it can be only on when user
has requested to see these time stamps.  The --notime option should not turn
the delta outputing off, because then option order matters and no-one wants
that.  Example of the old output:

$ dmesg --notime --show-delta | sed -n 's/ version.*//p; q'
[<    0.000000>] Linux
$ dmesg --show-delta --notime | sed -n 's/ version.*//p; q'
Linux

Addresses: https://bugs.launchpad.net/bugs/1544595
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 99cf26e..cf93331 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -1363,7 +1363,6 @@ int main(int argc, char *argv[])
 			break;
 		case 't':
 			ctl.time_fmt = DMESG_TIMEFTM_NONE;
-			delta = 0;
 			break;
 		case 'u':
 			ctl.fltr_fac = 1;
-- 
2.8.0

