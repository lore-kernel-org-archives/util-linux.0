Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.187]:53425 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034Ab1KNBsb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Nov 2011 20:48:31 -0500
Message-ID: <4EC0736E.5000607@bernhard-voelker.de>
Date: Mon, 14 Nov 2011 02:48:30 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 08/15] prlimit: give better diagnostic for illegal hard limit
 case
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[PATCH 08/15] prlimit: give better diagnostic for illegal hard limit case

Give better diagnostic in cases where the user only specifies a new
hard limit, but when that is lower than the current hard limit.

Example:
$ prlimit -n -p7852 --noheadings
NOFILE   max amount of open files 1024 8192

Previous message:
$ prlimit -n:1000 -p7852
prlimit: the soft limit cannot exceed the ceiling value

New message:
$ prlimit -n:1000 -p7852
prlimit: current soft limit NOFILE is greater than new hard limit

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/prlimit.c |   11 +++++++++++
  1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 622a318..4124faa 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -313,6 +313,17 @@ static void get_unknown_hardsoft(struct prlimit *lim)
  			lim->rlim.rlim_cur = old.rlim_cur;
  		else if (!(lim->found & PRLIMIT_HARD))
  			lim->rlim.rlim_max = old.rlim_max;
+			
+		/* give better diagnostic in cases where the new hard limit
+		 * would be lower than the current soft limit, and the user
+		 * did not give a new soft limit.
+		 */
+		if (!(lim->found & PRLIMIT_SOFT) &&
+			(lim->rlim.rlim_cur > lim->rlim.rlim_max)) {
+			errx(EXIT_FAILURE,
+				_("current soft limit %s is greater than new hard limit"),
+				lim->desc->name);
+		}
  	}
  }

