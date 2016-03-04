Return-Path: ldv@altlinux.org
Date: Sat, 5 Mar 2016 00:22:52 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: [PATCH] setarch: fix personality syscall return code check
Message-ID: <20160304212252.GB22191@altlinux.org>
References: <20160224125641.kw2t37ofjhmealej@ws.net.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160224125641.kw2t37ofjhmealej@ws.net.home>
List-ID: <util-linux.vger.kernel.org>

Depending on architecture and kernel version, personality
syscall is either capable or incapable of returning an error.
If the return value is not an error, then it's the previous
personality value, which can be an arbitrary value
undistinguishable from an error value.
To make things clear, a second call is needed.

For more details about personality syscall peculiarities see
https://sourceware.org/git/gitweb.cgi?p=glibc.git;h=glibc-2.22-637-ge0043e17dfc5

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---
 sys-utils/setarch.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index b6159c5..b5e401c 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -236,8 +236,18 @@ static int set_arch(const char *pers, unsigned long options, int list)
 	if (transitions[i].perval < 0)
 		errx(EXIT_FAILURE, _("%s: Unrecognized architecture"), pers);
 	pers_value = transitions[i].perval | options;
-	if (personality(pers_value) == -EINVAL)
-		return 1;
+	if (personality(pers_value) < 0) {
+		/*
+		 * Depending on architecture and kernel version, personality
+		 * syscall is either capable or incapable of returning an error.
+		 * If the return value is not an error, then it's the previous
+		 * personality value, which can be an arbitrary value
+		 * undistinguishable from an error value.
+		 * To make things clear, a second call is needed.
+		 */
+		if (personality(pers_value) < 0)
+			return 1;
+	}
 	uname(&un);
 	if (transitions[i].result_arch && strcmp(un.machine, transitions[i].result_arch)) {
 		if (strcmp(transitions[i].result_arch, "i386")

-- 
ldv
