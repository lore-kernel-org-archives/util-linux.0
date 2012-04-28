Return-Path: dave@gnu.org
Subject: [PATCH] fdisk: isolate dos label logic
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 29 Apr 2012 00:02:45 +0200
Message-ID: <1335650565.2545.5.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

DOS specific logic is currently embedded in the heart of fdisk code. This patch separates DOS label specific code
into its own file, just like the rest of the labels, leaving a more generic fdisk.c file. Most changes are just moving
code from fdisk.c to fdisk.h and fdiskdoslabel.[c/h].

The only logical modification is calling dos_delete_partition() from read_extended(), instead of the generic delete_partition.
This is ok since read extended is only called from a DOS context.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
I know. It's big and ugly, but not so evil to read. Nothing we can really do about it, it must be done eventually. 
This patch applies on top of the last 4 patches sent.

 fdisk/Makefile.am     |    2 +
 fdisk/fdisk.c         |  420 +------------------------------------------------
 fdisk/fdisk.h         |   64 ++++++++-
 fdisk/fdiskdoslabel.c |  323 +++++++++++++++++++++++++++++++++++++
 fdisk/fdiskdoslabel.h |   50 ++++++
 5 files changed, 446 insertions(+), 413 deletions(-)
 create mode 100644 fdisk/fdiskdoslabel.c
 create mode 100644 fdisk/fdiskdoslabel.h

diff --git a/fdisk/Makefile.am b/fdisk/Makefile.am
index b524f5b..7851bd1 100644
--- a/fdisk/Makefile.am
+++ b/fdisk/Makefile.am
@@ -32,6 +32,8 @@ fdisk_SOURCES = \
 	fdisksgilabel.h \
 	fdisksunlabel.c \
 	fdisksunlabel.h \
+	fdiskdoslabel.c \
+	fdiskdoslabel.h \
 	partname.c \
 	$(fdisk_common) \
 	$(top_srcdir)/lib/canonicalize.c
diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index f603a31..6695266 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -32,13 +32,13 @@
 #include "pathnames.h"
 #include "canonicalize.h"
 #include "strutils.h"
-#include "randutils.h"
 #include "closestream.h"
 
 #include "fdisksunlabel.h"
 #include "fdisksgilabel.h"
 #include "fdiskaixlabel.h"
 #include "fdiskmaclabel.h"
+#include "fdiskdoslabel.h"
 
 #ifdef HAVE_LINUX_COMPILER_H
 #include <linux/compiler.h>
@@ -62,8 +62,6 @@ static void delete_partition(int i);
 
 
 #define LINE_LENGTH	800
-#define pt_offset(b, n)	((struct partition *)((b) + 0x1be + \
-				(n) * sizeof(struct partition)))
 #define sector(s)	((s) & 0x3f)
 #define cylinder(s, c)	((c) | (((s) & 0xc0) << 2))
 
@@ -132,84 +130,16 @@ static const struct menulist_descr menulist[] = {
 	{'y', N_("change number of physical cylinders"), {0, SUN_LABEL}},
 };
 
-/* A valid partition table sector ends in 0x55 0xaa */
-static unsigned int
-part_table_flag(unsigned char *b) {
-	return ((unsigned int) b[510]) + (((unsigned int) b[511]) << 8);
-}
-
 int
 valid_part_table_flag(unsigned char *b) {
 	return (b[510] == 0x55 && b[511] == 0xaa);
 }
 
-static void
-write_part_table_flag(unsigned char *b) {
-	b[510] = 0x55;
-	b[511] = 0xaa;
-}
-
-/* start_sect and nr_sects are stored little endian on all machines */
-/* moreover, they are not aligned correctly */
-static void
-store4_little_endian(unsigned char *cp, unsigned int val) {
-	cp[0] = (val & 0xff);
-	cp[1] = ((val >> 8) & 0xff);
-	cp[2] = ((val >> 16) & 0xff);
-	cp[3] = ((val >> 24) & 0xff);
-}
-
-static unsigned int
-read4_little_endian(const unsigned char *cp) {
-	return (unsigned int)(cp[0]) + ((unsigned int)(cp[1]) << 8)
-		+ ((unsigned int)(cp[2]) << 16)
-		+ ((unsigned int)(cp[3]) << 24);
-}
-
-static void
-set_start_sect(struct partition *p, unsigned int start_sect) {
-	store4_little_endian(p->start4, start_sect);
-}
-
-unsigned long long
-get_start_sect(struct partition *p) {
-	return read4_little_endian(p->start4);
-}
-
-static void
-set_nr_sects(struct partition *p, unsigned long long nr_sects) {
-	store4_little_endian(p->size4, nr_sects);
-}
-
 unsigned long long
 get_nr_sects(struct partition *p) {
 	return read4_little_endian(p->size4);
 }
 
