Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcaib.dreamhost.com ([208.97.132.81]:37441 "EHLO
	homiemail-a62.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753376Ab2EFMK1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 6 May 2012 08:10:27 -0400
Subject: [PATCH 2/5] fdisk: move DOS new/add partition code
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 06 May 2012 14:10:18 +0200
Message-ID: <1336306218.2685.11.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
 
Since this is DOS specific logic, it belongs in its own label file. Additionally, a dos_new_partition() function is created
that asks the user for partition type and then calls the actual dos_add_partition().

This patch passed fdisk regression tests, builds without problems and it was locally tested against adding and removing DOS partitions.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c         |  354 ++-----------------------------------------------
 fdisk/fdisk.h         |   22 +++-
 fdisk/fdiskdoslabel.c |  332 ++++++++++++++++++++++++++++++++++++++++++++++
 fdisk/fdiskdoslabel.h |    5 +-
 4 files changed, 365 insertions(+), 348 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 3543745..8c2a162 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -64,19 +64,9 @@ int MBRbuffer_changed;
 			})
 

-#define LINE_LENGTH	800
 #define sector(s)	((s) & 0x3f)
 #define cylinder(s, c)	((c) | (((s) & 0xc0) << 2))
 
-#define set_hsc(h,s,c,sector) { \
-				s = sector % sectors + 1;	\
-				sector /= sectors;	\
-				h = sector % heads;	\
-				sector /= heads;	\
-				c = sector & 0xff;	\
-				s |= (sector >> 2) & 0xc0;	\
-			}
-
 /* menu list description */
 
 struct menulist_descr {
@@ -154,7 +144,7 @@ int	fd,				/* the disk */
 unsigned int	user_cylinders, user_heads, user_sectors;
 unsigned int   pt_heads, pt_sectors;
 
-unsigned long long sector_offset = 1, /* extended_offset = 0, */ sectors;
+unsigned long long sector_offset = 1, sectors;
 
 unsigned int	heads,
 	cylinders,
@@ -319,43 +309,6 @@ void list_types(struct systypes *sys)
 }
 
 static int
-is_cleared_partition(struct partition *p) {
-	return !(!p || p->boot_ind || p->head || p->sector || p->cyl ||
-		 p->sys_ind || p->end_head || p->end_sector || p->end_cyl ||
-		 get_start_sect(p) || get_nr_sects(p));
-}
-
-static void
-set_partition(int i, int doext, unsigned long long start,
-	      unsigned long long stop, int sysid) {
-	struct partition *p;
-	unsigned long long offset;
-
-	if (doext) {
-		p = ptes[i].ext_pointer;
-		offset = extended_offset;
-	} else {
-		p = ptes[i].part_table;
-		offset = ptes[i].offset;
-	}
-	p->boot_ind = 0;
-	p->sys_ind = sysid;
-	set_start_sect(p, start - offset);
-	set_nr_sects(p, stop - start + 1);
-
-	if (!doext)
-		print_partition_size(i + 1, start, stop, sysid);
-
-	if (dos_compatible_flag && (start/(sectors*heads) > 1023))
-		start = heads*sectors*1024 - 1;
-	set_hsc(p->head, p->sector, p->cyl, start);
-	if (dos_compatible_flag && (stop/(sectors*heads) > 1023))
-		stop = heads*sectors*1024 - 1;
-	set_hsc(p->end_head, p->end_sector, p->end_cyl, stop);
-	ptes[i].changed = 1;
-}
-
-static int
 test_c(char **m, char *mesg) {
 	int val = 0;
 	if (!*m)
@@ -368,8 +321,6 @@ test_c(char **m, char *mesg) {
 	return val;
 }
 
-#define alignment_required	(grain != sector_size)
-
 static int
 lba_is_aligned(unsigned long long lba)
 {
@@ -379,12 +330,7 @@ lba_is_aligned(unsigned long long lba)
 	return !((granularity + alignment_offset - offset) & (granularity - 1));
 }
 
-#define ALIGN_UP	1
-#define ALIGN_DOWN	2
-#define ALIGN_NEAREST	3
-
-static unsigned long long
-align_lba(unsigned long long lba, int direction)
+unsigned long long align_lba(unsigned long long lba, int direction)
 {
 	unsigned long long res;
 
@@ -435,23 +381,6 @@ align_lba(unsigned long long lba, int direction)
 	return res;
 }
 
-static unsigned long long
-align_lba_in_range(	unsigned long long lba,
-			unsigned long long start,
-			unsigned long long stop)
-{
-	start = align_lba(start, ALIGN_UP);
-	stop = align_lba(stop, ALIGN_DOWN);
-
-	lba = align_lba(lba, ALIGN_NEAREST);
-
-	if (lba < start)
-		return start;
-	else if (lba > stop)
-		return stop;
-	return lba;
-}
-
 int warn_geometry(void)
 {
 	char *m = NULL;
@@ -881,7 +810,7 @@ read_hex(struct systypes *sys)
         }
 }
 
