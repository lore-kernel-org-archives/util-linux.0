Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38956 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756272AbaDHHs5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 8 Apr 2014 03:48:57 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s387mviD007711
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:57 -0400
Received: from redhat.brq.redhat.com (unused-4-202.brq.redhat.com [10.34.4.202])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id s387moTo004800
	for <util-linux@vger.kernel.org>; Tue, 8 Apr 2014 03:48:56 -0400
From: Ondrej Oprala <ooprala@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 06/10] nologin: minor man page improvements
Date: Tue,  8 Apr 2014 09:48:45 +0200
Message-Id: <1396943329-22347-7-git-send-email-ooprala@redhat.com>
In-Reply-To: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
References: <1396943329-22347-1-git-send-email-ooprala@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Ondrej Oprala <ooprala@redhat.com>
---
 login-utils/nologin.8 | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/login-utils/nologin.8 b/login-utils/nologin.8
index f91029d..269daf5 100644
--- a/login-utils/nologin.8
+++ b/login-utils/nologin.8
@@ -9,7 +9,7 @@ nologin \- politely refuse a login
 .SH DESCRIPTION
 .B nologin
 displays a message that an account is not available and exits non-zero.  It is
-intended as a replacement shell field to deny login access to account.
+intended as a replacement shell field to deny login access to an account.
 .PP
 If the file /etc/nologin.txt exists, nologin displays its contents to the 
 user instead of the default message.
@@ -25,15 +25,15 @@ Display help text and exit.
 Display version information and exit.
 .SH NOTES
 .B nologin
-is per-account way to disable login (usually used for system accounts like http or ftp).
+is a per-account way to disable login (usually used for system accounts like http or ftp).
 .BR nologin (8)
-uses /etc/nologin.txt as optional source for non-default message, the login
-access is always refused independently on the file.
+uses /etc/nologin.txt as an optional source for a non-default message, the login
+access is always refused independently of the file.
 .PP
 .BR pam_nologin (8)
 PAM module usually prevents all non-root users from logging into the system.
 .BR pam_nologin (8)
-functionality is controlled by /var/run/nologin or /etc/nologin file.
+functionality is controlled by /var/run/nologin or the /etc/nologin file.
 .SH AUTHORS
 .UR kzak@redhat.com
 Karel Zak
-- 
1.8.5.1

