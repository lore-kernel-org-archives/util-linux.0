Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:55295 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755086Ab1KNBsz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Nov 2011 20:48:55 -0500
Message-ID: <4EC07385.70101@bernhard-voelker.de>
Date: Mon, 14 Nov 2011 02:48:53 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 14/15] prlimit: avoid prlimit syscalls for limits unless to
 modify or to show
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[PATCH 14/15] prlimit: avoid prlimit syscalls for limits unless to 
modify or to show

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/prlimit.c |    2 ++
  1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 1d6dd92..69440a5 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -349,6 +349,8 @@ static void do_prlimit(struct prlimit lims[], int 
tt_flags)
  				errx(EXIT_FAILURE, _("the soft limit cannot exceed the ceiling 
value"));

  			new = &lims[i].rlim;
+		} else if (!(lims[i].show)) {
+			continue;
  		}

  		if (verbose && new) {
