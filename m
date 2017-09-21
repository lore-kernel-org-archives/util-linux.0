Return-Path: elseifthen@gmx.com
Subject: [PATCH 2/2] Docs: add hwclock 'highlights' v2.31-ReleaseNotes
To: Karel Zak <kzak@redhat.com>
References: <20170920093910.topplypo723gwper@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <d0c89b94-8a82-f3f0-ecf6-3c0c874dddf8@gmx.com>
Date: Wed, 20 Sep 2017 21:20:47 -0400
MIME-Version: 1.0
In-Reply-To: <20170920093910.topplypo723gwper@ws.net.home>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 Documentation/releases/v2.31-ReleaseNotes | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/releases/v2.31-ReleaseNotes b/Documentation/releases/v2.31-ReleaseNotes
index bc0c6f4ea..fb3e29e87 100644
--- a/Documentation/releases/v2.31-ReleaseNotes
+++ b/Documentation/releases/v2.31-ReleaseNotes
@@ -67,6 +67,14 @@ option --ambient-caps (thanks Patrick Steinhardt) and the new command line
 option --init-groups allows initialization of supplementary groups (thanks to
 Sebastian Schrader).
 
+The hwclock command now significantly reduces system shutdown times by not
+reading the RTC before setting it (except when the --update-drift option is
+used). This also mitigates other potential shutdown and RTC setting problems
+caused by requiring an RTC read.
+
+The hwclock command now logs --systz when using libaudit. Also, for busybox
+compatibility -l is now aliased to --localtime.
+
 
 Security issues
 ---------------
