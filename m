Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:59577 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754178AbeCGJkZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 7 Mar 2018 04:40:25 -0500
Received: from tenfore.ga-group.nl ([92.195.17.205]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MfAog-1f4122045K-00OpNI for
 <util-linux@vger.kernel.org>; Wed, 07 Mar 2018 10:40:24 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] uuidd: don't truncate long socket paths
Date: Wed,  7 Mar 2018 10:40:23 +0100
Message-Id: <20180307094023.21198-1-sweet_f_a@gmx.de>
In-Reply-To: <a1b8906b-0077-79c9-db5a-2d91756c2ebb@gentoo.org>
References: <a1b8906b-0077-79c9-db5a-2d91756c2ebb@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This was the error
  uuidd: couldn't bind unix socket /var/tmp/portage/sys-apps/util-linux-2.31.1/work/util-linux-2.31.1-abi_x86_64.amd64/tests/output/uuid/uuiddkOcTUuoZ7kaP3: Address already in use

because the socket path was truncated to 108 chars which was luckily
an existing directory.

Now we abort early with "uuidd: socket name too long: ... "

Reported-by: Thomas Deutschmann <whissi@gentoo.org>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 misc-utils/uuidd.c  | 12 ++++++++----
 tests/ts/uuid/uuidd |  3 ++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index e7c25cfa1..ca2ae8cf7 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -118,8 +118,8 @@ static int call_daemon(const char *socket_path, int op, char *buf,
 	}
 
 	srv_addr.sun_family = AF_UNIX;
-	strncpy(srv_addr.sun_path, socket_path, sizeof(srv_addr.sun_path));
-	srv_addr.sun_path[sizeof(srv_addr.sun_path) - 1] = '\0';
+	assert(strlen(socket_path) < sizeof(srv_addr.sun_path));
+	xstrncpy(srv_addr.sun_path, socket_path, sizeof(srv_addr.sun_path));
 
 	if (connect(s, (const struct sockaddr *) &srv_addr,
 		    sizeof(struct sockaddr_un)) < 0) {
@@ -252,8 +252,8 @@ static int create_socket(struct uuidd_cxt_t *uuidd_cxt,
 	 * Create the address we will be binding to.
 	 */
 	my_addr.sun_family = AF_UNIX;
-	strncpy(my_addr.sun_path, socket_path, sizeof(my_addr.sun_path));
-	my_addr.sun_path[sizeof(my_addr.sun_path) - 1] = '\0';
+	assert(strlen(socket_path) < sizeof(my_addr.sun_path));
+	xstrncpy(my_addr.sun_path, socket_path, sizeof(my_addr.sun_path));
 	unlink(socket_path);
 	save_umask = umask(0);
 	if (bind(s, (const struct sockaddr *) &my_addr,
@@ -636,6 +636,10 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (strlen(socket_path) >= sizeof(((struct sockaddr_un *)0)->sun_path)) {
+		errx(EXIT_FAILURE, _("socket name too long: %s"), socket_path);
+	}
+
 	if (!no_pid && !pidfile_path)
 		pidfile_path = UUIDD_PIDFILE_PATH;
 
diff --git a/tests/ts/uuid/uuidd b/tests/ts/uuid/uuidd
index 17cf29d06..16dc45e3f 100755
--- a/tests/ts/uuid/uuidd
+++ b/tests/ts/uuid/uuidd
@@ -23,7 +23,8 @@ ts_check_test_command "$TS_CMD_UUIDD"
 
 OUTPUT_FILE="$(mktemp "${TS_OUTDIR}/uuiddXXXXXXXXXXXXX")"
 UUIDD_PID="$(mktemp -u "${TS_OUTDIR}/uuiddXXXXXXXXXXXXX")"
-UUIDD_SOCKET="$(mktemp -u "${TS_OUTDIR}/uuiddXXXXXXXXXXXXX")"
+# socket path must be short (SIZEOF_SOCKADDR_UN_SUN_PATH 108)
+UUIDD_SOCKET=$(mktemp "/tmp/ultest-$TS_COMPONENT-$TS_TESTNAME-socketXXXXXX")
 
 $TS_CMD_UUIDD -p "$UUIDD_PID" -s "$UUIDD_SOCKET"
 if [ $? -ne 0 ]; then
-- 
2.13.6

