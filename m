Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34367 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1046002AbdDWU6j (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 23 Apr 2017 16:58:39 -0400
Received: by mail-wr0-f196.google.com with SMTP id 6so4236645wrb.1
        for <util-linux@vger.kernel.org>; Sun, 23 Apr 2017 13:58:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 01/10] lsipc: fix options parsing and sync with man page
Date: Sun, 23 Apr 2017 21:58:12 +0100
Message-Id: <20170423205821.7444-2-kerolasa@iki.fi>
In-Reply-To: <20170423205821.7444-1-kerolasa@iki.fi>
References: <20170423205821.7444-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Option --pid was never implemented so remove it from struct options and
manual page.  Interestingly this option was not in usage().  Short option
string had 'u' that has never appear anywhere else, so it is also removed.
Finally add options --bytes and --numeric-perms to manual page.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/lsipc.1 | 7 +++++--
 sys-utils/lsipc.c | 3 +--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sys-utils/lsipc.1 b/sys-utils/lsipc.1
index 69f0cf197..9bb1dce91 100644
--- a/sys-utils/lsipc.1
+++ b/sys-utils/lsipc.1
@@ -74,8 +74,8 @@ Specify which output columns to print.  Use
 .B \-\-help
 to get a list of all supported columns.
 .TP
-\fB\-p\fR, \fB\-\-pid\fR
-Show PIDs of creator and last operator.
+\fB\-b\fR, \fB\-\-bytes\fR
+Print size in bytes rather than in human readable format.
 .TP
 \fB\-r\fR, \fB\-\-raw\fR
 Raw output (no columnation).
@@ -97,6 +97,9 @@ operation on semaphores.
 \fB\-\-time\-format\fR \fItype\fP
 Display dates in short, full or iso format.  The default is short, this time
 format is designed to be space efficient and human readable.
+.TP
+\fB\-P\fR, \fB\-\-numeric\-perms\fR
+Print numeric permissions in PERMS column.
 
 .SH EXIT STATUS
 .TP
diff --git a/sys-utils/lsipc.c b/sys-utils/lsipc.c
index ee203e02a..239aaf5d7 100644
--- a/sys-utils/lsipc.c
+++ b/sys-utils/lsipc.c
@@ -1094,7 +1094,6 @@ int main(int argc, char *argv[])
 		{ "notruncate",     no_argument,	NULL, OPT_NOTRUNC },
 		{ "numeric-perms",  no_argument,	NULL, 'P' },
 		{ "output",         required_argument,	NULL, 'o' },
-		{ "pid",            no_argument,	NULL, 'p' },
 		{ "queues",         no_argument,	NULL, 'q' },
 		{ "raw",            no_argument,	NULL, 'r' },
 		{ "semaphores",     no_argument,	NULL, 's' },
@@ -1123,7 +1122,7 @@ int main(int argc, char *argv[])
 
 	scols_init_debug(0);
 
-	while ((opt = getopt_long(argc, argv, "bceghi:Jlmno:PqrstuV", longopts, NULL)) != -1) {
+	while ((opt = getopt_long(argc, argv, "bceghi:Jlmno:PqrstV", longopts, NULL)) != -1) {
 
 		err_exclusive_options(opt, longopts, excl, excl_st);
 
-- 
2.12.2

