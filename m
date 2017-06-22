Return-Path: elseifthen@gmx.com
Subject: [PATCH 2/2] hwclock: add audit for --systz
To: Karel Zak <kzak@redhat.com>
References: <22e50897-04c9-a413-3b84-d2f968185c43@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <f7996220-7e35-c152-0d4e-714cc61a1fcd@gmx.com>
Date: Wed, 21 Jun 2017 20:53:20 -0400
MIME-Version: 1.0
In-Reply-To: <22e50897-04c9-a413-3b84-d2f968185c43@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index f6a87c7..0f60496 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1425,6 +1425,7 @@ int main(int argc, char **argv)
 		case OPT_SYSTZ:
 			ctl.systz = 1;		/* --systz */
 			ctl.show = 0;
+			ctl.hwaudit_on = 1;
 			break;
 		case OPT_PREDICT:
 			ctl.predict = 1;	/* --predict */
