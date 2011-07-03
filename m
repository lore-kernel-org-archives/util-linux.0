Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ww0-f44.google.com ([74.125.82.44]:33313 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755273Ab1GCKBw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jul 2011 06:01:52 -0400
Received: by wwe5 with SMTP id 5so4329435wwe.1
        for <util-linux@vger.kernel.org>; Sun, 03 Jul 2011 03:01:50 -0700 (PDT)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH] fdisk: use a single variable for the current disklabel
Date: Sun,  3 Jul 2011 12:01:21 +0200
Message-Id: <1309687281-6403-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Using a variable for each supported partition table type doesn't seem necessary.

This fixes also a minor bug in switching from SGI label to SUN label: the expert
menu isn't available as sgi_label variable remains set to true.

Code a bit more clear as *_label names have similarity with names such as
"sgilabel", "struct sun_label".

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c         |  142 ++++++++++++++++++++++++-------------------------
 fdisk/fdisk.h         |   15 ++++--
 fdisk/fdiskaixlabel.c |    5 +--
 fdisk/fdiskmaclabel.c |    5 +--
 fdisk/fdisksgilabel.c |    6 +--
 fdisk/fdisksunlabel.c |    4 +-
 6 files changed, 85 insertions(+), 92 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index f62fd0f..f6a2bc4 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -235,12 +235,8 @@ unsigned long grain = DEFAULT_SECTOR_SIZE,
 	      alignment_offset;
 int has_topology;
 
-#define dos_label (!sun_label && !sgi_label && !aix_label && !mac_label && !osf_label)
-int	sun_label = 0;			/* looking at sun disklabel */
-int	sgi_label = 0;			/* looking at sgi disklabel */
-int	aix_label = 0;			/* looking at aix disklabel */
-int	osf_label = 0;			/* looking at OSF/1 disklabel */
-int	mac_label = 0;			/* looking at mac disklabel */
+enum labeltype disklabel = DOS_LABEL;	/* Current disklabel */
+
 int	possibly_osf_label = 0;
 
 jmp_buf listingbuf;
