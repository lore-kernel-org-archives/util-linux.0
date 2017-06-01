Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:51361 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751097AbdFABIo (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 31 May 2017 21:08:44 -0400
Received: from tenfore.ga-group.nl ([77.12.147.210]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LnxQO-1drmL42Nom-00fz6p for
 <util-linux@vger.kernel.org>; Thu, 01 Jun 2017 03:08:42 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/6] misc: fix some warnings
Date: Thu,  1 Jun 2017 03:08:40 +0200
Message-Id: <1496279320-14541-7-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
References: <1496279320-14541-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

sys-utils/prlimit.c: In function 'do_prlimit':
sys-utils/prlimit.c:367:16: warning: format '%ju' expects argument of type 'uintmax_t', but argument 2 has type 'rlim_t {aka long long unsigned int}' [-Wformat=]
     printf("<%ju", new->rlim_cur);

lib/plymouth-ctrl.c: In function 'open_un_socket_and_connect':
lib/plymouth-ctrl.c:88:20: warning: passing argument 2 of 'connect' from incompatible pointer type [-Wincompatible-pointer-types]
  ret = connect(fd, &su, offsetof(struct sockaddr_un, sun_path) + 1 + strlen(su.sun_path+1));
                    ^
In file included from lib/plymouth-ctrl.c:35:0:
/usr/include/sys/socket.h:314:5: note: expected 'const struct sockaddr *' but argument is of type 'struct sockaddr_un *'
 int connect (int, const struct sockaddr *, socklen_t);

login-utils/last.c: In function 'list':
login-utils/last.c:506:54: warning: pointer targets in passing argument 4 of 'dns_lookup' differ in signedness [-Wpointer-sign]
   r = dns_lookup(domain, sizeof(domain), ctl->useip, p->ut_addr_v6);
                                                      ^
login-utils/last.c:291:12: note: expected 'int32_t * {aka int *}' but argument is of type 'unsigned int *'
 static int dns_lookup(char *result, int size, int useip, int32_t *a)
            ^~~~~~~~~~

In file included from sys-utils/hwclock-cmos.c:92:0:
sys-utils/hwclock.h:67:32: warning: 'struct timeval' declared inside parameter list will not be visible outside of this definition or declaration
 extern double time_diff(struct timeval subtrahend, struct timeval subtractor);

misc-utils/test_uuidd.c: In function 'create_nthreads':
misc-utils/test_uuidd.c:187:19: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
        proc->pid, (int) th->tid, th->index));

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 lib/plymouth-ctrl.c     |  3 ++-
 login-utils/last.c      |  2 +-
 misc-utils/test_uuidd.c | 10 +++++-----
 sys-utils/hwclock.h     |  1 +
 sys-utils/prlimit.c     |  4 ++--
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/lib/plymouth-ctrl.c b/lib/plymouth-ctrl.c
index 75d8b93..0e60341 100644
--- a/lib/plymouth-ctrl.c
+++ b/lib/plymouth-ctrl.c
@@ -85,7 +85,8 @@ static int open_un_socket_and_connect(void)
 	 * Please note that the PLYMOUTH_SOCKET_PATH has a
 	 * leading NULL byte to mark it as an abstract socket
 	 */
-	ret = connect(fd, &su, offsetof(struct sockaddr_un, sun_path) + 1 + strlen(su.sun_path+1));
+	ret = connect(fd, (const struct sockaddr *) &su,
+	              offsetof(struct sockaddr_un, sun_path) + 1 + strlen(su.sun_path+1));
 	if (ret < 0) {
 		if (errno != ECONNREFUSED)
 			warnx(_("cannot connect on UNIX socket"));
diff --git a/login-utils/last.c b/login-utils/last.c
index 679ea6c..f93ec7f 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -503,7 +503,7 @@ static int list(const struct last_control *ctl, struct utmpx *p, time_t logout_t
 	 */
 	r = -1;
 	if (ctl->usedns || ctl->useip)
-		r = dns_lookup(domain, sizeof(domain), ctl->useip, p->ut_addr_v6);
+		r = dns_lookup(domain, sizeof(domain), ctl->useip, (int32_t*)p->ut_addr_v6);
 	if (r < 0) {
 		size_t sz = sizeof(p->ut_host);
 
diff --git a/misc-utils/test_uuidd.c b/misc-utils/test_uuidd.c
index 73cc90a..9883cbf 100644
--- a/misc-utils/test_uuidd.c
+++ b/misc-utils/test_uuidd.c
@@ -183,8 +183,8 @@ static void create_nthreads(process_t *proc, size_t index)
 			break;
 		}
 
-		LOG(2, (stderr, "%d: started thread [tid=%d,index=%zu]\n",
-		     proc->pid, (int) th->tid, th->index));
+		LOG(2, (stderr, "%d: started thread [tid=%jd,index=%zu]\n",
+		     proc->pid, (intmax_t) th->tid, th->index));
 		index += nobjects;
 		ncreated++;
 	}
@@ -203,8 +203,8 @@ static void create_nthreads(process_t *proc, size_t index)
 			err(EXIT_FAILURE, "pthread_join failed");
 		}
 
-		LOG(2, (stderr, "%d: thread exited [tid=%d,return=%d]\n",
-		     proc->pid, (int) th->tid, th->retval));
+		LOG(2, (stderr, "%d: thread exited [tid=%jd,return=%d]\n",
+		     proc->pid, (intmax_t) th->tid, th->retval));
 	}
 }
 
@@ -256,7 +256,7 @@ static void object_dump(size_t idx, object_t *obj)
 	fprintf(stderr, "  uuid:    <%s>\n", p);
 	fprintf(stderr, "  idx:     %zu\n", obj->idx);
 	fprintf(stderr, "  process: %d\n", (int) obj->pid);
-	fprintf(stderr, "  thread:  %d\n", (int) obj->tid);
+	fprintf(stderr, "  thread:  %jd\n", (intmax_t) obj->tid);
 	fprintf(stderr, "}\n");
 }
 
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index 7d2cc45..f3f76a6 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -5,6 +5,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+#include <sys/time.h>
 #include <time.h>
 
 #include "c.h"
diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index a62d457..afd1928 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -364,12 +364,12 @@ static void do_prlimit(struct list_head *lims)
 			if (new->rlim_cur == RLIM_INFINITY)
 				printf("<%s", _("unlimited"));
 			else
-				printf("<%ju", new->rlim_cur);
+				printf("<%ju", (uintmax_t)new->rlim_cur);
 
 			if (new->rlim_max == RLIM_INFINITY)
 				printf(":%s>\n", _("unlimited"));
 			else
-				printf(":%ju>\n", new->rlim_max);
+				printf(":%ju>\n", (uintmax_t)new->rlim_max);
 		}
 
 		if (prlimit(pid, lim->desc->resource, new, old) == -1)
-- 
1.8.5.6

