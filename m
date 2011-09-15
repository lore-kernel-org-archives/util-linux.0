Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 6/6] lscpu: stricter command line parsing
Date: Thu, 15 Sep 2011 08:52:34 +0200
Message-Id: <1316069554-20977-7-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1316069554-20977-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1316069554-20977-1-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Disallow superfluous commands for lscpu like e.g. "lscpu bla" and let it
fail print the help text instead.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 31c8fa8..f21af71 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1275,6 +1275,10 @@ int main(int argc, char *argv[])
 			usage(stderr);
 		}
 	}
+
+	if (argc != optind)
+		usage(stderr);
+
 	/* set default cpu display mode if none was specified */
 	if (!mod->online && !mod->offline) {
 		mod->online = 1;
-- 
1.7.5.4
