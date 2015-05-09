Return-Path: util-linux-owner@vger.kernel.org
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:47053 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbbEIVPa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 9 May 2015 17:15:30 -0400
Date: Sat, 9 May 2015 23:15:23 +0200
From: "Jean-Loup 'clippix' Bogalho" <clippix@lse.epita.fr>
To: util-linux@vger.kernel.org
Cc: bensberg@justemail.net, kzak@redhat.com
Subject: [PATCH v3] fdisk: add the 'i'nfo command
Message-ID: <20150509211523.GA5207@clippix.lab.lse.epita.fr>
Reply-To: jean-loup.bogalho@clippix.eu
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add the 'i'nfo command to fdisk that prints details about a specific partition.
Details are everything the function 'fdisk_label_get_field' can return.

Signed-off-by: Jean-Loup 'clippix' Bogalho <clippix@lse.epita.fr>
---

This version is modified following the comments of Karel Zak and
Benno Schuleberg in the review of the previous patch.

 disk-utils/fdisk-menu.c |  4 ++++
 disk-utils/fdisk.c      | 44 ++++++++++++++++++++++++++++++++++++++++++++
 disk-utils/fdisk.h      |  2 ++
 3 files changed, 50 insertions(+)

diff --git a/disk-utils/fdisk-menu.c b/disk-utils/fdisk-menu.c
index a77a13f..6c7f583 100644
--- a/disk-utils/fdisk-menu.c
+++ b/disk-utils/fdisk-menu.c
@@ -99,6 +99,7 @@ struct menu menu_generic = {
 		MENU_BENT ('p', N_("print the partition table")),
 		MENU_ENT  ('t', N_("change a partition type")),
 		MENU_BENT_E('v', N_("verify the partition table"), FDISK_DISKLABEL_BSD),
+		MENU_ENT  ('i', N_("print information about a partition")),
 
 		MENU_XENT('d', N_("print the raw data of the first sector from the device")),
 		MENU_XENT('D', N_("print the raw data of the disklabel from the device")),
@@ -557,6 +558,9 @@ static int generic_menu_cb(struct fdisk_context **cxt0,
 	case 'v':
 		rc = fdisk_verify_disklabel(cxt);
 		break;
+	case 'i':
+		rc = print_partition_info(cxt);
+		break;
 	}
 
 	/* expert mode */
diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index a1e7259..2b04574 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -564,6 +564,50 @@ void change_partition_type(struct fdisk_context *cxt)
 	fdisk_unref_partition(pa);
 }
 
+int print_partition_info(struct fdisk_context *cxt)
+{
+	struct fdisk_partition *pa = NULL;
+	int rc = 0, details;
+	size_t i, nfields;
+	int *fields = NULL;
+	struct fdisk_label *lb = fdisk_get_label(cxt, NULL);
+
+	if ((rc = fdisk_ask_partnum(cxt, &i, FALSE)))
+		return rc;
+
+	if ((rc = fdisk_get_partition(cxt, i, &pa))) {
+		fdisk_warnx(cxt, _("Partition %zu does not exist yet!"), i + 1);
+		return rc;
+	}
+
+	details = fdisk_is_details(cxt);
+	fdisk_enable_details(cxt, 1);
+	if ((rc = fdisk_label_get_fields_ids(lb, cxt, &fields, &nfields)))
+		goto clean_data;
+	fdisk_enable_details(cxt, details);
+
+	for (i = 0; i < nfields; ++i) {
+		int id = fields[i];
+		char *data = NULL;
+		const struct fdisk_field *fd = fdisk_label_get_field(lb, id);
+
+		if (!fd)
+			continue;
+
+		rc = fdisk_partition_to_string(pa, cxt, id, &data);
+		if (rc < 0)
+			goto clean_data;
+
+		fdisk_info(cxt, _("%15s: %s"), fdisk_field_get_name(fd), data);
+		free(data);
+	}
+
+clean_data:
+	fdisk_unref_partition(pa);
+	free(fields);
+	return rc;
+}
+
 static size_t skip_empty(const unsigned char *buf, size_t i, size_t sz)
 {
 	size_t next;
diff --git a/disk-utils/fdisk.h b/disk-utils/fdisk.h
index 4bd4733..6a62c24 100644
--- a/disk-utils/fdisk.h
+++ b/disk-utils/fdisk.h
@@ -36,6 +36,8 @@ extern int process_fdisk_menu(struct fdisk_context **cxt);
 extern int ask_callback(struct fdisk_context *cxt, struct fdisk_ask *ask,
 		    void *data __attribute__((__unused__)));
 
+extern int print_partition_info(struct fdisk_context *cxt);
+
 /* prototypes for fdisk.c */
 extern void dump_firstsector(struct fdisk_context *cxt);
 extern void dump_disklabel(struct fdisk_context *cxt);
-- 
2.1.0


-- 
Jean-Loup 'clippix' Bogalho
LSE 2016
