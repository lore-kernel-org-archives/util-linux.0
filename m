Return-Path: <SRS0=A2OT=5V=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14475C2D0E8
	for <util-linux@archiver.kernel.org>; Sun,  5 Apr 2020 05:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BAA2072F
	for <util-linux@archiver.kernel.org>; Sun,  5 Apr 2020 05:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GdYy57sO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDEF4Y (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 5 Apr 2020 01:56:24 -0400
Received: from mail-wr1-f74.google.com ([209.85.221.74]:56187 "EHLO
        mail-wr1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgDEF4Y (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Apr 2020 01:56:24 -0400
Received: by mail-wr1-f74.google.com with SMTP id r15so5913237wrm.22
        for <util-linux@vger.kernel.org>; Sat, 04 Apr 2020 22:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to;
        bh=lohjFHOV+qanZgj4hYxv/bMNg1IIrke2JyPLg1DbHUg=;
        b=GdYy57sOmfu9ArA8SnFwsQyoWzNr7knTfnOFIh98YOSgcJF5i4w0BmzJoQhKrtf2By
         5l+SOCjCOYXJpun2w75vCBDX7kY+VEr+5C4a9ytRzPuB/cOp758s+HGKSWHNQtClqeLr
         QKPv+vMSxYnoio0VAfxMfukUqM5oJMbZo+Mtb9oNO4f0tLzMR+pBx7GfdnnfYdz42bAD
         5W7EYoO8YW2DQAaRMTj4yxplGYL2ZEFJzMLUahIBFzLCA8p3H0di3s08Cx+PxbFZUb2M
         c009mdghPwhx6QgXtfsR9E++BnooWOb5nFukZZxc03gOJz7ZM9NCXuwoIHEtMMfoQ9mE
         A6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to;
        bh=lohjFHOV+qanZgj4hYxv/bMNg1IIrke2JyPLg1DbHUg=;
        b=LkMLbws+iNcpUu331G/yGmZL7CkV9kNxC7RlVleUMYDYPvVTa6einypfs/xxoVEk/r
         klrtE06Gub86MSnhDGn5VVtlSw1Miyzhc8eQls4+67YRNZqkCIRtUpkGNDpIIzpVcS6d
         FSnGFHfzZGvm7khDDS/GU1iHKk9vF4fqnAk9EJMVsLhCsFa7gjA0d4J2AYeEBvGvz7kI
         T7jm8+lONwvT3Y8wE1Wjx5lXwK+TN0yKFxHfC1qFwQrf2UU1A3QIdRxEC8Ucn0XqIRG5
         46ILFI2Xpdo97JBfFheNd66i8Qg1NocINCmwTmy3RLzeQrwYgPaSt0cSQeTpjy+p6pwm
         By1g==
X-Gm-Message-State: AGi0PubfRzfj7KnMmV9uPGPdpBTxwyljnxMoB3jI09wagFiPIwR0IKGc
        eP+kuvE9qjiSzoYJQ9yVHdEc/Esh5QeIhB2nJ1paPjhakbWhFBlqy1iM7dKS/5IsZXK6sXP2x9G
        Pchz7LkSNQI5JKNrX2IlfbEVNyqLKxm0T7PB1IoaT93sxX7bos5Yd9JZ/MK0IgFuD
X-Google-Smtp-Source: APiQypLbf41OusAn6lXCg9Q79IoPqGRfx1SqcWQ/hP8Pij2hKZnxrtE8sv9u7rC9e8oFBuEwM8640981uQ==
X-Received: by 2002:a5d:4683:: with SMTP id u3mr17075391wrq.248.1586066182564;
 Sat, 04 Apr 2020 22:56:22 -0700 (PDT)
Date:   Sun,  5 Apr 2020 07:55:14 +0200
Message-Id: <20200405055514.227225-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [PATCH] docs: renice(1): Add chrt(1) to SEE ALSO
From:   Jann Horn <jannh@google.com>
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

A user who wants to change the niceness of a process is likely to also be
interested in changing the scheduler class and/or RT priority.

Signed-off-by: Jann Horn <jannh@google.com>
---
 sys-utils/renice.1 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sys-utils/renice.1 b/sys-utils/renice.1
index 44af9e065..3ef3512f4 100644
--- a/sys-utils/renice.1
+++ b/sys-utils/renice.1
@@ -104,6 +104,7 @@ negative (to make things go very fast).
 to map user names to user IDs
 .SH SEE ALSO
 .BR nice (1),
+.BR chrt (1),
 .BR getpriority (2),
 .BR setpriority (2),
 .BR credentials (7),

base-commit: bee464006776203a8cb545a35c86234181c7a55a
-- 
2.26.0.292.g33ef6b2f38-goog

