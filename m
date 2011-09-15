Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 4/6] lscpu: fix -e output
Date: Thu, 15 Sep 2011 08:52:32 +0200
Message-Id: <1316069554-20977-5-git-send-email-heiko.carstens@de.ibm.com>
In-Reply-To: <1316069554-20977-1-git-send-email-heiko.carstens@de.ibm.com>
References: <1316069554-20977-1-git-send-email-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

The modifier mod->allcpus must be set earlier and also must be used
earlier. The current code only reads sysfs attributes from online
cpus but skips offline cpus.
So initialize mod->allcpus earlier.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 78d936f..63377d1 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1266,11 +1266,13 @@ int main(int argc, char *argv[])
 			usage(stderr);
 		}
 	}
+	if (mod->mode == OUTPUT_READABLE && !mod->online)
+		mod->allcpus = 1;
 
 	read_basicinfo(desc, mod);
 
 	for (i = 0; i < desc->ncpus; i++) {
-		if (desc->online && !is_cpu_online(desc, i))
+		if (desc->online && !is_cpu_online(desc, i) && !mod->allcpus)
 			continue;
 		read_topology(desc, i);
 		read_cache(desc, i);
@@ -1300,8 +1302,6 @@ int main(int argc, char *argv[])
 		print_parsable(desc, columns, ncolumns, mod);
 		break;
 	case OUTPUT_READABLE:
-		if (!mod->online)
-			mod->allcpus = 1;
 		if (!ncolumns) {
 			/* No list was given. Just print whatever is there. */
 			columns[ncolumns++] = COL_CPU;
-- 
1.7.5.4
