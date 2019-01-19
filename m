Return-Path: <SRS0=WtKw=P3=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768B1C61CE4
	for <util-linux@archiver.kernel.org>; Sat, 19 Jan 2019 22:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A2302086A
	for <util-linux@archiver.kernel.org>; Sat, 19 Jan 2019 22:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbfASWSU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 19 Jan 2019 17:18:20 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:46551 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbfASWSU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 19 Jan 2019 17:18:20 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43hsdk1dHrz1rYjr
        for <util-linux@vger.kernel.org>; Sat, 19 Jan 2019 23:18:18 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43hsdk1W98z1qr5n
        for <util-linux@vger.kernel.org>; Sat, 19 Jan 2019 23:18:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id v-EwiVvTH2_M for <util-linux@vger.kernel.org>;
        Sat, 19 Jan 2019 23:18:17 +0100 (CET)
X-Auth-Info: kQxovIH9UhXKgYMVlaH7891cjJnOoxeIjjk10yCInZTMH8oOm09PCzSmfF8s+vq6
Received: from igel.home (ppp-188-174-144-29.dynamic.mnet-online.de [188.174.144.29])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA
        for <util-linux@vger.kernel.org>; Sat, 19 Jan 2019 23:18:17 +0100 (CET)
Received: by igel.home (Postfix, from userid 1000)
        id A739E2C1397; Sat, 19 Jan 2019 23:18:16 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     util-linux@vger.kernel.org
Subject: [PATCH] setarch: don't return address of automatic variable
X-Yow:  ..I'll make you an ASHTRAY!!
Date:   Sat, 19 Jan 2019 23:18:16 +0100
Message-ID: <87imyk9tqv.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On architectures without special personalities setarch uses the contents
of a local variable with automatic storage duration after return from
the function, causing it to report a spurious error.

$ setarch m68k
setarch: Kernel cannot set architecture to m68k

Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
---
 sys-utils/setarch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index 7c0a63fbb262..703c36d864e1 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -131,7 +131,7 @@ static void __attribute__((__noreturn__)) usage(int archwrapper)
  */
 static struct arch_domain *init_arch_domains(void)
 {
-	struct utsname un;
+	static struct utsname un;
 	size_t i;
 
 	static struct arch_domain transitions[] =
-- 
2.20.1


-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