-/*
- * Raw disk label. For DOS-type partition tables the MBR,
- * with descriptions of the primary partitions.
- */
-unsigned char *MBRbuffer;
-
-int MBRbuffer_changed;
-
-/*
- * per partition table entry data
- *
- * The four primary partitions have the same sectorbuffer (MBRbuffer)
- * and have NULL ext_pointer.
- * Each logical partition table entry has two pointers, one for the
- * partition and one link to the next one.
- */
-struct pte {
-	struct partition *part_table;	/* points into sectorbuffer */
-	struct partition *ext_pointer;	/* points into sectorbuffer */
-	char changed;			/* boolean */
-	unsigned long long offset;	/* disk sector number */
-	unsigned char *sectorbuffer;	/* disk sector contents */
-} ptes[MAXIMUM_PARTS];
-
 char	*disk_device,			/* must be specified */
 	*line_ptr,			/* interactive input */
 	line_buffer[LINE_LENGTH];
@@ -224,7 +154,7 @@ int	fd,				/* the disk */
 unsigned int	user_cylinders, user_heads, user_sectors;
 unsigned int   pt_heads, pt_sectors;
 
-unsigned long long sector_offset = 1, extended_offset = 0, sectors;
+unsigned long long sector_offset = 1, /* extended_offset = 0, */ sectors;
 
 unsigned int	heads,
 	cylinders,
@@ -283,44 +213,6 @@ void fatal(enum failure why)
 	}
 }
 
