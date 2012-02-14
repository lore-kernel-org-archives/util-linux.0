Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbef.dreamhost.com ([208.97.132.145]:47944 "EHLO
	homiemail-a61.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1759682Ab2BNLNX (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Feb 2012 06:13:23 -0500
Subject: [PATCH 3/4] more: fix typos
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 14 Feb 2012 12:13:16 +0100
Message-ID: <1329217996.3269.7.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 text-utils/more.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index d68b40e..32eb765 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -303,7 +303,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	      "  -d        display help instead of ring bell\n"
               "  -f        count logical, rather than screen lines\n"
               "  -l        suppress pause after form feed\n"
-              "  -p        suppress scroll, clean screen and disblay text\n"
+              "  -p        suppress scroll, clean screen and display text\n"
               "  -c        suppress scroll, display text and clean line ends\n"
               "  -u        suppress underlining\n"
               "  -s        squeeze multiple blank lines into one\n"
-- 
1.7.4.1




