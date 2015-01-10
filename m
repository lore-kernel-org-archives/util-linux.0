Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:51496 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753393AbbAJNlv (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 10 Jan 2015 08:41:51 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/4] setarch: accept the option --list in any position
Date: Sat, 10 Jan 2015 14:41:34 +0100
Message-Id: <1420897295-17573-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1420897295-17573-1-git-send-email-bensberg@justemail.net>
References: <1420897295-17573-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/setarch.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index a09625c..a60d2b0 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -44,7 +44,8 @@
 /* Options without equivalent short options */
 enum {
 	OPT_4GB = CHAR_MAX + 1,
-	OPT_UNAME26
+	OPT_UNAME26,
+	OPT_LIST
 };
 
 #define turn_on(_flag, _opts) \
@@ -277,6 +278,7 @@ int main(int argc, char *argv[])
 		{"3gb",			no_argument,	NULL,	'3'},
 		{"4gb",			no_argument,	NULL,	OPT_4GB},
 		{"uname-2.6",		no_argument,	NULL,	OPT_UNAME26},
+		{"list",		no_argument,	NULL,	OPT_LIST},
 		{NULL,			0,		NULL,	0}
 	};
 
@@ -360,6 +362,9 @@ int main(int argc, char *argv[])
 		case OPT_UNAME26:
 			turn_on(UNAME26, options);
 			break;
+		case OPT_LIST:
+			set_arch(argv[0], 0L, 1);
+			return EXIT_SUCCESS;
 		default:
 			show_usage(NULL);
 		}
-- 
1.7.0.4