-static unsigned int
+unsigned int
 read_int_with_suffix(unsigned int low, unsigned int dflt, unsigned int high,
 	 unsigned int base, char *mesg, int *is_suffix_used)
 {
@@ -1024,7 +953,6 @@ read_int(unsigned int low, unsigned int dflt, unsigned int high,
 	return read_int_with_suffix(low, dflt, high, base, mesg, NULL);
 }
 
-
 int
 get_partition_dflt(int warn, int max, int dflt) {
 	struct pte *pe;
@@ -1085,35 +1013,6 @@ not_unique:
 	return get_partition(warn, max);
 }
 
-static int
-get_nonexisting_partition(int warn, int max) {
-	int pno = -1;
-	int i;
-	int dflt = 0;
-
-	for (i = 0; i < max; i++) {
-		struct pte *pe = &ptes[i];
-		struct partition *p = pe->part_table;
-
-		if (p && is_cleared_partition(p)) {
-			if (pno >= 0) {
-				dflt = pno + 1;
-				goto not_unique;
-			}
-			pno = i;
-		}
-	}
-	if (pno >= 0) {
-		printf(_("Selected partition %d\n"), pno+1);
-		return pno;
-	}
-	printf(_("All primary partitions have been defined already!\n"));
-	return -1;
-
- not_unique:
-	return get_partition_dflt(warn, max, dflt);
-}
-
 const char *
 str_units(int n)
 {
@@ -1604,8 +1503,8 @@ x_list_table(int extend) {
 	}
 }
 
-static void
-fill_bounds(unsigned long long *first, unsigned long long *last) {
+void fill_bounds(unsigned long long *first, unsigned long long *last)
+{
 	int i;
 	struct pte *pe = &ptes[0];
 	struct partition *p;
@@ -1724,27 +1623,6 @@ verify(void) {
 		       n_sectors - total, sector_size);
 }
 
-static unsigned long long
-get_unused_start(int part_n,
-		unsigned long long start,
-		unsigned long long first[],
-		unsigned long long last[])
-{
-	int i;
-
-	for (i = 0; i < partitions; i++) {
-		unsigned long long lastplusoff;
-
-		if (start == ptes[i].offset)
-			start += sector_offset;
-		lastplusoff = last[i] + ((part_n < 4) ? 0 : sector_offset);
-		if (start >= first[i] && start <= lastplusoff)
-			start = lastplusoff + 1;
-	}
-
-	return start;
-}
-
 void print_partition_size(int num, unsigned long long start, unsigned long long stop, int sysid)
 {
 	char *str = size_to_human_string(SIZE_SUFFIX_3LETTER | SIZE_SUFFIX_SPACE,
@@ -1753,171 +1631,8 @@ void print_partition_size(int num, unsigned long long start, unsigned long long
 	free(str);
 }
 
-static void
-add_partition(int n, int sys) {
-	char mesg[256];		/* 48 does not suffice in Japanese */
-	int i, read = 0;
-	struct partition *p = ptes[n].part_table;
-	struct partition *q = ptes[ext_index].part_table;
-	unsigned long long start, stop = 0, limit, temp,
-		first[partitions], last[partitions];
-
-	if (p && p->sys_ind) {
-		printf(_("Partition %d is already defined.  Delete "
-			 "it before re-adding it.\n"), n + 1);
-		return;
-	}
-	fill_bounds(first, last);
-	if (n < 4) {
-		start = sector_offset;
-		if (display_in_cyl_units || !total_number_of_sectors)
-			limit = heads * sectors * cylinders - 1;
-		else
-			limit = total_number_of_sectors - 1;
-
-		if (limit > UINT_MAX)
-			limit = UINT_MAX;
-
-		if (extended_offset) {
-			first[ext_index] = extended_offset;
-			last[ext_index] = get_start_sect(q) +
-				get_nr_sects(q) - 1;
-		}
-	} else {
-		start = extended_offset + sector_offset;
-		limit = get_start_sect(q) + get_nr_sects(q) - 1;
-	}
-	if (display_in_cyl_units)
-		for (i = 0; i < partitions; i++)
-			first[i] = (cround(first[i]) - 1) * units_per_sector;
-
-	snprintf(mesg, sizeof(mesg), _("First %s"), str_units(SINGULAR));
-	do {
-		unsigned long long dflt, aligned;
-
-		temp = start;
-		dflt = start = get_unused_start(n, start, first, last);
-
-		/* the default sector should be aligned and unused */
-		do {
-			aligned = align_lba_in_range(dflt, dflt, limit);
-			dflt = get_unused_start(n, aligned, first, last);
-		} while (dflt != aligned && dflt > aligned && dflt < limit);
-
-		if (dflt >= limit)
-			dflt = start;
-		if (start > limit)
-			break;
-		if (start >= temp+units_per_sector && read) {
-			printf(_("Sector %llu is already allocated\n"), temp);
-			temp = start;
-			read = 0;
-		}
-		if (!read && start == temp) {
-			unsigned long long i = start;
-
-			start = read_int(cround(i), cround(dflt), cround(limit),
-					 0, mesg);
-			if (display_in_cyl_units) {
-				start = (start - 1) * units_per_sector;
-				if (start < i) start = i;
-			}
-			read = 1;
-		}
-	} while (start != temp || !read);
-	if (n > 4) {			/* NOT for fifth partition */
-		struct pte *pe = &ptes[n];
-
-		pe->offset = start - sector_offset;
-		if (pe->offset == extended_offset) { /* must be corrected */
-			pe->offset++;
-			if (sector_offset == 1)
-				start++;
-		}
-	}
-
-	for (i = 0; i < partitions; i++) {
-		struct pte *pe = &ptes[i];
-
-		if (start < pe->offset && limit >= pe->offset)
-			limit = pe->offset - 1;
-		if (start < first[i] && limit >= first[i])
-			limit = first[i] - 1;
-	}
-	if (start > limit) {
-		printf(_("No free sectors available\n"));
-		if (n > 4)
-			partitions--;
-		return;
-	}
-	if (cround(start) == cround(limit)) {
-		stop = limit;
-	} else {
-		int is_suffix_used = 0;
-
-		snprintf(mesg, sizeof(mesg),
-			_("Last %1$s, +%2$s or +size{K,M,G}"),
-			 str_units(SINGULAR), str_units(PLURAL));
-
-		stop = read_int_with_suffix(cround(start), cround(limit), cround(limit),
-				cround(start), mesg, &is_suffix_used);
-		if (display_in_cyl_units) {
-			stop = stop * units_per_sector - 1;
-			if (stop >limit)
-				stop = limit;
-		}
-
-		if (is_suffix_used && alignment_required) {
-			/* the last sector has not been exactly requested (but
-			 * defined by +size{K,M,G} convention), so be smart
-			 * and align the end of the partition. The next
-			 * partition will start at phy.block boundary.
-			 */
-			stop = align_lba_in_range(stop, start, limit) - 1;
-			if (stop > limit)
-				stop = limit;
-		}
-	}
-
-	set_partition(n, 0, start, stop, sys);
-	if (n > 4)
-		set_partition(n - 1, 1, ptes[n].offset, stop, EXTENDED);
-
-	if (IS_EXTENDED (sys)) {
-		struct pte *pe4 = &ptes[4];
-		struct pte *pen = &ptes[n];
-
-		ext_index = n;
-		pen->ext_pointer = p;
-		pe4->offset = extended_offset = start;
-		pe4->sectorbuffer = xcalloc(1, sector_size);
-		pe4->part_table = pt_offset(pe4->sectorbuffer, 0);
-		pe4->ext_pointer = pe4->part_table + 1;
-		pe4->changed = 1;
-		partitions = 5;
-	}
-}
-
-static void
-add_logical(void) {
-	if (partitions > 5 || ptes[4].part_table->sys_ind) {
-		struct pte *pe = &ptes[partitions];
-
-		pe->sectorbuffer = xcalloc(1, sector_size);
-		pe->part_table = pt_offset(pe->sectorbuffer, 0);
-		pe->ext_pointer = pe->part_table + 1;
-		pe->offset = 0;
-		pe->changed = 1;
-		partitions++;
-	}
-	printf(_("Adding logical partition %d\n"), partitions);
-	add_partition(partitions - 1, LINUX_NATIVE);
-}
-
-static void
-new_partition(void) {
-	int i, free_primary = 0;
-
+static void new_partition(void)
+{
 	if (warn_geometry())
 		return;
 
@@ -1949,59 +1664,8 @@ new_partition(void) {
 		 return;
 	}
 
-	for (i = 0; i < 4; i++)
-		free_primary += !ptes[i].part_table->sys_ind;
-
-	if (!free_primary && partitions >= MAXIMUM_PARTS) {
-		printf(_("The maximum number of partitions has been created\n"));
-		return;
-	}
-
-	if (!free_primary) {
-		if (extended_offset) {
-			printf(_("All primary partitions are in use\n"));
-			add_logical();
-		} else
-			printf(_("If you want to create more than four partitions, you must replace a\n"
-				 "primary partition with an extended partition first.\n"));
-	} else if (partitions >= MAXIMUM_PARTS) {
-		printf(_("All logical partitions are in use\n"));
-		printf(_("Adding a primary partition\n"));
-		add_partition(get_partition(0, 4), LINUX_NATIVE);
-	} else {
-		char c, dflt, line[LINE_LENGTH];
-
-		dflt = (free_primary == 1 && !extended_offset) ? 'e' : 'p';
-		snprintf(line, sizeof(line),
-			 _("Partition type:\n"
-			   "   p   primary (%d primary, %d extended, %d free)\n"
-			   "%s\n"
-			   "Select (default %c): "),
-			 4 - (extended_offset ? 1 : 0) - free_primary, extended_offset ? 1 : 0, free_primary,
-			 extended_offset ? _("   l   logical (numbered from 5)") : _("   e   extended"),
-			 dflt);
-
-		c = tolower(read_chars(line));
-		if (c == '\n') {
-			c = dflt;
-			printf(_("Using default response %c\n"), c);
-		}
-		if (c == 'p') {
-			int i = get_nonexisting_partition(0, 4);
-			if (i >= 0)
-				add_partition(i, LINUX_NATIVE);
-			return;
-		} else if (c == 'l' && extended_offset) {
-			add_logical();
-			return;
-		} else if (c == 'e' && !extended_offset) {
-			int i = get_nonexisting_partition(0, 4);
-			if (i >= 0)
-				add_partition(i, EXTENDED);
-			return;
-		} else
-			printf(_("Invalid partition type `%c'\n"), c);
-	}
+	/* default to DOS/BSD */
+	dos_new_partition();
 }
 
 static void
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index 3a1cfd7..0dafbf8 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -20,6 +20,12 @@
 #define LINUX_LVM       0x8e
 #define LINUX_RAID      0xfd
 
+#define ALIGN_UP	1
+#define ALIGN_DOWN	2
+#define ALIGN_NEAREST	3
+
+#define LINE_LENGTH	800
+
 #define IS_EXTENDED(i) \
 	((i) == EXTENDED || (i) == WIN98_EXTENDED || (i) == LINUX_EXTENDED)
 
@@ -78,7 +84,7 @@ extern void print_menu(enum menutype);
 extern void print_partition_size(int num, unsigned long long start, unsigned long long stop, int sysid);
 
 extern void zeroize_mbr_buffer(void);
-
+extern void fill_bounds(unsigned long long *first, unsigned long long *last);
 extern unsigned int heads, cylinders, sector_size;
 extern unsigned long long sectors;
 extern char *partition_type(unsigned char type);
@@ -89,6 +95,10 @@ extern void set_all_unchanged(void);
 extern int warn_geometry(void);
 extern void warn_limits(void);
 extern void warn_alignment(void);
+extern unsigned int read_int_with_suffix(unsigned int low, unsigned int dflt, unsigned int high,
+				  unsigned int base, char *mesg, int *is_suffix_used);
+extern unsigned long long align_lba(unsigned long long lba, int direction);
+extern int get_partition_dflt(int warn, int max, int dflt);
 
 #define PLURAL	0
 #define SINGULAR 1
@@ -114,7 +124,8 @@ extern enum labeltype disklabel;
  */
 extern unsigned char *MBRbuffer;
 extern int MBRbuffer_changed;
-
+extern unsigned long long total_number_of_sectors;
+extern unsigned long grain;
 /* start_sect and nr_sects are stored little endian on all machines */
 /* moreover, they are not aligned correctly */
 static inline void
@@ -168,6 +179,13 @@ static inline unsigned long long get_start_sect(struct partition *p)
 	return read4_little_endian(p->start4);
 }
 
+static inline int is_cleared_partition(struct partition *p)
+{
+	return !(!p || p->boot_ind || p->head || p->sector || p->cyl ||
+		 p->sys_ind || p->end_head || p->end_sector || p->end_cyl ||
+		 get_start_sect(p) || get_nr_sects(p));
+}
+
 /* prototypes for fdiskbsdlabel.c */
 extern void bsd_command_prompt(void);
 extern int check_osf_label(void);
diff --git a/fdisk/fdiskdoslabel.c b/fdisk/fdiskdoslabel.c
index 4dfe876..3f820db 100644
--- a/fdisk/fdiskdoslabel.c
+++ b/fdisk/fdiskdoslabel.c
@@ -4,6 +4,7 @@
  */
 
 #include <unistd.h>
+#include <ctype.h>
 
 #include "nls.h"
 #include "xalloc.h"
@@ -12,10 +13,51 @@
 #include "fdisk.h"
 #include "fdiskdoslabel.h"
 
+#define set_hsc(h,s,c,sector) { \
+		s = sector % sectors + 1;			\
+		sector /= sectors;				\
+		h = sector % heads;				\
+		sector /= heads;				\
+		c = sector & 0xff;				\
+		s |= (sector >> 2) & 0xc0;			\
+	}
+
+#define alignment_required	(grain != sector_size)
+
 struct pte ptes[MAXIMUM_PARTS];
 unsigned long long extended_offset;
 int ext_index;
 
+static int get_nonexisting_partition(int warn, int max)
+{
+	int pno = -1;
+	int i;
+	int dflt = 0;
+
+	for (i = 0; i < max; i++) {
+		struct pte *pe = &ptes[i];
+		struct partition *p = pe->part_table;
+
+		if (p && is_cleared_partition(p)) {
+			if (pno >= 0) {
+				dflt = pno + 1;
+				goto not_unique;
+			}
+			pno = i;
+		}
+	}
+	if (pno >= 0) {
+		printf(_("Selected partition %d\n"), pno+1);
+		return pno;
+	}
+	printf(_("All primary partitions have been defined already!\n"));
+	return -1;
+
+ not_unique:
+	return get_partition_dflt(warn, max, dflt);
+}
+
+
 /* Allocate a buffer and read a partition table sector */
 static void read_pte(int fd, int pno, unsigned long long offset)
 {
@@ -325,3 +367,293 @@ int is_dos_partition(int t)
 		t == 0x1b || t == 0x1c || t == 0x1e || t == 0x24 ||
 		t == 0xc1 || t == 0xc4 || t == 0xc6);
 }
+
+static void set_partition(int i, int doext, unsigned long long start,
+			  unsigned long long stop, int sysid)
+{
+	struct partition *p;
+	unsigned long long offset;
+
+	if (doext) {
+		p = ptes[i].ext_pointer;
+		offset = extended_offset;
+	} else {
+		p = ptes[i].part_table;
+		offset = ptes[i].offset;
+	}
+	p->boot_ind = 0;
+	p->sys_ind = sysid;
+	set_start_sect(p, start - offset);
+	set_nr_sects(p, stop - start + 1);
+
+	if (!doext)
+		print_partition_size(i + 1, start, stop, sysid);
+
+	if (dos_compatible_flag && (start/(sectors*heads) > 1023))
+		start = heads*sectors*1024 - 1;
+	set_hsc(p->head, p->sector, p->cyl, start);
+	if (dos_compatible_flag && (stop/(sectors*heads) > 1023))
+		stop = heads*sectors*1024 - 1;
+	set_hsc(p->end_head, p->end_sector, p->end_cyl, stop);
+	ptes[i].changed = 1;
+}
+
+static unsigned long long get_unused_start(int part_n,
+					   unsigned long long start,
+					   unsigned long long first[],
+					   unsigned long long last[])
+{
+	int i;
+
+	for (i = 0; i < partitions; i++) {
+		unsigned long long lastplusoff;
+
+		if (start == ptes[i].offset)
+			start += sector_offset;
+		lastplusoff = last[i] + ((part_n < 4) ? 0 : sector_offset);
+		if (start >= first[i] && start <= lastplusoff)
+			start = lastplusoff + 1;
+	}
+
+	return start;
+}
+
+static unsigned long long align_lba_in_range(	unsigned long long lba,
+						unsigned long long start,
+						unsigned long long stop)
+{
+	start = align_lba(start, ALIGN_UP);
+	stop = align_lba(stop, ALIGN_DOWN);
+
+	lba = align_lba(lba, ALIGN_NEAREST);
+
+	if (lba < start)
+		return start;
+	else if (lba > stop)
+		return stop;
+	return lba;
+}
+
+void dos_add_partition(int n, int sys)
+{
+	char mesg[256];		/* 48 does not suffice in Japanese */
+	int i, read = 0;
+	struct partition *p = ptes[n].part_table;
+	struct partition *q = ptes[ext_index].part_table;
+	unsigned long long start, stop = 0, limit, temp,
+		first[partitions], last[partitions];
+
+	if (p && p->sys_ind) {
+		printf(_("Partition %d is already defined.  Delete "
+			 "it before re-adding it.\n"), n + 1);
+		return;
+	}
+	fill_bounds(first, last);
+	if (n < 4) {
+		start = sector_offset;
+		if (display_in_cyl_units || !total_number_of_sectors)
+			limit = heads * sectors * cylinders - 1;
+		else
+			limit = total_number_of_sectors - 1;
+
+		if (limit > UINT_MAX)
+			limit = UINT_MAX;
+
+		if (extended_offset) {
+			first[ext_index] = extended_offset;
+			last[ext_index] = get_start_sect(q) +
+				get_nr_sects(q) - 1;
+		}
+	} else {
+		start = extended_offset + sector_offset;
+		limit = get_start_sect(q) + get_nr_sects(q) - 1;
+	}
+	if (display_in_cyl_units)
+		for (i = 0; i < partitions; i++)
+			first[i] = (cround(first[i]) - 1) * units_per_sector;
+
+	snprintf(mesg, sizeof(mesg), _("First %s"), str_units(SINGULAR));
+	do {
+		unsigned long long dflt, aligned;
+
+		temp = start;
+		dflt = start = get_unused_start(n, start, first, last);
+
+		/* the default sector should be aligned and unused */
+		do {
+			aligned = align_lba_in_range(dflt, dflt, limit);
+			dflt = get_unused_start(n, aligned, first, last);
+		} while (dflt != aligned && dflt > aligned && dflt < limit);
+
+		if (dflt >= limit)
+			dflt = start;
+		if (start > limit)
+			break;
+		if (start >= temp+units_per_sector && read) {
+			printf(_("Sector %llu is already allocated\n"), temp);
+			temp = start;
+			read = 0;
+		}
+		if (!read && start == temp) {
+			unsigned long long i = start;
+
+			start = read_int(cround(i), cround(dflt), cround(limit),
+					 0, mesg);
+			if (display_in_cyl_units) {
+				start = (start - 1) * units_per_sector;
+				if (start < i) start = i;
+			}
+			read = 1;
+		}
+	} while (start != temp || !read);
+	if (n > 4) {			/* NOT for fifth partition */
+		struct pte *pe = &ptes[n];
+
+		pe->offset = start - sector_offset;
+		if (pe->offset == extended_offset) { /* must be corrected */
+			pe->offset++;
+			if (sector_offset == 1)
+				start++;
+		}
+	}
+
+	for (i = 0; i < partitions; i++) {
+		struct pte *pe = &ptes[i];
+
+		if (start < pe->offset && limit >= pe->offset)
+			limit = pe->offset - 1;
+		if (start < first[i] && limit >= first[i])
+			limit = first[i] - 1;
+	}
+	if (start > limit) {
+		printf(_("No free sectors available\n"));
+		if (n > 4)
+			partitions--;
+		return;
+	}
+	if (cround(start) == cround(limit)) {
+		stop = limit;
+	} else {
+		int is_suffix_used = 0;
+
+		snprintf(mesg, sizeof(mesg),
+			_("Last %1$s, +%2$s or +size{K,M,G}"),
+			 str_units(SINGULAR), str_units(PLURAL));
+
+		stop = read_int_with_suffix(cround(start), cround(limit), cround(limit),
+				cround(start), mesg, &is_suffix_used);
+		if (display_in_cyl_units) {
+			stop = stop * units_per_sector - 1;
+			if (stop >limit)
+				stop = limit;
+		}
+
+		if (is_suffix_used && alignment_required) {
+			/* the last sector has not been exactly requested (but
+			 * defined by +size{K,M,G} convention), so be smart
+			 * and align the end of the partition. The next
+			 * partition will start at phy.block boundary.
+			 */
+			stop = align_lba_in_range(stop, start, limit) - 1;
+			if (stop > limit)
+				stop = limit;
+		}
+	}
+
+	set_partition(n, 0, start, stop, sys);
+	if (n > 4)
+		set_partition(n - 1, 1, ptes[n].offset, stop, EXTENDED);
+
+	if (IS_EXTENDED (sys)) {
+		struct pte *pe4 = &ptes[4];
+		struct pte *pen = &ptes[n];
+
+		ext_index = n;
+		pen->ext_pointer = p;
+		pe4->offset = extended_offset = start;
+		pe4->sectorbuffer = xcalloc(1, sector_size);
+		pe4->part_table = pt_offset(pe4->sectorbuffer, 0);
+		pe4->ext_pointer = pe4->part_table + 1;
+		pe4->changed = 1;
+		partitions = 5;
+	}
+}
+
+static void add_logical(void)
+{
+	if (partitions > 5 || ptes[4].part_table->sys_ind) {
+		struct pte *pe = &ptes[partitions];
+
+		pe->sectorbuffer = xcalloc(1, sector_size);
+		pe->part_table = pt_offset(pe->sectorbuffer, 0);
+		pe->ext_pointer = pe->part_table + 1;
+		pe->offset = 0;
+		pe->changed = 1;
+		partitions++;
+	}
+	printf(_("Adding logical partition %d\n"), partitions);
+	dos_add_partition(partitions - 1, LINUX_NATIVE);
+}
+
+/*
+ * Ask the user for new partition type information (logical, extended).
+ * This function calls the actual partition adding logic - dos_add_partition.
+ */
+void dos_new_partition(void)
+{
+	int i, free_primary = 0;
+
+	for (i = 0; i < 4; i++)
+		free_primary += !ptes[i].part_table->sys_ind;
+
+	if (!free_primary && partitions >= MAXIMUM_PARTS) {
+		printf(_("The maximum number of partitions has been created\n"));
+		return;
+	}
+
+	if (!free_primary) {
+		if (extended_offset) {
+			printf(_("All primary partitions are in use\n"));
+			add_logical();
+		} else
+			printf(_("If you want to create more than four partitions, you must replace a\n"
+				 "primary partition with an extended partition first.\n"));
+	} else if (partitions >= MAXIMUM_PARTS) {
+		printf(_("All logical partitions are in use\n"));
+		printf(_("Adding a primary partition\n"));
+		dos_add_partition(get_partition(0, 4), LINUX_NATIVE);
+	} else {
+		char c, dflt, line[LINE_LENGTH];
+
+		dflt = (free_primary == 1 && !extended_offset) ? 'e' : 'p';
+		snprintf(line, sizeof(line),
+			 _("Partition type:\n"
+			   "   p   primary (%d primary, %d extended, %d free)\n"
+			   "%s\n"
+			   "Select (default %c): "),
+			 4 - (extended_offset ? 1 : 0) - free_primary, extended_offset ? 1 : 0, free_primary,
+			 extended_offset ? _("   l   logical (numbered from 5)") : _("   e   extended"),
+			 dflt);
+
+		c = tolower(read_chars(line));
+		if (c == '\n') {
+			c = dflt;
+			printf(_("Using default response %c\n"), c);
+		}
+		if (c == 'p') {
+			int i = get_nonexisting_partition(0, 4);
+			if (i >= 0)
+				dos_add_partition(i, LINUX_NATIVE);
+			return;
+		} else if (c == 'l' && extended_offset) {
+			add_logical();
+			return;
+		} else if (c == 'e' && !extended_offset) {
+			int i = get_nonexisting_partition(0, 4);
+			if (i >= 0)
+				dos_add_partition(i, EXTENDED);
+			return;
+		} else
+			printf(_("Invalid partition type `%c'\n"), c);
+	}
+}
diff --git a/fdisk/fdiskdoslabel.h b/fdisk/fdiskdoslabel.h
index 1897b6c..e45a026 100644
--- a/fdisk/fdiskdoslabel.h
+++ b/fdisk/fdiskdoslabel.h
@@ -18,12 +18,13 @@ struct pte {
 };
 
 extern struct pte ptes[MAXIMUM_PARTS];
+extern int dos_compatible_flag;
 
 #define pt_offset(b, n)	((struct partition *)((b) + 0x1be + \
 					      (n) * sizeof(struct partition)))
 
 extern int ext_index; /* the prime extended partition */
-extern unsigned long long extended_offset;
+extern unsigned long long extended_offset, sector_offset;
 
 static inline void write_part_table_flag(unsigned char *b)
 {
@@ -49,5 +50,7 @@ extern void dos_delete_partition(int i);
 extern int check_dos_label(void);
 extern int is_dos_partition(int t);
 extern void dos_init(void);
+extern void dos_add_partition(int n, int sys);
+extern void dos_new_partition(void);
 
 #endif
-- 
1.7.4.1




