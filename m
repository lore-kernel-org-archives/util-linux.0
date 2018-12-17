Return-Path: <SRS0=1kTP=O2=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E46EC43387
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 12:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DB052133F
	for <util-linux@archiver.kernel.org>; Mon, 17 Dec 2018 12:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=eworm.de header.i=@eworm.de header.b="RipXjqdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbeLQMuk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:50:40 -0500
Received: from mx.mylinuxtime.de ([195.201.174.144]:38808 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731909AbeLQMuk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 17 Dec 2018 07:50:40 -0500
X-Greylist: delayed 320 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Dec 2018 07:50:39 EST
Received: from leda.eworm.de (unknown [87.190.244.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id 069A0131514;
        Mon, 17 Dec 2018 13:45:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de 069A0131514
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1545050718; bh=2jSqWOu643sVaaIQkd0O04FR2qPDOwwZUBtkQbE4Jjc=;
        h=From:To:Cc:Subject:Date;
        b=RipXjqdPTHIyAli6SvFr1sbfgVnEflthPu9Jn/ZdnwIswcAxMFPKQYrKNCiRidyIq
         VZ2j/NTDK+aYwHRlB/tywhHKaK6yKwPcgFgLFpQE2TV5DFFRCJdm4fmvSY27D9loi4
         vnF/DwR9Pxrqrjy1dl6EWF+S4EiKZGsrnNhJ7TL0=
Received: by leda.eworm.de (Postfix, from userid 1000)
        id 814AD123685; Mon, 17 Dec 2018 13:44:47 +0100 (CET)
From:   Christian Hesse <mail@eworm.de>
To:     util-linux@vger.kernel.org
Cc:     Christian Hesse <mail@eworm.de>
Subject: [PATCH 1/1] fstrim: add random delay to systemd timer
Date:   Mon, 17 Dec 2018 13:44:22 +0100
Message-Id: <20181217124422.13334-1-mail@eworm.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=smtp-only@eworm.de smtp.mailfrom=eworm@leda.eworm.de
X-Rspamd-Server: mx
X-Stat-Signature: bek565aau3nigowwnuztnoy8uzaks9qr
X-Rspamd-Queue-Id: 069A0131514
X-Spamd-Result: default: False [5.77 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM(1.20)[0.400,0];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCPT_COUNT_TWO(0.00)[2];
         MID_CONTAINS_FROM(1.00)[];
         FORGED_SENDER(0.30)[mail@eworm.de,eworm@leda.eworm.de];
         RCVD_TLS_LAST(0.00)[];
         ASN(0.00)[asn:3320, ipnet:87.128.0.0/10, country:DE];
         FROM_NEQ_ENVFROM(0.00)[mail@eworm.de,eworm@leda.eworm.de];
         BAYES_HAM(-0.63)[82.35%];
         RCVD_COUNT_TWO(0.00)[2]
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The fstrim timer tends to fire simultaneously with other timers like
updatedb. As fstrim is not time criticaly let's add a random delay of
up to an hour.

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 sys-utils/fstrim.timer | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sys-utils/fstrim.timer b/sys-utils/fstrim.timer
index 3a3762d5c..dd3328e2a 100644
--- a/sys-utils/fstrim.timer
+++ b/sys-utils/fstrim.timer
@@ -5,6 +5,7 @@ Documentation=man:fstrim
 [Timer]
 OnCalendar=weekly
 AccuracySec=1h
+RandomizedDelaySec=1h
 Persistent=true
 
 [Install]
