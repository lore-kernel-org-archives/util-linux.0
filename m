Return-Path: util-linux-owner@vger.kernel.org
Received: from sonata.ens-lyon.org ([140.77.166.138]:55918 "EHLO
	sonata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbbARTKV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 Jan 2015 14:10:21 -0500
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id E27C2200A3
	for <util-linux@vger.kernel.org>; Sun, 18 Jan 2015 20:10:18 +0100 (CET)
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pO5BWlWfWPtd for <util-linux@vger.kernel.org>;
	Sun, 18 Jan 2015 20:10:18 +0100 (CET)
Received: from type.youpi.perso.aquilenet.fr (youpi.perso.aquilenet.fr [80.67.176.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 9113E2009E
	for <util-linux@vger.kernel.org>; Sun, 18 Jan 2015 20:10:18 +0100 (CET)
Received: from samy by type.youpi.perso.aquilenet.fr with local (Exim 4.84)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1YCvEm-0006BV-1D
	for util-linux@vger.kernel.org; Sun, 18 Jan 2015 20:10:16 +0100
Date: Sun, 18 Jan 2015 20:10:16 +0100
From: Samuel Thibault <sthibault@debian.org>
To: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.26-rc1
Message-ID: <20150118191015.GI2957@type.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2qXFWqzzG3v1+95a"
In-Reply-To: <20150114194608.GF28019@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

Here is a fix for systems which don't have sys/timex.h and its
ntp_gettime().

Samuel

--2qXFWqzzG3v1+95a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch

diff --git a/configure.ac b/configure.ac
index 3d77307..fce7e0e 100644
--- a/configure.ac
+++ b/configure.ac
@@ -230,6 +230,7 @@ AC_CHECK_HEADERS([ \
 	sys/swap.h \
 	sys/syscall.h \
 	sys/time.h \
+	sys/timex.h \
 	sys/ttydefaults.h \
 	sys/types.h \
 	sys/un.h \
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 35caf9d..6be6033 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -44,7 +44,9 @@
 #include <stdio.h>
 #include <ctype.h>
 #include <string.h>
+#ifdef HAVE_SYS_TIMEX_H
 #include <sys/timex.h>
+#endif
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/un.h>
@@ -325,7 +327,9 @@ static void syslog_rfc5424(const  struct logger_ctl *ctl, const char *msg)
 {
 	char *buf, *tag = NULL, *hostname = NULL;
 	char pid[32], time[64], timeq[80];
+#ifdef HAVE_SYS_TIMEX_H
 	struct ntptimeval ntptv;
+#endif
 	struct timeval tv;
 	struct tm *tm;
 	int len;
@@ -363,6 +367,7 @@ static void syslog_rfc5424(const  struct logger_ctl *ctl, const char *msg)
 	if (ctl->pid)
 		snprintf(pid, sizeof(pid), " %d", ctl->pid);
 
+#ifdef HAVE_SYS_TIMEX_H
 	if (ctl->rfc5424_tq) {
 		if (ntp_gettime(&ntptv) == TIME_OK)
 			snprintf(timeq, sizeof(timeq),
@@ -372,6 +377,7 @@ static void syslog_rfc5424(const  struct logger_ctl *ctl, const char *msg)
 			snprintf(timeq, sizeof(timeq),
 				 " [timeQuality tzKnown=\"1\" isSynced=\"0\"]");
 	}
+#endif
 
 	len = xasprintf(&buf, "<%d>1%s%s%s %s -%s%s %s", ctl->pri, time,
 		  hostname ? " " : "",

--2qXFWqzzG3v1+95a--
