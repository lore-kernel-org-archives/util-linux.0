Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53091 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754455Ab2ECTCK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 15:02:10 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 84F02978B8
	for <util-linux@vger.kernel.org>; Thu,  3 May 2012 21:02:09 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 09/15] uuidd: print all debugging information to stderr
Date: Thu,  3 May 2012 21:01:55 +0200
Message-Id: <1336071721-32492-10-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
References: <1336071721-32492-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/uuidd.c |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index c6ec208..fafc8d1 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -335,7 +335,8 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 				  sizeof(reply_buf), 0, NULL);
 		if (ret > 0) {
 			if (!quiet)
-				printf(_("uuidd daemon already running at pid %s\n"),
+				fprintf(stderr,
+					_("uuidd daemon already running at pid %s\n"),
 				       reply_buf);
 			exit(EXIT_FAILURE);
 		}
@@ -396,7 +397,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			if (len < 0)
 				perror("read");
 			else
-				printf(_("Error reading from client, "
+				fprintf(stderr, _("Error reading from client, "
 					 "len = %d\n"), len);
 			goto shutdown_socket;
 		}
@@ -405,10 +406,10 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			if (read_all(ns, (char *) &num, sizeof(num)) != 4)
 				goto shutdown_socket;
 			if (debug)
-				printf(_("operation %d, incoming num = %d\n"),
+				fprintf(stderr, _("operation %d, incoming num = %d\n"),
 				       op, num);
 		} else if (debug)
-			printf(_("operation %d\n"), op);
+			fprintf(stderr, _("operation %d\n"), op);
 
 		switch (op) {
 		case UUIDD_OP_GETPID:
@@ -424,7 +425,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			__uuid_generate_time(uu, &num);
 			if (debug) {
 				uuid_unparse(uu, str);
-				printf(_("Generated time UUID: %s\n"), str);
+				fprintf(stderr, _("Generated time UUID: %s\n"), str);
 			}
 			memcpy(reply_buf, uu, sizeof(uu));
 			reply_len = sizeof(uu);
@@ -434,7 +435,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			__uuid_generate_random(uu, &num);
 			if (debug) {
 				uuid_unparse(uu, str);
-				printf(_("Generated random UUID: %s\n"), str);
+				fprintf(stderr, _("Generated random UUID: %s\n"), str);
 			}
 			memcpy(reply_buf, uu, sizeof(uu));
 			reply_len = sizeof(uu);
@@ -443,10 +444,10 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			__uuid_generate_time(uu, &num);
 			if (debug) {
 				uuid_unparse(uu, str);
-				printf(P_("Generated time UUID %s "
-					  "and %d following\n",
-					  "Generated time UUID %s "
-					  "and %d following\n", num - 1),
+				fprintf(stderr, P_("Generated time UUID %s "
+						   "and %d following\n",
+						   "Generated time UUID %s "
+						   "and %d following\n", num - 1),
 				       str, num - 1);
 			}
 			memcpy(reply_buf, uu, sizeof(uu));
@@ -464,13 +465,13 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			__uuid_generate_random((unsigned char *) reply_buf +
 					      sizeof(num), &num);
 			if (debug) {
-				printf(P_("Generated %d UUID:\n",
-					  "Generated %d UUIDs:\n", num), num);
+				fprintf(stderr, P_("Generated %d UUID:\n",
+						   "Generated %d UUIDs:\n", num), num);
 				for (i = 0, cp = reply_buf + sizeof(num);
 				     i < num;
 				     i++, cp += UUID_LEN) {
 					uuid_unparse((unsigned char *)cp, str);
-					printf("\t%s\n", str);
+					fprintf(stderr, "\t%s\n", str);
 				}
 			}
 			reply_len = (num * UUID_LEN) + sizeof(num);
@@ -478,7 +479,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			break;
 		default:
 			if (debug)
-				printf(_("Invalid operation %d\n"), op);
+				fprintf(stderr, _("Invalid operation %d\n"), op);
 			goto shutdown_socket;
 		}
 		write_all(ns, (char *) &reply_len, sizeof(reply_len));
-- 
1.7.7

