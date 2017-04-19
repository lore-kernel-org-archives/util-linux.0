Return-Path: elseifthen@gmx.com
Subject: [PATCH 3/5] hwclock: --set and --predict segmentation fault
To: Karel Zak <kzak@redhat.com>
References: <7592945f-746d-7f67-192a-78dff67923d5@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <ded9a986-713b-ccc3-5942-8c3c5165b026@gmx.com>
Date: Tue, 18 Apr 2017 23:05:17 -0400
MIME-Version: 1.0
In-Reply-To: <7592945f-746d-7f67-192a-78dff67923d5@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Segmentation fault for --set or --predict when the
--date option is not included.

* sys-utils/hwclock.c: exit with an error message when
    the required --date option is missing.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 0c58795..bb3a9d8 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1505,6 +1505,10 @@ int main(int argc, char **argv)
 	}
 
 	if (ctl.set || ctl.predict) {
+		if (!ctl.date_opt){
+		warnx(_("--date is required for --set or --predict"));
+		hwclock_exit(&ctl, EX_USAGE);
+		}
 		if (parse_date(&when, ctl.date_opt, NULL))
 			set_time = when.tv_sec;
 		else {
