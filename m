Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f174.google.com ([209.85.192.174]:40187 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753267AbaICDjw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Sep 2014 23:39:52 -0400
Received: by mail-pd0-f174.google.com with SMTP id ft15so10156895pdb.33
        for <util-linux@vger.kernel.org>; Tue, 02 Sep 2014 20:39:51 -0700 (PDT)
From: Michael Marineau <michael.marineau@coreos.com>
To: util-linux@vger.kernel.org
Cc: Michael Marineau <michael.marineau@coreos.com>
Subject: [PATCH] build-sys: create parent directory for $(PATHFILES)
Date: Tue,  2 Sep 2014 20:39:28 -0700
Message-Id: <1409715568-24476-1-git-send-email-michael.marineau@coreos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When building outside the source tree there is nothing to guarantee the
target directory exists before writing to it. Most of the time this just
happens to work because something else creates the directory but not
always. For example:

    $ mkdir build
    $ cd build
    $ ../configure --disable-dependency-tracking
    $ make libuuid/uuid.pc
      GEN      libuuid/uuid.pc
    /bin/sh: line 2: libuuid/uuid.pc.tmp: No such file or directory
    make: *** [libuuid/uuid.pc] Error 1
---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index 79b5aea..08269e2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -128,6 +128,7 @@ EXTRA_DIST += $(PATHFILES:=.in)
 
 $(PATHFILES): Makefile
 	@ rm -f $@ $@.tmp
+	$(AM_V_at) test -d $(dir $@) || mkdir -p $(dir $@)
 	$(AM_V_GEN) srcdir=''; \
 		test -f ./$@.in || srcdir=$(srcdir)/; \
 		$(edit_cmd) $${srcdir}$@.in >$@.tmp
-- 
1.8.5.5

