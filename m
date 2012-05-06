Return-Path: dave@gnu.org
Subject: [PATCH] lslocks: fix bracket indentation
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 06 May 2012 21:06:01 +0200
Message-ID: <1336331161.2685.23.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 misc-utils/lslocks.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
index 2f9093d..13eaaf3 100644
--- a/misc-utils/lslocks.c
+++ b/misc-utils/lslocks.c
@@ -204,7 +204,7 @@ static char *get_filename_sz(ino_t inode, pid_t pid, size_t *size)
 
 		ret = xstrdup(sym);
 		break;
-}
+	}
 out:
 	closedir(dirp);
 	return ret;
-- 
1.7.4.1
