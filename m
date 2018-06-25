Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:53857 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933391AbeFYMSd (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 25 Jun 2018 08:18:33 -0400
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0MVeCF-1fft3f065n-00YzQp for <util-linux@vger.kernel.org>; Mon, 25 Jun 2018
 14:18:32 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] ipcs,chmem: fix access() usage
Date: Mon, 25 Jun 2018 14:18:31 +0200
Message-Id: <20180625121831.14610-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Some mistakes happened lately when switching from path_exist()
to ul_path_access(). See f09a98de and 8ca31279.

This caused ipcs tests failures when running i386 binaries on x86_64
hosts, because the syscall fallback was always used. That's why I
reviewed all similar changes and found another one in chmem.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/chmem.c    |  2 +-
 sys-utils/ipcutils.c | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sys-utils/chmem.c b/sys-utils/chmem.c
index e5eab096a..4a4439a22 100644
--- a/sys-utils/chmem.c
+++ b/sys-utils/chmem.c
@@ -428,7 +428,7 @@ int main(int argc, char **argv)
 
 
 	/* The valid_zones sysfs attribute was introduced with kernel 3.18 */
-	if (ul_path_access(desc->sysmem, F_OK, "memory0/valid_zones"))
+	if (ul_path_access(desc->sysmem, F_OK, "memory0/valid_zones") == 0)
 		desc->have_zones = 1;
 	else if (zone)
 		warnx(_("zone ignored, no valid_zones sysfs attribute present"));
diff --git a/sys-utils/ipcutils.c b/sys-utils/ipcutils.c
index e6dd0c561..5fe297fd4 100644
--- a/sys-utils/ipcutils.c
+++ b/sys-utils/ipcutils.c
@@ -18,9 +18,9 @@
 
 int ipc_msg_get_limits(struct ipc_limits *lim)
 {
-	if (access(_PATH_PROC_IPC_MSGMNI, F_OK) &&
-	    access(_PATH_PROC_IPC_MSGMNB, F_OK) &&
-	    access(_PATH_PROC_IPC_MSGMAX, F_OK)) {
+	if (access(_PATH_PROC_IPC_MSGMNI, F_OK) == 0 &&
+	    access(_PATH_PROC_IPC_MSGMNB, F_OK) == 0 &&
+	    access(_PATH_PROC_IPC_MSGMAX, F_OK) == 0) {
 
 		ul_path_read_s32(NULL, &lim->msgmni, _PATH_PROC_IPC_MSGMNI);
 		ul_path_read_s32(NULL, &lim->msgmnb, _PATH_PROC_IPC_MSGMNB);
@@ -71,9 +71,9 @@ int ipc_shm_get_limits(struct ipc_limits *lim)
 {
 	lim->shmmin = SHMMIN;
 
-	if (access(_PATH_PROC_IPC_SHMALL, F_OK) &&
-	    access(_PATH_PROC_IPC_SHMMAX, F_OK) &&
-	    access(_PATH_PROC_IPC_SHMMNI, F_OK)) {
+	if (access(_PATH_PROC_IPC_SHMALL, F_OK) == 0 &&
+	    access(_PATH_PROC_IPC_SHMMAX, F_OK) == 0 &&
+	    access(_PATH_PROC_IPC_SHMMNI, F_OK) == 0) {
 
 		ul_path_read_u64(NULL, &lim->shmall, _PATH_PROC_IPC_SHMALL);
 		ul_path_read_u64(NULL, &lim->shmmax, _PATH_PROC_IPC_SHMMAX);
-- 
2.13.7

