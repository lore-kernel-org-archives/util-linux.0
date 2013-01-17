Return-Path: util-linux-owner@vger.kernel.org
Received: from out03.mta.xmission.com ([166.70.13.233]:33749 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757751Ab3AQAfY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 16 Jan 2013 19:35:24 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Karel Zak <kzak@redhat.com>
Cc: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org,
        Neil Horman <nhorman@tuxdriver.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Michael Kerrisk \(man-pages\)" <mtk.manpages@gmail.com>
References: <876234812z.fsf@xmission.com> <20130111161320.GA16206@x2.net.home>
	<87fw27jq29.fsf_-_@xmission.com>
	<201301111845.16591.vapier@gentoo.org>
	<20130114082846.GA16421@x2.net.home> <87a9s8lkbq.fsf_-_@xmission.com>
Date: Wed, 16 Jan 2013 16:35:12 -0800
In-Reply-To: <87a9s8lkbq.fsf_-_@xmission.com> (Eric W. Biederman's message of
	"Wed, 16 Jan 2013 16:33:29 -0800")
Message-ID: <87sj60k5of.fsf_-_@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [PATCH 3/5] nsenter: Add const to declarations where possible.
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Make it clear where functions do not modify their arguments.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 sys-utils/nsenter.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
index d7d65f9..5b8d9c4 100644
--- a/sys-utils/nsenter.c
+++ b/sys-utils/nsenter.c
@@ -60,7 +60,7 @@ static int setns(int fd, int nstype)
 
 static struct namespace_file{
 	int nstype;
-	char *name;
+	const char *name;
 	int fd;
 } namespace_files[] = {
 	/* Careful the order is significant in this array.
@@ -109,7 +109,7 @@ static pid_t namespace_target_pid = 0;
 static int root_fd = -1;
 static int wd_fd = -1;
 
-static void open_target_fd(int *fd, const char *type, char *path)
+static void open_target_fd(int *fd, const char *type, const char *path)
 {
 	char pathbuf[PATH_MAX];
 
@@ -130,7 +130,7 @@ static void open_target_fd(int *fd, const char *type, char *path)
 		err(EXIT_FAILURE, _("open of '%s' failed"), path);
 }
 
-static void open_namespace_fd(int nstype, char *path)
+static void open_namespace_fd(int nstype, const char *path)
 {
 	struct namespace_file *nsfile;
 
-- 
1.7.5.4

