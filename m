Return-Path: <SRS0=uTWB=7H=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BECC433E0
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 07:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85FEA2065F
	for <util-linux@archiver.kernel.org>; Mon, 25 May 2020 07:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KIrdCYmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388948AbgEYHa3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 25 May 2020 03:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388947AbgEYHa3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 25 May 2020 03:30:29 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE28FC061A0E
        for <util-linux@vger.kernel.org>; Mon, 25 May 2020 00:30:28 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f5so7519120wmh.2
        for <util-linux@vger.kernel.org>; Mon, 25 May 2020 00:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version:organization
         :content-transfer-encoding;
        bh=pGtOo5BkdXjlz9fC2HE8FBVfm7y6RGSpR89zLfB+9GQ=;
        b=KIrdCYmcZH+ohWIIAEMJkxjtLTKjSo7EkD1q0olMEWw6A+IVdEALVQaPBNie2Ejkxz
         SW8nwk8r+f4vqi/W3UydNI5wej7qNoGTISgkDP7+CQ416EpS7RTIs4MilLLJxyJOEP9g
         0jWY31nAZKEe3ySuSbb47CpSk8FvxhZ0ul1a8VEiv9QL7ni23VYcQc+PFYnVorVIOyFy
         UgUl40DaO7iVrftncnlYIepOjAO6xeUdqwu1o/GaxCBmeVMfj1U7njplM6+XGphnCVMT
         0KbY1RCSXIBgJ1Gyu3Qtumat54C+1qyjN6Rc4FlSzkjfD/y9KKnjsnZYWg9WCMNhYrij
         ctjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:organization:content-transfer-encoding;
        bh=pGtOo5BkdXjlz9fC2HE8FBVfm7y6RGSpR89zLfB+9GQ=;
        b=TzlTH2GVvBh1dSdvqbgdQZmGjiDcZPOfMAzBqCtBT9vBlnrnZz0Za7lpH2534+LM9U
         /wBXUiQbsk91EotKLk1WHuPwD4iqdexkWmTOJzcXk271FKOhoxNpKLkXfqV34JWeQGZs
         DxVVSg8bellvZD9hTPu8wXtiYx9qXjhPcSoW0xMdzwP4ffAl0TGpVGenX0nlgk3TDgGD
         smU371LWmIfKI5yUS4KyjKI/KJxbFIRZ/87q5Th/vbuhpSOwz2J5hhkzVhwCiFtpg1Bm
         wn/bLghTl7Zd+myKUQ46bbWKrxptVrAQ8uCfbF5XLTGG8X/2JKfEsUUQqO46KREobHha
         SAAg==
X-Gm-Message-State: AOAM532XfsFyobV36UXqi70dXQEL2gjRoSSwzXL/YYG+GK1Q13hBhrGX
        7u0kWtG4X/dptcSPjwKVDMU2uDid
X-Google-Smtp-Source: ABdhPJyOtHJlXTFuSPvNQxEFrGg8SunkQixyARJq1LEKFoncl2/gJ9lTfny8wAG6V39btXMkIlst8g==
X-Received: by 2002:a1c:9cd4:: with SMTP id f203mr25430263wme.26.1590391826898;
        Mon, 25 May 2020 00:30:26 -0700 (PDT)
Received: from localhost ([2a02:8010:659f:0:8b7c:8150:5102:21e9])
        by smtp.gmail.com with ESMTPSA id m3sm17293630wrn.96.2020.05.25.00.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 00:30:26 -0700 (PDT)
From:   Sami Kerola <kerolasa@iki.fi>
To:     util-linux@vger.kernel.org
Cc:     Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] more: avoid libmagic telling an empty file is binary
Date:   Mon, 25 May 2020 08:30:24 +0100
Message-Id: <20200525073024.40308-1-kerolasa@iki.fi>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Organization: Cloudflare
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

My earlier change that took libmagic in use to identify mime-type of an input
file caused empty files to be marked binary.  Before the change empty files
were simply displayed as empty.  This change will restore that behavior.

Addresses: 09070e1a658e70ec203150e4fa5f486b32771858
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index b69fa5c5b..3855d8549 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -395,7 +395,23 @@ static void print_separator(const int c, int n)
 static int check_magic(struct more_control *ctl, char *fs)
 {
 #ifdef HAVE_MAGIC
-	const char *mime_encoding = magic_descriptor(ctl->magic, fileno(ctl->current_file));
+	const int fd = fileno(ctl->current_file);
+	const char *mime_encoding = magic_descriptor(ctl->magic, fd);
+	const char *magic_error_msg = magic_error(ctl->magic);
+	struct stat st;
+
+	if (magic_error_msg) {
+		printf(_("magic failed: %s\n"), magic_error_msg);
+		return 0;
+	}
+	if (fstat(fd, &st)) {
+		warn(_("cannot stat %s"), fs);
+		return 1;
+	}
+	if (st.st_size == 0) {
+		/* libmagic tells an empty file has binary encoding */
+		return 0;
+	}
 
 	if (!mime_encoding || !(strcmp("binary", mime_encoding))) {
 		printf(_("\n******** %s: Not a text file ********\n\n"), fs);
-- 
2.26.2

