Return-Path: heiko.carstens@de.ibm.com
Message-Id: <20110906010157.588946438@de.ibm.com>
Date: Tue, 06 Sep 2011 02:52:55 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH 04/11] [PATCH] lscpu: allow read_cache() to be called for offline cpus
References: <20110906005251.497675140@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

First check path before accessing files to be sure they actually
exist. This is necessary when also informations for offline CPUs
will be printed.
Since we do not necessarily know if "cpu is offline" means the same
as "path does not exist" just check for it.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 sys-utils/lscpu.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 49b6f2b..d7c7028 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -804,6 +804,9 @@ read_cache(struct lscpu_desc *desc, int num)
 		struct cpu_cache *ca = &desc->caches[i];
 		cpu_set_t *map;
 
+		if (!path_exist(_PATH_SYS_SYSTEM "/cpu/cpu%d/cache/index%d",
+				num, i))
+			continue;
 		if (!ca->name) {
 			int type, level;
 
-- 
1.7.5.4
