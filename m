Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccah.dreamhost.com ([208.97.132.207]:51028 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752182Ab2E0ToR (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 27 May 2012 15:44:17 -0400
Subject: [PATCH 4/7] fdisk: introduce sector_t type
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 27 May 2012 21:44:13 +0200
Message-ID: <1338147853.22474.3.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |   38 ++++++++++++++++++--------------------
 fdisk/fdisk.h |   24 +++++++++++++-----------
 2 files changed, 31 insertions(+), 31 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 3e15b6b..1143b2f 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -125,8 +125,7 @@ valid_part_table_flag(unsigned char *b) {
 	return (b[510] == 0x55 && b[511] == 0xaa);
 }
 
-unsigned long long
-get_nr_sects(struct partition *p) {
+sector_t get_nr_sects(struct partition *p) {
 	return read4_little_endian(p->size4);
 }
 
@@ -141,7 +140,7 @@ int	nowarn = 0,			/* no warnings for fdisk -l/-s */
 unsigned int	user_cylinders, user_heads, user_sectors;
 unsigned int   pt_heads, pt_sectors;
 
-unsigned long long sector_offset = 1, sectors;
+sector_t sector_offset = 1, sectors;
 
 unsigned int	heads,
 	cylinders,
@@ -150,7 +149,7 @@ unsigned int	heads,
 	units_per_sector = 1,
 	display_in_cyl_units = 0;
 
-unsigned long long total_number_of_sectors;	/* in logical sectors */
+sector_t total_number_of_sectors; /* in logical sectors */
 unsigned long grain = DEFAULT_SECTOR_SIZE,
 	      io_size = DEFAULT_SECTOR_SIZE,
 	      min_io_size = DEFAULT_SECTOR_SIZE,
@@ -319,22 +318,22 @@ test_c(char **m, char *mesg) {
 }
 
 static int
-lba_is_aligned(unsigned long long lba)
+lba_is_aligned(sector_t lba)
 {
 	unsigned int granularity = max(phy_sector_size, min_io_size);
-	unsigned long long offset = (lba * sector_size) & (granularity - 1);
+	sector_t offset = (lba * sector_size) & (granularity - 1);
 
 	return !((granularity + alignment_offset - offset) & (granularity - 1));
 }
 
-unsigned long long align_lba(unsigned long long lba, int direction)
+sector_t align_lba(sector_t lba, int direction)
 {
-	unsigned long long res;
+	sector_t res;
 
 	if (lba_is_aligned(lba))
 		res = lba;
 	else {
-		unsigned long long sects_in_phy = grain / sector_size;
+		sector_t sects_in_phy = grain / sector_size;
 
 		if (lba < sector_offset)
 			res = sector_offset;
@@ -423,7 +422,7 @@ void warn_limits(void)
 "partition table format (GPT).\n\n"),
 			hectogiga / 10, hectogiga % 10,
 			bytes,
-			(unsigned long long ) UINT_MAX * sector_size,
+			(sector_t ) UINT_MAX * sector_size,
 			sector_size);
 	}
 }
@@ -563,7 +562,7 @@ update_sector_offset(void)
 		 *
 		 * c) or for very small devices use 1 phy.sector
 		 */
