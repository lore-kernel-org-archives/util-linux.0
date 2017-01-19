Return-Path: util-linux-owner@vger.kernel.org
Received: from mx.datacom.ind.br ([177.66.5.10]:44526 "EHLO
        mail.datacom.ind.br" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751898AbdASUEA (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 19 Jan 2017 15:04:00 -0500
From: Carlos Santos <casantos@datacom.ind.br>
To: util-linux@vger.kernel.org
Subject: [PATCH] Fix compilation with ncurses and uClibc or musl libc
Date: Thu, 19 Jan 2017 17:27:37 -0200
Message-Id: <1484854057-2506-1-git-send-email-casantos@datacom.ind.br>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Compiling util-linux with musl and uClibc-ng toolchains when wide-char
support is not enabled in ncurses results in compilation failures with
the following message:

    error: two or more data types in declaration specifiers
    #define
     wchar_t char

The problem occurs because util-linux #defines its own wchar_t (as char)
when configured without widechar support. This conflicts with definition
of wchar_t contained in stddef.h.

This error can be reproduced running "<toolchain-cc -o test test.c" with
the following test program:

    #include <ctype.h>
    #define wchar_t char
    #include <stddef.h>

    int main()
    {
        return 0;
    }

The only way to avoid the problem it to reorder the inclusion of headers
in some files under the text-utils directory.

Addresses:
  http://autobuild.buildroot.net/results/3a2f228e0fa7b5cc28a13d49f48f1a6aef8d9d7a
  http://autobuild.buildroot.net/results/99e96069f652d511c6212a5bb6be29e68fb1747c
  http://autobuild.buildroot.net/results/2dc5721aef93b7b410153bafad78248fac3db941
  http://autobuild.buildroot.net/results/8a9e197ba7a292b18f8c0c36dca974685556a38a

Signed-off-by: Carlos Santos <casantos@datacom.ind.br>
---
 text-utils/colcrt.c | 2 +-
 text-utils/colrm.c  | 2 +-
 text-utils/column.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/text-utils/colcrt.c b/text-utils/colcrt.c
index 62f8425..f376350 100644
--- a/text-utils/colcrt.c
+++ b/text-utils/colcrt.c
@@ -46,8 +46,8 @@
 #include <getopt.h>
 
 #include "nls.h"
-#include "widechar.h"
 #include "c.h"
+#include "widechar.h"
 #include "closestream.h"
 
 /*
diff --git a/text-utils/colrm.c b/text-utils/colrm.c
index 431eae0..e799cd1 100644
--- a/text-utils/colrm.c
+++ b/text-utils/colrm.c
@@ -44,9 +44,9 @@
 #include <unistd.h>
 
 #include "nls.h"
-#include "widechar.h"
 #include "strutils.h"
 #include "c.h"
+#include "widechar.h"
 #include "closestream.h"
 
 /*
diff --git a/text-utils/column.c b/text-utils/column.c
index b8d31c9..e0144a2 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -50,8 +50,8 @@
 #include <getopt.h>
 
 #include "nls.h"
-#include "widechar.h"
 #include "c.h"
+#include "widechar.h"
 #include "xalloc.h"
 #include "strutils.h"
 #include "closestream.h"
-- 
2.7.4

