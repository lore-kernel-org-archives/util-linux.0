Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 33/49] login: remove unnecessary variables
Date: Mon, 17 Oct 2011 13:15:12 +0200
Message-Id: <1318850128-23458-34-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index ffde1af..fba8fdd 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1041,10 +1041,8 @@ static void init_environ(struct login_context *cxt)
 
 int main(int argc, char **argv)
 {
-	extern int optind;
-	extern char *optarg, **environ;
-	register int ch;
-	register char *p;
+	int c;
+	char *p;
 	int cnt;
 	char *domain;
 	char tbuf[PATH_MAX + 2];
@@ -1083,8 +1081,8 @@ int main(int argc, char **argv)
 	gethostname(tbuf, sizeof(tbuf));
 	domain = strchr(tbuf, '.');
 
-	while ((ch = getopt(argc, argv, "fh:p")) != -1)
-		switch (ch) {
+	while ((c = getopt(argc, argv, "fh:p")) != -1)
+		switch (c) {
 		case 'f':
 			cxt.noauth = 1;
 			break;
-- 
1.7.6.4
