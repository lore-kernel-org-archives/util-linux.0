Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:60359 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752859Ab1KNBr7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Nov 2011 20:47:59 -0500
Message-ID: <4EC0734D.5000503@bernhard-voelker.de>
Date: Mon, 14 Nov 2011 02:47:57 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 01/15] prlimit: show all limits if called without options
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[PATCH 01/15] prlimit: show all limits if called without options

Fix option parsing: prlimit ran into usage() if called
without arguments which should only be done for surplus
arguments. Instead, it should display all limits.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  sys-utils/prlimit.c |    3 +--
  1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index d3f3503..fed4f38 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -581,8 +581,7 @@ int main(int argc, char **argv)
  			break;
  		}
  	}
-
-	if (argc == 1)
+	if (argc > optind)
  		usage(stderr);

  	if (!ncolumns) {
