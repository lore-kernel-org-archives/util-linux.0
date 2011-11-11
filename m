Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ww0-f42.google.com ([74.125.82.42]:59039 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab1KKKMs (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 11 Nov 2011 05:12:48 -0500
Received: by wwi18 with SMTP id 18so1958030wwi.1
        for <util-linux@vger.kernel.org>; Fri, 11 Nov 2011 02:12:46 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 4/5] fdisk: rewrite print menu system
Date: Fri, 11 Nov 2011 11:12:10 +0100
Message-Id: <1321006331-7633-4-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1321006331-7633-1-git-send-email-cosoleto@gmail.com>
References: <1321006331-7633-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

DOS and SGI label menus are unchanged, SUN label menu is only an
alphabetic order fix. BSD label command descriptions changed slightly
to use a common form.

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c         |  205 ++++++++++++++++---------------------------------
 fdisk/fdisk.h         |   20 ++++--
 fdisk/fdiskbsdlabel.c |   23 +-----
 3 files changed, 81 insertions(+), 167 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 2a0e09c..934d458 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -77,6 +77,60 @@ static void delete_partition(int i);
 				s |= (sector >> 2) & 0xc0;	\
 			}
 
+/* menu list description */
+
+struct menulist_descr {
+	char command;				/* command key */
+	char *description;			/* command description */
+	enum labeltype label[2];		/* disklabel types associated with main and expert menu */
+};
+
+static const struct menulist_descr menulist[] = {
+	{'a', N_("toggle a bootable flag"), {DOS_LABEL, 0}},
+	{'a', N_("toggle a read only flag"), {SUN_LABEL, 0}},
+	{'a', N_("select bootable partition"), {SGI_LABEL, 0}},
+	{'a', N_("change number of alternate cylinders"), {0, SUN_LABEL}},
+	{'b', N_("edit bsd disklabel"), {DOS_LABEL | SUN_LABEL, 0}},
+	{'b', N_("edit bootfile entry"), {SGI_LABEL, 0}},
+	{'b', N_("move beginning of data in a partition"), {0, DOS_LABEL}},
+	{'c', N_("toggle the dos compatibility flag"), {DOS_LABEL, 0}},
+	{'c', N_("toggle the mountable flag"), {SUN_LABEL, 0}},
+	{'c', N_("select sgi swap partition"), {SGI_LABEL, 0}},
+	{'c', N_("change number of cylinders"), {0, DOS_LABEL | SUN_LABEL}},
+	{'d', N_("delete a partition"), {DOS_LABEL | SUN_LABEL | SGI_LABEL | OSF_LABEL, 0}},
+	{'d', N_("print the raw data in the partition table"), {0, ANY_LABEL}},
+	{'e', N_("change number of extra sectors per cylinder"), {0, SUN_LABEL}},
+	{'e', N_("list extended partitions"), {0, DOS_LABEL}},
+	{'e', N_("edit drive data"), {OSF_LABEL, 0}},
+	{'f', N_("fix partition order"), {0, DOS_LABEL}},
+	{'g', N_("create an IRIX (SGI) partition table"), {0, DOS_LABEL | SGI_LABEL}},
+	{'h', N_("change number of heads"), {0, DOS_LABEL | SUN_LABEL}},
+	{'i', N_("change interleave factor"), {0, SUN_LABEL}},
+	{'i', N_("change the disk identifier"), {0, DOS_LABEL}},
+	{'i', N_("install bootstrap"), {OSF_LABEL, 0}},
+	{'l', N_("list known partition types"), {DOS_LABEL | SUN_LABEL | SGI_LABEL | OSF_LABEL, 0}},
+	{'m', N_("print this menu"), {ANY_LABEL, ANY_LABEL}},
+	{'n', N_("add a new partition"), {DOS_LABEL | SUN_LABEL | SGI_LABEL | OSF_LABEL, 0}},
+	{'o', N_("create a new empty DOS partition table"), {~OSF_LABEL, 0}},
+	{'o', N_("change rotation speed (rpm)"), {0, SUN_LABEL}},
+	{'p', N_("print the partition table"), {DOS_LABEL | SUN_LABEL | SGI_LABEL | OSF_LABEL, DOS_LABEL | SUN_LABEL}},
+	{'q', N_("quit without saving changes"), {ANY_LABEL, ANY_LABEL}},
+	{'r', N_("return to main menu"), {OSF_LABEL, DOS_LABEL | SUN_LABEL | SGI_LABEL | OSF_LABEL}},
+	{'s', N_("create a new empty Sun disklabel"), {~OSF_LABEL, 0}},
+	{'s', N_("change number of sectors/track"), {0, DOS_LABEL | SUN_LABEL}},
+	{'s', N_("show complete disklabel"), {OSF_LABEL, 0}},
+	{'t', N_("change a partition's system id"), {DOS_LABEL | SUN_LABEL | SGI_LABEL | OSF_LABEL, 0}},
+	{'u', N_("change display/entry units"), {DOS_LABEL | SUN_LABEL | SGI_LABEL | OSF_LABEL, 0}},
+	{'v', N_("verify the partition table"), {DOS_LABEL | SUN_LABEL | SGI_LABEL, DOS_LABEL | SUN_LABEL | SGI_LABEL}},
+	{'w', N_("write table to disk and exit"), {DOS_LABEL | SUN_LABEL | SGI_LABEL, DOS_LABEL | SUN_LABEL | SGI_LABEL}},
+	{'w', N_("write disklabel to disk"), {OSF_LABEL, 0}},
+	{'x', N_("extra functionality (experts only)"), {DOS_LABEL | SUN_LABEL, 0}},
+#if !defined (__alpha__)
+	{'x', N_("link BSD partition to non-BSD partition"), {OSF_LABEL, 0}},
+#endif
+	{'y', N_("change number of physical cylinders"), {0, SUN_LABEL}},
+};
+
 /* A valid partition table sector ends in 0x55 0xaa */
 static unsigned int
 part_table_flag(unsigned char *b) {
@@ -374,143 +428,16 @@ is_dos_partition(int t) {
 		t == 0xc1 || t == 0xc4 || t == 0xc6);
 }
 
