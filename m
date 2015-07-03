Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52126 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755077AbbGCM60 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 3 Jul 2015 08:58:26 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id E50BAC2309
	for <util-linux@vger.kernel.org>; Fri,  3 Jul 2015 12:58:25 +0000 (UTC)
From: Stef Walter <stefw@redhat.com>
To: util-linux@vger.kernel.org
Cc: Stef Walter <stefw@redhat.com>
Subject: [PATCH] agetty: Reprompt once the network addresses change if address displayed
Date: Fri,  3 Jul 2015 14:58:08 +0200
Message-Id: <1435928288-25644-1-git-send-email-stefw@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Several of the /etc/issue escape codes such as \4 and \6 depend on
the current addresses of the system that can change after the agetty
prompt is displayed.  This can cause stale data to be displayed
when a user looks at a VT, especially in cases of DHCP racing with
system start up.

Similar to the --reload mechanism, if we're displaying an address
in the issue output, and the user hasn't typed anything yet: then
redisplay the prompt with the new address.

We use netlink to watch for address changes. We only open the netlink
socket if we display an address in the issue file.
---
 term-utils/agetty.c | 113 +++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 95 insertions(+), 18 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 122959f..fc36488 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -129,9 +129,12 @@
  */
 #ifdef AGETTY_RELOAD
 # include <sys/inotify.h>
+# include <linux/netlink.h>
+# include <linux/rtnetlink.h>
 # define AGETTY_RELOAD_FILENAME "/run/agetty.reload"	/* trigger file */
 # define AGETTY_RELOAD_FDNONE	-2			/* uninitialized fd */
 static int inotify_fd = AGETTY_RELOAD_FDNONE;
+static int netlink_fd = AGETTY_RELOAD_FDNONE;
 #endif
 
 /*
@@ -1516,6 +1519,68 @@ done:
 }
 
 #ifdef AGETTY_RELOAD
+static void open_netlink(void)
+{
+	struct sockaddr_nl addr = { 0, };
+	int sock;
+
+	if (netlink_fd != AGETTY_RELOAD_FDNONE)
+		return;
+
+	sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+	if (sock >= 0) {
+		addr.nl_family = AF_NETLINK;
+		addr.nl_pid = getpid();
+		addr.nl_groups = RTMGRP_IPV4_IFADDR | RTMGRP_IPV6_IFADDR;
+		if (bind(sock,(struct sockaddr *)&addr, sizeof(addr)) < 0)
+			close (sock);
+		else
+			netlink_fd = sock;
+	}
+}
+
+static int process_netlink_msg(int *changed)
+{
+	char buf[4096];
+	struct sockaddr_nl snl;
+	struct iovec iov = { buf, sizeof buf };
+	struct msghdr msg = { (void*)&snl, sizeof (snl), &iov, 1, NULL, 0, 0 };
+	struct nlmsghdr *h;
+	int rc;
+
+	rc = recvmsg(netlink_fd, &msg, MSG_DONTWAIT);
+	if (rc < 0) {
+		if (errno == EWOULDBLOCK || errno == EAGAIN)
+			return 0;
+
+		/* Failure, just stop listening for changes */
+		close (netlink_fd);
+		netlink_fd = AGETTY_RELOAD_FDNONE;
+		return 0;
+	}
+
+	for (h = (struct nlmsghdr *)buf; NLMSG_OK(h, (unsigned int)rc); h = NLMSG_NEXT(h, rc)) {
+		if (h->nlmsg_type == NLMSG_DONE ||
+		    h->nlmsg_type == NLMSG_ERROR) {
+			close (netlink_fd);
+			netlink_fd = AGETTY_RELOAD_FDNONE;
+			return 0;
+		}
+
+		*changed = 1;
+		break;
+	}
+
+	return 1;
+}
+
+static int process_netlink(void)
+{
+	int changed = 0;
+	while (process_netlink_msg (&changed));
+	return changed;
+}
+
 static int wait_for_term_input(int fd)
 {
 	char buffer[sizeof(struct inotify_event) + NAME_MAX + 1];
@@ -1556,33 +1621,41 @@ static int wait_for_term_input(int fd)
 					AGETTY_RELOAD_FILENAME);
 	}
 
-	FD_ZERO(&rfds);
-	FD_SET(fd, &rfds);
+	for (;;) {
+		FD_ZERO(&rfds);
+		FD_SET(fd, &rfds);
 
-	if (inotify_fd >= 0)
-		FD_SET(inotify_fd, &rfds);
+		if (inotify_fd >= 0)
+			FD_SET(inotify_fd, &rfds);
+		if (netlink_fd >= 0)
+			FD_SET(netlink_fd, &rfds);
 
-	/* If waiting fails, just fall through, presumably reading input will fail */
-	if (select(max(fd, inotify_fd) + 1, &rfds, NULL, NULL, NULL) < 0)
-		return 1;
+		/* If waiting fails, just fall through, presumably reading input will fail */
+		if (select(max(fd, inotify_fd) + 1, &rfds, NULL, NULL, NULL) < 0)
+			return 1;
 
-	if (FD_ISSET(fd, &rfds)) {
-		count = read(fd, buffer, sizeof (buffer));
+		if (FD_ISSET(fd, &rfds)) {
+			count = read(fd, buffer, sizeof (buffer));
 
-		tcsetattr(fd, TCSANOW, &orig);
+			tcsetattr(fd, TCSANOW, &orig);
 
-		/* Reinject the bytes we read back into the buffer, usually just one byte */
-		for (i = 0; i < count; i++)
-			ioctl(fd, TIOCSTI, buffer + i);
+			/* Reinject the bytes we read back into the buffer, usually just one byte */
+			for (i = 0; i < count; i++)
+				ioctl(fd, TIOCSTI, buffer + i);
 
-		/* Have terminal input */
-		return 1;
+			/* Have terminal input */
+			return 1;
 
-	} else {
-		tcsetattr(fd, TCSANOW, &orig);
+		} else if (netlink_fd >= 0 && FD_ISSET (netlink_fd, &rfds)) {
+			if (!process_netlink())
+				continue;
 
 		/* Just drain the inotify buffer */
-		while (read(inotify_fd, buffer, sizeof (buffer)) > 0);
+		} else if (inotify_fd >= 0 && FD_ISSET (inotify_fd, &rfds)) {
+			while (read(inotify_fd, buffer, sizeof (buffer)) > 0);
+		}
+
+		tcsetattr(fd, TCSANOW, &orig);
 
 		/* Need to reprompt */
 		return 0;
@@ -2371,6 +2444,10 @@ static void output_special_char(unsigned char c, struct options *op,
 		struct ifaddrs *addrs = NULL;
 		char iface[128];
 
+#ifdef AGETTY_RELOAD
+		open_netlink();
+#endif
+
 		if (getifaddrs(&addrs))
 			break;
 
-- 
2.4.3

