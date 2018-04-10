Return-Path: util-linux-owner@vger.kernel.org
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:55521 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753446AbeDJMgm (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Tue, 10 Apr 2018 08:36:42 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7490820F57
        for <util-linux@vger.kernel.org>; Tue, 10 Apr 2018 08:36:41 -0400 (EDT)
Received: from apu2 (x4e37ce4a.dyn.telefonica.de [78.55.206.74])
        by mail.messagingengine.com (Postfix) with ESMTPA id A115B10401
        for <util-linux@vger.kernel.org>; Tue, 10 Apr 2018 08:36:40 -0400 (EDT)
From: Patrick Steinhardt <ps@pks.im>
To: util-linux@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/2] cfdisk: fix missing prototype for `get_wch`
Date: Tue, 10 Apr 2018 13:36:31 +0100
Message-Id: <b96441d34412526f7d55da793c6bb2dd05f152c2.1523363782.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The header <ncursesw/ncurses.h> defines the get_wch(3) function only
when `NCURSES_WIDECHAR` is defined. This define is actually getting set
in the same header file, but only in case `_XOPEN_SOURCE` is defined and
has a value of 500 or higher. As we already have the precedence of
defining `_XOPEN_SOURCE` to a value of 600 in some other files, simply
define it to the minimum required value of 500 in "cfdisk.c". This
silences a warning for `get_wch` being unknown.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 disk-utils/cfdisk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 806bff837..8f590387f 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -33,6 +33,10 @@
 # include <slang/slang.h>
 #endif
 
+#ifndef _XOPEN_SOURCE
+# define _XOPEN_SOURCE 500 /* for inclusion of get_wch */
+#endif
+
 #ifdef HAVE_SLCURSES_H
 # include <slcurses.h>
 #elif defined(HAVE_SLANG_SLCURSES_H)
-- 
2.17.0