-static void
-menu(void) {
-	if (disklabel == SUN_LABEL) {
-	   puts(_("Command action"));
-	   puts(_("   a   toggle a read only flag"));		/* sun */
-	   puts(_("   b   edit bsd disklabel"));
-	   puts(_("   c   toggle the mountable flag"));		/* sun */
-	   puts(_("   d   delete a partition"));
-	   puts(_("   l   list known partition types"));
-	   puts(_("   m   print this menu"));
-	   puts(_("   n   add a new partition"));
-	   puts(_("   o   create a new empty DOS partition table"));
-	   puts(_("   p   print the partition table"));
-	   puts(_("   q   quit without saving changes"));
-	   puts(_("   s   create a new empty Sun disklabel"));	/* sun */
-	   puts(_("   t   change a partition's system id"));
-	   puts(_("   u   change display/entry units"));
-	   puts(_("   v   verify the partition table"));
-	   puts(_("   w   write table to disk and exit"));
-	   puts(_("   x   extra functionality (experts only)"));
-	}
-	else if (disklabel == SGI_LABEL) {
-	   puts(_("Command action"));
-	   puts(_("   a   select bootable partition"));    /* sgi flavour */
-	   puts(_("   b   edit bootfile entry"));          /* sgi */
-	   puts(_("   c   select sgi swap partition"));    /* sgi flavour */
-	   puts(_("   d   delete a partition"));
-	   puts(_("   l   list known partition types"));
-	   puts(_("   m   print this menu"));
-	   puts(_("   n   add a new partition"));
-	   puts(_("   o   create a new empty DOS partition table"));
-	   puts(_("   p   print the partition table"));
-	   puts(_("   q   quit without saving changes"));
-	   puts(_("   s   create a new empty Sun disklabel"));	/* sun */
-	   puts(_("   t   change a partition's system id"));
-	   puts(_("   u   change display/entry units"));
-	   puts(_("   v   verify the partition table"));
-	   puts(_("   w   write table to disk and exit"));
-	}
-	else if (disklabel == AIX_LABEL || disklabel == MAC_LABEL) {
-	   puts(_("Command action"));
-	   puts(_("   m   print this menu"));
-	   puts(_("   o   create a new empty DOS partition table"));
-	   puts(_("   q   quit without saving changes"));
-	   puts(_("   s   create a new empty Sun disklabel"));	/* sun */
-	}
-	else {
-	   puts(_("Command action"));
-	   puts(_("   a   toggle a bootable flag"));
-	   puts(_("   b   edit bsd disklabel"));
-	   puts(_("   c   toggle the dos compatibility flag"));
-	   puts(_("   d   delete a partition"));
-	   puts(_("   l   list known partition types"));
-	   puts(_("   m   print this menu"));
-	   puts(_("   n   add a new partition"));
-	   puts(_("   o   create a new empty DOS partition table"));
-	   puts(_("   p   print the partition table"));
-	   puts(_("   q   quit without saving changes"));
-	   puts(_("   s   create a new empty Sun disklabel"));	/* sun */
-	   puts(_("   t   change a partition's system id"));
-	   puts(_("   u   change display/entry units"));
-	   puts(_("   v   verify the partition table"));
-	   puts(_("   w   write table to disk and exit"));
-	   puts(_("   x   extra functionality (experts only)"));
-	}
-}
+void print_menu(enum menutype menu)
+{
+	size_t i;
 
-static void
-xmenu(void) {
-	if (disklabel == SUN_LABEL) {
-	   puts(_("Command action"));
-	   puts(_("   a   change number of alternate cylinders"));      /*sun*/
-	   puts(_("   c   change number of cylinders"));
-	   puts(_("   d   print the raw data in the partition table"));
-	   puts(_("   e   change number of extra sectors per cylinder"));/*sun*/
-	   puts(_("   h   change number of heads"));
-	   puts(_("   i   change interleave factor"));			/*sun*/
-	   puts(_("   o   change rotation speed (rpm)"));		/*sun*/
-	   puts(_("   m   print this menu"));
-	   puts(_("   p   print the partition table"));
-	   puts(_("   q   quit without saving changes"));
-	   puts(_("   r   return to main menu"));
-	   puts(_("   s   change number of sectors/track"));
-	   puts(_("   v   verify the partition table"));
-	   puts(_("   w   write table to disk and exit"));
-	   puts(_("   y   change number of physical cylinders"));	/*sun*/
-	}
-	else if (disklabel == SGI_LABEL) {
-	   puts(_("Command action"));
-	   puts(_("   b   move beginning of data in a partition")); /* !sun */
-	   puts(_("   c   change number of cylinders"));
-	   puts(_("   d   print the raw data in the partition table"));
-	   puts(_("   e   list extended partitions"));		/* !sun */
-	   puts(_("   g   create an IRIX (SGI) partition table"));/* sgi */
-	   puts(_("   h   change number of heads"));
-	   puts(_("   m   print this menu"));
-	   puts(_("   p   print the partition table"));
-	   puts(_("   q   quit without saving changes"));
-	   puts(_("   r   return to main menu"));
-	   puts(_("   s   change number of sectors/track"));
-	   puts(_("   v   verify the partition table"));
-	   puts(_("   w   write table to disk and exit"));
-	}
-	else if (disklabel == AIX_LABEL || disklabel == MAC_LABEL) {
-	   puts(_("Command action"));
-	   puts(_("   b   move beginning of data in a partition")); /* !sun */
-	   puts(_("   c   change number of cylinders"));
-	   puts(_("   d   print the raw data in the partition table"));
-	   puts(_("   e   list extended partitions"));		/* !sun */
-	   puts(_("   g   create an IRIX (SGI) partition table"));/* sgi */
-	   puts(_("   h   change number of heads"));
-	   puts(_("   m   print this menu"));
-	   puts(_("   p   print the partition table"));
-	   puts(_("   q   quit without saving changes"));
-	   puts(_("   r   return to main menu"));
-	   puts(_("   s   change number of sectors/track"));
-	   puts(_("   v   verify the partition table"));
-	   puts(_("   w   write table to disk and exit"));
-	}
-	else {
-	   puts(_("Command action"));
-	   puts(_("   b   move beginning of data in a partition")); /* !sun */
-	   puts(_("   c   change number of cylinders"));
-	   puts(_("   d   print the raw data in the partition table"));
-	   puts(_("   e   list extended partitions"));		/* !sun */
-	   puts(_("   f   fix partition order"));		/* !sun, !aix, !sgi */
-	   puts(_("   g   create an IRIX (SGI) partition table"));/* sgi */
-	   puts(_("   h   change number of heads"));
-	   puts(_("   i   change the disk identifier")); /* dos only */
-	   puts(_("   m   print this menu"));
-	   puts(_("   p   print the partition table"));
-	   puts(_("   q   quit without saving changes"));
-	   puts(_("   r   return to main menu"));
-	   puts(_("   s   change number of sectors/track"));
-	   puts(_("   v   verify the partition table"));
-	   puts(_("   w   write table to disk and exit"));
-	}
+	puts(_("Command action"));
+
+	for (i = 0; i < ARRAY_SIZE(menulist); i++)
+		if ((menu != BSD_MENU && menulist[i].label[menu] & disklabel)
+		    || (menu == BSD_MENU && menulist[i].label[MAIN_MENU] & OSF_LABEL))
+			printf("   %c   %s\n", menulist[i].command, menulist[i].description);
 }
 
 static int
@@ -2825,7 +2752,7 @@ expert_command_prompt(void)
 				sun_set_pcylcount();
 			break;
 		default:
-			xmenu();
+			print_menu(EXPERT_MENU);
 		}
 	}
 }
