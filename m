Return-Path: util-linux-owner@vger.kernel.org
Received: from cosmos.geomatys.fr ([88.191.17.20]:53531 "EHLO
	cosmos.geomatys.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935420Ab1ETMQr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 20 May 2011 08:16:47 -0400
Received: from [10.234.175.50] (unknown [193.252.149.222])
	by cosmos.geomatys.fr (Postfix) with ESMTPSA id DFDF01200038
	for <util-linux@vger.kernel.org>; Fri, 20 May 2011 14:06:21 +0200 (CEST)
Message-ID: <4DD6593D.2090202@geomatys.fr>
Date: Fri, 20 May 2011 14:06:21 +0200
From: "corentin.labbe" <corentin.labbe@geomatys.fr>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] dmesg.c: print human readable timestamp
Content-Type: multipart/mixed;
 boundary="------------020201020107020808040000"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------020201020107020808040000
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello

This patch add the -H option to dmesg which allow to print human readable time instead of the number of seconds since boot.

Best regards,

--------------020201020107020808040000
Content-Type: text/x-patch;
 name="dmesg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg.patch"

--- dmesg.c.orig	2011-05-20 13:32:58.000000000 +0200
+++ dmesg.c	2011-05-20 13:58:09.000000000 +0200
@@ -35,6 +35,11 @@
 #include <stdlib.h>
 #include <sys/klog.h>
 #include <ctype.h>
+#include <sys/sysinfo.h>
+#include <time.h>
+#include <sys/time.h>
+#include <error.h>
+#include <errno.h>
 
 #include "c.h"
 #include "nls.h"
@@ -44,7 +49,7 @@
 static void __attribute__ ((noreturn)) usage(void)
 {
 	fprintf(stderr,
-		_("Usage: %s [-c] [-n level] [-r] [-s bufsize]\n"),
+		_("Usage: %s [-c] [-n level] [-r] [-s bufsize] [-H]\n"),
 		program_invocation_short_name);
 	exit(EXIT_FAILURE);
 
@@ -62,12 +67,16 @@
 	int  lastc;
 	int  cmd = 3;		/* Read all messages in the ring buffer */
 	int  raw = 0;
+	int hr = 0;/* hr for human readable*/
+	char *hr_date = NULL;
+	struct sysinfo info;
+	struct timeval mytv;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 
-	while ((c = getopt(argc, argv, "crn:s:")) != -1) {
+	while ((c = getopt(argc, argv, "Hcrn:s:")) != -1) {
 		switch (c) {
 		case 'c':
 			cmd = 4;	/* Read and clear all messages */
@@ -79,6 +88,9 @@
 		case 'r':
 			raw = 1;
 			break;
+		case 'H':
+			hr = 1;
+			break;
 		case 's':
 			bufsize = strtol_or_err(optarg, _("failed to parse buffer size"));
 			if (bufsize < 4096)
@@ -140,12 +152,58 @@
 			if (buf[i] == '>')
 				i++;
 		}
+		if (hr > 0 && i > 0 && buf[i] == '[' && buf[i-1] == '>' && (buf[i+1] == ' ' || (buf[i+1] >= '0' && buf[i+1] <= '9'))) {
+			i++;
+			/* we will read all between those [] and convert them */
+			/* zap all spaces */
+			while (buf[i] == ' ')
+				i++;
+			hr = i;/* start of timestamp*/
+			while (buf[i] != '.')
+				i++;
+			/* end of timestamp */
+			buf[i] = '\0';
+			if (sysinfo(&info) != 0) {
+				error(0, errno, "sysinfo error\n");
+				free(buf);
+				free(hr_date);
+				exit(EXIT_FAILURE);
+			}
+			if (gettimeofday(&mytv, NULL) != 0) {
+				error(0, errno, "gettimeofday error\n");
+				free(buf);
+				free(hr_date);
+				exit(EXIT_FAILURE);
+			}
+			mytv.tv_sec -= info.uptime;
+			mytv.tv_sec += strtol(buf + hr, NULL, 10);
+			if (hr_date == NULL)
+				hr_date = malloc(256);/* ctime_r expect a buffer of 26 at minmum, 256 is enought */
+			if (hr_date == NULL) {
+				error(0, errno, "malloc error\n");
+				free(buf);
+				exit(EXIT_FAILURE);
+			}
+			if (ctime_r(&mytv.tv_sec, hr_date) == NULL) {
+				error(0, errno, "ctime_r error\n");
+				free(buf);
+				free(hr_date);
+				exit(EXIT_FAILURE);
+			}
+			hr_date[strlen(hr_date) - 1] = '\0';
+			printf("[%s]", hr_date);
+			i++;
+			while (buf[i] != ']')
+				i++;
+			i++;
+		}
 		lastc = buf[i];
 		putchar(lastc);
 	}
 	if (lastc != '\n')
 		putchar('\n');
 	free(buf);
+	free(hr_date);
 
 	return EXIT_SUCCESS;
 }

--------------020201020107020808040000--
