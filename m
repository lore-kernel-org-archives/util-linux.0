Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ww0-f44.google.com ([74.125.82.44]:64935 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751553Ab1KKKMq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 11 Nov 2011 05:12:46 -0500
Received: by mail-ww0-f44.google.com with SMTP id 5so1085409wwe.1
        for <util-linux@vger.kernel.org>; Fri, 11 Nov 2011 02:12:45 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 3/5] fdisk: move command prompt code to a separate function
Date: Fri, 11 Nov 2011 11:12:09 +0100
Message-Id: <1321006331-7633-3-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1321006331-7633-1-git-send-email-cosoleto@gmail.com>
References: <1321006331-7633-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 fdisk/fdisk.c |  244 +++++++++++++++++++++++++++++----------------------------
 1 files changed, 125 insertions(+), 119 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index 7d1bd19..2a0e09c 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -2946,7 +2946,131 @@ unknown_command(int c) {
 	printf(_("%c: unknown command\n"), c);
 }
 
+static void command_prompt(void)
+{
+	int c, j;
+
+	fprintf(stderr, _("Welcome to fdisk (%s).\n\n"
+		"Changes will remain in memory only, until you decide to write them.\n"
+		"Be careful before using the write command.\n"), PACKAGE_STRING);
 
+	if (disklabel == OSF_LABEL) {
+		putchar('\n');
+		/* OSF label, and no DOS label */
+		printf(_("Detected an OSF/1 disklabel on %s, entering "
+			 "disklabel mode.\n"),
+		       disk_device);
+		bsd_command_prompt();
+		/* If we return we may want to make an empty DOS label? */
+		disklabel = DOS_LABEL;
+	}
+
+	while (1) {
+		putchar('\n');
+		c = tolower(read_char(_("Command (m for help): ")));
+		switch (c) {
+		case 'a':
+			if (disklabel == DOS_LABEL)
+				toggle_active(get_partition(1, partitions));
+			else if (disklabel == SUN_LABEL)
+				toggle_sunflags(get_partition(1, partitions),
+						SUN_FLAG_UNMNT);
+			else if (disklabel == SGI_LABEL)
+				sgi_set_bootpartition(
+					get_partition(1, partitions));
+			else
+				unknown_command(c);
+			break;
+		case 'b':
+			if (disklabel == SGI_LABEL) {
+				printf(_("\nThe current boot file is: %s\n"),
+				       sgi_get_bootfile());
+				if (read_chars(_("Please enter the name of the "
+					       "new boot file: ")) == '\n')
+					printf(_("Boot file unchanged\n"));
+				else
+					sgi_set_bootfile(line_ptr);
+			} else
+				bsd_command_prompt();
+			break;
+		case 'c':
+			if (disklabel == DOS_LABEL)
+				toggle_dos_compatibility_flag();
+			else if (disklabel == SUN_LABEL)
+				toggle_sunflags(get_partition(1, partitions),
+						SUN_FLAG_RONLY);
+			else if (disklabel == SGI_LABEL)
+				sgi_set_swappartition(
+						get_partition(1, partitions));
+			else
+				unknown_command(c);
+			break;
+		case 'd':
+			/* If sgi_label then don't use get_existing_partition,
+			   let the user select a partition, since
+			   get_existing_partition() only works for Linux-like
+			   partition tables */
+			if (disklabel != SGI_LABEL) {
+				j = get_existing_partition(1, partitions);
+			} else {
+				j = get_partition(1, partitions);
+			}
+			if (j >= 0)
+				delete_partition(j);
+			break;
+		case 'i':
+			if (disklabel == SGI_LABEL)
+				create_sgiinfo();
+			else
+				unknown_command(c);
+		case 'l':
+			list_types(get_sys_types());
+			break;
+		case 'm':
+			menu();
+			break;
+		case 'n':
+			new_partition();
+			break;
+		case 'o':
+			create_doslabel();
+			break;
+		case 'p':
+			list_table(0);
+			break;
+		case 'q':
+			close(fd);
+			printf("\n");
+			exit(0);
+		case 's':
+			create_sunlabel();
+			break;
+		case 't':
+			change_sysid();
+			break;
+		case 'u':
+			change_units();
+			break;
+		case 'v':
+			verify();
+			break;
+		case 'w':
+			write_table(); 		/* does not return */
+			break;
+		case 'x':
+			if (disklabel == SGI_LABEL) {
+				fprintf(stderr,
+					_("\n\tSorry, no experts menu for SGI "
+					"partition tables available.\n\n"));
+			} else
+				expert_command_prompt();
+			break;
+		default:
+			unknown_command(c);
+			menu();
+		}
+	}
+}
 
 int
 main(int argc, char **argv) {
@@ -3080,125 +3204,7 @@ main(int argc, char **argv) {
 	gpt_warning(disk_device);
 	get_boot(fdisk);
 
-	fprintf(stderr, _("Welcome to fdisk (%s).\n\n"
-		"Changes will remain in memory only, until you decide to write them.\n"
-		"Be careful before using the write command.\n"), PACKAGE_STRING);
+	command_prompt();
 
-	if (disklabel == OSF_LABEL) {
-		putchar('\n');
-		/* OSF label, and no DOS label */
-		printf(_("Detected an OSF/1 disklabel on %s, entering "
-			 "disklabel mode.\n"),
-		       disk_device);
-		bsd_command_prompt();
-		/* If we return we may want to make an empty DOS label? */
-		disklabel = DOS_LABEL;
-	}
-
-	while (1) {
-		putchar('\n');
-		c = tolower(read_char(_("Command (m for help): ")));
-		switch (c) {
-		case 'a':
-			if (disklabel == DOS_LABEL)
-				toggle_active(get_partition(1, partitions));
-			else if (disklabel == SUN_LABEL)
-				toggle_sunflags(get_partition(1, partitions),
-						SUN_FLAG_UNMNT);
-			else if (disklabel == SGI_LABEL)
-				sgi_set_bootpartition(
-					get_partition(1, partitions));
-			else
-				unknown_command(c);
-			break;
-		case 'b':
-			if (disklabel == SGI_LABEL) {
-				printf(_("\nThe current boot file is: %s\n"),
-				       sgi_get_bootfile());
-				if (read_chars(_("Please enter the name of the "
-					       "new boot file: ")) == '\n')
-					printf(_("Boot file unchanged\n"));
-				else
-					sgi_set_bootfile(line_ptr);
-			} else
-				bsd_command_prompt();
-			break;
-		case 'c':
-			if (disklabel == DOS_LABEL)
-				toggle_dos_compatibility_flag();
-			else if (disklabel == SUN_LABEL)
-				toggle_sunflags(get_partition(1, partitions),
-						SUN_FLAG_RONLY);
-			else if (disklabel == SGI_LABEL)
-				sgi_set_swappartition(
-						get_partition(1, partitions));
-			else
-				unknown_command(c);
-			break;
-		case 'd':
-        		/* If sgi_label then don't use get_existing_partition,
-			   let the user select a partition, since
-			   get_existing_partition() only works for Linux-like
-			   partition tables */
-			if (disklabel != SGI_LABEL) {
-                		j = get_existing_partition(1, partitions);
-        		} else {
-                		j = get_partition(1, partitions);
-        		}
-			if (j >= 0)
-				delete_partition(j);
-			break;
-		case 'i':
-			if (disklabel == SGI_LABEL)
-				create_sgiinfo();
-			else
-				unknown_command(c);
-		case 'l':
-			list_types(get_sys_types());
-			break;
-		case 'm':
-			menu();
-			break;
-		case 'n':
-			new_partition();
-			break;
-		case 'o':
-			create_doslabel();
-			break;
-		case 'p':
-			list_table(0);
-			break;
-		case 'q':
-			close(fd);
-			printf("\n");
-			exit(0);
-		case 's':
-			create_sunlabel();
-			break;
-		case 't':
-			change_sysid();
-			break;
-		case 'u':
-			change_units();
-			break;
-		case 'v':
-			verify();
-			break;
-		case 'w':
-			write_table(); 		/* does not return */
-			break;
-		case 'x':
-			if (disklabel == SGI_LABEL) {
-				fprintf(stderr,
-					_("\n\tSorry, no experts menu for SGI "
-					"partition tables available.\n\n"));
-			} else
-				expert_command_prompt();
-			break;
-		default:
-			unknown_command(c);
-			menu();
-		}
-	}
 	return 0;
 }
-- 
1.7.3.4

