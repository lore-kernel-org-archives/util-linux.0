Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A037C433FE
	for <util-linux@archiver.kernel.org>; Wed, 17 Nov 2021 02:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D10B61507
	for <util-linux@archiver.kernel.org>; Wed, 17 Nov 2021 02:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232054AbhKQCNp (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 16 Nov 2021 21:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhKQCNn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 16 Nov 2021 21:13:43 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ED0C061746
        for <util-linux@vger.kernel.org>; Tue, 16 Nov 2021 18:10:46 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id v22so1177630qtx.8
        for <util-linux@vger.kernel.org>; Tue, 16 Nov 2021 18:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RRMCgEzGqBN8kkxXS0K/RYZnnnVmP1dTWb/cIEjKAX8=;
        b=l6r4825SsKtCIsu945w0Fkb9BviIE3CU0YVybehlWfLgDAXY9ucX13PrQxvoikSd5n
         wruDYAil5fITUl2eZ5oO2QbbNKs7vTXdZsxIO/kXS/qNB98zUh5M+TE1omrjoAdKOvNs
         cmA9RUUQCMr7a+GJKZKV7qsnku7BbYM0XrxzX8ohN4SbbYzMIkMOp7PKbeqXemWPfJvz
         EtRheLnLbZvVX/dJUOYZTnErWEXwE91drsFGwJjojFmGOTbufRnIxPfMgrbX0I5WB5ii
         MLWWki/EjFIA0auaUmx/0OD0i6xAIt//yNo6N49nyp5hR7rU9C527zkXra7Lxfvm8ozS
         Mc1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RRMCgEzGqBN8kkxXS0K/RYZnnnVmP1dTWb/cIEjKAX8=;
        b=szBfa5tZl8Zr0GpDTObbjMIrz0D7WXDUxBmlvRfSnmmCarU0zT9QBX/N8imNjwaXko
         TZ5Nbwxo1FHdXqHW5B6Az34lYoDNK7XKjQSxEDlEjsipGjwEM7C3ZISTcpJr+iO/4E1u
         jOp/RxDt+Ehp4WpfatFOUeyUQVBXwhYGlRyR4p43P1mptgGHe3irUpkf/iCbJlFwzRU7
         e72r3SAAjd26oE/EtM1bEJTb+PmSCoIwqPSpJUtNdZ55JkkiHjJfotPgOryQgTVOufAJ
         cr6GzGlNuTqYzIMS7O0L/6gdc7xmYor9AUPxjwdYFsYbqBzezJEC8+MC1mMohShf1Eqn
         LOqA==
X-Gm-Message-State: AOAM532vhlR7HQajgFRf9bgYwYKgA67yoDJzV6rJxUZT1PBGZZvWPfCy
        l1l0magoE2ElYAz4ez22fcIYS+oQxtA=
X-Google-Smtp-Source: ABdhPJz5FliVCzbaVcHHnCjPZdnXzIhmDtmOFKggQH/cbYtAw7dihqcXDD7O/uV6aexSPf/tA9tP8Q==
X-Received: by 2002:ac8:5a0b:: with SMTP id n11mr13165122qta.372.1637115045102;
        Tue, 16 Nov 2021 18:10:45 -0800 (PST)
Received: from godwin.fios-router.home (pool-108-18-207-184.washdc.fios.verizon.net. [108.18.207.184])
        by smtp.gmail.com with ESMTPSA id t11sm9326200qkm.96.2021.11.16.18.10.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 18:10:44 -0800 (PST)
From:   Sean Anderson <seanga2@gmail.com>
To:     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Cc:     Mikhail Gusarov <dottedmag@dottedmag.net>,
        Matthew Harm Bekkema <id@mbekkema.name>,
        James Peach <jpeach@apache.org>,
        Sean Anderson <seanga2@gmail.com>
Subject: [PATCH 2/5] unshare: Add waitchild helper
Date:   Tue, 16 Nov 2021 21:10:35 -0500
Message-Id: <20211117021038.823851-3-seanga2@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211117021038.823851-1-seanga2@gmail.com>
References: <20211117021038.823851-1-seanga2@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This refactors out the waitpid() logic into a function which will be
reused for the upcoming patches.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

 sys-utils/unshare.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/sys-utils/unshare.c b/sys-utils/unshare.c
index 3f8287799..540305ee7 100644
--- a/sys-utils/unshare.c
+++ b/sys-utils/unshare.c
@@ -261,6 +261,23 @@ static void bind_ns_files_from_child(pid_t *child, int fds[2])
 	}
 }
 
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
 static uid_t get_user(const char *s, const char *err)
 {
 	struct passwd *pw;
@@ -580,7 +597,6 @@ int main(int argc, char *argv[])
 	if (npersists && (pid || !forkit)) {
 		/* run in parent */
 		if (pid_bind && (unshare_flags & CLONE_NEWNS)) {
-			int rc;
 			char ch = PIPE_SYNC_BYTE;
 
 			/* signal child we are ready */
@@ -589,17 +605,7 @@ int main(int argc, char *argv[])
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

