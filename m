Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC809C63697
	for <util-linux@archiver.kernel.org>; Tue, 17 Nov 2020 20:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69EB122202
	for <util-linux@archiver.kernel.org>; Tue, 17 Nov 2020 20:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgKQU0o (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 17 Nov 2020 15:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKQU02 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 17 Nov 2020 15:26:28 -0500
X-Greylist: delayed 364 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Nov 2020 12:26:28 PST
Received: from hera.aquilenet.fr (hera.aquilenet.fr [IPv6:2a0c:e300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4D4C0613CF
        for <util-linux@vger.kernel.org>; Tue, 17 Nov 2020 12:26:28 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 7C8B0F60;
        Tue, 17 Nov 2020 21:20:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g7fJ_N3m-bbM; Tue, 17 Nov 2020 21:20:18 +0100 (CET)
Received: from function.youpi.perso.aquilenet.fr (unknown [IPv6:2a01:cb19:956:1b00:9eb6:d0ff:fe88:c3c7])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 6BAB8ED7;
        Tue, 17 Nov 2020 21:20:18 +0100 (CET)
Received: from samy by function.youpi.perso.aquilenet.fr with local (Exim 4.94)
        (envelope-from <samuel.thibault@ens-lyon.org>)
        id 1kf7Sb-000KbX-DS; Tue, 17 Nov 2020 21:20:17 +0100
Date:   Tue, 17 Nov 2020 21:20:17 +0100
From:   Samuel Thibault <samuel.thibault@ens-lyon.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: Fix building util-linux on non-linux
Message-ID: <20201117202017.afatx2kpuxp5kf7u@function>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="tv7riqct6hszn43v"
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--tv7riqct6hszn43v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

The attached patch fixes building on non-linux

Samuel

--tv7riqct6hszn43v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index 4f52cea3c..8bc3ee37e 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -31,8 +31,10 @@ dist_man_MANS += login-utils/sulogin.8
 sulogin_SOURCES = \
 	login-utils/sulogin.c \
 	login-utils/sulogin-consoles.c \
-	login-utils/sulogin-consoles.h \
-	lib/plymouth-ctrl.c
+	login-utils/sulogin-consoles.h
+if USE_PLYMOUTH_SUPPORT
+sulogin_SOURCES += lib/plymouth-ctrl.c
+endif
 sulogin_LDADD = $(LDADD) libcommon.la
 
 if HAVE_LIBCRYPT
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 1f7ef3317..db448687d 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -678,7 +678,7 @@ display_time(struct timeval hwctime)
 #ifndef SYS_settimeofday
 # ifdef __NR_settimeofday
 #  define SYS_settimeofday	__NR_settimeofday
-# else
+# elif defined(__NR_settimeofday_time32)
 #  define SYS_settimeofday	__NR_settimeofday_time32
 # endif
 #endif
diff --git a/term-utils/Makemodule.am b/term-utils/Makemodule.am
index 92df7dbc8..c424dbdf8 100644
--- a/term-utils/Makemodule.am
+++ b/term-utils/Makemodule.am
@@ -42,8 +42,10 @@ endif # BUILD_SCRIPTLIVE
 if BUILD_AGETTY
 sbin_PROGRAMS += agetty
 dist_man_MANS += term-utils/agetty.8
-agetty_SOURCES = term-utils/agetty.c \
-		 lib/plymouth-ctrl.c
+agetty_SOURCES = term-utils/agetty.c
+if USE_PLYMOUTH_SUPPORT
+agetty_SOURCES += lib/plymouth-ctrl.c
+endif
 agetty_LDADD = $(LDADD) libcommon.la
 if BSD
 agetty_LDADD += -lutil

--tv7riqct6hszn43v--
