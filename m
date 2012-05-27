Return-Path: dave@gnu.org
Subject: [PATCH 5/7] fdisk: dos: use sector_t
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 27 May 2012 21:44:17 +0200
Message-ID: <1338147857.22474.4.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdiskdoslabel.c |   28 ++++++++++++----------------
 fdisk/fdiskdoslabel.h |    6 +++---
 2 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/fdisk/fdiskdoslabel.c b/fdisk/fdiskdoslabel.c
index 1bd27ef..382909c 100644
--- a/fdisk/fdiskdoslabel.c
+++ b/fdisk/fdiskdoslabel.c
@@ -25,7 +25,7 @@
 #define alignment_required	(grain != sector_size)
 
 struct pte ptes[MAXIMUM_PARTS];
-unsigned long long extended_offset;
+sector_t extended_offset;
 int ext_index;
 
 static int get_nonexisting_partition(int warn, int max)
@@ -59,7 +59,7 @@ static int get_nonexisting_partition(int warn, int max)
 

 /* Allocate a buffer and read a partition table sector */
-static void read_pte(struct fdisk_context *cxt, int pno, unsigned long long offset)
+static void read_pte(struct fdisk_context *cxt, int pno, sector_t offset)
 {
 	struct pte *pe = &ptes[pno];
 
@@ -368,11 +368,11 @@ int is_dos_partition(int t)
 		t == 0xc1 || t == 0xc4 || t == 0xc6);
 }
 
-static void set_partition(int i, int doext, unsigned long long start,
-			  unsigned long long stop, int sysid)
+static void set_partition(int i, int doext, sector_t start,
+			  sector_t stop, int sysid)
 {
 	struct partition *p;
-	unsigned long long offset;
+	sector_t offset;
 
 	if (doext) {
 		p = ptes[i].ext_pointer;
@@ -398,15 +398,13 @@ static void set_partition(int i, int doext, unsigned long long start,
 	ptes[i].changed = 1;
 }
 
-static unsigned long long get_unused_start(int part_n,
-					   unsigned long long start,
-					   unsigned long long first[],
-					   unsigned long long last[])
+static sector_t get_unused_start(int part_n, sector_t start,
+				 sector_t first[], sector_t last[])
 {
 	int i;
 
 	for (i = 0; i < partitions; i++) {
-		unsigned long long lastplusoff;
+		sector_t lastplusoff;
 
 		if (start == ptes[i].offset)
 			start += sector_offset;
@@ -418,9 +416,7 @@ static unsigned long long get_unused_start(int part_n,
 	return start;
 }
 
-static unsigned long long align_lba_in_range(	unsigned long long lba,
-						unsigned long long start,
-						unsigned long long stop)
+static sector_t align_lba_in_range(sector_t lba, sector_t start, sector_t stop)
 {
 	start = align_lba(start, ALIGN_UP);
 	stop = align_lba(stop, ALIGN_DOWN);
@@ -440,7 +436,7 @@ void dos_add_partition(int n, int sys)
 	int i, read = 0;
 	struct partition *p = ptes[n].part_table;
 	struct partition *q = ptes[ext_index].part_table;
-	unsigned long long start, stop = 0, limit, temp,
+	sector_t start, stop = 0, limit, temp,
 		first[partitions], last[partitions];
 
 	if (p && p->sys_ind) {
@@ -474,7 +470,7 @@ void dos_add_partition(int n, int sys)
 
 	snprintf(mesg, sizeof(mesg), _("First %s"), str_units(SINGULAR));
 	do {
-		unsigned long long dflt, aligned;
+		sector_t dflt, aligned;
 
 		temp = start;
 		dflt = start = get_unused_start(n, start, first, last);
@@ -495,7 +491,7 @@ void dos_add_partition(int n, int sys)
 			read = 0;
 		}
 		if (!read && start == temp) {
-			unsigned long long i = start;
+			sector_t i = start;
 
 			start = read_int(cround(i), cround(dflt), cround(limit),
 					 0, mesg);
diff --git a/fdisk/fdiskdoslabel.h b/fdisk/fdiskdoslabel.h
index 7f5e48e..a436e53 100644
--- a/fdisk/fdiskdoslabel.h
+++ b/fdisk/fdiskdoslabel.h
@@ -13,7 +13,7 @@ struct pte {
 	struct partition *part_table;	/* points into sectorbuffer */
 	struct partition *ext_pointer;	/* points into sectorbuffer */
 	char changed;			/* boolean */
-	unsigned long long offset;	/* disk sector number */
+	sector_t offset;	        /* disk sector number */
 	unsigned char *sectorbuffer;	/* disk sector contents */
 };
 
@@ -24,7 +24,7 @@ extern int dos_compatible_flag;
 					      (n) * sizeof(struct partition)))
 
 extern int ext_index; /* the prime extended partition */
-extern unsigned long long extended_offset, sector_offset;
+extern sector_t extended_offset, sector_offset;
 
 static inline void write_part_table_flag(unsigned char *b)
 {
@@ -38,7 +38,7 @@ static inline unsigned int part_table_flag(unsigned char *b)
 	return ((unsigned int) b[510]) + (((unsigned int) b[511]) << 8);
 }
 
-static inline unsigned long long get_partition_start(struct pte *pe)
+static inline sector_t get_partition_start(struct pte *pe)
 {
 	return pe->offset + get_start_sect(pe->part_table);
 }
-- 
1.7.4.1
