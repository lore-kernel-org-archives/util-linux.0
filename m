Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E7FCD13CF
	for <util-linux@archiver.kernel.org>; Sun, 17 Sep 2023 16:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231688AbjIQQoT (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 17 Sep 2023 12:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbjIQQoP (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 17 Sep 2023 12:44:15 -0400
X-Greylist: delayed 453 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 17 Sep 2023 09:44:08 PDT
Received: from hera.aquilenet.fr (hera.aquilenet.fr [185.233.100.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9089511D
        for <util-linux@vger.kernel.org>; Sun, 17 Sep 2023 09:44:08 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by hera.aquilenet.fr (Postfix) with ESMTP id 3A54D8C9;
        Sun, 17 Sep 2023 18:36:33 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hera.aquilenet.fr
Received: from hera.aquilenet.fr ([127.0.0.1])
        by localhost (hera.aquilenet.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yzIWDgUadxjl; Sun, 17 Sep 2023 18:36:32 +0200 (CEST)
Received: from begin (unknown [IPv6:2a01:cb19:4a:a400:de41:a9ff:fe47:ec49])
        by hera.aquilenet.fr (Postfix) with ESMTPSA id 85BAE663;
        Sun, 17 Sep 2023 18:36:32 +0200 (CEST)
Received: from samy by begin with local (Exim 4.96)
        (envelope-from <samuel.thibault@aquilenet.fr>)
        id 1qhul5-00BJYN-24;
        Sun, 17 Sep 2023 18:36:31 +0200
Date:   Sun, 17 Sep 2023 18:36:31 +0200
From:   Samuel Thibault <samuel.thibault@aquilenet.fr>
To:     Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Subject: Fix non-Linux build
Message-ID: <20230917163631.xcmdnwodz4wrcpyq@begin>
Mail-Followup-To: Samuel Thibault <samuel.thibault@aquilenet.fr>,
        Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wx7h3pxdc6esca6j"
Content-Disposition: inline
Organization: I am not organized
User-Agent: NeoMutt/20170609 (1.8.3)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--wx7h3pxdc6esca6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Here are some fixes for non-linux build.

Samuel

--wx7h3pxdc6esca6j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/configure.ac b/configure.ac
index 5f609dec7..061e22e15 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1906,7 +1906,8 @@ AS_IF([test "x$build_enosys" = xyes], [
 ])
 AM_CONDITIONAL([BUILD_ENOSYS], [test "x$build_enosys" = xyes])
 
-UL_BUILD_INIT([lsclocks], [yes])
+UL_BUILD_INIT([lsclocks], [check])
+UL_REQUIRES_LINUX([lsclocks])
 AM_CONDITIONAL([BUILD_LSCLOCKS], [test "x$build_lsclocks" = xyes])
 
 UL_BUILD_INIT([getopt], [yes])
diff --git a/libmount/src/hooks.c b/libmount/src/hooks.c
index dcfe69fa4..39d9d1337 100644
--- a/libmount/src/hooks.c
+++ b/libmount/src/hooks.c
@@ -315,9 +315,11 @@ static int call_hook(struct libmnt_context *cxt, struct hookset_hook *hook)
 {
 	int rc = 0;
 
+#if LINUX
 	if (mnt_context_is_fake(cxt))
 		DBG(CXT, ul_debugobj(cxt, " FAKE call"));
 	else
+#endif
 		rc = hook->func(cxt, hook->hookset, hook->data);
 
 	hook->executed = 1;

--wx7h3pxdc6esca6j--
