Return-Path: <SRS0=Vkmh=UX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC29C43613
	for <util-linux@archiver.kernel.org>; Mon, 24 Jun 2019 02:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC358204FD
	for <util-linux@archiver.kernel.org>; Mon, 24 Jun 2019 02:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5t0yaqc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfFXCol (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 23 Jun 2019 22:44:41 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:32947 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfFXCok (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 23 Jun 2019 22:44:40 -0400
Received: by mail-qk1-f194.google.com with SMTP id r6so8690441qkc.0
        for <util-linux@vger.kernel.org>; Sun, 23 Jun 2019 19:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mvlqzzKBKA+mFQpgfFjJZkTs7wdTgfMlUvjLUDnnFBg=;
        b=b5t0yaqcc5YKRi25MilKqMSknReP3YyoD/TPsUost+7+w8mo/gL3/KM0atsuWMrptJ
         FgTqvvsLb8XD+x4l+CsjHxUNWL5YFIniiPBOYDn/3gguge0Oq6aXp4PzGlee4VduZRaZ
         GueRvKAY4+H3Teyb13y6novUOJ+P0uJn1JSX2XtzqDHOZa6IHtsOMPJrRitc8GyyYlWR
         AwYsF05C5DCptq9bTynwT62miOVM4qo8FW57Ygp7bnPphWfuoEkCSzCmKKP253hVmEWx
         bopCSmevfIAzgddm7iBoFwNJs0XbtSidae7JP7DdK0SPBH2O2d2PuJ+yGquDMt+y4pR0
         4sVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mvlqzzKBKA+mFQpgfFjJZkTs7wdTgfMlUvjLUDnnFBg=;
        b=sRmvTKemZpUSskYjWkRyozS1hl7uGvRbqGteZRDwAfldKTMwYiSCCZR3hQtOvOzi+u
         zji5H/bbNqIjdrw+nZTvLQhEYO4sUAtTM7/zT2B8IUbHuZ/TEfDesq9zFYeSfjb5QD3J
         +MgnTZ9BnaLY9EJIBiD/hRfCSPGMhXL47L1KsLhxUGW6Rbr3Jn+vxIjqHmq5zsk2wVmV
         rEFMvI9+033BdEELdi8lt70fcX9FattDcHavaFRlzdvk4HD9zvXrj26p48ruhM7tQsc7
         56rd4vOXvEYvkRYvG9C6yqemJ6CVlFeAlRU1+nURR71tT3H+29IcsVsymoDUAu4jpIsy
         WQnA==
X-Gm-Message-State: APjAAAXtPiw9mCEedz1+du7kgBPXroK9i2krIy56EPoR8jZdrEst+WuZ
        2QK1llVGziv9uluzYldDe996dExByqc=
X-Google-Smtp-Source: APXvYqx/UgtF531xPlOcs0bbbqIkDXaBGfKY+5kDJiFLSTHjPseMyVC9so9P4LPXxVJrDz7O1VFpqA==
X-Received: by 2002:a37:7147:: with SMTP id m68mr15363270qkc.475.1561329063922;
        Sun, 23 Jun 2019 15:31:03 -0700 (PDT)
Received: from casantos.remote.csb (189-71-198-232.user.veloxzone.com.br. [189.71.198.232])
        by smtp.gmail.com with ESMTPSA id e63sm4844534qkd.57.2019.06.23.15.31.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 15:31:03 -0700 (PDT)
From:   unixmania@gmail.com
To:     util-linux@vger.kernel.org
Cc:     Carlos Santos <unixmania@gmail.com>
Subject: [PATCH v2] hwclock: define cmos_interface only if necessary
Date:   Sun, 23 Jun 2019 19:30:52 -0300
Message-Id: <20190623223052.3345-1-unixmania@gmail.com>
X-Mailer: git-send-email 2.18.1
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Carlos Santos <unixmania@gmail.com>

Make the static declaration of the cmos_interface struct and related
functions conditional to i386/x86_64, preventing several "defined but
not used" compiler warnings.

Signed-off-by: Carlos Santos <unixmania@gmail.com>
---
 sys-utils/hwclock-cmos.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index a11f676b8..51a405f42 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -75,17 +75,6 @@ static int inb(int c __attribute__((__unused__)))
 	return 0;
 }
 # endif				/* __i386__ __x86_64__ */
-#else
-# warning "disable cmos access - not i386 or x86_64"
-static void outb(int a __attribute__((__unused__)),
-		 int b __attribute__((__unused__)))
-{
-}
-
-static int inb(int c __attribute__((__unused__)))
-{
-	return 0;
-}
 #endif				/* for inb, outb */
 
 #include "hwclock.h"
@@ -100,6 +89,8 @@ static int inb(int c __attribute__((__unused__)))
  */
 #define TM_EPOCH 1900
 
+#if defined(__i386__) || defined(__x86_64__)
+
 static unsigned short clock_ctl_addr = 0x70;
 static unsigned short clock_data_addr = 0x71;
 
@@ -360,7 +351,6 @@ static int set_hardware_clock_cmos(const struct hwclock_control *ctl
 	return 0;
 }
 
-#if defined(__i386__) || defined(__x86_64__)
 # if defined(HAVE_IOPL)
 static int i386_iopl(const int level)
 {
@@ -373,12 +363,6 @@ static int i386_iopl(const int level __attribute__ ((__unused__)))
 	return ioperm(clock_ctl_addr, 2, 1);
 }
 # endif
-#else
-static int i386_iopl(const int level __attribute__ ((__unused__)))
-{
-	return IOPL_NOT_IMPLEMENTED;
-}
-#endif
 
 static int get_permissions_cmos(void)
 {
@@ -407,6 +391,8 @@ static struct clock_ops cmos_interface = {
 	get_device_path,
 };
 
+#endif
+
 /*
  * return &cmos if cmos clock present, NULL otherwise.
  */
-- 
2.18.1

