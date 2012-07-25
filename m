Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:63323 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751314Ab2GYTQA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:16:00 -0400
Received: by mail-we0-f174.google.com with SMTP id x8so794233wey.19
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:15:59 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/19] more: fix shadow declaration
Date: Wed, 25 Jul 2012 21:15:31 +0200
Message-Id: <1343243745-1172-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

text-utils/more.c:1123:13: warning: declaration of 'state' shadows a previous local [-Wshadow]
text-utils/more.c:1095:18: warning: shadowed declaration is here [-Wshadow]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 4cf090f..5e41a54 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1120,10 +1120,10 @@ void prbuf (register char *s, register int n)
 	    {
 		wchar_t wc;
 		size_t mblength;
-		mbstate_t state;
-		memset (&state, '\0', sizeof (mbstate_t));
+		mbstate_t mbstate;
+		memset (&mbstate, '\0', sizeof (mbstate_t));
 		s--; n++;
-		mblength = mbrtowc (&wc, s, n, &state);
+		mblength = mbrtowc (&wc, s, n, &mbstate);
 		if (mblength == (size_t) -2 || mblength == (size_t) -1)
 			mblength = 1;
 		while (mblength--)
-- 
1.7.11.3

