Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:56801 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161231AbdD0Dmx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 26 Apr 2017 23:42:53 -0400
Subject: [PATCH 4/4] hwclock: use a consistent name for --predict
To: Karel Zak <kzak@redhat.com>
References: <50c7367a-c086-2c18-af81-9f86f1c2560a@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <2b4a329b-79b3-2e66-4448-a31e07e70e83@gmx.com>
Date: Wed, 26 Apr 2017 23:42:42 -0400
MIME-Version: 1.0
In-Reply-To: <50c7367a-c086-2c18-af81-9f86f1c2560a@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


The predict function name is documented as '--predict', but the
code uses '--predict-hc'. This works okay, except that the
'mutually exclusive' error message prints the undocumented name.

* sys-utils/hwclock.c: rename 'predict-hc' to 'predict' so that
    it matches the man-page. This should not be a problem because
    'predict-hc' was never documented.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index e66acd2..e890cb8 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1304,7 +1304,7 @@ int main(int argc, char **argv)
 		OPT_GETEPOCH,
 		OPT_LOCALTIME,
 		OPT_NOADJFILE,
-		OPT_PREDICT_HC,
+		OPT_PREDICT,
 		OPT_SET,
 		OPT_SETEPOCH,
 		OPT_SYSTZ,
@@ -1337,7 +1337,7 @@ int main(int argc, char **argv)
 #endif
 		{ "adjfile",      required_argument, NULL, OPT_ADJFILE    },
 		{ "systz",        no_argument,       NULL, OPT_SYSTZ      },
-		{ "predict-hc",   no_argument,       NULL, OPT_PREDICT_HC },
+		{ "predict",      no_argument,       NULL, OPT_PREDICT    },
 		{ "get",          no_argument,       NULL, OPT_GET        },
 		{ "update-drift", no_argument,       NULL, OPT_UPDATE     },
 		{ NULL, 0, NULL, 0 }
@@ -1345,7 +1345,7 @@ int main(int argc, char **argv)
 
 	static const ul_excl_t excl[] = {	/* rows and cols in ASCII order */
 		{ 'a','r','s','w',
-		  OPT_GET, OPT_GETEPOCH, OPT_PREDICT_HC,
+		  OPT_GET, OPT_GETEPOCH, OPT_PREDICT,
 		  OPT_SET, OPT_SETEPOCH, OPT_SYSTZ },
 		{ 'u', OPT_LOCALTIME},
 		{ OPT_ADJFILE, OPT_NOADJFILE },
@@ -1454,8 +1454,8 @@ int main(int argc, char **argv)
 			ctl.systz = 1;		/* --systz */
 			ctl.show = 0;
 			break;
-		case OPT_PREDICT_HC:
-			ctl.predict = 1;	/* --predict-hc */
+		case OPT_PREDICT:
+			ctl.predict = 1;	/* --predict */
 			ctl.show = 0;
 			break;
 		case OPT_GET:
