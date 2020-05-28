Return-Path: <SRS0=us4l=7K=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3929C433DF
	for <util-linux@archiver.kernel.org>; Thu, 28 May 2020 14:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 803E02075F
	for <util-linux@archiver.kernel.org>; Thu, 28 May 2020 14:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qaFTA5yC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403949AbgE1O6c (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 28 May 2020 10:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403770AbgE1O6b (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 28 May 2020 10:58:31 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15EFC08C5C6
        for <util-linux@vger.kernel.org>; Thu, 28 May 2020 07:58:30 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x6so14628719wrm.13
        for <util-linux@vger.kernel.org>; Thu, 28 May 2020 07:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAx5rhLrxwxzYF+kDGI9Z/lR9mo7nVzbJpeJGCBz/ts=;
        b=qaFTA5yCPqbLXoNCAuiqh/4C/s+6SIZu7owv73lyP8Gr9PuJtW3oqPQxvaIUZHUN7r
         +nZzhrDlu7TJFsRQcQsrbYxIUvf9C0HRwOHjeWPbnDzyJnmmvAjWY14wFEEYajcJft6c
         98b/01dXELuYEU7ydsQOiM+ojVXwu/p5PF1oIF3KPKvdBX5n0uSl017V49Z/s1EFdFV/
         Yrd1S3c77tW6ce4FtPS/z9AJwSqXtM2VicaWtDmFqPbvEKDo5nBGYCiNY1Vn1zcVJRq7
         tQ0mx2On5qBTNkxz5JC6aD8z6jybVtqekdogix+1m9CRwrso0Bd1LdmYvc3cPIyBkEcq
         DkKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jAx5rhLrxwxzYF+kDGI9Z/lR9mo7nVzbJpeJGCBz/ts=;
        b=pKktq9GDwFeyR9jhghj9rbHKTG7hcw+6Xxu6lmn1+bjEoZ+RI9wAXa48bxvGBS32ku
         4OZvfTNOoSdueLrxF2jvWKzyr/gr1EtztnroWffyemqyzP7RHsRLayPX/m2kJSrsuMUR
         gD5nAx1+v6ZZ2PgcAAxa21/FaJf84WtpSF5XBRtkgdRFMhQirKY21EQhRPxM2eue9HYa
         Ys7AQzpTdFLAeg+s90cnblrlfskE4OKnt6iFeadre6HPoQPAd9kk8Q9k3H35knxpkBrR
         PwdtDclbc82/shHZV2kpiiAoOZRbNXW4fSzqROzrvKyd+VDmgg3FERzPUvdG8iNTZKyB
         d8lA==
X-Gm-Message-State: AOAM531KTHTl9FQG7zgCWtwAbTQFntcdXvDRHYRZ8mK37vb21Bef7vY4
        Af7tfm5b6eex4lLHs9B/FwJtbhGZ3R4=
X-Google-Smtp-Source: ABdhPJxEG6kd84pX/H6Bgfu78ihn8FXg3Oq66//AtX+6KfUv1ywQ2W9RM2cWlsl3NMGkgWRXggnPDQ==
X-Received: by 2002:adf:fec9:: with SMTP id q9mr4206368wrs.172.1590677909298;
        Thu, 28 May 2020 07:58:29 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:2516:6501:a84b:ccd6:785a:2f0f])
        by smtp.gmail.com with ESMTPSA id v7sm6482630wre.93.2020.05.28.07.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 07:58:28 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 01/10] Manual pages: unshare.1: EXAMPLES: improve persistent mount namespace example
Date:   Thu, 28 May 2020 16:58:15 +0200
Message-Id: <20200528145823.978508-1-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The text describing the persistent mount namespace example
is rather confused. Explain more clearly the purpose of making
the parent directory a bind mount with private propagation.
Also make a few other wording improvements.

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 sys-utils/unshare.1 | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index ea170b13a..e3a23f78c 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -304,9 +304,16 @@ FOO
 .EE
 .in
 .PP
-Establish a persistent mount namespace referenced by the bind mount
-/root/namespaces/mnt.  This example shows a portable solution, because it
-makes sure that the bind mount is created on a shared filesystem.
+The following commands
+establish a persistent mount namespace referenced by the bind mount
+.IR /root/namespaces/mnt .
+In order to ensure that this bind mount does not get propagated
+to other mount namespaces,
+the parent directory
+.RI ( /root/namespaces )
+is first made a bind mount with
+.I private
+propagation.
 .PP
 .in +4n
 .EX
-- 
2.26.2

