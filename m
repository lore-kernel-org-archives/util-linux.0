Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:40968 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617AbaIQJAS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 17 Sep 2014 05:00:18 -0400
Date: Wed, 17 Sep 2014 11:00:10 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] Patches for kFreeBSD support from Debian
Message-ID: <20140917090010.GI7867@x2.net.home>
References: <1408896284-14467-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1408896284-14467-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 24, 2014 at 06:04:40PM +0200, Andreas Henriksson wrote:
> This is the patch set that has been shipping since forever
> in Debian (minus the last one from me, which is new).

 Applied, thanks.

> Christoph Egger (1):
>   Fixing FTBFS on !linux (Debian util-linux 2.20.1-1.2)

 -lutil everywhere seems like overkill as login_tty() is probably 
 necessary for BSD only, so I have applied the patch below too.

    Karel


commit 8026fa9bc7525c4cef02c17099e2db79284078f8
Author: Karel Zak <kzak@redhat.com>
Date:   Wed Sep 17 10:56:46 2014 +0200

    build-sys: use -lutil for BSD only
    
    Signed-off-by: Karel Zak <kzak@redhat.com>

diff --git a/configure.ac b/configure.ac
index 5b558ec..387372f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -136,9 +136,17 @@ PKG_PROG_PKG_CONFIG
 GTK_DOC_CHECK([1.10])
 AC_PATH_PROG([XSLTPROC], [xsltproc])
 
+
 linux_os=no
-AS_CASE([${host_os}], [*linux*], [linux_os=yes])
+bsd_os=no
+AS_CASE([${host_os}],
+  [*linux*],
+     [linux_os=yes],
+  [*bsd*],
+     [bsd_os=yes])
 AM_CONDITIONAL([LINUX], [test "x$linux_os" = xyes])
+AM_CONDITIONAL([BSD], [test "x$bsd_os" = xyes])
+
 
 dnl define ARCH_<NAME> conditionals
 UL_SET_ARCH([I86], [i?86-*])
diff --git a/term-utils/Makemodule.am b/term-utils/Makemodule.am
index 627aca0..e7ac707 100644
--- a/term-utils/Makemodule.am
+++ b/term-utils/Makemodule.am
@@ -23,7 +23,9 @@ sbin_PROGRAMS += agetty
 dist_man_MANS += term-utils/agetty.8
 agetty_SOURCES = term-utils/agetty.c
 agetty_LDADD = $(LDADD) libcommon.la
+if BSD
 agetty_LDADD += -lutil
+endif
 endif # BUILD_AGETTY
 
 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
