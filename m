Return-Path: <SRS0=dIn1=7M=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A33DC433E0
	for <util-linux@archiver.kernel.org>; Sat, 30 May 2020 14:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A604920723
	for <util-linux@archiver.kernel.org>; Sat, 30 May 2020 14:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="POfTNdKr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgE3OH6 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 30 May 2020 10:07:58 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:44594 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727851AbgE3OH6 (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Sat, 30 May 2020 10:07:58 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 9E4DA2E14D8
        for <util-linux@vger.kernel.org>; Sat, 30 May 2020 17:07:54 +0300 (MSK)
Received: from iva4-7c3d9abce76c.qloud-c.yandex.net (iva4-7c3d9abce76c.qloud-c.yandex.net [2a02:6b8:c0c:4e8e:0:640:7c3d:9abc])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id lORyuSzDWl-7rIarxN6;
        Sat, 30 May 2020 17:07:54 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1590847674; bh=URzsery+zgQSv9aYgg6vpSImVJFHOcBzwpVc4VMkoys=;
        h=Message-ID:Date:To:From:Subject;
        b=POfTNdKrpt6G7SgFc5VTrXyPVyktQp6yc/S4ynNmLaSCAwyYuWDc3ctusS2cPHjO6
         VqqsgWk+03Qsg0MaBJUFJpxM37xu2uTh1Om43V6zF4nJC2uZAZdX+gyo4pDlTBEgRo
         jtrvQN+x7MgPD0WkAtzVAA1CvfMzOUq+5+KKvETc=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:8218::1:0])
        by iva4-7c3d9abce76c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 4oHasFvvT0-7rW0k7dq;
        Sat, 30 May 2020 17:07:53 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: [PATCH] dmesg: add --follow-new
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     util-linux@vger.kernel.org
Date:   Sat, 30 May 2020 17:07:53 +0300
Message-ID: <159084767331.127122.9117317049390963928.stgit@buzz>
User-Agent: StGit/0.22-39-gd257
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Option --follow-new (-W) works the same as --follow (-w) but initially
seeks to the end of kernel ring buffer, so it prints only new messages.
Useful for capturing kernel messages during actions without past log.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
---
 bash-completion/dmesg |    1 +
 sys-utils/dmesg.1     |    3 +++
 sys-utils/dmesg.c     |   11 +++++++++--
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/bash-completion/dmesg b/bash-completion/dmesg
index 319605f8ee39..02f2fc7a62d4 100644
--- a/bash-completion/dmesg
+++ b/bash-completion/dmesg
@@ -55,6 +55,7 @@ _dmesg_module()
 		--time-format
 		--userspace
 		--follow
+		--follow-new
 		--decode
 		--help
 		--version"
diff --git a/sys-utils/dmesg.1 b/sys-utils/dmesg.1
index 31bfb56f3f5e..61a6ce89465d 100644
--- a/sys-utils/dmesg.1
+++ b/sys-utils/dmesg.1
@@ -193,6 +193,9 @@ Print userspace messages.
 Wait for new messages.  This feature is supported only on systems with
 a readable /dev/kmsg (since kernel 3.5.0).
 .TP
+.BR \-W , " \-\-follow-new"
+Wait and print only new messages.
+.TP
 .BR \-x , " \-\-decode"
 Decode facility and level (priority) numbers to human-readable prefixes.
 .TP
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 1eb7cde3c1b2..ae1ebc74a2d9 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -190,6 +190,7 @@ struct dmesg_control {
 	unsigned int	time_fmt;	/* time format */
 
 	unsigned int	follow:1,	/* wait for new messages */
+			end:1,		/* seek to the of buffer */
 			raw:1,		/* raw mode */
 			noesc:1,	/* no escape */
 			fltr_lev:1,	/* filter out by levels[] */
@@ -292,6 +293,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -s, --buffer-size <size>    buffer size to query the kernel ring buffer\n"), out);
 	fputs(_(" -u, --userspace             display userspace messages\n"), out);
 	fputs(_(" -w, --follow                wait for new messages\n"), out);
+	fputs(_(" -W, --follow-new            wait and print only new messages\n"), out);
 	fputs(_(" -x, --decode                decode facility and level to readable string\n"), out);
 	fputs(_(" -d, --show-delta            show time delta between printed messages\n"), out);
 	fputs(_(" -e, --reltime               show local time and time delta in readable format\n"), out);
@@ -1127,7 +1129,7 @@ static int init_kmsg(struct dmesg_control *ctl)
 	 *
 	 * ... otherwise SYSLOG_ACTION_CLEAR will have no effect for kmsg.
 	 */
-	lseek(ctl->kmsg, 0, SEEK_DATA);
+	lseek(ctl->kmsg, 0, ctl->end ? SEEK_END : SEEK_DATA);
 
 	/*
 	 * Old kernels (<3.5) allow to successfully open /dev/kmsg for
@@ -1336,6 +1338,7 @@ int main(int argc, char *argv[])
 		{ "file",          required_argument, NULL, 'F' },
 		{ "facility",      required_argument, NULL, 'f' },
 		{ "follow",        no_argument,       NULL, 'w' },
+		{ "follow-new",    no_argument,       NULL, 'W' },
 		{ "human",         no_argument,       NULL, 'H' },
 		{ "help",          no_argument,	      NULL, 'h' },
 		{ "kernel",        no_argument,       NULL, 'k' },
@@ -1375,7 +1378,7 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	close_stdout_atexit();
 
-	while ((c = getopt_long(argc, argv, "CcDdEeF:f:HhkL::l:n:iPprSs:TtuVwx",
+	while ((c = getopt_long(argc, argv, "CcDdEeF:f:HhkL::l:n:iPprSs:TtuVWwx",
 				longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
@@ -1466,6 +1469,10 @@ int main(int argc, char *argv[])
 		case 'w':
 			ctl.follow = 1;
 			break;
+		case 'W':
+			ctl.follow = 1;
+			ctl.end = 1;
+			break;
 		case 'x':
 			ctl.decode = 1;
 			break;