-		unsigned long long x = 0;
+		sector_t x = 0;
 
 		if (has_topology) {
 			if (alignment_offset)
@@ -593,7 +592,7 @@ update_sector_offset(void)
 
 void
 get_geometry(struct fdisk_context *cxt, struct geom *g) {
-	unsigned long long llcyls, nsects = 0;
+	sector_t llcyls, nsects = 0;
 	unsigned int kern_heads = 0, kern_sectors = 0;
 
 	get_topology(cxt);
@@ -1205,7 +1204,7 @@ static void check_consistency(struct partition *p, int partition) {
 }
 
 static void
-check_alignment(unsigned long long lba, int partition)
+check_alignment(sector_t lba, int partition)
 {
 	if (!lba_is_aligned(lba))
 		printf(_("Partition %i does not start on physical sector boundary.\n"),
@@ -1489,7 +1488,7 @@ x_list_table(struct fdisk_context *cxt, int extend) {
 	}
 }
 
-void fill_bounds(unsigned long long *first, unsigned long long *last)
+void fill_bounds(sector_t *first, sector_t *last)
 {
 	int i;
 	struct pte *pe = &ptes[0];
@@ -1536,8 +1535,7 @@ check(int n, unsigned int h, unsigned int s, unsigned int c,
 static void
 verify(void) {
 	int i, j;
-	unsigned long long total = 1;
-	unsigned long long n_sectors = total_number_of_sectors;
+	sector_t total = 1, n_sectors = total_number_of_sectors;
 	unsigned long long first[partitions], last[partitions];
 	struct partition *p;
 
@@ -1583,7 +1581,7 @@ verify(void) {
 
 	if (extended_offset) {
 		struct pte *pex = &ptes[ext_index];
-		unsigned long long e_last = get_start_sect(pex->part_table) +
+		sector_t e_last = get_start_sect(pex->part_table) +
 			get_nr_sects(pex->part_table) - 1;
 
 		for (i = 4; i < partitions; i++) {
@@ -1609,7 +1607,7 @@ verify(void) {
 		       n_sectors - total, sector_size);
 }
 
-void print_partition_size(int num, unsigned long long start, unsigned long long stop, int sysid)
+void print_partition_size(int num, sector_t start, sector_t stop, int sysid)
 {
 	char *str = size_to_human_string(SIZE_SUFFIX_3LETTER | SIZE_SUFFIX_SPACE,
 				     (stop - start + 1) * sector_size);
@@ -2096,10 +2094,10 @@ static void command_prompt(struct fdisk_context *cxt)
 	}
 }
 
-static unsigned long long get_dev_blocks(char *dev)
+static sector_t get_dev_blocks(char *dev)
 {
 	int fd;
-	unsigned long long size;
+	sector_t size;
 
 	if ((fd = open(dev, O_RDONLY)) < 0)
 		err(EXIT_FAILURE, _("unable to open %s"), dev);
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index 9c75ca4..31129e8 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -100,6 +100,8 @@ struct geom {
 	unsigned int cylinders;
 };
 
+typedef unsigned long long sector_t;
+
 struct fdisk_context {
 	int dev_fd;     /* device descriptor */
 	char *dev_path; /* device path */
@@ -126,12 +128,12 @@ extern int valid_part_table_flag(unsigned char *b);
 extern unsigned int read_int(unsigned int low, unsigned int dflt,
 			     unsigned int high, unsigned int base, char *mesg);
 extern void print_menu(enum menutype);
-extern void print_partition_size(int num, unsigned long long start, unsigned long long stop, int sysid);
+extern void print_partition_size(int num, sector_t start, sector_t stop, int sysid);
 
 extern void zeroize_mbr_buffer(void);
-extern void fill_bounds(unsigned long long *first, unsigned long long *last);
+extern void fill_bounds(sector_t *first, sector_t *last);
 extern unsigned int heads, cylinders, sector_size;
-extern unsigned long long sectors;
+extern sector_t sectors;
 extern char *partition_type(unsigned char type);
 extern void update_units(void);
 extern char read_chars(char *mesg);
@@ -142,14 +144,14 @@ extern void warn_limits(void);
 extern void warn_alignment(void);
 extern unsigned int read_int_with_suffix(unsigned int low, unsigned int dflt, unsigned int high,
 				  unsigned int base, char *mesg, int *is_suffix_used);
-extern unsigned long long align_lba(unsigned long long lba, int direction);
+extern sector_t align_lba(sector_t lba, int direction);
 extern int get_partition_dflt(int warn, int max, int dflt);
 
 #define PLURAL	0
 #define SINGULAR 1
 extern const char * str_units(int);
 
-extern unsigned long long get_nr_sects(struct partition *p);
+extern sector_t get_nr_sects(struct partition *p);
 
 enum labeltype {
 	DOS_LABEL = 1,
@@ -169,7 +171,7 @@ extern enum labeltype disklabel;
  */
 extern unsigned char *MBRbuffer;
 extern int MBRbuffer_changed;
-extern unsigned long long total_number_of_sectors;
+extern sector_t total_number_of_sectors;
 extern unsigned long grain;
 /* start_sect and nr_sects are stored little endian on all machines */
 /* moreover, they are not aligned correctly */
@@ -188,7 +190,7 @@ static inline unsigned int read4_little_endian(const unsigned char *cp)
 		+ ((unsigned int)(cp[3]) << 24);
 }
 
-static inline void set_nr_sects(struct partition *p, unsigned long long nr_sects)
+static inline void set_nr_sects(struct partition *p, sector_t nr_sects)
 {
 	store4_little_endian(p->size4, nr_sects);
 }
@@ -198,28 +200,28 @@ static inline void set_start_sect(struct partition *p, unsigned int start_sect)
 	store4_little_endian(p->start4, start_sect);
 }
 
-static inline void seek_sector(struct fdisk_context *cxt, unsigned long long secno)
+static inline void seek_sector(struct fdisk_context *cxt, sector_t secno)
 {
 	off_t offset = (off_t) secno * sector_size;
 	if (lseek(cxt->dev_fd, offset, SEEK_SET) == (off_t) -1)
 		fatal(cxt, unable_to_seek);
 }
 
-static inline void read_sector(struct fdisk_context *cxt, unsigned long long secno, unsigned char *buf)
+static inline void read_sector(struct fdisk_context *cxt, sector_t secno, unsigned char *buf)
 {
 	seek_sector(cxt, secno);
 	if (read(cxt->dev_fd, buf, sector_size) != sector_size)
 		fatal(cxt, unable_to_read);
 }
 
-static inline void write_sector(struct fdisk_context *cxt, unsigned long long secno, unsigned char *buf)
+static inline void write_sector(struct fdisk_context *cxt, sector_t secno, unsigned char *buf)
 {
 	seek_sector(cxt, secno);
 	if (write(cxt->dev_fd, buf, sector_size) != sector_size)
 		fatal(cxt, unable_to_write);
 }
 
-static inline unsigned long long get_start_sect(struct partition *p)
+static inline sector_t get_start_sect(struct partition *p)
 {
 	return read4_little_endian(p->start4);
 }
-- 
1.7.4.1




