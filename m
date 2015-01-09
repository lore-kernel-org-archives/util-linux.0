Return-Path: elseifthen@gmx.com
Message-ID: <54B0215A.3030808@gmx.com>
Date: Fri, 09 Jan 2015 13:43:38 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: [PATCH] hwclock: man regression
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

Fixes merge for commit 2ed1d70 that clobbered commit 98ac774

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
The following changes since commit 4bb82a455461e42644c9b3d8aa1206ad8889ed35:

  libfdisk: (gpt) cleanup header size usage (2015-01-09 13:05:49 +0100)

are available in the git repository at:

  git@github.com:jwpi/util-linux.git man

 sys-utils/hwclock.8.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/hwclock.8.in b/sys-utils/hwclock.8.in
index 20a8dd0..74a3146 100644
--- a/sys-utils/hwclock.8.in
+++ b/sys-utils/hwclock.8.in
@@ -783,7 +783,7 @@ synchronizes the System Clock.
 .PP
 If your system runs with \%'11\ minute\ mode' on, it may need to use either
 .BR \%\-\-hctosys " or " \%\-\-systz
-in a startup script, especially if the Hardware Clock is configured to to use
+in a startup script, especially if the Hardware Clock is configured to use
 the local timescale. Unless the kernel is informed of what timescale the
 Hardware Clock is using, it may clobber it with the wrong one. The kernel
 uses UTC by default.
