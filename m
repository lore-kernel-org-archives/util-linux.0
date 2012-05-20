Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbbj.dreamhost.com ([208.97.132.119]:37745 "EHLO
	homiemail-a62.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752606Ab2ETQL2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 20 May 2012 12:11:28 -0400
Subject: [PATCH 2/6] fdisk: remove bogus statement
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 20 May 2012 18:11:26 +0200
Message-ID: <1337530286.2677.13.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

usage() does not return, also move the help option handling to the bottom of the switch.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 2f3c119..9387795 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -2095,8 +2095,8 @@ static void command_prompt(void)
 	}
 }
 
-int
-main(int argc, char **argv) {
+int main(int argc, char **argv)
+{
 	int j, c;
 	int optl = 0, opts = 0;
 
@@ -2130,9 +2130,6 @@ main(int argc, char **argv) {
 			else if (optarg && strcmp(optarg, "=nondos"))
 				usage(stderr);
 			break;
-		case 'h':
-			usage(stdout);
-			break;
 		case 'H':
 			user_heads = strtou32_or_err(optarg, _("invalid heads argument"));
 			if (user_heads > 256)
@@ -2160,6 +2157,8 @@ main(int argc, char **argv) {
 		case 'v':
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
+		case 'h':
+			usage(stdout);
 		default:
 			usage(stderr);
 		}
-- 
1.7.4.1




