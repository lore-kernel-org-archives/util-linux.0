Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2299 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754744Ab2EBMRc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 May 2012 08:17:32 -0400
Date: Wed, 2 May 2012 14:17:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] fdisk: isolate dos label logic
Message-ID: <20120502121703.GA16016@x2.net.home>
References: <1335650565.2545.5.camel@offbook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1335650565.2545.5.camel@offbook>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 29, 2012 at 12:02:45AM +0200, Davidlohr Bueso wrote:
> I know. It's big and ugly, but not so evil to read.

David, test your patches! Please. This patch was completely broken.

> --- a/fdisk/fdisk.c
> +++ b/fdisk/fdisk.c
...
> -/*
> - * Raw disk label. For DOS-type partition tables the MBR,
> - * with descriptions of the primary partitions.
> - */
> -unsigned char *MBRbuffer;
> -
> -int MBRbuffer_changed;

No, in .c file has to be definition and in .h file is "extern ...".

> diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
> index cff6b60..2032db7 100644
> --- a/fdisk/fdisk.h
> +++ b/fdisk/fdisk.h
> @@ -87,12 +87,14 @@ extern void update_units(void);
>  extern char read_chars(char *mesg);
>  extern void set_changed(int);
>  extern void set_all_unchanged(void);
> +extern int warn_geometry(void);
> +extern void warn_limits(void);
> +extern void warn_alignment(void);
>  
>  #define PLURAL	0
>  #define SINGULAR 1
>  extern const char * str_units(int);
>  
> -extern unsigned long long get_start_sect(struct partition *p);
>  extern unsigned long long get_nr_sects(struct partition *p);
>  
>  enum labeltype {
> @@ -107,6 +109,66 @@ enum labeltype {
>  
>  extern enum labeltype disklabel;
>  
> +/*
> + * Raw disk label. For DOS-type partition tables the MBR,
> + * with descriptions of the primary partitions.
> + */
> +int MBRbuffer_changed;
> +unsigned char *MBRbuffer;

this belong to fdisk.c, to fdisk.h belong:

     extern int MBRbuffer_changed;
     extern unsigned char *MBRbuffer;

> +/* start_sect and nr_sects are stored little endian on all machines */
> +/* moreover, they are not aligned correctly */
> +static void
> +store4_little_endian(unsigned char *cp, unsigned int val) {

this is header file, so "static inline ..."

    Karel


>From 96f817fb169ac38fe5535cb8c6d2fdf9b2cb8f10 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Wed, 2 May 2012 14:05:51 +0200
Subject: [PATCH] fdisk: fix fdiskdoslabel.c global variables

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 fdisk/fdisk.c         |    4 +++-
 fdisk/fdisk.h         |   21 ++++++++++-----------
 fdisk/fdiskdoslabel.c |    4 ++++
 fdisk/fdiskdoslabel.h |   14 ++++++++------
 4 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 6695266..acc84d1 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -54,6 +54,9 @@
 
 static void delete_partition(int i);
 
+unsigned char *MBRbuffer;
+int MBRbuffer_changed;
+
 #define hex_val(c)	({ \
 				char _c = (c); \
 				isdigit(_c) ? _c - '0' : \
@@ -145,7 +148,6 @@ char	*disk_device,			/* must be specified */
 	line_buffer[LINE_LENGTH];
 
 int	fd,				/* the disk */
-	ext_index,			/* the prime extended partition */
 	nowarn = 0,			/* no warnings for fdisk -l/-s */
 	dos_compatible_flag = 0,	/* disabled by default */
 	dos_changed = 0,
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index da86e30..3a1cfd7 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -77,7 +77,6 @@ extern unsigned int read_int(unsigned int low, unsigned int dflt,
 extern void print_menu(enum menutype);
 extern void print_partition_size(int num, unsigned long long start, unsigned long long stop, int sysid);
 
-extern unsigned char *MBRbuffer;
 extern void zeroize_mbr_buffer(void);
 
 extern unsigned int heads, cylinders, sector_size;
@@ -113,12 +112,12 @@ extern enum labeltype disklabel;
  * Raw disk label. For DOS-type partition tables the MBR,
  * with descriptions of the primary partitions.
  */
-int MBRbuffer_changed;
-unsigned char *MBRbuffer;
+extern unsigned char *MBRbuffer;
+extern int MBRbuffer_changed;
 
 /* start_sect and nr_sects are stored little endian on all machines */
 /* moreover, they are not aligned correctly */
-static void
+static inline void
 store4_little_endian(unsigned char *cp, unsigned int val) {
 	cp[0] = (val & 0xff);
 	cp[1] = ((val >> 8) & 0xff);
@@ -126,45 +125,45 @@ store4_little_endian(unsigned char *cp, unsigned int val) {
 	cp[3] = ((val >> 24) & 0xff);
 }
 
-static unsigned int read4_little_endian(const unsigned char *cp)
+static inline unsigned int read4_little_endian(const unsigned char *cp)
 {
 	return (unsigned int)(cp[0]) + ((unsigned int)(cp[1]) << 8)
 		+ ((unsigned int)(cp[2]) << 16)
 		+ ((unsigned int)(cp[3]) << 24);
 }
 
-static void set_nr_sects(struct partition *p, unsigned long long nr_sects)
+static inline void set_nr_sects(struct partition *p, unsigned long long nr_sects)
 {
 	store4_little_endian(p->size4, nr_sects);
 }
 
-static void set_start_sect(struct partition *p, unsigned int start_sect)
+static inline void set_start_sect(struct partition *p, unsigned int start_sect)
 {
 	store4_little_endian(p->start4, start_sect);
 }
 
-static void seek_sector(int fd, unsigned long long secno)
+static inline void seek_sector(int fd, unsigned long long secno)
 {
 	off_t offset = (off_t) secno * sector_size;
 	if (lseek(fd, offset, SEEK_SET) == (off_t) -1)
 		fatal(unable_to_seek);
 }
 
-static void read_sector(int fd, unsigned long long secno, unsigned char *buf)
+static inline void read_sector(int fd, unsigned long long secno, unsigned char *buf)
 {
 	seek_sector(fd, secno);
 	if (read(fd, buf, sector_size) != sector_size)
 		fatal(unable_to_read);
 }
 
-static void write_sector(int fd, unsigned long long secno, unsigned char *buf)
+static inline void write_sector(int fd, unsigned long long secno, unsigned char *buf)
 {
 	seek_sector(fd, secno);
 	if (write(fd, buf, sector_size) != sector_size)
 		fatal(unable_to_write);
 }
 
-static unsigned long long get_start_sect(struct partition *p)
+static inline unsigned long long get_start_sect(struct partition *p)
 {
 	return read4_little_endian(p->start4);
 }
diff --git a/fdisk/fdiskdoslabel.c b/fdisk/fdiskdoslabel.c
index 04fdf84..6a9a044 100644
--- a/fdisk/fdiskdoslabel.c
+++ b/fdisk/fdiskdoslabel.c
@@ -12,6 +12,10 @@
 #include "fdisk.h"
 #include "fdiskdoslabel.h"
 
+struct pte ptes[MAXIMUM_PARTS];
+unsigned long long extended_offset;
+int ext_index;
+
 /* Allocate a buffer and read a partition table sector */
 static void read_pte(int fd, int pno, unsigned long long offset)
 {
diff --git a/fdisk/fdiskdoslabel.h b/fdisk/fdiskdoslabel.h
index b444243..f5568df 100644
--- a/fdisk/fdiskdoslabel.h
+++ b/fdisk/fdiskdoslabel.h
@@ -15,27 +15,29 @@ struct pte {
 	char changed;			/* boolean */
 	unsigned long long offset;	/* disk sector number */
 	unsigned char *sectorbuffer;	/* disk sector contents */
-} ptes[MAXIMUM_PARTS];
+};
+
+extern struct pte ptes[MAXIMUM_PARTS];
 
 #define pt_offset(b, n)	((struct partition *)((b) + 0x1be + \
 					      (n) * sizeof(struct partition)))
 
-int ext_index; /* the prime extended partition */
-unsigned long long extended_offset;
+extern int ext_index; /* the prime extended partition */
+extern unsigned long long extended_offset;
 
-static void write_part_table_flag(unsigned char *b)
+static inline void write_part_table_flag(unsigned char *b)
 {
 	b[510] = 0x55;
 	b[511] = 0xaa;
 }
 
 /* A valid partition table sector ends in 0x55 0xaa */
-static unsigned int part_table_flag(unsigned char *b)
+static inline unsigned int part_table_flag(unsigned char *b)
 {
 	return ((unsigned int) b[510]) + (((unsigned int) b[511]) << 8);
 }
 
-static unsigned long long get_partition_start(struct pte *pe)
+static inline unsigned long long get_partition_start(struct pte *pe)
 {
 	return pe->offset + get_start_sect(pe->part_table);
 }
-- 
1.7.7.6



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
