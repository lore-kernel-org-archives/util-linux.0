Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35014 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752328AbcHOJvB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 15 Aug 2016 05:51:01 -0400
Received: by mail-wm0-f66.google.com with SMTP id i5so10226428wmg.2
        for <util-linux@vger.kernel.org>; Mon, 15 Aug 2016 02:51:00 -0700 (PDT)
Received: from grayswandir.berep.pl (89-72-45-26.dynamic.chello.pl. [89.72.45.26])
        by smtp.gmail.com with ESMTPSA id o36sm3274908lfi.5.2016.08.15.02.50.58
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 02:50:59 -0700 (PDT)
From: =?UTF-8?q?Micha=C5=82=20Bartoszkiewicz?=
	<mbartoszkiewicz@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] lsns: support cgroup namespaces
Date: Mon, 15 Aug 2016 11:50:52 +0200
Message-Id: <20160815095052.24450-1-mbartoszkiewicz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Michał Bartoszkiewicz <mbartoszkiewicz@gmail.com>
---
 sys-utils/lsns.8 | 4 ++--
 sys-utils/lsns.c | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

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
index 75c04f8..b21e600 100644
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
-- 
2.9.2

