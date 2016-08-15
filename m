Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33650 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752748AbcHOKWh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 15 Aug 2016 06:22:37 -0400
Received: by mail-wm0-f66.google.com with SMTP id o80so10375259wme.0
        for <util-linux@vger.kernel.org>; Mon, 15 Aug 2016 03:22:36 -0700 (PDT)
Received: from grayswandir.berep.pl (89-72-45-26.dynamic.chello.pl. [89.72.45.26])
        by smtp.gmail.com with ESMTPSA id vv2sm20757366wjc.29.2016.08.15.03.22.34
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 03:22:34 -0700 (PDT)
From: =?UTF-8?q?Micha=C5=82=20Bartoszkiewicz?=
	<mbartoszkiewicz@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH v2] lsns: support cgroup namespaces
Date: Mon, 15 Aug 2016 12:22:30 +0200
Message-Id: <20160815102230.7552-1-mbartoszkiewicz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Michał Bartoszkiewicz <mbartoszkiewicz@gmail.com>
---
 sys-utils/lsns.8 | 4 ++--
 sys-utils/lsns.c | 8 +++++---
 2 files changed, 7 insertions(+), 5 deletions(-)

Changes in v2:
Added the new type to usage.

diff --git a/sys-utils/lsns.8 b/sys-utils/lsns.8
index 9fe22f1..7ea1cb3 100644
--- a/sys-utils/lsns.8
+++ b/sys-utils/lsns.8
@@ -54,8 +54,8 @@ Use the raw output format.
 .TP
 .BR \-t , " \-\-type " \fItype\fP
 Display the specified \fItype\fP of namespaces only.  The supported types are
-\fBmnt\fP, \fBnet\fP, \fBipc\fP, \fBuser\fP, \fBpid\fP and \fButs\fP.  This
-option may be given more than once.
+\fBmnt\fP, \fBnet\fP, \fBipc\fP, \fBuser\fP, \fBpid\fP, \fButs\fP and
+\fBcgroup\fP.  This option may be given more than once.
 .TP
 .BR \-u , " \-\-notruncate"
 Do not truncate text in columns.
diff --git a/sys-utils/lsns.c b/sys-utils/lsns.c
index 75c04f8..278598a 100644
--- a/sys-utils/lsns.c
+++ b/sys-utils/lsns.c
@@ -100,7 +100,8 @@ enum {
 	LSNS_ID_PID,
 	LSNS_ID_UTS,
 	LSNS_ID_IPC,
-	LSNS_ID_USER
+	LSNS_ID_USER,
+	LSNS_ID_CGROUP
 };
 
 static char *ns_names[] = {
@@ -109,7 +110,8 @@ static char *ns_names[] = {
 	[LSNS_ID_PID] = "pid",
 	[LSNS_ID_UTS] = "uts",
 	[LSNS_ID_IPC] = "ipc",
-	[LSNS_ID_USER] = "user"
+	[LSNS_ID_USER] = "user",
+	[LSNS_ID_CGROUP] = "cgroup"
 };
 
 struct lsns_namespace {
@@ -599,7 +601,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_(" -p, --task <pid>       print process namespaces\n"), out);
 	fputs(_(" -r, --raw              use the raw output format\n"), out);
 	fputs(_(" -u, --notruncate       don't truncate text in columns\n"), out);
-	fputs(_(" -t, --type <name>      namespace type (mnt, net, ipc, user, pid, uts)\n"), out);
+	fputs(_(" -t, --type <name>      namespace type (mnt, net, ipc, user, pid, uts, cgroup)\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
-- 
2.9.2

