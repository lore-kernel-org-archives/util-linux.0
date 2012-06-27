Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:48078 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751602Ab2F0NrX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Jun 2012 09:47:23 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] findmnt: add FSROOT column
Date: Wed, 27 Jun 2012 09:47:20 -0400
Message-Id: <1340804840-1666-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Provide this separately in an unambiguous format, mainly to avoid the
need for scripts to parse the source of a btrfs subvol or bind mount.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 misc-utils/findmnt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index c4cebf8..d7b252a 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -78,6 +78,7 @@ enum {
 	COL_AVAIL,
 	COL_USED,
 	COL_USEPERC,
+	COL_FSROOT,
 
 	FINDMNT_NCOLUMNS
 };
@@ -118,6 +119,7 @@ static struct colinfo infos[FINDMNT_NCOLUMNS] = {
 	[COL_AVAIL]        = { "AVAIL",           5, TT_FL_RIGHT, N_("filesystem size available") },
 	[COL_USED]         = { "USED",            5, TT_FL_RIGHT, N_("filesystem size used") },
 	[COL_USEPERC]      = { "USE%",            3, TT_FL_RIGHT, N_("filesystem use percentage") },
+	[COL_FSROOT]       = { "FSROOT",       0.25, TT_FL_NOEXTREMES, N_("filesystem root") },
 };
 
 /* global flags */
@@ -470,6 +472,9 @@ static const char *get_data(struct libmnt_fs *fs, int num)
 	case COL_USEPERC:
 		str = get_vfs_attr(fs, col_id);
 		break;
+	case COL_FSROOT:
+		str = mnt_fs_get_root(fs);
+		break;
 	default:
 		break;
 	}
-- 
1.7.11.1