-static void
-seek_sector(int fd, unsigned long long secno) {
-	off_t offset = (off_t) secno * sector_size;
-	if (lseek(fd, offset, SEEK_SET) == (off_t) -1)
-		fatal(unable_to_seek);
-}
-
-static void
-read_sector(int fd, unsigned long long secno, unsigned char *buf) {
-	seek_sector(fd, secno);
-	if (read(fd, buf, sector_size) != sector_size)
-		fatal(unable_to_read);
-}
-
-static void
-write_sector(int fd, unsigned long long secno, unsigned char *buf) {
-	seek_sector(fd, secno);
-	if (write(fd, buf, sector_size) != sector_size)
-		fatal(unable_to_write);
-}
-
-/* Allocate a buffer and read a partition table sector */
-static void
-read_pte(int fd, int pno, unsigned long long offset) {
-	struct pte *pe = &ptes[pno];
-
-	pe->offset = offset;
-	pe->sectorbuffer = xmalloc(sector_size);
-	read_sector(fd, offset, pe->sectorbuffer);
-	pe->changed = 0;
-	pe->part_table = pe->ext_pointer = NULL;
-}
-
-static unsigned long long
-get_partition_start(struct pte *pe) {
-	return pe->offset + get_start_sect(pe->part_table);
-}
-
 struct partition *
 get_part_table(int i) {
 	return ptes[i].part_table;
@@ -353,21 +245,6 @@ is_garbage_table(void) {
 	return 0;
 }
 
-/*
- * Avoid warning about DOS partitions when no DOS partition was changed.
- * Here a heuristic "is probably dos partition".
- * We might also do the opposite and warn in all cases except
- * for "is probably nondos partition".
- */
-static int
-is_dos_partition(int t) {
-	return (t == 1 || t == 4 || t == 6 ||
-		t == 0x0b || t == 0x0c || t == 0x0e ||
-		t == 0x11 || t == 0x12 || t == 0x14 || t == 0x16 ||
-		t == 0x1b || t == 0x1c || t == 0x1e || t == 0x24 ||
-		t == 0xc1 || t == 0xc4 || t == 0xc6);
-}
-
 void print_menu(enum menutype menu)
 {
 	size_t i;
@@ -449,22 +326,6 @@ is_cleared_partition(struct partition *p) {
 }
 
 static void
-clear_partition(struct partition *p) {
-	if (!p)
-		return;
-	p->boot_ind = 0;
-	p->head = 0;
-	p->sector = 0;
-	p->cyl = 0;
-	p->sys_ind = 0;
-	p->end_head = 0;
-	p->end_sector = 0;
-	p->end_cyl = 0;
-	set_start_sect(p,0);
-	set_nr_sects(p,0);
-}
-
-static void
 set_partition(int i, int doext, unsigned long long start,
 	      unsigned long long stop, int sysid) {
 	struct partition *p;
@@ -591,8 +452,8 @@ align_lba_in_range(	unsigned long long lba,
 	return lba;
 }
 
-static int
-warn_geometry(void) {
+int warn_geometry(void)
+{
 	char *m = NULL;
 	int prev = 0;
 
@@ -622,8 +483,8 @@ void update_units(void)
 		units_per_sector = 1;	/* in sectors */
 }
 
-static void
-warn_limits(void) {
+void warn_limits(void)
+{
 	if (total_number_of_sectors > UINT_MAX && !nowarn) {
 		unsigned long long bytes = total_number_of_sectors * sector_size;
 		int giga = bytes / 1000000000;
@@ -641,8 +502,8 @@ warn_limits(void) {
 	}
 }
 
-static void
-warn_alignment(void) {
+void warn_alignment(void)
+{
 	if (nowarn)
 		return;
 
@@ -665,182 +526,6 @@ warn_alignment(void) {
 }
 
 static void
-read_extended(int ext) {
-	int i;
-	struct pte *pex;
-	struct partition *p, *q;
-
-	ext_index = ext;
-	pex = &ptes[ext];
-	pex->ext_pointer = pex->part_table;
-
-	p = pex->part_table;
-	if (!get_start_sect(p)) {
-		fprintf(stderr,
-			_("Bad offset in primary extended partition\n"));
-		return;
-	}
-
-	while (IS_EXTENDED (p->sys_ind)) {
-		struct pte *pe = &ptes[partitions];
-
-		if (partitions >= MAXIMUM_PARTS) {
-			/* This is not a Linux restriction, but
-			   this program uses arrays of size MAXIMUM_PARTS.
-			   Do not try to `improve' this test. */
-			struct pte *pre = &ptes[partitions-1];
-
-			fprintf(stderr,
-				_("Warning: omitting partitions after #%d.\n"
-				  "They will be deleted "
-				  "if you save this partition table.\n"),
-				partitions);
-			clear_partition(pre->ext_pointer);
-			pre->changed = 1;
-			return;
-		}
-
-		read_pte(fd, partitions, extended_offset + get_start_sect(p));
-
-		if (!extended_offset)
-			extended_offset = get_start_sect(p);
-
-		q = p = pt_offset(pe->sectorbuffer, 0);
-		for (i = 0; i < 4; i++, p++) if (get_nr_sects(p)) {
-			if (IS_EXTENDED (p->sys_ind)) {
-				if (pe->ext_pointer)
-					fprintf(stderr,
-						_("Warning: extra link "
-						  "pointer in partition table"
-						  " %d\n"), partitions + 1);
-				else
-					pe->ext_pointer = p;
-			} else if (p->sys_ind) {
-				if (pe->part_table)
-					fprintf(stderr,
-						_("Warning: ignoring extra "
-						  "data in partition table"
-						  " %d\n"), partitions + 1);
-				else
-					pe->part_table = p;
-			}
-		}
-
-		/* very strange code here... */
-		if (!pe->part_table) {
-			if (q != pe->ext_pointer)
-				pe->part_table = q;
-			else
-				pe->part_table = q + 1;
-		}
-		if (!pe->ext_pointer) {
-			if (q != pe->part_table)
-				pe->ext_pointer = q;
-			else
-				pe->ext_pointer = q + 1;
-		}
-
-		p = pe->ext_pointer;
-		partitions++;
-	}
-
-	/* remove empty links */
- remove:
-	for (i = 4; i < partitions; i++) {
-		struct pte *pe = &ptes[i];
-
-		if (!get_nr_sects(pe->part_table) &&
-		    (partitions > 5 || ptes[4].part_table->sys_ind)) {
-			printf(_("omitting empty partition (%d)\n"), i+1);
-			delete_partition(i);
-			goto remove; 	/* numbering changed */
-		}
-	}
-}
-
-static void
-dos_write_mbr_id(unsigned char *b, unsigned int id) {
-	store4_little_endian(&b[440], id);
-}
-
-static unsigned int
-dos_read_mbr_id(const unsigned char *b) {
-	return read4_little_endian(&b[440]);
-}
-
-static void
-dos_print_mbr_id(void) {
-	printf(_("Disk identifier: 0x%08x\n"), dos_read_mbr_id(MBRbuffer));
-}
-
-static void
-dos_set_mbr_id(void) {
-	unsigned long new_id;
-	char *ep;
-	char ps[64];
-
-	snprintf(ps, sizeof ps, _("New disk identifier (current 0x%08x): "),
-		 dos_read_mbr_id(MBRbuffer));
-
-	if (read_chars(ps) == '\n')
-		return;
-
-	new_id = strtoul(line_ptr, &ep, 0);
-	if (*ep != '\n')
-		return;
-
-	dos_write_mbr_id(MBRbuffer, new_id);
-	MBRbuffer_changed = 1;
-	dos_print_mbr_id();
-}
-
-static void dos_init(void)
-{
-	int i;
-
-	disklabel = DOS_LABEL;
-	partitions = 4;
-	ext_index = 0;
-	extended_offset = 0;
-
-	for (i = 0; i < 4; i++) {
-		struct pte *pe = &ptes[i];
-
-		pe->part_table = pt_offset(MBRbuffer, i);
-		pe->ext_pointer = NULL;
-		pe->offset = 0;
-		pe->sectorbuffer = MBRbuffer;
-		pe->changed = 0;
-	}
-
-	warn_geometry();
-	warn_limits();
-	warn_alignment();
-}
-
-static void
-create_doslabel(void) {
-	unsigned int id;
-
-	/* random disk signature */
-	random_get_bytes(&id, sizeof(id));
-
-	fprintf(stderr, _("Building a new DOS disklabel with disk identifier 0x%08x.\n"), id);
-
-	dos_init();
-	zeroize_mbr_buffer();
-
-	set_all_unchanged();
-	set_changed(0);
-
-	/* Generate an MBR ID for this disk */
-	dos_write_mbr_id(MBRbuffer, id);
-
-	/* Put MBR signature */
-	write_part_table_flag(MBRbuffer);
-}
-
-static void
 get_topology(int fd) {
 	int arg;
 #ifdef HAVE_LIBBLKID
@@ -1038,41 +723,7 @@ void zeroize_mbr_buffer(void)
 		memset(MBRbuffer, 0, MAX_SECTOR_SIZE);
 }
 
-static int check_dos_label(void)
-{
-	int i;
-
-	if (!valid_part_table_flag(MBRbuffer))
-		return 0;
-
-	dos_init();
 
-	for (i = 0; i < 4; i++) {
-		struct pte *pe = &ptes[i];
-
-		if (IS_EXTENDED (pe->part_table->sys_ind)) {
-			if (partitions != 4)
-				fprintf(stderr, _("Ignoring extra extended "
-					"partition %d\n"), i + 1);
-			else
-				read_extended(i);
-		}
-	}
-
-	for (i = 3; i < partitions; i++) {
-		struct pte *pe = &ptes[i];
-
-		if (!valid_part_table_flag(pe->sectorbuffer)) {
-			fprintf(stderr,
-				_("Warning: invalid flag 0x%04x of partition "
-				"table %d will be corrected by w(rite)\n"),
-				part_table_flag(pe->sectorbuffer), i + 1);
-			pe->changed = 1;
-		}
-	}
-
-	return 1;
-}
 
 /*
  * Read MBR.  Returns:
@@ -1504,61 +1155,6 @@ toggle_dos_compatibility_flag(void) {
 	update_sector_offset();
 }
 
-static void dos_delete_partition(int i)
-{
-	struct pte *pe = &ptes[i];
-	struct partition *p = pe->part_table;
-	struct partition *q = pe->ext_pointer;
-
-	/* Note that for the fifth partition (i == 4) we don't actually
-	   decrement partitions. */
-
-	if (i < 4) {
-		if (IS_EXTENDED (p->sys_ind) && i == ext_index) {
-			partitions = 4;
-			ptes[ext_index].ext_pointer = NULL;
-			extended_offset = 0;
-		}
-		clear_partition(p);
-	} else if (!q->sys_ind && i > 4) {
-		/* the last one in the chain - just delete */
-		--partitions;
-		--i;
-		clear_partition(ptes[i].ext_pointer);
-		ptes[i].changed = 1;
-	} else {
-		/* not the last one - further ones will be moved down */
-		if (i > 4) {
-			/* delete this link in the chain */
-			p = ptes[i-1].ext_pointer;
-			*p = *q;
-			set_start_sect(p, get_start_sect(q));
-			set_nr_sects(p, get_nr_sects(q));
-			ptes[i-1].changed = 1;
-		} else if (partitions > 5) {    /* 5 will be moved to 4 */
-			/* the first logical in a longer chain */
-			struct pte *pe = &ptes[5];
-
-			if (pe->part_table) /* prevent SEGFAULT */
-				set_start_sect(pe->part_table,
-					       get_partition_start(pe) -
-					       extended_offset);
-			pe->offset = extended_offset;
-			pe->changed = 1;
-		}
-
-		if (partitions > 5) {
-			partitions--;
-			while (i < partitions) {
-				ptes[i] = ptes[i+1];
-				i++;
-			}
-		} else
-			/* the only logical: clear only */
-			clear_partition(ptes[i].part_table);
-	}
-}
-
 static void
 delete_partition(int i)
 {
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index cff6b60..2032db7 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -87,12 +87,14 @@ extern void update_units(void);
 extern char read_chars(char *mesg);
 extern void set_changed(int);
 extern void set_all_unchanged(void);
+extern int warn_geometry(void);
+extern void warn_limits(void);
+extern void warn_alignment(void);
 
 #define PLURAL	0
 #define SINGULAR 1
 extern const char * str_units(int);
 
-extern unsigned long long get_start_sect(struct partition *p);
 extern unsigned long long get_nr_sects(struct partition *p);
 
 enum labeltype {
@@ -107,6 +109,66 @@ enum labeltype {
 
 extern enum labeltype disklabel;
 
+/*
+ * Raw disk label. For DOS-type partition tables the MBR,
+ * with descriptions of the primary partitions.
+ */
+int MBRbuffer_changed;
+unsigned char *MBRbuffer;
+
+/* start_sect and nr_sects are stored little endian on all machines */
+/* moreover, they are not aligned correctly */
+static void
+store4_little_endian(unsigned char *cp, unsigned int val) {
+	cp[0] = (val & 0xff);
+	cp[1] = ((val >> 8) & 0xff);
+	cp[2] = ((val >> 16) & 0xff);
+	cp[3] = ((val >> 24) & 0xff);
+}
+
+static unsigned int read4_little_endian(const unsigned char *cp)
+{
+	return (unsigned int)(cp[0]) + ((unsigned int)(cp[1]) << 8)
+		+ ((unsigned int)(cp[2]) << 16)
+		+ ((unsigned int)(cp[3]) << 24);
+}
+
+static void set_nr_sects(struct partition *p, unsigned long long nr_sects)
+{
+	store4_little_endian(p->size4, nr_sects);
+}
+
+static void set_start_sect(struct partition *p, unsigned int start_sect)
+{
+	store4_little_endian(p->start4, start_sect);
+}
+
+static void seek_sector(int fd, unsigned long long secno)
+{
+	off_t offset = (off_t) secno * sector_size;
+	if (lseek(fd, offset, SEEK_SET) == (off_t) -1)
+		fatal(unable_to_seek);
+}
+
+static void read_sector(int fd, unsigned long long secno, unsigned char *buf)
+{
+	seek_sector(fd, secno);
+	if (read(fd, buf, sector_size) != sector_size)
+		fatal(unable_to_read);
+}
+
+static void write_sector(int fd, unsigned long long secno, unsigned char *buf)
+{
+	seek_sector(fd, secno);
+	if (write(fd, buf, sector_size) != sector_size)
+		fatal(unable_to_write);
+}
+
+static unsigned long long get_start_sect(struct partition *p)
+{
+	return read4_little_endian(p->start4);
+}
+
 /* prototypes for fdiskbsdlabel.c */
 extern void bsd_command_prompt(void);
 extern int check_osf_label(void);
diff --git a/fdisk/fdiskdoslabel.c b/fdisk/fdiskdoslabel.c
new file mode 100644
index 0000000..04fdf84
--- /dev/null
+++ b/fdisk/fdiskdoslabel.c
@@ -0,0 +1,323 @@
+/*
+ * Many, many hands.
+ * Specific DOS label file  - Davidlohr Bueso <dave@gnu.org>
+ */
+
+#include <unistd.h>
+
+#include "nls.h"
+#include "xalloc.h"
+#include "randutils.h"
+#include "common.h"
+#include "fdisk.h"
+#include "fdiskdoslabel.h"
+
+/* Allocate a buffer and read a partition table sector */
+static void read_pte(int fd, int pno, unsigned long long offset)
+{
+	struct pte *pe = &ptes[pno];
+
+	pe->offset = offset;
+	pe->sectorbuffer = xmalloc(sector_size);
+	read_sector(fd, offset, pe->sectorbuffer);
+	pe->changed = 0;
+	pe->part_table = pe->ext_pointer = NULL;
+}
+
+static void dos_write_mbr_id(unsigned char *b, unsigned int id)
+{
+	store4_little_endian(&b[440], id);
+}
+
+static unsigned int dos_read_mbr_id(const unsigned char *b)
+{
+	return read4_little_endian(&b[440]);
+}
+
+static void clear_partition(struct partition *p)
+{
+	if (!p)
+		return;
+	p->boot_ind = 0;
+	p->head = 0;
+	p->sector = 0;
+	p->cyl = 0;
+	p->sys_ind = 0;
+	p->end_head = 0;
+	p->end_sector = 0;
+	p->end_cyl = 0;
+	set_start_sect(p,0);
+	set_nr_sects(p,0);
+}
+
+static void dos_init(void)
+{
+	int i;
+
+	disklabel = DOS_LABEL;
+	partitions = 4;
+	ext_index = 0;
+	extended_offset = 0;
+
+	for (i = 0; i < 4; i++) {
+		struct pte *pe = &ptes[i];
+
+		pe->part_table = pt_offset(MBRbuffer, i);
+		pe->ext_pointer = NULL;
+		pe->offset = 0;
+		pe->sectorbuffer = MBRbuffer;
+		pe->changed = 0;
+	}
+
+	warn_geometry();
+	warn_limits();
+	warn_alignment();
+}
+
+static void read_extended(int ext)
+{
+	int i;
+	struct pte *pex;
+	struct partition *p, *q;
+
+	ext_index = ext;
+	pex = &ptes[ext];
+	pex->ext_pointer = pex->part_table;
+
+	p = pex->part_table;
+	if (!get_start_sect(p)) {
+		fprintf(stderr,
+			_("Bad offset in primary extended partition\n"));
+		return;
+	}
+
+	while (IS_EXTENDED (p->sys_ind)) {
+		struct pte *pe = &ptes[partitions];
+
+		if (partitions >= MAXIMUM_PARTS) {
+			/* This is not a Linux restriction, but
+			   this program uses arrays of size MAXIMUM_PARTS.
+			   Do not try to `improve' this test. */
+			struct pte *pre = &ptes[partitions-1];
+
+			fprintf(stderr,
+				_("Warning: omitting partitions after #%d.\n"
+				  "They will be deleted "
+				  "if you save this partition table.\n"),
+				partitions);
+			clear_partition(pre->ext_pointer);
+			pre->changed = 1;
+			return;
+		}
+
+		read_pte(fd, partitions, extended_offset + get_start_sect(p));
+
+		if (!extended_offset)
+			extended_offset = get_start_sect(p);
+
+		q = p = pt_offset(pe->sectorbuffer, 0);
+		for (i = 0; i < 4; i++, p++) if (get_nr_sects(p)) {
+			if (IS_EXTENDED (p->sys_ind)) {
+				if (pe->ext_pointer)
+					fprintf(stderr,
+						_("Warning: extra link "
+						  "pointer in partition table"
+						  " %d\n"), partitions + 1);
+				else
+					pe->ext_pointer = p;
+			} else if (p->sys_ind) {
+				if (pe->part_table)
+					fprintf(stderr,
+						_("Warning: ignoring extra "
+						  "data in partition table"
+						  " %d\n"), partitions + 1);
+				else
+					pe->part_table = p;
+			}
+		}
+
+		/* very strange code here... */
+		if (!pe->part_table) {
+			if (q != pe->ext_pointer)
+				pe->part_table = q;
+			else
+				pe->part_table = q + 1;
+		}
+		if (!pe->ext_pointer) {
+			if (q != pe->part_table)
+				pe->ext_pointer = q;
+			else
+				pe->ext_pointer = q + 1;
+		}
+
+		p = pe->ext_pointer;
+		partitions++;
+	}
+
+	/* remove empty links */
+ remove:
+	for (i = 4; i < partitions; i++) {
+		struct pte *pe = &ptes[i];
+
+		if (!get_nr_sects(pe->part_table) &&
+		    (partitions > 5 || ptes[4].part_table->sys_ind)) {
+			printf(_("omitting empty partition (%d)\n"), i+1);
+			dos_delete_partition(i);
+			goto remove; 	/* numbering changed */
+		}
+	}
+}
+
+void dos_print_mbr_id(void)
+{
+	printf(_("Disk identifier: 0x%08x\n"), dos_read_mbr_id(MBRbuffer));
+}
+
+void create_doslabel(void)
+{
+	unsigned int id;
+
+	/* random disk signature */
+	random_get_bytes(&id, sizeof(id));
+
+	fprintf(stderr, _("Building a new DOS disklabel with disk identifier 0x%08x.\n"), id);
+
+	dos_init();
+	zeroize_mbr_buffer();
+
+	set_all_unchanged();
+	set_changed(0);
+
+	/* Generate an MBR ID for this disk */
+	dos_write_mbr_id(MBRbuffer, id);
+
+	/* Put MBR signature */
+	write_part_table_flag(MBRbuffer);
+}
+
+void dos_set_mbr_id(void)
+{
+	unsigned long new_id;
+	char *ep;
+	char ps[64];
+
+	snprintf(ps, sizeof ps, _("New disk identifier (current 0x%08x): "),
+		 dos_read_mbr_id(MBRbuffer));
+
+	if (read_chars(ps) == '\n')
+		return;
+
+	new_id = strtoul(line_ptr, &ep, 0);
+	if (*ep != '\n')
+		return;
+
+	dos_write_mbr_id(MBRbuffer, new_id);
+	MBRbuffer_changed = 1;
+	dos_print_mbr_id();
+}
+
+void dos_delete_partition(int i)
+{
+	struct pte *pe = &ptes[i];
+	struct partition *p = pe->part_table;
+	struct partition *q = pe->ext_pointer;
+
+	/* Note that for the fifth partition (i == 4) we don't actually
+	   decrement partitions. */
+
+	if (i < 4) {
+		if (IS_EXTENDED (p->sys_ind) && i == ext_index) {
+			partitions = 4;
+			ptes[ext_index].ext_pointer = NULL;
+			extended_offset = 0;
+		}
+		clear_partition(p);
+	} else if (!q->sys_ind && i > 4) {
+		/* the last one in the chain - just delete */
+		--partitions;
+		--i;
+		clear_partition(ptes[i].ext_pointer);
+		ptes[i].changed = 1;
+	} else {
+		/* not the last one - further ones will be moved down */
+		if (i > 4) {
+			/* delete this link in the chain */
+			p = ptes[i-1].ext_pointer;
+			*p = *q;
+			set_start_sect(p, get_start_sect(q));
+			set_nr_sects(p, get_nr_sects(q));
+			ptes[i-1].changed = 1;
+		} else if (partitions > 5) {    /* 5 will be moved to 4 */
+			/* the first logical in a longer chain */
+			struct pte *pe = &ptes[5];
+
+			if (pe->part_table) /* prevent SEGFAULT */
+				set_start_sect(pe->part_table,
+					       get_partition_start(pe) -
+					       extended_offset);
+			pe->offset = extended_offset;
+			pe->changed = 1;
+		}
+
+		if (partitions > 5) {
+			partitions--;
+			while (i < partitions) {
+				ptes[i] = ptes[i+1];
+				i++;
+			}
+		} else
+			/* the only logical: clear only */
+			clear_partition(ptes[i].part_table);
+	}
+}
+
+int check_dos_label(void)
+{
+	int i;
+
+	if (!valid_part_table_flag(MBRbuffer))
+		return 0;
+
+	dos_init();
+
+	for (i = 0; i < 4; i++) {
+		struct pte *pe = &ptes[i];
+
+		if (IS_EXTENDED (pe->part_table->sys_ind)) {
+			if (partitions != 4)
+				fprintf(stderr, _("Ignoring extra extended "
+					"partition %d\n"), i + 1);
+			else
+				read_extended(i);
+		}
+	}
+
+	for (i = 3; i < partitions; i++) {
+		struct pte *pe = &ptes[i];
+
+		if (!valid_part_table_flag(pe->sectorbuffer)) {
+			fprintf(stderr,
+				_("Warning: invalid flag 0x%04x of partition "
+				"table %d will be corrected by w(rite)\n"),
+				part_table_flag(pe->sectorbuffer), i + 1);
+			pe->changed = 1;
+		}
+	}
+
+	return 1;
+}
+
+/*
+ * Avoid warning about DOS partitions when no DOS partition was changed.
+ * Here a heuristic "is probably dos partition".
+ * We might also do the opposite and warn in all cases except
+ * for "is probably nondos partition".
+ */
+int is_dos_partition(int t)
+{
+	return (t == 1 || t == 4 || t == 6 ||
+		t == 0x0b || t == 0x0c || t == 0x0e ||
+		t == 0x11 || t == 0x12 || t == 0x14 || t == 0x16 ||
+		t == 0x1b || t == 0x1c || t == 0x1e || t == 0x24 ||
+		t == 0xc1 || t == 0xc4 || t == 0xc6);
+}
diff --git a/fdisk/fdiskdoslabel.h b/fdisk/fdiskdoslabel.h
new file mode 100644
index 0000000..b444243
--- /dev/null
+++ b/fdisk/fdiskdoslabel.h
@@ -0,0 +1,50 @@
+#ifndef FDISK_DOS_LABEL_H
+#define FDISK_DOS_LABEL_H
+
+/*
+ * per partition table entry data
+ *
+ * The four primary partitions have the same sectorbuffer (MBRbuffer)
+ * and have NULL ext_pointer.
+ * Each logical partition table entry has two pointers, one for the
+ * partition and one link to the next one.
+ */
+struct pte {
+	struct partition *part_table;	/* points into sectorbuffer */
+	struct partition *ext_pointer;	/* points into sectorbuffer */
+	char changed;			/* boolean */
+	unsigned long long offset;	/* disk sector number */
+	unsigned char *sectorbuffer;	/* disk sector contents */
+} ptes[MAXIMUM_PARTS];
+
+#define pt_offset(b, n)	((struct partition *)((b) + 0x1be + \
+					      (n) * sizeof(struct partition)))
+
+int ext_index; /* the prime extended partition */
+unsigned long long extended_offset;
+
+static void write_part_table_flag(unsigned char *b)
+{
+	b[510] = 0x55;
+	b[511] = 0xaa;
+}
+
+/* A valid partition table sector ends in 0x55 0xaa */
+static unsigned int part_table_flag(unsigned char *b)
+{
+	return ((unsigned int) b[510]) + (((unsigned int) b[511]) << 8);
+}
+
+static unsigned long long get_partition_start(struct pte *pe)
+{
+	return pe->offset + get_start_sect(pe->part_table);
+}
+
+extern void create_doslabel(void);
+extern void dos_print_mbr_id(void);
+extern void dos_set_mbr_id(void);
+extern void dos_delete_partition(int i);
+extern int check_dos_label(void);
+extern int is_dos_partition(int t);
+
+#endif
-- 
1.7.4.1
