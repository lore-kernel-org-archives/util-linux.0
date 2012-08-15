Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53901 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081Ab2HOJJY convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 15 Aug 2012 05:09:24 -0400
Received: by bkwj10 with SMTP id j10so432323bkw.19
        for <util-linux@vger.kernel.org>; Wed, 15 Aug 2012 02:09:22 -0700 (PDT)
From: Andrea Bonomi <a.bonomi@endian.com>
Content-Type: text/plain; charset=us-ascii
Subject: [PATCH 1/2] agetty: display network address in issue
Date: Wed, 15 Aug 2012 11:09:20 +0200
Message-Id: <2700EB83-DDF2-4773-B7BB-DFAC548B7405@endian.com>
To: util-linux@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v1278)
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Andrea Bonomi <a.bonomi@endian.com>

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 43243f9..055c249 100644
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
@@ -49,6 +52,7 @@
 #  endif
 #  ifndef DEFAULT_STERM
 #    define DEFAULT_STERM  "vt102"
+#  define DEFAULT_INTERFACE "eth0"
 #  endif
 #elif defined(__GNU__)
 #  define USE_SYSLOG
@@ -58,6 +62,7 @@
 #  ifndef DEFAULT_STERM
 #    define DEFAULT_STERM  "vt102"
 #  endif
+#  define DEFAULT_INTERFACE "eth0"
 #else
 #  ifndef DEFAULT_VCTERM
 #    define DEFAULT_VCTERM "vt100"
@@ -65,6 +70,7 @@
 #  ifndef DEFAULT_STERM
 #    define DEFAULT_STERM  "vt100"
 #  endif
+#  define DEFAULT_INTERFACE "en0"
 #endif
 
 /* If USE_SYSLOG is undefined all diagnostics go to /dev/console. */
@@ -145,6 +151,7 @@ struct options {
 	int nice;			/* Run login with this priority */
 	int numspeed;			/* number of baud rates to try */
 	speed_t speeds[MAX_SPEED];	/* baud rates to be tried */
+	char *interface;		/* name of the network interface displayed in issue */
 };
 
 #define	F_PARSE		(1<<0)	/* process modem status messages */
@@ -169,6 +176,7 @@ struct options {
 #define F_LONGHNAME	(1<<19) /* Show Full qualified hostname */
 #define F_NOHINTS	(1<<20) /* Don't print hints */
 #define F_REMOTE	(1<<21) /* Add '-h fakehost' to login(1) command line */
+#define F_INTERFACE	(1<<22) /* Name of the network interface displayed in issue */
 
 #define serial_tty_option(opt, flag)	\
 	(((opt)->flags & (F_VCONSOLE|(flag))) == (flag))
@@ -280,7 +288,8 @@ int main(int argc, char **argv)
 		.login  =  _PATH_LOGIN,		/* default login program */
 		.tty    = "tty1",		/* default tty line */
 		.term   =  DEFAULT_VCTERM,	/* terminal type */
-		.issue  =  ISSUE		/* default issue file */
+		.issue  =  ISSUE,		/* default issue file */
+		.interface = DEFAULT_INTERFACE	/* default network interface displayed in issue */ 
 	};
 	char *login_argv[LOGIN_ARGV_MAX + 1];
 	int login_argc = 0;
@@ -569,6 +578,7 @@ static void parse_args(int argc, char **argv, struct options *op)
 		{  "timeout",	     required_argument,  0,  't'  },
 		{  "detect-case",    no_argument,	 0,  'U'  },
 		{  "wait-cr",	     no_argument,	 0,  'w'  },
+		{  "interface",      required_argument,  0,  'x'  },
 		{  "nohints",        no_argument,        0,  NOHINTS_OPTION },
 		{  "nohostname",     no_argument,	 0,  NOHOSTNAME_OPTION },
 		{  "long-hostname",  no_argument,	 0,  LONGHOSTNAME_OPTION },
@@ -578,7 +588,7 @@ static void parse_args(int argc, char **argv, struct options *op)
 	};
 
 	while ((c = getopt_long(argc, argv,
-			   "8a:cC:d:Ef:hH:iI:Jl:LmnNo:pP:r:Rst:Uw", longopts,
+			   "8a:cC:d:Ef:hH:iI:Jl:LmnNo:pP:r:Rst:Uwx:", longopts,
 			    NULL)) != -1) {
 		switch (c) {
 		case '8':
@@ -659,6 +669,10 @@ static void parse_args(int argc, char **argv, struct options *op)
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
@@ -1696,6 +1710,27 @@ static void log_warn(const char *fmt, ...)
 	va_end(ap);
 }
 
+static void output_ip_address(struct ifaddrs * ifaddrs_ptr, const char *interface, sa_family_t family)
+{
+	if (strcmp(ifaddrs_ptr->ifa_name, interface) == 0 && 
+		ifaddrs_ptr->ifa_addr->sa_family == family &&
+		ifaddrs_ptr->ifa_addr) {
+		void *addr = NULL;
+		char buffer[INET6_ADDRSTRLEN+1];
+		if (ifaddrs_ptr->ifa_addr->sa_family == AF_INET)
+			addr = &((struct sockaddr_in *)	 ifaddrs_ptr->ifa_addr)->sin_addr;
+		else if (ifaddrs_ptr->ifa_addr->sa_family == AF_INET6)
+			addr = &((struct sockaddr_in6 *) ifaddrs_ptr->ifa_addr)->sin6_addr;
+		if (addr) {
+			inet_ntop (ifaddrs_ptr->ifa_addr->sa_family,
+					   addr, buffer, sizeof (buffer));
+			printf ("%s", buffer);
+		}
+	} else if (ifaddrs_ptr->ifa_next) {
+		output_ip_address (ifaddrs_ptr->ifa_next, interface, family);
+	}
+}
+
 static void output_special_char(unsigned char c, struct options *op,
 				struct termios *tp)
 {
@@ -1808,6 +1843,22 @@ static void output_special_char(unsigned char c, struct options *op,
 			printf((users == 1) ? _("user") : _("users"));
 		break;
 	}
+	case 'x':
+		/** Print the interface name */
+		printf("%s", op->interface);
+		break;
+	case '4':
+	case '6':
+	{
+		/** Print the IP v4 or v6 interface address */
+		struct ifaddrs * ifaddrs_ptr;
+		int status;
+		status = getifaddrs (& ifaddrs_ptr);
+		if (status == 0) {
+			output_ip_address (ifaddrs_ptr, op->interface, c == '4' ? AF_INET : AF_INET6);
+			freeifaddrs (ifaddrs_ptr);
+		}
+	}
 	default:
 		putchar(c);
 		break;

