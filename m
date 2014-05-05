Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:48103 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751473AbaEEStu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 May 2014 14:49:50 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id D4422AAF1
	for <util-linux@vger.kernel.org>; Mon,  5 May 2014 18:49:49 +0000 (UTC)
Message-ID: <1399315789.11780.40.camel@oct.suse.cz>
Subject: [PATCH 2/2] hwclock: Check drift value in /etc/adjtime
From: Stanislav Brabec <sbrabec@suse.cz>
To: util-linux@vger.kernel.org
Date: Mon, 05 May 2014 20:49:49 +0200
Content-Type: text/plain; charset="ISO-8859-2"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Due to bug in older versions of hwclock, /etc/adjtime can contain
excessive drift value (up to many years per day). Prevent it
from applying.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 sys-utils/hwclock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 5e786a8..fe97fcb 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1211,6 +1211,10 @@ do_adjustment(struct adjtime *adjtime_p,
 			printf(_
 			       ("Not setting clock because last adjustment time is zero, "
 				"so history is bad."));
+	} else if (abs(adjtime_p->drift_factor) > MAX_DRIFT) {
+		if (debug)
+		printf(_("Not setting clock because drift factor %f is far too high.\n"),
+		       adjtime_p->drift_factor);
 	} else {
 		int adjustment;
 		/* Number of seconds we must insert in the Hardware Clock */
-- 
1.8.4.5

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                          e-mail: sbrabec@suse.cz
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76

