Return-Path: <SRS0=/wRe=UW=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56323C43613
	for <util-linux@archiver.kernel.org>; Sun, 23 Jun 2019 17:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2801F2073F
	for <util-linux@archiver.kernel.org>; Sun, 23 Jun 2019 17:28:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iukt8afX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfFWR2T (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 23 Jun 2019 13:28:19 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36983 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbfFWR2T (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 23 Jun 2019 13:28:19 -0400
Received: by mail-qt1-f194.google.com with SMTP id y57so12178974qtk.4
        for <util-linux@vger.kernel.org>; Sun, 23 Jun 2019 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=V+RoGbUExfZ2FviaF1hG1zjb8UniiEZm8f5UVXXvYS4=;
        b=Iukt8afXwUE0kSHx9WAFa3TPYjxjS3A57NNPbhsikanOWXRgK9dB5uCTXOSyU2z8gL
         QfkmZ0tfFZdu7/SFoXXFm7ZQao8ptQ8EcJfOmdAa80Du1ZL0qlm0FutXZzp0bYsUHSOP
         TdehKDQsTUg3B+akptHaEjqbonN03gLbWH1OBNlbsnBdVeA2Uk2sdmJ0iKwJ+g+mARqn
         qz9ZzHur7eBqvHmd1Hu8wLqRjdONKaC/eInAjx3JUJBB8PeuSj0yRQ/byaQ0PO+hzSRa
         ZqQKPMZa0SeXakDopEsQNtI8tju4BxQD27/vgJqNPoSCAonQerJIgVTZ0r3ub32x8cOL
         bizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=V+RoGbUExfZ2FviaF1hG1zjb8UniiEZm8f5UVXXvYS4=;
        b=ZPDp5YHrQ6MZ+Jsj8fw2S1gNy4YxffQawpxbIpiK+NwqIQpHvVwyOAQEYemX0xX9Iv
         CyP4q9MwbRanzeF+J3D2AazHIFpaJfhkL7S0uQREDtn1kIqOHX3/TduMxTNsojcG0BMZ
         ITOynSboZ7/wlssy7cg9fSiQv2EVF7BoP4737OSq4pHDzwqUpt297s0lPMBmIafAcV9R
         7iUQ+qXnEZUkp/kuvlUltN1cVEJ/fdDBWuZx3sKkA6yjCSEIh5B+HEXZ8fWXiBveWGDm
         WMqnz7XZoONAogGPiTrYijqfq8fY+ZGsd0UW1aYy1vVlXhmCQJa0y02bPMKWLtd8jHcu
         9q4g==
X-Gm-Message-State: APjAAAUOFdWThuHoB46gMw1rdaKu1KT01bnnDsN0MdfZzd+K0riZhk7O
        KTqyKW78ob6O31xJiiLOq3jiTck+z5o=
X-Google-Smtp-Source: APXvYqxJbGLZCiDCWGZjMNhBmGCLGF7lnAEz+QKOIA0Nf6o4c6L9Ue+UfQz4IbOZ6XXjjGeYXm+92Q==
X-Received: by 2002:ad4:5426:: with SMTP id g6mr18066957qvt.132.1561310898033;
        Sun, 23 Jun 2019 10:28:18 -0700 (PDT)
Received: from casantos.remote.csb (189-71-198-232.user.veloxzone.com.br. [189.71.198.232])
        by smtp.gmail.com with ESMTPSA id s130sm4212322qke.104.2019.06.23.10.28.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 23 Jun 2019 10:28:17 -0700 (PDT)
From:   unixmania@gmail.com
To:     util-linux@vger.kernel.org
Cc:     Carlos Santos <unixmania@gmail.com>
Subject: [PATCH] hwclock: define cmos_interface only if necessary
Date:   Sun, 23 Jun 2019 14:28:00 -0300
Message-Id: <20190623172800.23445-1-unixmania@gmail.com>
X-Mailer: git-send-email 2.18.1
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

From: Carlos Santos <unixmania@gmail.com>

Move the static declaration to the probe_for_cmos_clock() function and
make it conditional to i386/x86_64, preventing a "defined but not used"
compiler warning.

Signed-off-by: Carlos Santos <unixmania@gmail.com>
---
 sys-utils/hwclock-cmos.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index a11f676b8..ada4a9c43 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -398,21 +398,21 @@ static const char *get_device_path(void)
 	return NULL;
 }
 
-static struct clock_ops cmos_interface = {
-	N_("Using direct ISA access to the clock"),
-	get_permissions_cmos,
-	read_hardware_clock_cmos,
-	set_hardware_clock_cmos,
-	synchronize_to_clock_tick_cmos,
-	get_device_path,
-};
-
 /*
  * return &cmos if cmos clock present, NULL otherwise.
  */
 struct clock_ops *probe_for_cmos_clock(void)
 {
 #if defined(__i386__) || defined(__x86_64__)
+	static struct clock_ops cmos_interface = {
+		N_("Using direct ISA access to the clock"),
+		get_permissions_cmos,
+		read_hardware_clock_cmos,
+		set_hardware_clock_cmos,
+		synchronize_to_clock_tick_cmos,
+		get_device_path,
+	};
+
 	return &cmos_interface;
 #else
 	return NULL;
-- 
2.18.1

