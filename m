Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41247 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754506Ab2ILJhd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 12 Sep 2012 05:37:33 -0400
Date: Wed, 12 Sep 2012 11:37:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Andrea Bonomi <a.bonomi@endian.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/2] agetty: display network address in issue
Message-ID: <20120912093728.GA17256@x2.net.home>
References: <2B6CF89C-6218-4289-B116-27108562664F@endian.com>
 <BBDB2F27-F199-4F90-B393-569763011661@endian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <BBDB2F27-F199-4F90-B393-569763011661@endian.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

On Wed, Aug 15, 2012 at 11:08:16AM +0200, Andrea Bonomi wrote:
> Hello, I developed a small patch for displaying the network address
> (IPv4 or IPv6) of a selected network interface in the agetty issue
> file.  The name of network interface (default eth0) can be
> configured through a command line option.  I use this feature on my
> virtual machines, so I can know the addresses without login. I hope
> this can be useful for someone else.  Have a nice day, Andrea Bonomi

I did some changes to the patch -- see below. I don't like the
hardcoded interface names and I guess that on many machines is more
important just machine IP (based on hostname) rather than interface
IP. So:

 \4 and \6 print IP address as returned by getaddrinfo() *or* if
 --interface command line option is specified then interface IP is
 printed.

It means that --interface is optional and probably unnecessary in many
cases.

Objections?

    Karel

>From ca2fda5f40440f4f7686716d76f93c302f1b2e67 Mon Sep 17 00:00:00 2001
From: Andrea Bonomi <a.bonomi@endian.com>
Date: Wed, 15 Aug 2012 11:10:19 +0200
Subject: [PATCH] agetty: display network address in issue

Signed-off-by: Andrea Bonomi <a.bonomi@endian.com>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 term-utils/agetty.8 |   18 +++++++++-
 term-utils/agetty.c |   96 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index ebfdb96..bbf65d0 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -3,7 +3,7 @@
 agetty \- alternative Linux getty
 
 .SH SYNOPSIS
-.BR "agetty " [\-8chiLmnsUw]
+.BR "agetty " [\-8chiLmnsUwx]
 .RI "[\-a " user ]
 .RI "[\-f " issue_file ]
 .RI "[\-H " login_host ]
@@ -198,6 +198,10 @@ Wait for the user or the modem to send a carriage-return or a
 linefeed character before sending the \fI/etc/issue\fP (or other) file
 and the login prompt. Very useful in connection with the \-I option.
 .TP
+\-x, \-\-interface \fIinterface_name\fP
+The IPv4 and IPv6 addresses of a network interface can be displayed in
+the issue. The name of the network is configured by this option.
+.TP
 \-\-noclear
 Do not clear the screen before prompting for the login name
 (the screen is normally cleared).
@@ -269,6 +273,18 @@ time etc. All escape codes consist of a backslash (\\) immediately
 followed by one of the letters explained below.
 
 .TP
+4
+Insert the IPv4 address of the machine hostname or IPv4 address the configured
+network interface if the \fB\-\-interface\fP command line option is specified.
+.TP
+6
+Insert the IPv6 address of the machine hostname or IPv6 address the configured
+network interface if the \fB\-\-interface\fP command line option is specified.
+.TP
+x
+Name of the configured network interface (configured by the \fB\-\-interface\fP
+command line option).
+.TP
 b
 Insert the baudrate of the current line.
 .TP
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 43243f9..71c7da3 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -31,6 +31,9 @@
 #include <netdb.h>
 #include <langinfo.h>
 #include <grp.h>
+#include <arpa/inet.h>
+#include <netdb.h>
+#include <ifaddrs.h>
 
 #include "strutils.h"
 #include "all-io.h"
@@ -145,6 +148,7 @@ struct options {
 	int nice;			/* Run login with this priority */
 	int numspeed;			/* number of baud rates to try */
 	speed_t speeds[MAX_SPEED];	/* baud rates to be tried */
+	char *interface;		/* name of the network interface displayed in issue */
 };
 
 #define	F_PARSE		(1<<0)	/* process modem status messages */
@@ -169,6 +173,7 @@ struct options {
 #define F_LONGHNAME	(1<<19) /* Show Full qualified hostname */
 #define F_NOHINTS	(1<<20) /* Don't print hints */
 #define F_REMOTE	(1<<21) /* Add '-h fakehost' to login(1) command line */
+#define F_INTERFACE	(1<<22) /* Name of the network interface displayed in issue */
 
 #define serial_tty_option(opt, flag)	\
 	(((opt)->flags & (F_VCONSOLE|(flag))) == (flag))
@@ -280,7 +285,7 @@ int main(int argc, char **argv)
 		.login  =  _PATH_LOGIN,		/* default login program */
 		.tty    = "tty1",		/* default tty line */
 		.term   =  DEFAULT_VCTERM,	/* terminal type */
-		.issue  =  ISSUE		/* default issue file */
+		.issue  =  ISSUE,		/* default issue file */
 	};
 	char *login_argv[LOGIN_ARGV_MAX + 1];
 	int login_argc = 0;
