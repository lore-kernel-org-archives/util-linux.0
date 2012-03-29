Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50610 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759051Ab2C2Qpl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Mar 2012 12:45:41 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 9B2F48FE2D
	for <util-linux@vger.kernel.org>; Thu, 29 Mar 2012 18:45:40 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 08/20] uuidd: print all debugging information to stderr
Date: Thu, 29 Mar 2012 18:45:16 +0200
Message-Id: <1333039528-24784-9-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
References: <1333039528-24784-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/uuidd.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index abc24a4..aae5dbf 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -332,7 +332,7 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 	ret = call_daemon(socket_path, UUIDD_OP_GETPID, reply_buf, sizeof(reply_buf), 0, NULL);
 	if (ret > 0) {
 		if (!quiet)
-			printf(_("uuidd daemon already running at pid %s\n"),
+			fprintf(stderr, _("uuidd daemon already running at pid %s\n"),
 			       reply_buf);
 		exit(EXIT_FAILURE);
 	}
@@ -394,7 +394,7 @@ socket_ready:
 			if (len < 0)
 				perror("read");
 			else
-				printf(_("Error reading from client, "
+				fprintf(stderr, _("Error reading from client, "
 					 "len = %d\n"), len);
 			goto shutdown_socket;
 		}
@@ -403,10 +403,10 @@ socket_ready:
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
@@ -422,7 +422,7 @@ socket_ready:
 			__uuid_generate_time(uu, &num);
 			if (debug) {
 				uuid_unparse(uu, str);
-				printf(_("Generated time UUID: %s\n"), str);
+				fprintf(stderr, _("Generated time UUID: %s\n"), str);
 			}
 			memcpy(reply_buf, uu, sizeof(uu));
 			reply_len = sizeof(uu);
@@ -432,7 +432,7 @@ socket_ready:
 			__uuid_generate_random(uu, &num);
 			if (debug) {
 				uuid_unparse(uu, str);
-				printf(_("Generated random UUID: %s\n"), str);
+				fprintf(stderr, _("Generated random UUID: %s\n"), str);
 			}
 			memcpy(reply_buf, uu, sizeof(uu));
 			reply_len = sizeof(uu);
@@ -441,10 +441,10 @@ socket_ready:
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
@@ -462,13 +462,13 @@ socket_ready:
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
@@ -476,7 +476,7 @@ socket_ready:
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