@@ -379,7 +375,7 @@ is_dos_partition(int t) {
 
 static void
 menu(void) {
-	if (sun_label) {
+	if (disklabel == SUN_LABEL) {
 	   puts(_("Command action"));
 	   puts(_("   a   toggle a read only flag"));		/* sun */
 	   puts(_("   b   edit bsd disklabel"));
@@ -398,7 +394,7 @@ menu(void) {
 	   puts(_("   w   write table to disk and exit"));
 	   puts(_("   x   extra functionality (experts only)"));
 	}
-	else if (sgi_label) {
+	else if (disklabel == SGI_LABEL) {
 	   puts(_("Command action"));
 	   puts(_("   a   select bootable partition"));    /* sgi flavour */
 	   puts(_("   b   edit bootfile entry"));          /* sgi */
@@ -416,7 +412,7 @@ menu(void) {
 	   puts(_("   v   verify the partition table"));
 	   puts(_("   w   write table to disk and exit"));
 	}
-	else if (aix_label || mac_label) {
+	else if (disklabel == AIX_LABEL || disklabel == MAC_LABEL) {
 	   puts(_("Command action"));
 	   puts(_("   m   print this menu"));
 	   puts(_("   o   create a new empty DOS partition table"));
@@ -446,7 +442,7 @@ menu(void) {
 
 static void
 xmenu(void) {
-	if (sun_label) {
+	if (disklabel == SUN_LABEL) {
 	   puts(_("Command action"));
 	   puts(_("   a   change number of alternate cylinders"));      /*sun*/
 	   puts(_("   c   change number of cylinders"));
@@ -464,7 +460,7 @@ xmenu(void) {
 	   puts(_("   w   write table to disk and exit"));
 	   puts(_("   y   change number of physical cylinders"));	/*sun*/
 	}
-	else if (sgi_label) {
+	else if (disklabel == SGI_LABEL) {
 	   puts(_("Command action"));
 	   puts(_("   b   move beginning of data in a partition")); /* !sun */
 	   puts(_("   c   change number of cylinders"));
@@ -480,7 +476,7 @@ xmenu(void) {
 	   puts(_("   v   verify the partition table"));
 	   puts(_("   w   write table to disk and exit"));
 	}
-	else if (aix_label || mac_label) {
+	else if (disklabel == AIX_LABEL || disklabel == MAC_LABEL) {
 	   puts(_("Command action"));
 	   puts(_("   b   move beginning of data in a partition")); /* !sun */
 	   puts(_("   c   change number of cylinders"));
@@ -519,16 +515,16 @@ xmenu(void) {
 static int
 get_sysid(int i) {
 	return (
-		sun_label ? sun_get_sysid(i) :
-		sgi_label ? sgi_get_sysid(i) :
+		disklabel == SUN_LABEL ? sun_get_sysid(i) :
+		disklabel == SGI_LABEL ? sgi_get_sysid(i) :
 		ptes[i].part_table->sys_ind);
 }
 
 static struct systypes *
 get_sys_types(void) {
 	return (
-		sun_label ? sun_sys_types :
-		sgi_label ? sgi_sys_types :
+		disklabel == SUN_LABEL ? sun_sys_types :
+		disklabel == SGI_LABEL ? sgi_sys_types :
 		i386_sys_types);
 }
 
@@ -729,7 +725,7 @@ warn_geometry(void) {
 	char *m = NULL;
 	int prev = 0;
 
-	if (sgi_label)	/* cannot set cylinders etc anyway */
+	if (disklabel == SGI_LABEL)	/* cannot set cylinders etc anyway */
 		return 0;
 	if (!heads)
 		prev = test_c(&m, _("heads"));
@@ -938,7 +934,8 @@ create_doslabel(void) {
 		id);
 	sun_nolabel();  /* otherwise always recognised as sun */
 	sgi_nolabel();  /* otherwise always recognised as sgi */
-	mac_label = aix_label = osf_label = possibly_osf_label = 0;
+	disklabel = DOS_LABEL;
+	possibly_osf_label = 0;
 	partitions = 4;
 
 	/* Zero out the MBR buffer */
@@ -1233,7 +1230,7 @@ get_boot(enum action what) {
 	if (check_osf_label()) {
 		possibly_osf_label = 1;
 		if (!valid_part_table_flag(MBRbuffer)) {
-			osf_label = 1;
+			disklabel = OSF_LABEL;
 			return 0;
 		}
 		printf(_("This disk has both DOS and BSD magic.\n"
@@ -1543,11 +1540,11 @@ get_partition_dflt(int warn, int max, int dflt) {
 	pe = &ptes[i];
 
 	if (warn) {
-		if ((!sun_label && !sgi_label && !pe->part_table->sys_ind)
-		    || (sun_label &&
+		if ((disklabel != SUN_LABEL && disklabel != SGI_LABEL && !pe->part_table->sys_ind)
+		    || (disklabel == SUN_LABEL &&
 			(!sunlabel->partitions[i].num_sectors ||
 			 !sunlabel->part_tags[i].tag))
-		    || (sgi_label && (!sgi_get_num_sectors(i)))
+		    || (disklabel == SGI_LABEL && (!sgi_get_num_sectors(i)))
 		   )
 			fprintf(stderr,
 				_("Warning: partition %d has empty type\n"),
@@ -1576,6 +1573,7 @@ get_existing_partition(int warn, int max) {
 			pno = i;
 		}
 	}
+
 	if (pno >= 0) {
 		printf(_("Selected partition %d\n"), pno+1);
 		return pno;
@@ -1673,12 +1671,12 @@ delete_partition(int i) {
 		return;		/* C/H/S not set */
 	pe->changed = 1;
 
-	if (sun_label) {
+	if (disklabel == SUN_LABEL) {
 		sun_delete_partition(i);
 		return;
 	}
 
-	if (sgi_label) {
+	if (disklabel == SGI_LABEL) {
 		sgi_delete_partition(i);
 		return;
 	}
@@ -1741,7 +1739,7 @@ change_sysid(void) {
 	/* If sgi_label then don't use get_existing_partition,
 	   let the user select a partition, since get_existing_partition()
 	   only works for Linux like partition tables. */
-	if (!sgi_label) {
+	if (disklabel != SGI_LABEL) {
 		i = get_existing_partition(0, partitions);
 	} else {
 		i = get_partition(0, partitions);
@@ -1754,12 +1752,12 @@ change_sysid(void) {
 
 	/* if changing types T to 0 is allowed, then
 	   the reverse change must be allowed, too */
-	if (!sys && !sgi_label && !sun_label && !get_nr_sects(p))
+	if (!sys && disklabel != SGI_LABEL && disklabel != SUN_LABEL && !get_nr_sects(p))
                 printf(_("Partition %d does not exist yet!\n"), i + 1);
         else while (1) {
 		sys = read_hex (get_sys_types());
 
-		if (!sys && !sgi_label && !sun_label) {
+		if (!sys && disklabel != SGI_LABEL && disklabel != SUN_LABEL) {
 			printf(_("Type 0 means free space to many systems\n"
 			       "(but not to Linux). Having partitions of\n"
 			       "type 0 is probably unwise. You can delete\n"
@@ -1767,7 +1765,7 @@ change_sysid(void) {
 			/* break; */
 		}
 
-		if (!sun_label && !sgi_label) {
+		if (disklabel != SGI_LABEL && disklabel != SUN_LABEL) {
 			if (IS_EXTENDED (sys) != IS_EXTENDED (p->sys_ind)) {
 				printf(_("You cannot change a partition into"
 				       " an extended one or vice versa\n"
@@ -1777,12 +1775,12 @@ change_sysid(void) {
 		}
 
                 if (sys < 256) {
-			if (sun_label && i == 2 && sys != SUN_TAG_BACKUP)
+			if (disklabel == SUN_LABEL && i == 2 && sys != SUN_TAG_BACKUP)
 				printf(_("Consider leaving partition 3 "
 				       "as Whole disk (5),\n"
 				       "as SunOS/Solaris expects it and "
 				       "even Linux likes it.\n\n"));
-			if (sgi_label && ((i == 10 && sys != ENTIRE_DISK)
+			if (disklabel == SGI_LABEL && ((i == 10 && sys != ENTIRE_DISK)
 					  || (i == 8 && sys != 0)))
 				printf(_("Consider leaving partition 9 "
 				       "as volume header (0),\nand "
@@ -1790,10 +1788,10 @@ change_sysid(void) {
 				       "as IRIX expects it.\n\n"));
                         if (sys == origsys)
 				break;
-			if (sun_label) {
+			if (disklabel == SUN_LABEL) {
 				ptes[i].changed = sun_change_sysid(i, sys);
 			} else
-			if (sgi_label) {
+			if (disklabel == SGI_LABEL) {
 				ptes[i].changed = sgi_change_sysid(i, sys);
 			} else {
 				p->sys_ind = sys;
@@ -1931,7 +1929,7 @@ list_disk_geometry(void) {
 				min_io_size, io_size);
 	if (alignment_offset)
 		printf(_("Alignment offset: %lu bytes\n"), alignment_offset);
-	if (dos_label)
+	if (disklabel == DOS_LABEL)
 		dos_print_mbr_id();
 	printf("\n");
 }
@@ -2077,19 +2075,19 @@ list_table(int xtra) {
 	char *type;
 	int i, w;
 
-	if (sun_label) {
+	if (disklabel == SUN_LABEL) {
 		sun_list_table(xtra);
 		return;
 	}
 
-	if (sgi_label) {
+	if (disklabel == SGI_LABEL) {
 		sgi_list_table(xtra);
 		return;
 	}
 
 	list_disk_geometry();
 
-	if (osf_label) {
+	if (disklabel == OSF_LABEL) {
 		xbsd_print_disklabel(xtra);
 		return;
 	}
@@ -2146,7 +2144,7 @@ list_table(int xtra) {
 	/* Is partition table in disk order? It need not be, but... */
 	/* partition table entries are not checked for correct order if this
 	   is a sgi, sun or aix labeled disk... */
-	if (dos_label && wrong_p_order(NULL)) {
+	if (disklabel == DOS_LABEL && wrong_p_order(NULL)) {
 		printf(_("\nPartition table entries are not in disk order\n"));
 	}
 }
@@ -2235,12 +2233,12 @@ verify(void) {
 	if (warn_geometry())
 		return;
 
-	if (sun_label) {
+	if (disklabel == SUN_LABEL) {
 		verify_sun();
 		return;
 	}
 
-	if (sgi_label) {
+	if (disklabel == SGI_LABEL) {
 		verify_sgi(1);
 		return;
 	}
@@ -2489,17 +2487,17 @@ new_partition(void) {
 	if (warn_geometry())
 		return;
 
-	if (sun_label) {
+	if (disklabel == SUN_LABEL) {
 		add_sun_partition(get_partition(0, partitions), LINUX_NATIVE);
 		return;
 	}
 
-	if (sgi_label) {
+	if (disklabel == SGI_LABEL) {
 		sgi_add_partition(get_partition(0, partitions), LINUX_NATIVE);
 		return;
 	}
 
-	if (aix_label) {
+	if (disklabel == AIX_LABEL) {
 		printf(_("\tSorry - this fdisk cannot handle AIX disk labels."
 			 "\n\tIf you want to add DOS-type partitions, create"
 			 "\n\ta new empty DOS partition table first. (Use o.)"
@@ -2508,7 +2506,7 @@ new_partition(void) {
 		return;
 	}
 
-	if (mac_label) {
+	if (disklabel == MAC_LABEL) {
 		printf(_("\tSorry - this fdisk cannot handle Mac disk labels."
 		         "\n\tIf you want to add DOS-type partitions, create"
 		         "\n\ta new empty DOS partition table first. (Use o.)"
@@ -2576,7 +2574,7 @@ static void
 write_table(void) {
 	int i;
 
-	if (dos_label) {
+	if (disklabel == DOS_LABEL) {
 		/* MBR (primary partitions) */
 		if (!MBRbuffer_changed) {
 			for (i = 0; i < 4; i++)
@@ -2597,10 +2595,10 @@ write_table(void) {
 			}
 		}
 	}
-	else if (sgi_label) {
+	else if (disklabel == SGI_LABEL) {
 		/* no test on change? the printf below might be mistaken */
 		sgi_write_table();
-	} else if (sun_label) {
+	} else if (disklabel == SUN_LABEL) {
 		int needw = 0;
 
 		for (i=0; i<8; i++)
@@ -2681,7 +2679,7 @@ print_raw(void) {
 	int i;
 
 	printf(_("Device: %s\n"), disk_device);
-	if (sun_label || sgi_label)
+	if (disklabel == SUN_LABEL || disklabel == SGI_LABEL)
 		print_buffer(MBRbuffer);
 	else for (i = 3; i < partitions; i++)
 		print_buffer(ptes[i].sectorbuffer);
@@ -2745,34 +2743,34 @@ xselect(void) {
 		c = tolower(read_char(_("Expert command (m for help): ")));
 		switch (c) {
 		case 'a':
-			if (sun_label)
+			if (disklabel == SUN_LABEL)
 				sun_set_alt_cyl();
 			break;
 		case 'b':
-			if (dos_label)
+			if (disklabel == DOS_LABEL)
 				move_begin(get_partition(0, partitions));
 			break;
 		case 'c':
 			user_cylinders = cylinders =
 				read_int(1, cylinders, 1048576, 0,
 					 _("Number of cylinders"));
-			if (sun_label)
+			if (disklabel == SUN_LABEL)
 				sun_set_ncyl(cylinders);
 			break;
 		case 'd':
 			print_raw();
 			break;
 		case 'e':
-			if (sgi_label)
+			if (disklabel == SGI_LABEL)
 				sgi_set_xcyl();
-			else if (sun_label)
+			else if (disklabel == SUN_LABEL)
 				sun_set_xcyl();
 			else
-			if (dos_label)
+			if (disklabel == DOS_LABEL)
 				x_list_table(1);
 			break;
 		case 'f':
-			if (dos_label)
+			if (disklabel == DOS_LABEL)
 				fix_partition_table_order();
 			break;
 		case 'g':
@@ -2784,17 +2782,17 @@ xselect(void) {
 			update_units();
 			break;
 		case 'i':
-			if (sun_label)
+			if (disklabel == SUN_LABEL)
 				sun_set_ilfact();
-			if (dos_label)
+			else if (disklabel == DOS_LABEL)
 				dos_set_mbr_id();
 			break;
 		case 'o':
-			if (sun_label)
+			if (disklabel == SUN_LABEL)
 				sun_set_rspeed();
 			break;
 		case 'p':
-			if (sun_label)
+			if (disklabel == SUN_LABEL)
 				list_table(1);
 			else
 				x_list_table(0);
@@ -2822,7 +2820,7 @@ xselect(void) {
 			write_table(); 	/* does not return */
 			break;
 		case 'y':
-			if (sun_label)
+			if (disklabel == SUN_LABEL)
 				sun_set_pcylcount();
 			break;
 		default:
@@ -2888,7 +2886,7 @@ try(char *device, int user_specified) {
 		if (gb > 0) { /* I/O error */
 		} else if (gb < 0) { /* no DOS signature */
 			list_disk_geometry();
-			if (!aix_label && !mac_label && btrydev(device) < 0)
+			if (disklabel != AIX_LABEL && disklabel != MAC_LABEL && btrydev(device) < 0)
 				fprintf(stderr,
 					_("Disk %s doesn't contain a valid "
 					  "partition table\n"), device);
@@ -3082,14 +3080,14 @@ main(int argc, char **argv) {
 	gpt_warning(disk_device);
 	get_boot(fdisk);
 
-	if (osf_label) {
+	if (disklabel == OSF_LABEL) {
 		/* OSF label, and no DOS label */
 		printf(_("Detected an OSF/1 disklabel on %s, entering "
 			 "disklabel mode.\n"),
 		       disk_device);
 		bselect();
-		osf_label = 0;
 		/* If we return we may want to make an empty DOS label? */
+		disklabel = DOS_LABEL;
 	}
 
 	while (1) {
@@ -3097,19 +3095,19 @@ main(int argc, char **argv) {
 		c = tolower(read_char(_("Command (m for help): ")));
 		switch (c) {
 		case 'a':
-			if (dos_label)
+			if (disklabel == DOS_LABEL)
 				toggle_active(get_partition(1, partitions));
-			else if (sun_label)
+			else if (disklabel == SUN_LABEL)
 				toggle_sunflags(get_partition(1, partitions),
 						SUN_FLAG_UNMNT);
-			else if (sgi_label)
+			else if (disklabel == SGI_LABEL)
 				sgi_set_bootpartition(
 					get_partition(1, partitions));
 			else
 				unknown_command(c);
 			break;
 		case 'b':
-			if (sgi_label) {
+			if (disklabel == SGI_LABEL) {
 				printf(_("\nThe current boot file is: %s\n"),
 				       sgi_get_bootfile());
 				if (read_chars(_("Please enter the name of the "
@@ -3121,12 +3119,12 @@ main(int argc, char **argv) {
 				bselect();
 			break;
 		case 'c':
-			if (dos_label)
+			if (disklabel == DOS_LABEL)
 				toggle_dos_compatibility_flag();
-			else if (sun_label)
+			else if (disklabel == SUN_LABEL)
 				toggle_sunflags(get_partition(1, partitions),
 						SUN_FLAG_RONLY);
-			else if (sgi_label)
+			else if (disklabel == SGI_LABEL)
 				sgi_set_swappartition(
 						get_partition(1, partitions));
 			else
@@ -3137,7 +3135,7 @@ main(int argc, char **argv) {
 			   let the user select a partition, since
 			   get_existing_partition() only works for Linux-like
 			   partition tables */
-        		if (!sgi_label) {
+			if (disklabel != SGI_LABEL) {
                 		j = get_existing_partition(1, partitions);
         		} else {
                 		j = get_partition(1, partitions);
@@ -3146,7 +3144,7 @@ main(int argc, char **argv) {
 				delete_partition(j);
 			break;
 		case 'i':
-			if (sgi_label)
+			if (disklabel == SGI_LABEL)
 				create_sgiinfo();
 			else
 				unknown_command(c);
@@ -3185,7 +3183,7 @@ main(int argc, char **argv) {
 			write_table(); 		/* does not return */
 			break;
 		case 'x':
-			if (sgi_label) {
+			if (disklabel == SGI_LABEL) {
 				fprintf(stderr,
 					_("\n\tSorry, no experts menu for SGI "
 					"partition tables available.\n\n"));
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index 302a7a7..9b7f4c7 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -94,11 +94,16 @@ extern const char * str_units(int);
 extern unsigned long long get_start_sect(struct partition *p);
 extern unsigned long long get_nr_sects(struct partition *p);
 
-extern int osf_label;
-extern int sun_label;
-extern int sgi_label;
-extern int aix_label;
-extern int mac_label;
+enum labeltype {
+	DOS_LABEL,
+	SUN_LABEL,
+	SGI_LABEL,
+	AIX_LABEL,
+	OSF_LABEL,
+	MAC_LABEL
+};
+
+extern enum labeltype disklabel;
 
 /* prototypes for fdiskbsdlabel.c */
 extern void bselect(void);
diff --git a/fdisk/fdiskaixlabel.c b/fdisk/fdiskaixlabel.c
index e7ee95d..9fde61f 100644
--- a/fdisk/fdiskaixlabel.c
+++ b/fdisk/fdiskaixlabel.c
@@ -42,7 +42,6 @@ void
 aix_nolabel( void )
 {
     aixlabel->magic = 0;
-    aix_label = 0;
     partitions = 4;
     zeroize_mbr_buffer();
     return;
@@ -53,17 +52,15 @@ check_aix_label( void )
 {
     if (aixlabel->magic != AIX_LABEL_MAGIC &&
 	aixlabel->magic != AIX_LABEL_MAGIC_SWAPPED) {
-	aix_label = 0;
 	other_endian = 0;
 	return 0;
     }
     other_endian = (aixlabel->magic == AIX_LABEL_MAGIC_SWAPPED);
     update_units();
-    aix_label = 1;
+    disklabel = AIX_LABEL;
     partitions= 1016;
     volumes = 15;
     aix_info();
     aix_nolabel();		/* %% */
-    aix_label = 1;		/* %% */
     return 1;
 }
diff --git a/fdisk/fdiskmaclabel.c b/fdisk/fdiskmaclabel.c
index 4e3db20..e82347d 100644
--- a/fdisk/fdiskmaclabel.c
+++ b/fdisk/fdiskmaclabel.c
@@ -42,7 +42,6 @@ void
 mac_nolabel( void )
 {
     maclabel->magic = 0;
-    mac_label = 0;
     partitions = 4;
     zeroize_mbr_buffer();
     return;
@@ -65,7 +64,6 @@ check_mac_label( void )
 			goto IS_MAC;
 			break;
 		default:
-			mac_label = 0;
 			other_endian = 0;
 			return 0;
 
@@ -75,12 +73,11 @@ check_mac_label( void )
 IS_MAC:
     other_endian = (maclabel->magic == MAC_LABEL_MAGIC_SWAPPED); // =?
     update_units();
-    mac_label = 1;
+    disklabel = MAC_LABEL;
     partitions= 1016; // =?
     volumes = 15;	// =?
     mac_info();
     mac_nolabel();		/* %% */
-    mac_label = 1;		/* %% */
     return 1;
 }
 
diff --git a/fdisk/fdisksgilabel.c b/fdisk/fdisksgilabel.c
index b5cbadb..cb00e76 100644
--- a/fdisk/fdisksgilabel.c
+++ b/fdisk/fdisksgilabel.c
@@ -132,7 +132,6 @@ sgi_get_pcylcount(void) {
 void
 sgi_nolabel() {
 	sgilabel->magic = 0;
-	sgi_label = 0;
 	partitions = 4;
 }
 
@@ -158,7 +157,6 @@ check_sgi_label() {
 
 	if (sgilabel->magic != SGI_LABEL_MAGIC &&
 	    sgilabel->magic != SGI_LABEL_MAGIC_SWAPPED) {
-		sgi_label = 0;
 		other_endian = 0;
 		return 0;
 	}
@@ -173,7 +171,7 @@ check_sgi_label() {
 			_("Detected sgi disklabel with wrong checksum.\n"));
 	}
 	update_units();
-	sgi_label = 1;
+	disklabel = SGI_LABEL;
 	partitions= 16;
 	volumes = 15;
 	return 1;
@@ -780,7 +778,7 @@ create_sgilabel(void)
 	sgilabel->devparam.xylogics_writecont	= SSWAP16(0);
 	memset(&(sgilabel->directory), 0, sizeof(struct volume_directory)*15);
 	memset(&(sgilabel->partitions), 0, sizeof(struct sgi_partition)*16);
-	sgi_label  =  1;
+	disklabel  = SGI_LABEL;
 	partitions = 16;
 	volumes    = 15;
 	sgi_set_entire();
diff --git a/fdisk/fdisksunlabel.c b/fdisk/fdisksunlabel.c
index 68596ee..e43d168 100644
--- a/fdisk/fdisksunlabel.c
+++ b/fdisk/fdisksunlabel.c
@@ -110,7 +110,6 @@ static void set_sun_partition(int i, uint32_t start, uint32_t stop, uint16_t sys
 
 void sun_nolabel(void)
 {
-	sun_label = 0;
 	sunlabel->magic = 0;
 	partitions = 4;
 }
@@ -122,7 +121,6 @@ int check_sun_label(void)
 
 	if (sunlabel->magic != SUN_LABEL_MAGIC &&
 	    sunlabel->magic != SUN_LABEL_MAGIC_SWAPPED) {
-		sun_label = 0;
 		other_endian = 0;
 		return 0;
 	}
@@ -177,7 +175,7 @@ int check_sun_label(void)
 		}
 	}
 	update_units();
-	sun_label = 1;
+	disklabel = SUN_LABEL;
 	partitions = SUN_NUM_PARTITIONS;
 	return 1;
 }
-- 
1.7.3.4

