Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.kundenserver.de ([212.227.17.13]:53294 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbcJCUFT (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 3 Oct 2016 16:05:19 -0400
Received: from localhost ([79.234.34.66]) by mrelayeu.kundenserver.de
 (mreue104) with ESMTPSA (Nemesis) id 0M7Jry-1awQQT0qOs-00x10F for
 <util-linux@vger.kernel.org>; Mon, 03 Oct 2016 22:05:11 +0200
Date: Mon, 3 Oct 2016 22:06:23 +0200
From: Tobias Stoeckmann <tobias@stoeckmann.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] rev: Avoid out of boundary read
Message-ID: <20161003200623.GC2287@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Check if the length of the parsed string is at least 1,
otherwise an out of boundary read would occur.
---
 text-utils/rev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/text-utils/rev.c b/text-utils/rev.c
index ace2cd6..735aaef 100644
--- a/text-utils/rev.c
+++ b/text-utils/rev.c
@@ -149,6 +149,9 @@ int main(int argc, char *argv[])
 		while (fgetws(buf, bufsiz, fp)) {
 			len = wcslen(buf);
 
+			if (len == 0)
+				continue;
+
 			/* This is my hack from setpwnam.c -janl */
 			while (buf[len-1] != '\n' && !feof(fp)) {
 				/* Extend input buffer if it failed getting the whole line */
-- 
2.10.0

