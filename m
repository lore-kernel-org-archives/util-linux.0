Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:38499 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753105Ab2EQHhc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 May 2012 03:37:32 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 401428FA98
	for <util-linux@vger.kernel.org>; Thu, 17 May 2012 09:37:31 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] blkid: stop device probing if error is detected
Date: Thu, 17 May 2012 09:37:25 +0200
Message-Id: <1337240245-24300-1-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <20120516101346.GR8268@x2.net.home>
References: <20120516101346.GR8268@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

blkid -p dev1 dev2 [...] now stops upon first error detected and
returns correct value. Previously, if error was detected with dev1,
it continued with dev2 anyways and so the return value corresponded
to the last device only.

Reported-by: Bernhard Voelker <bernhard.voelker@siemens-enterprise.com>
Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/blkid.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 52b2a4b..25e6c00 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -868,11 +868,14 @@ int main(int argc, char **argv)
 				goto exit;
 		}
 
-		for (i = 0; i < numdev; i++)
+		for (i = 0; i < numdev; i++) {
 			err = lowprobe_device(pr, devices[i], lowprobe, show,
 					output_format,
 					(blkid_loff_t) offset,
 					(blkid_loff_t) size);
+			if (err)
+				break;
+		}
 		blkid_free_probe(pr);
 	} else if (eval) {
 		/*
-- 
1.7.7

