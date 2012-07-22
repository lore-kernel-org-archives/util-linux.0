Return-Path: dave@gnu.org
Subject: [PATCH 10/10] fdisk: API: add FDISK_ERROR_NOLABEL error string
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 22 Jul 2012 19:05:48 +0200
Message-ID: <1342976748.2863.20.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/utils.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/fdisks/utils.c b/fdisks/utils.c
index 510d641..383c1a4 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -426,6 +426,8 @@ const char *fdisk_error_name(enum fdisk_error errcode)
 		return "error: ioctl";
 	case FDISK_ERROR_PROBE:
 		return "error: cannot probe";
+	case FDISK_ERROR_NOLABEL:
+		return "error: cannot recognize device partition table";
 	default:
 		return "error: unknown";
 	}
-- 
1.7.4.1