@@ -3027,7 +2954,7 @@ static void command_prompt(void)
 			list_types(get_sys_types());
 			break;
 		case 'm':
-			menu();
+			print_menu(MAIN_MENU);
 			break;
 		case 'n':
 			new_partition();
@@ -3067,7 +2994,7 @@ static void command_prompt(void)
 			break;
 		default:
 			unknown_command(c);
-			menu();
+			print_menu(MAIN_MENU);
 		}
 	}
 }
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index 0bc1289..2d80096 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -45,6 +45,12 @@ struct partition {
 	unsigned char size4[4];         /* nr of sectors in partition */
 } PACKED;
 
+enum menutype {
+	MAIN_MENU,
+	EXPERT_MENU,
+	BSD_MENU
+};
+
 enum failure {ioctl_error,
 	unable_to_open, unable_to_read, unable_to_seek,
 	unable_to_write};
@@ -75,6 +81,7 @@ extern struct partition *get_part_table(int);
 extern int valid_part_table_flag(unsigned char *b);
 extern unsigned int read_int(unsigned int low, unsigned int dflt,
 			     unsigned int high, unsigned int base, char *mesg);
+extern void print_menu(enum menutype);
 extern void print_partition_size(int num, unsigned long long start, unsigned long long stop, int sysid);
 
 extern unsigned char *MBRbuffer;
