Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6746CC4332F
	for <util-linux@archiver.kernel.org>; Sat, 15 Jan 2022 16:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiAOQ3l (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 15 Jan 2022 11:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiAOQ3l (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 15 Jan 2022 11:29:41 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5715BC061574
        for <util-linux@vger.kernel.org>; Sat, 15 Jan 2022 08:29:41 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id q4so13276354qvh.9
        for <util-linux@vger.kernel.org>; Sat, 15 Jan 2022 08:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MpAEOCrfv+O/pKiGQ81iShR3/E4cr2NMnWvJJWIdfIM=;
        b=mqyJIFdmtNo5+HgC74Fuh5hdJgU5PiSSscJY9BUxMi5SSwUHfUf/vl1vh6kiRI1fps
         nwxC9A7F0ezXDjNIxBAS2I/EQ/rVWsU8lIsOmj23z83I9kYcG9X6MVX9fLQ9OrcWTGdb
         JPztd1Ak4jbLWth6SC87cdMq9c90y3r03ApMNKGfURUk91ea6d8KAbmYnT2sZSgNVIX1
         Eo+VR9mrbt1cUHP0CfL+JNHYzrHyYbDsNVTBN1gT5O5wMndL5620ID6DcW07ksOxMNfP
         SZl/6FUGmmq11aB5nMRbRH6roNVh+hOrDbxq1KMxaLD4+RZ8Sp9Y7mFKhls5x7n2TnX4
         ETtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MpAEOCrfv+O/pKiGQ81iShR3/E4cr2NMnWvJJWIdfIM=;
        b=KfnlkomhZHGbUwq+iDaidwwP91u9GQygR/HX57zC/bVd04MyMYERF5SNynfD9Xu+WE
         OHQSkkQPWcaAsJ9FejbexuhOFCP0SZsCCzDcHaA6ZN5MXtlgn7h4p1KqiLvcft5/GA90
         fkDfU59piFs8gnQZzgpPQsOz6c55CWVLnRjin9o8flh5eMoi2SYodaf9MPj7Tca//Ppi
         WWrDkoMjdKF1mhnnP1MCQuCi+PJQ3A9fNnBWXIPI73iHdS5c4YKc88CQsUS6v3ZnHNE5
         zRWGzsLIZA4qd/4qzKLn046m8lZA5OfLr+hzFL8pXoSIUHVBi7eOWSFTTUfyFbooijMM
         BPew==
X-Gm-Message-State: AOAM532Wh2Go3piuTMbPK0ym/fYNX+Zn1UoEFEfgXUHqLdC58fAOp/1B
        zgTQqIGdoJnIjSnInJw7IRBY4UEfMGU=
X-Google-Smtp-Source: ABdhPJzu+gUkjZuhcnmXzFFmayoYE/seooz1GzyFJfqjCNxE56rswqdtEPFVSFo+PKf69JNzsGC+Iw==
X-Received: by 2002:a05:6214:27cb:: with SMTP id ge11mr12454989qvb.56.1642264180414;
        Sat, 15 Jan 2022 08:29:40 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-137-133.washdc.fios.verizon.net. [108.18.137.133])
        by smtp.gmail.com with ESMTPSA id w14sm6090347qta.6.2022.01.15.08.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 08:29:40 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc:     Daniel Gerber <dg@atufi.org>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 2/2] unshare: Fix doc comments
Date:   Sat, 15 Jan 2022 11:29:26 -0500
Message-Id: <20220115162926.546843-3-seanga2@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220115162926.546843-1-seanga2@gmail.com>
References: <20220115162926.546843-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Several doc comments use the wrong terminology, or have mismatches
descriptions. Fix them.

Fixes: ff5dc96eb ("unshare: Add options to map blocks of user/group IDs")
Signed-off-by: Sean Anderson <seanga2@gmail.com>
Reported-by: Daniel Gerber <dg@atufi.org>
---

 sys-utils/unshare.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 889c561ca..edce65c77 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -359,8 +359,8 @@ static gid_t get_group(const char *s, const char *err)
 
 /**
  * struct map_range - A range of IDs to map
- * @outer: First ID inside the namespace
- * @inner: First ID outside the namespace
+ * @outer: First ID mapped on the outside of the namespace
+ * @inner: First ID mapped on the inside of the namespace
  * @count: Length of the inside and outside ranges
  *
  * A range of uids/gids to map using new[gu]idmap.
@@ -394,9 +394,9 @@ static int uint_to_id(const char *name, size_t sz)
 
 /**
  * get_map_range() - Parse a mapping range from a string
- * @s: A string of the format upper,lower,count
+ * @s: A string of the format outer,inner,count
  *
- * Parse a string of the form upper,lower,count into a new mapping range.
+ * Parse a string of the form outer,inner,count into a new mapping range.
  *
  * Return: A new &struct map_range
  */
-- 
2.34.1

