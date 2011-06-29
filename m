Return-Path: dave@gnu.org
Subject: [PATCH 3/3] mkfs.minix: document -3 option
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jun 2011 13:28:17 -0400
Message-ID: <1309368497.3162.5.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Wed, 29 Jun 2011 13:01:10 -0400

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 disk-utils/mkfs.minix.8 |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/disk-utils/mkfs.minix.8 b/disk-utils/mkfs.minix.8
index add59c8..6a8ebae 100644
--- a/disk-utils/mkfs.minix.8
+++ b/disk-utils/mkfs.minix.8
@@ -64,6 +64,9 @@ Make a Minix version 1 filesystem.
 .TP
 .B  \-2,\-v
 Make a Minix version 2 filesystem.
+.TP
+.B \-3
+Make a Minix version 3 filesystem.
 .SH "EXIT CODES"
 The exit code returned by
 .B mkfs.minix
--=20
1.7.4.1
