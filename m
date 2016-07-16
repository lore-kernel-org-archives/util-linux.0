Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.126.130]:65112 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751430AbcGPKvq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 16 Jul 2016 06:51:46 -0400
Date: Sat, 16 Jul 2016 12:51:42 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix previously adjusted segfault patch
Message-ID: <20160716105142.GA2436@localhost>
References: <20160710141407.GA26802@localhost>
 <20160714101215.ckr3tl22fmpcumwa@ws.net.home>
 <20160714192834.GA3861@localhost>
 <20160715111626.levjhzetw7cvldri@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160715111626.levjhzetw7cvldri@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Casting the value to be checked to size_t renders the check useless.
If st_size is SIZE_MAX+1, it will be truncated to 0 and the check
succeeds. In fact, this check can never be false because every value
stored in a size_t is smaller or equal to SIZE_MAX.

I think this adjustment was meant to fix a compiler warning for 64 bit
systems for which sizeof(off_t) is sizeof(size_t), but the signedness
differs.

Going unconditionally to the greatest possible unsigned int type if
st_size is positive (off_t is signed) will fix this issue.

Signed-off-by: Tobias Stoeckmann <tobias@stoeckmann.org>
---
This should be an easy fix without adding too much boiler-plate code.
Your macros also imply that every value would be allowed as upper limit,
but in fact it would have to be a 2^x-1 value, otherwise the bit pattern
check would turn out to be invalid.
---
 text-utils/tailf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index 6219aa2..5937f73 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -284,7 +284,7 @@ int main(int argc, char **argv)
 		errx(EXIT_FAILURE, _("%s: is not a file"), filename);
 
 	/* mmap is based on size_t */
-	if (st.st_size && (size_t) st.st_size <= SIZE_MAX)
+	if (st.st_size > 0 && (uintmax_t) st.st_size <= (uintmax_t) SIZE_MAX)
 		tailf(filename, lines, &st);
 
 #ifdef HAVE_INOTIFY_INIT
-- 
2.9.1

