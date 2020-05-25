Return-Path: <SRS0=uTWB=7H=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71BDC433E0
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 12:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82032078B
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 12:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOREeciQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390571AbgEYM72 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 May 2020 08:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388738AbgEYM71 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 May 2020 08:59:27 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B017DC061A0E
        for <util-linux@vger.kernel.org>; Mon, 25 May 2020 05:59:26 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id i16so14957179edv.1
        for <util-linux@vger.kernel.org>; Mon, 25 May 2020 05:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wPidpFPCxJ1H/w1PyGyAJPyFteseUds9AR5gw3qskiM=;
        b=tOREeciQGFRhDZUyPp7Q1Kj+wIQstfuvUgXv3i0JgpT73tXEIh7lbtkxTxjAmlFUTH
         dej8k9pD/bmFV1RcIx63LnavOPXOJ15gzulG8grTUCEfDf/UygZtKGRj50fxVBWjFKrK
         fSKbIXOZ3WUPvqh8SApHzX+2vSLV8e3utT79HUISI4pAQhq6wjV6mmL0MT+6NomFTtOJ
         SpLdZk0iizvTfAN4ZTZi+iXsuWVNLwPnRwAufoEmO0rSsxS46feTV3mC23xtUzKDGqpq
         8TnidauhOFtOeCo3b+RXwOliXpqZv6ZGX9JOaFN/SAKT4lbksqMb7sZSO47bLXdAI46K
         OPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wPidpFPCxJ1H/w1PyGyAJPyFteseUds9AR5gw3qskiM=;
        b=MmxiYSNpd27/pA5ns0ha2flcnWKtH8RfZ1X1qBqqn7HYUmxw+emMu1N3iS1JvvQNRY
         JQ0CmtmZCcxTHaRbFDRgtx05i7f8EFGz3j4hukiS/+B3xrFhr2hHM7zycSrOvwdx7Hc2
         W5ZWs5OjKyywIYrqMTFraQyuekxhKd58gkWbxBo0zSKsx4g/EVYfU20PFnexN239/N8/
         5Pw86c4KDmwwdCdmBHH0lvR9iKO/SFj/zMwBIiswzOIm403EyDFd/jUucmMqK32WiFFp
         ZyS7Daor17FkD5cXwymFYp9Bh1MTKv4rx6fYKpndhon29jnb5y/Z4TfmpXcqwN7i75U3
         l7ew==
X-Gm-Message-State: AOAM531Nuk81HCqv+jtDu/j4rCn5BQ/FzGSSRGVT0RrQqpry0loFVss8
        QIMrFn2yRQzd1U6nwA8dgCo=
X-Google-Smtp-Source: ABdhPJyc7EMzTycA96puCdZJe8jbx/pJYitRmZ+mq0qkwdH0qXCiWEKtHCUm4AK+LXKR4qQdVAXxAA==
X-Received: by 2002:aa7:ca49:: with SMTP id j9mr15609138edt.186.1590411565491;
        Mon, 25 May 2020 05:59:25 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2482:101:a081:4793:30bf:f3d5])
        by smtp.gmail.com with ESMTPSA id b14sm15709719edx.93.2020.05.25.05.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 05:59:25 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 3/5] Manual pages: ipcmk.1, ipcrm.1, ipcs.1, lsipc.1: SEE ALSO: add sysvipc(7)
Date:   Mon, 25 May 2020 14:59:10 +0200
Message-Id: <20200525125912.43748-3-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200525125912.43748-1-mtk.manpages@gmail.com>
References: <20200525125912.43748-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

These commands all relate to System V IPC, so point the reader
at the relevant Section 7 page provided by the Linux man-pages
project.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 sys-utils/ipcmk.1 | 3 ++-
 sys-utils/ipcrm.1 | 3 ++-
 sys-utils/ipcs.1  | 3 ++-
 sys-utils/lsipc.1 | 3 ++-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/sys-utils/ipcmk.1 b/sys-utils/ipcmk.1
index 6102693ca..6de6d819d 100644
--- a/sys-utils/ipcmk.1
+++ b/sys-utils/ipcmk.1
@@ -46,7 +46,8 @@ Hayden A. James
 .ME
 .SH SEE ALSO
 .BR ipcrm (1),
-.BR ipcs (1)
+.BR ipcs (1),
+.BR sysvipc (7)
 .SH AVAILABILITY
 The ipcmk command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/sys-utils/ipcrm.1 b/sys-utils/ipcrm.1
index 6bb93f6bc..fc851352d 100644
--- a/sys-utils/ipcrm.1
+++ b/sys-utils/ipcrm.1
@@ -109,7 +109,8 @@ compatibility the previous syntax is still supported.
 .BR shmctl (2),
 .BR shmdt (2),
 .BR shmget (2),
-.BR ftok (3)
+.BR ftok (3),
+.BR sysvipc (7)
 .SH AVAILABILITY
 The ipcrm command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/sys-utils/ipcs.1 b/sys-utils/ipcs.1
index 8fd1a33ef..e0662302d 100644
--- a/sys-utils/ipcs.1
+++ b/sys-utils/ipcs.1
@@ -126,7 +126,8 @@ Krishna Balasubramanian
 .BR semop (2),
 .BR shmat (2),
 .BR shmdt (2),
-.BR shmget (2)
+.BR shmget (2),
+.BR sysvipc (7)
 .SH AVAILABILITY
 The ipcs command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
diff --git a/sys-utils/lsipc.1 b/sys-utils/lsipc.1
index 71cf0cf74..e5ae55bbd 100644
--- a/sys-utils/lsipc.1
+++ b/sys-utils/lsipc.1
@@ -131,7 +131,8 @@ Karel Zak
 .BR semop (2),
 .BR shmat (2),
 .BR shmdt (2),
-.BR shmget (2)
+.BR shmget (2),
+.BR sysvipc (7)
 .SH AVAILABILITY
 The lsipc command is part of the util-linux package and is available from
 .UR https://\:www.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
-- 
2.26.2

