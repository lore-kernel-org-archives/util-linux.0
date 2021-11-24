Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCB4C433EF
	for <util-linux@archiver.kernel.org>; Wed, 24 Nov 2021 18:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhKXS3n (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236712AbhKXS3n (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 24 Nov 2021 13:29:43 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32284C061574
        for <util-linux@vger.kernel.org>; Wed, 24 Nov 2021 10:26:33 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id j17so3625968qtx.2
        for <util-linux@vger.kernel.org>; Wed, 24 Nov 2021 10:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZrQKlW0epqCKlkEQC5kp0Xp/gPZsfaf45Rtsi/FMs5A=;
        b=UNgF4ae2HTEEFhWebaiVfpPB1XzcZBudzN0g0SXsCPw6/m5Y0rvJJGuxhAPVmY57KT
         byfya6/ZjQaaNl7iHos4K52QZjVEWMxN/E3GbqWwEr47RbbmI054qHWgF7YiRy1j776A
         lPTioVniFmT4H4zNqEVkvPNxmOPL2P3rw+UUg/vSf2FNtK9yWhi+0/3g7c3vfzJCUBY4
         AFKSm9rl+CH5cMUzhiWxZzeeuCf6knBCcxuJi+MceiVuhU4+T2TEYM4YK4t8/WFBo7oe
         r2y6aps/Q7tLeBO+TedG3191naqYqQNMXcjagNO/YKEXNQ2BRWxz+ZqCcapeS+1Sbz42
         ctaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZrQKlW0epqCKlkEQC5kp0Xp/gPZsfaf45Rtsi/FMs5A=;
        b=dxyQpXbeeB7mNCil54mf13gqE7o15kj8agBnm6GPfx8WiB+tfPz7B3C1ENCilSH5bz
         8julywDPIJjkIvgYf1FMUOeZpIn6O4vfGlm69v1M/ks2xUuMBBUtPXs1GqsB+PsvRRIn
         LRblUQdOakEIzF/cAxEQ+vmsSViAhJygpwtU5bZjSI44m3L6hLd9Z8jd1qE/Gmva4RUy
         BjSCoLdO7Ion+b0akrvVK2btybByDTSMiBZNKoBqMF3ErWdXgBc8tOfFnot0Sbd23MWZ
         ZJzMabHPdcWm4fbO/gDwAFZnN0DZxR9eF4nlf79NUGXSm6eW7NUgCeOruIqplMNIjtPH
         8Ohw==
X-Gm-Message-State: AOAM5328Cx75WznmWVHsjQewI5C0HMTX+eN8mRDgR39EW2NWZsddPE6u
        r/s+l8eDF6ZxrxzVBzyK9ieA/nXgmGo=
X-Google-Smtp-Source: ABdhPJxMgPnbvZdldM2F0z/CcyxYw2Cf+MrnB7O4racF0eJ0C1zxOpyOyNrHuW7if3iEQDgURzRkLw==
X-Received: by 2002:a05:622a:308:: with SMTP id q8mr1005414qtw.463.1637778392179;
        Wed, 24 Nov 2021 10:26:32 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id h19sm274936qth.63.2021.11.24.10.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 10:26:31 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc:     Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v2 2/6] unshare: Add waitchild helper
Date:   Wed, 24 Nov 2021 13:26:14 -0500
Message-Id: <20211124182618.1801447-3-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211124182618.1801447-1-seanga2@gmail.com>
References: <20211124182618.1801447-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This refactors out the waitpid() logic into a function which will be
reused for the upcoming patches.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v2:
- Add some documentation for waitchild

 sys-utils/unshare.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 3f8287799..62fa66067 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -226,6 +226,30 @@ static void settime(time_t offset, clockid_t clk_id)
 	close(fd);
 }
 
+/**
+ * waitchild() - Wait for a process to exit successfully
+ * @pid: PID of the process to wait for
+ *
+ * Wait for a process to exit successfully. If it exits with a non-zero return
+ * code, then exit() with the same status.
+ */
+static void waitchild(int pid)
+{
+	int rc, status;
+
+	do {
+		rc = waitpid(pid, &status, 0);
+		if (rc < 0) {
+			if (errno == EINTR)
+				continue;
+			err(EXIT_FAILURE, _("waitpid failed"));
+		}
+		if (WIFEXITED(status) &&
+		    WEXITSTATUS(status) != EXIT_SUCCESS)
+			exit(WEXITSTATUS(status));
+	} while (rc < 0);
+}
+
 static void bind_ns_files_from_child(pid_t *child, int fds[2])
 {
 	char ch;
@@ -580,7 +604,6 @@ int main(int argc, char *argv[])
 	if (npersists && (pid || !forkit)) {
 		/* run in parent */
 		if (pid_bind && (unshare_flags & CLONE_NEWNS)) {
-			int rc;
 			char ch = PIPE_SYNC_BYTE;
 
 			/* signal child we are ready */
@@ -589,17 +612,7 @@ int main(int argc, char *argv[])
 			fds[1] = -1;
 
 			/* wait for bind_ns_files_from_child() */
-			do {
-				rc = waitpid(pid_bind, &status, 0);
-				if (rc < 0) {
-					if (errno == EINTR)
-						continue;
-					err(EXIT_FAILURE, _("waitpid failed"));
-				}
-				if (WIFEXITED(status) &&
-				    WEXITSTATUS(status) != EXIT_SUCCESS)
-					return WEXITSTATUS(status);
-			} while (rc < 0);
+			waitchild(pid_bind);
 		} else
 			/* simple way, just bind */
 			bind_ns_files(getpid());
-- 
2.33.0

