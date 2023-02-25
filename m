Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23B93C64EC7
	for <util-linux@archiver.kernel.org>; Sat, 25 Feb 2023 11:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjBYLvA (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 25 Feb 2023 06:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBYLu7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 25 Feb 2023 06:50:59 -0500
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 25 Feb 2023 03:50:57 PST
Received: from magnesium.8pit.net (magnesium.8pit.net [45.76.88.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B536B770;
        Sat, 25 Feb 2023 03:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=opensmtpd; bh=PXEyRBv+Ow
        09jdb+rKfmekx2qk181Czs2Z2YogL+1w0=; h=date:subject:to:from;
        d=soeren-tempel.net; b=S2PmbLB6RZD1oCs+cGRipnrqsg0KF1OYOhdabiVlE2nspvY
        D/60erAvmc0Ln/FLNGeow0vuydENfnmkQKHm0KxbXVAO3KlEn92GrBe7XDG0jsS0Xxpv1z
        l5ZZhYWYyY6my54VgDL8L/2d6wWotAc5NX0XXw2mDigJkjKwRdO3IY=
Received: from localhost (<unknown> [2a02:8109:3b40:22d0:4f69:d3b1:cd02:7bd3])
        by magnesium.8pit.net (OpenSMTPD) with ESMTPSA id 9aee3696 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:YES);
        Sat, 25 Feb 2023 12:44:14 +0100 (CET)
From:   soeren@soeren-tempel.net
To:     util-linux@vger.kernel.org
Subject: [PATCH] libmount: Fix access to uninitialised value in mnt_optstr_locate_option
Date:   Sat, 25 Feb 2023 12:43:52 +0100
Message-Id: <20230225114352.9151-1-soeren@soeren-tempel.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Sören Tempel <soeren@soeren-tempel.net>

Consider the following libmount example program:

	#include <libmount.h>

	int
	main(void)
	{
		mnt_match_options("", "+");
		return 0;
	}

Compiling this program and executing it with valgrind(1) will yield
the following warning regarding a conditional jump depending on an
uninitialised value:

	Conditional jump or move depends on uninitialised value(s)
	   at 0x48AA61B: strlen (in /usr/libexec/valgrind/vgpreload_memcheck-amd64-linux.so)
	   by 0x48C6154: ??? (in /lib/libmount.so.1.1.0)
	   by 0x48C65A0: mnt_optstr_get_option (in /lib/libmount.so.1.1.0)
	   by 0x48C7B85: mnt_match_options (in /lib/libmount.so.1.1.0)
	   by 0x1091C1: main (util-linux-test.c:6)

This is because if name == "+" then we advance to the null byte
in name due to the following code in mnt_match_options():

	if (*name == '+')
		name++, namesz--;

This will cause the `xstrncpy(buf, name, namesz + 1)` invocation in
mnt_match_options() to copy nothing to the destination buffer. The
buffer (buf) is therefore passed uninitialized as the name argument
to mnt_optstr_get_option(). When mnt_optstr_locate_option() (which
is called by mnt_optstr_get_option) attempts to determine the
length of the name argument using strlen(3) then everything blows
up because the name argument is not initialized.

This patch fixes this issue by initializing the buf argument in
mnt_match_options() with NULL before calling xstrncpy thereby
ensuring that buf is /always/ initialized even if xstrncpy
returns without copying any data to the destination buffer
due to the following early return in xstrncpy:

	size_t len = src ? strlen(src) : 0;
	if (!len)
		return;

This issue has been discovered using KLEE <https://klee.github.io/>.

Signed-off-by: Sören Tempel <soeren@soeren-tempel.net>
---
 libmount/src/optstr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libmount/src/optstr.c b/libmount/src/optstr.c
index a8b56e212..ae3efc78b 100644
--- a/libmount/src/optstr.c
+++ b/libmount/src/optstr.c
@@ -853,6 +853,7 @@ int mnt_match_options(const char *optstr, const char *pattern)
 		else if ((no = (startswith(name, "no") != NULL)))
 			name += 2, namesz -= 2;
 
+		buf = NULL; /* ensure buf is initialized even if name == "" */
 		xstrncpy(buf, name, namesz + 1);
 
 		rc = mnt_optstr_get_option(optstr, buf, &val, &sz);
