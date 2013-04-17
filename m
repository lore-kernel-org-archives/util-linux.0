Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-gg0-f170.google.com ([209.85.161.170]:44956 "EHLO
	mail-gg0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936189Ab3DQC7w (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Apr 2013 22:59:52 -0400
Received: by mail-gg0-f170.google.com with SMTP id k4so192941ggn.1
        for <util-linux@vger.kernel.org>; Tue, 16 Apr 2013 19:59:51 -0700 (PDT)
Message-ID: <516E1024.6090101@gmail.com>
Date: Tue, 16 Apr 2013 21:59:48 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH 1/1] Remove invalid compiler warning
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I'm not that familiar with git, but this patch is really small.
Remove an irritating compiler warning in two programs.

   -- Bruce Dubbs

--- util-linux-2.23-rc2.orig/text-utils/Makemodule.am   2013-03-11 
05:20:39.424933506 -0500
+++ util-linux-2.23-rc2/text-utils/Makemodule.am        2013-04-16 
21:54:21.595291067 -0500
@@ -53,6 +53,7 @@
  usrbin_exec_PROGRAMS += pg
  dist_man_MANS += text-utils/pg.1
  pg_SOURCES = text-utils/pg.c
+pg_CFLAGS = -Wno-clobbered
  pg_LDADD = $(LDADD) libcommon.la @NCURSES_LIBS@
  if HAVE_TINFO
  pg_LDADD += -ltinfo
@@ -77,6 +78,7 @@
  bin_PROGRAMS += more
  dist_man_MANS += text-utils/more.1
  more_SOURCES = text-utils/more.c
+more_CFLAGS = -Wno-clobbered
  more_LDADD = $(LDADD)
  if HAVE_TINFO
  more_LDADD += -ltinfo