@@ -96,12 +103,13 @@ extern unsigned long long get_start_sect(struct partition *p);
 extern unsigned long long get_nr_sects(struct partition *p);
 
 enum labeltype {
-	DOS_LABEL,
-	SUN_LABEL,
-	SGI_LABEL,
-	AIX_LABEL,
-	OSF_LABEL,
-	MAC_LABEL
+	DOS_LABEL = 1,
+	SUN_LABEL = 2,
+	SGI_LABEL = 4,
+	AIX_LABEL = 8,
+	OSF_LABEL = 16,
+	MAC_LABEL = 32,
+	ANY_LABEL = -1
 };
 
 extern enum labeltype disklabel;
diff --git a/fdisk/fdiskbsdlabel.c b/fdisk/fdiskbsdlabel.c
index 68d481c..1bebca2 100644
--- a/fdisk/fdiskbsdlabel.c
+++ b/fdisk/fdiskbsdlabel.c
@@ -123,27 +123,6 @@ btrydev (char * dev) {
 	return 0;
 }
 
-static void
-bmenu (void) {
-  puts (_("Command action"));
-  puts (_("   d   delete a BSD partition"));
-  puts (_("   e   edit drive data"));
-  puts (_("   i   install bootstrap"));
-  puts (_("   l   list known filesystem types"));
-  puts (_("   m   print this menu"));
-  puts (_("   n   add a new BSD partition"));
-  puts (_("   p   print BSD partition table"));
-  puts (_("   q   quit without saving changes"));
-  puts (_("   r   return to main menu"));
-  puts (_("   s   show complete disklabel"));
-  puts (_("   t   change a partition's filesystem id"));
-  puts (_("   u   change units (cylinders/sectors)"));
-  puts (_("   w   write disklabel to disk"));
-#if !defined (__alpha__)
-  puts (_("   x   link BSD partition to non-BSD partition"));
-#endif
-}
-
 #if !defined (__alpha__)
 static int
 hidden(int type) {
@@ -243,7 +222,7 @@ bsd_command_prompt (void)
 	break;
 #endif
       default:
-	bmenu ();
+	print_menu(BSD_MENU);
 	break;
     }
   }
-- 
1.7.3.4

