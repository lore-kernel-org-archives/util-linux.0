Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:39673 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042Ab2JNUVU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:20 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2680278wey.19
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/19] agetty: stop using MAXHOSTNAMELEN
Date: Sun, 14 Oct 2012 21:20:55 +0100
Message-Id: <1350246070-10544-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use the sysconf(_SC_HOST_NAME_MAX) to determine maximum length of a
hostname.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/agetty.c | 33 +++++++++++++++++++++++----------
 1 file changed, 23 insertions(+), 10 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 4e23135..754a43f 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1293,12 +1293,14 @@ static void do_prompt(struct options *op, struct termios *tp)
 	}
 #endif /* KDGKBLED */
 	if ((op->flags & F_NOHOSTNAME) == 0) {
-		char hn[MAXHOSTNAMELEN + 1];
-		if (gethostname(hn, sizeof(hn)) == 0) {
+		char *hn;
+		hn = malloc(sizeof(char) * (sysconf(_SC_HOST_NAME_MAX) + 1));
+		if (!hn)
+			log_err(_("failed to allocate memory: %m"));
+		if (gethostname(hn, sysconf(_SC_HOST_NAME_MAX)) == 0) {
 			struct hostent *ht;
 			char *dot = strchr(hn, '.');
 
-			hn[MAXHOSTNAMELEN] = '\0';
 			if ((op->flags & F_LONGHNAME) == 0) {
 				if (dot)
 					*dot = '\0';
@@ -1309,6 +1311,7 @@ static void do_prompt(struct options *op, struct termios *tp)
 				write_all(STDOUT_FILENO, hn, strlen(hn));
 			write_all(STDOUT_FILENO, " ", 1);
 		}
+		free(hn);
 	}
 	if (op->autolog == (char*)0) {
 		/* Always show login prompt. */
@@ -1732,7 +1735,7 @@ static void output_iface_ip(struct ifaddrs *addrs, const char *iface, sa_family_
 
 static void output_ip(sa_family_t family)
 {
-	char host[MAXHOSTNAMELEN + 1];
+	char *host;
 	struct addrinfo hints, *info = NULL;
 
 	memset(&hints, 0, sizeof(hints));
@@ -1740,7 +1743,10 @@ static void output_ip(sa_family_t family)
 	if (family == AF_INET6)
 		hints.ai_flags = AI_V4MAPPED;
 
-	if (gethostname(host, sizeof(host)) == 0
+	host = malloc(sizeof(char) * (sysconf(_SC_HOST_NAME_MAX) + 1));
+	if (!host)
+		log_err(_("failed to allocate memory: %m"));
+	if (gethostname(host, sysconf(_SC_HOST_NAME_MAX)) == 0
 	    && getaddrinfo(host, NULL, &hints, &info) == 0
 	    && info) {
 
@@ -1760,6 +1766,7 @@ static void output_ip(sa_family_t family)
 
 		freeaddrinfo(info);
 	}
+	free(host);
 }
 
 /*
@@ -1814,25 +1821,30 @@ static void output_special_char(unsigned char c, struct options *op,
 		break;
 	case 'o':
 	{
-		char domainname[MAXHOSTNAMELEN+1];
+		char *domainname;
+		domainname = malloc(sizeof(char) * (sysconf(_SC_HOST_NAME_MAX) + 1));
+		if (!domainname)
+			log_err(_("failed to allocate memory: %m"));
 #ifdef HAVE_GETDOMAINNAME
-		if (getdomainname(domainname, sizeof(domainname)))
+		if (getdomainname(domainname, sysconf(_SC_HOST_NAME_MAX)))
 #endif
 		strcpy(domainname, "unknown_domain");
-		domainname[sizeof(domainname)-1] = '\0';
 		printf("%s", domainname);
 		break;
 	}
 	case 'O':
 	{
 		char *dom = "unknown_domain";
-		char host[MAXHOSTNAMELEN+1];
+		char *host;
 		struct addrinfo hints, *info = NULL;
 
 		memset(&hints, 0, sizeof(hints));
 		hints.ai_flags = AI_CANONNAME;
 
-		if (gethostname(host, sizeof(host)) ||
+		host = malloc(sizeof(char) * (sysconf(_SC_HOST_NAME_MAX) + 1));
+		if (!host)
+			log_err(_("failed to allocate memory: %m"));
+		if (gethostname(host, sysconf(_SC_HOST_NAME_MAX)) ||
 		    getaddrinfo(host, NULL, &hints, &info) ||
 		    info == NULL)
 			fputs(dom, stdout);
@@ -1844,6 +1856,7 @@ static void output_special_char(unsigned char c, struct options *op,
 			fputs(dom, stdout);
 			freeaddrinfo(info);
 		}
+		free(host);
 		break;
 	}
 	case 'd':
-- 
1.7.12.2