@@ -569,6 +574,7 @@ static void parse_args(int argc, char **argv, struct options *op)
 		{  "timeout",	     required_argument,  0,  't'  },
 		{  "detect-case",    no_argument,	 0,  'U'  },
 		{  "wait-cr",	     no_argument,	 0,  'w'  },
+		{  "interface",      required_argument,  0,  'x'  },
 		{  "nohints",        no_argument,        0,  NOHINTS_OPTION },
 		{  "nohostname",     no_argument,	 0,  NOHOSTNAME_OPTION },
 		{  "long-hostname",  no_argument,	 0,  LONGHOSTNAME_OPTION },
@@ -578,7 +584,7 @@ static void parse_args(int argc, char **argv, struct options *op)
 	};
 
 	while ((c = getopt_long(argc, argv,
-			   "8a:cC:d:Ef:hH:iI:Jl:LmnNo:pP:r:Rst:Uw", longopts,
+			   "8a:cC:d:Ef:hH:iI:Jl:LmnNo:pP:r:Rst:Uwx:", longopts,
 			    NULL)) != -1) {
 		switch (c) {
 		case '8':
@@ -659,6 +665,10 @@ static void parse_args(int argc, char **argv, struct options *op)
 		case 'w':
 			op->flags |= F_WAITCRLF;
 			break;
+		case 'x':
+			op->flags |= F_INTERFACE;
+			op->interface = optarg;
+			break;
 		case NOHINTS_OPTION:
 			op->flags |= F_NOHINTS;
 			break;
@@ -1696,6 +1706,68 @@ static void log_warn(const char *fmt, ...)
 	va_end(ap);
 }
 
+static void output_iface_ip(struct ifaddrs *addrs, const char *iface, sa_family_t family)
+{
+	if (!iface)
+		return;
+
+	if (addrs->ifa_name
+	    && strcmp(addrs->ifa_name, iface) == 0
+	    && addrs->ifa_addr
+	    && addrs->ifa_addr->sa_family == family) {
+
+		void *addr = NULL;
+		char buff[INET6_ADDRSTRLEN + 1];
+
+		switch (addrs->ifa_addr->sa_family) {
+		case AF_INET:
+			addr = &((struct sockaddr_in *)	addrs->ifa_addr)->sin_addr;
+			break;
+		case AF_INET6:
+			addr = &((struct sockaddr_in6 *) addrs->ifa_addr)->sin6_addr;
+			break;
+		}
+		if (addr) {
+			inet_ntop(addrs->ifa_addr->sa_family, addr, buff, sizeof(buff));
+			printf("%s", buff);
+		}
+
+	} else if (addrs->ifa_next)
+		output_iface_ip(addrs->ifa_next, iface, family);
+}
+
+static void output_ip(sa_family_t family)
+{
+	char host[MAXHOSTNAMELEN + 1];
+	struct addrinfo hints, *info = NULL;
+
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_family = family;
+	if (family == AF_INET6)
+		hints.ai_flags = AI_V4MAPPED;
+
+	if (gethostname(host, sizeof(host)) == 0
+	    && getaddrinfo(host, NULL, &hints, &info) == 0
+	    && info) {
+
+		void *addr = NULL;
+		char buff[INET6_ADDRSTRLEN + 1];
+
+		switch (info->ai_family) {
+		case AF_INET:
+			addr = &((struct sockaddr_in *) info->ai_addr)->sin_addr;
+			break;
+		case AF_INET6:
+			addr = &((struct sockaddr_in6 *) info->ai_addr)->sin6_addr;
+			break;
+		}
+		inet_ntop(info->ai_family, (void *) addr, buff, sizeof(buff));
+		printf("%s", buff);
+
+		freeaddrinfo(info);
+	}
+}
+
 static void output_special_char(unsigned char c, struct options *op,
 				struct termios *tp)
 {
@@ -1808,6 +1880,26 @@ static void output_special_char(unsigned char c, struct options *op,
 			printf((users == 1) ? _("user") : _("users"));
 		break;
 	}
+	case 'x':
+		if (op->interface)			/* interface name */
+			printf("%s", op->interface);
+		break;
+	case '4':
+	case '6':
+	{
+		sa_family_t family = c == '4' ? AF_INET : AF_INET6;
+
+		if (op->interface) {			/* interface IP */
+			struct ifaddrs *addrs;
+			int status = getifaddrs(&addrs);
+			if (status != 0)
+				break;
+			output_iface_ip(addrs, op->interface, family);
+			freeifaddrs(addrs);
+		} else					/* host IP */
+			output_ip(family);
+		break;
+	}
 	default:
 		putchar(c);
 		break;
-- 
1.7.7.6

