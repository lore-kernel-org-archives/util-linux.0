Return-Path: elseifthen@gmx.com
Subject: [PATCH 4/6] hwclock: improve cmos message strings
To: Karel Zak <kzak@redhat.com>
References: <24f2ccba-6144-9497-69fc-c5dbfd9a39fc@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <488bbb4d-7ecd-df2a-d39d-e25039cf1191@gmx.com>
Date: Fri, 31 Mar 2017 10:47:24 -0400
MIME-Version: 1.0
In-Reply-To: <24f2ccba-6144-9497-69fc-c5dbfd9a39fc@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


* sys-utils/hwclock-cmos.c: improve message strings

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-cmos.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sys-utils/hwclock-cmos.c b/sys-utils/hwclock-cmos.c
index a5eb9fd..5158369 100644
--- a/sys-utils/hwclock-cmos.c
+++ b/sys-utils/hwclock-cmos.c
@@ -405,19 +405,18 @@ static int get_permissions_cmos(void)
 
 	rc = i386_iopl(3);
 	if (rc == IOPL_NOT_IMPLEMENTED) {
-		warnx(_("I failed to get permission because I didn't try."));
+		warnx(_("ISA port access is not implemented"));
 	} else if (rc != 0) {
 		rc = errno;
-		warn(_("unable to get I/O port access:  "
-		       "the iopl(3) call failed"));
+		warn(_("iopl() port access failed"));
 		if (rc == EPERM && geteuid())
-			warnx(_("Probably you need root privileges.\n"));
+			warnx(_("root privileges may be required"));
 	}
 	return rc ? 1 : 0;
 }
 
 static struct clock_ops cmos_interface = {
-	N_("Using direct I/O instructions to ISA clock."),
+	N_("Using direct ISA access to the clock"),
 	get_permissions_cmos,
 	read_hardware_clock_cmos,
 	set_hardware_clock_cmos,
