Return-Path: elseifthen@gmx.com
Subject: [PATCH 4/5] hwclock: fix whitespace in hwclock-rtc.c
To: Karel Zak <kzak@redhat.com>
References: <d0e36cbd-1205-8ce8-3fb3-06efafb12227@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <bea9ac66-2f30-ef50-05ce-565b4d726c66@gmx.com>
Date: Mon, 10 Apr 2017 18:58:37 -0400
MIME-Version: 1.0
In-Reply-To: <d0e36cbd-1205-8ce8-3fb3-06efafb12227@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock-rtc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sys-utils/hwclock-rtc.c b/sys-utils/hwclock-rtc.c
index f272828..b39a970 100644
--- a/sys-utils/hwclock-rtc.c
+++ b/sys-utils/hwclock-rtc.c
@@ -413,8 +413,7 @@ int get_epoch_rtc(const struct hwclock_control *ctl, unsigned long *epoch_p)
 	}
 
 	if (ioctl(rtc_fd, RTC_EPOCH_READ, epoch_p) == -1) {
-			warn(_("ioctl(RTC_EPOCH_READ) to %s failed"),
-				  rtc_dev_name);
+		warn(_("ioctl(RTC_EPOCH_READ) to %s failed"), rtc_dev_name);
 		return 1;
 	}
 
