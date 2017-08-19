Return-Path: elseifthen@gmx.com
Subject: [PATCH 6/6] hwclock: for debugging print startup system time
To: Karel Zak <kzak@redhat.com>
References: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <2e80fe91-3ed7-bcdb-7bf3-e17fa3176fda@gmx.com>
Date: Fri, 18 Aug 2017 20:24:13 -0400
MIME-Version: 1.0
In-Reply-To: <7059c516-6d5f-0579-81be-60b4519f0ce7@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 sys-utils/hwclock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 4279931..72f1f09 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -1364,8 +1364,11 @@ int main(int argc, char **argv)
 	}
 #endif
 
-	if (ctl.debug)
+	if (ctl.debug) {
 		out_version();
+		printf(_("System Time: %ld.%06ld\n"),
+		       startup_time.tv_sec, startup_time.tv_usec);
+	}
 
 	if (!ctl.systz && !ctl.predict)
 		determine_clock_access_method(&ctl);
