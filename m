Return-Path: <SRS0=sYuO=7Z=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E296C433E0
	for <util-linux@archiver.kernel.org>; Fri, 12 Jun 2020 11:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBDF1207D8
	for <util-linux@archiver.kernel.org>; Fri, 12 Jun 2020 11:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AOF/eZh2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgFLLTk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 12 Jun 2020 07:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFLLTj (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 12 Jun 2020 07:19:39 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FBEC08C5C1
        for <util-linux@vger.kernel.org>; Fri, 12 Jun 2020 04:19:38 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d128so7944136wmc.1
        for <util-linux@vger.kernel.org>; Fri, 12 Jun 2020 04:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4AfxjcWYdbbytzg+gYIDaOzi7KaDO6Dea96Fh43Q4DI=;
        b=AOF/eZh286W/Ra+UKNGDvDZkUe8HcIaF1ZrMitta0hY43R6sFEnMubELQ63+V16eSq
         DjLuhN5n1V52Xb4GvdkqX8EmalitjEzDaeYfnNlJpn1X8b4XO0wjZHaeTsbUdyF+wLsp
         c+33Khaz64j5vKjcM9IZSwpQ9msukantgGztJI6Hf5aneTGaBY9SLLN0PFCKxO0+9Iiq
         M1/4I8vv5f5PCDv0wqYX4alMgg8kRI78mo/ivmXVlUGzK4mrpcmeOrsen4+VYvheChPF
         ZvZ6t85XZTJ0Ig7Df1y207/7wIi/Eef2syyWs8I1e6k466zeKf9nFbMQLl5jIQmouTQL
         LRTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4AfxjcWYdbbytzg+gYIDaOzi7KaDO6Dea96Fh43Q4DI=;
        b=kfh5hcgPyTXcbn56wew2/MAbE7ClV/X6vPrpOkq0rub3qSz2f0hZNMDI2nqjyhK2WU
         t24gNVWgbyupnkhnYVnNVZ4Ytjw9wt3Y/Pz0QiUunBemuVQTwkl4Q1KVMYTLrii5eRZ0
         qIznBZ6sHdK/uS/1NCEAQUXWbxyLtYmhHQKXLFNRazf1POE21N5EwOAyCeKaItAWwRb4
         PzDRlC1ZUnR4gmwHFoxMcfNQPkGL1IUO6w5EKUKYZlUl55jajECJERP/+n/od4XvMyxy
         bfTsCot4bOIawhMK5Jg1MkCnU4ibruiI95rft+KxhXYqn5PufePs56upzWmWv5mUeyJV
         rqDw==
X-Gm-Message-State: AOAM530SrWmSxyCl6OBBUL9Lum0KmyAasOvsYN3yAhYW9UzsvMHXqYKw
        YFxrtV+6EfygEJSCzYXdVhc=
X-Google-Smtp-Source: ABdhPJwdZ2QX8oaCGzm1U3PagNRiUf9zqzfJu3QEAnsNd7TPkNP2QdQYAA5WHogMZGRoFJT5FC8i5g==
X-Received: by 2002:a7b:c0c8:: with SMTP id s8mr13437125wmh.134.1591960777611;
        Fri, 12 Jun 2020 04:19:37 -0700 (PDT)
Received: from bienne.fritz.box ([2001:a61:253c:8201:b2fb:3ef8:ca:1604])
        by smtp.gmail.com with ESMTPSA id o6sm9511433wrp.3.2020.06.12.04.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 04:19:37 -0700 (PDT)
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
To:     mtk.manpages@gmail.com, Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH 2/3] Manual pages: setpriv.1: Various minor wording and formatting fixes
Date:   Fri, 12 Jun 2020 13:19:32 +0200
Message-Id: <20200612111933.3043314-2-mtk.manpages@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200612111933.3043314-1-mtk.manpages@gmail.com>
References: <20200612111933.3043314-1-mtk.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Signed-off-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
---
 sys-utils/setpriv.1 | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/sys-utils/setpriv.1 b/sys-utils/setpriv.1
index 939b69a3a..3794a917e 100644
--- a/sys-utils/setpriv.1
+++ b/sys-utils/setpriv.1
@@ -33,7 +33,7 @@ Clear supplementary groups.
 .TP
 .BR \-d , " \-\-dump"
 Dump the current privilege state.
-Can be specified more than once to show extra,
+This option can be specified more than once to show extra,
 mostly useless, information.  Incompatible with all other options.
 .TP
 .B \-\-groups \fIgroup\fR...
@@ -55,14 +55,17 @@ where \fIN\fR is the internal capability index used by Linux.
 .B +all
 and
 .B \-all
-can be used to add or remove all caps.  The set of capabilities starts out as
+can be used to add or remove all caps.
+.IP
+The set of capabilities starts out as
 the current inheritable set for
 .BR \-\-inh\-caps ,
 the current ambient set for
 .B \-\-ambient\-caps
 and the current bounding set for
 .BR \-\-bounding\-set .
-If you drop something from the bounding set without also dropping it from the
+.IP
+If you drop a capability from the bounding set without also dropping it from the
 inheritable set, you are likely to become confused.  Do not do that.
 .TP
 .B \-\-keep\-groups
@@ -170,11 +173,16 @@ to fail at AppArmor's whim.
 .TP
 .B \-\-reset\-env
 Clears all the environment variables except TERM; initializes the environment variables HOME, SHELL, USER, LOGNAME
-according to the user's passwd entry; sets PATH to \fI/usr/local/bin:/bin:/usr/bin\fR for a regual user and to
+according to the user's passwd entry; sets PATH to \fI/usr/local/bin:/bin:/usr/bin\fR for a regular user and to
 \fI/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin\fR for root.
 .sp
-The environment variable PATH may be different on systems where /bin and /sbin
-are merged into /usr.  The environment variable SHELL defaults to \fI/bin/sh\fR if none is given in the user's
+The environment variable PATH may be different on systems where
+.I /bin
+and
+.I /sbin
+are merged into
+.IR /usr .
+The environment variable SHELL defaults to \fI/bin/sh\fR if none is given in the user's
 passwd entry.
 .TP
 .BR \-V , " \-\-version"
-- 
2.26.2

