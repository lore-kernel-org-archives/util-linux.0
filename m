Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33655 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750737AbbEFOV5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 May 2015 10:21:57 -0400
Received: by wgin8 with SMTP id n8so13480415wgi.0
        for <util-linux@vger.kernel.org>; Wed, 06 May 2015 07:21:55 -0700 (PDT)
Date: Wed, 6 May 2015 16:21:43 +0200
From: "Jean-Loup 'clippix' Bogalho" <clippix@lse.epita.fr>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com
Subject: [PATCH v2] fdisk: add the 'i'nfo command
Message-ID: <20150506142143.GA27359@clippix.lab.lse.epita.fr>
Reply-To: clippix@lse.epita.fr
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add the 'i'nfo command to fdisk that prints details about a specific partition
(as of now: name / offset / size / uuid / type / C/H/S).

The output format is as follow:

    name:       <name>
    start:      <offset>
    size:       <size>
    uuid:       <uuid>
    type:       <type>
    C/H/S:      <cylinders/1/sectors>

Signed-off-by: Jean-Loup 'clippix' Bogalho <clippix@lse.epita.fr>
---

This is a second version of the patch that adds the 'i'nfo command, modified
according to the review of Karel Zak. I'm still getting a NULL pointer when
asking for the device's name or uuid. Moreover, whether you ask for cylinders
or sectors, fdisk_partition_to_string always return the partition size, is it
supposed to be the wanted behavior?

 disk-utils/fdisk-menu.c |  4 ++++
 disk-utils/fdisk.c      | 43 +++++++++++++++++++++++++++++++++++++++++++
 disk-utils/fdisk.h      |  2 ++
 3 files changed, 49 insertions(+)

diff --git a/disk-utils/fdisk-menu.c b/disk-utils/fdisk-menu.c
index a77a13f..29af2c9 100644
--- a/disk-utils/fdisk-menu.c
+++ b/disk-utils/fdisk-menu.c
@@ -99,6 +99,7 @@ struct menu menu_generic = {
 		MENU_BENT ('p', N_("print the partition table")),
 		MENU_ENT  ('t', N_("change a partition type")),
 		MENU_BENT_E('v', N_("verify the partition table"), FDISK_DISKLABEL_BSD),
+		MENU_ENT  ('i', N_("print informations about a partition")),
 
 		MENU_XENT('d', N_("print the raw data of the first sector from the device")),
 		MENU_XENT('D', N_("print the raw data of the disklabel from the device")),
@@ -557,6 +558,9 @@ static int generic_menu_cb(struct fdisk_context **cxt0,
 	case 'v':
 		rc = fdisk_verify_disklabel(cxt);
 		break;
+	case 'i':
+		rc = print_partition_infos(cxt);
+		break;
 	}
 
 	/* expert mode */
diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index a1e7259..b1c6d0f 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -564,6 +564,49 @@ void change_partition_type(struct fdisk_context *cxt)
 	fdisk_unref_partition(pa);
 }
 
+#define NB_INFO_FIELDS	6
+
+int print_partition_infos(struct fdisk_context *cxt)
+{
+	struct fdisk_partition *pa = NULL;
+	char *data = NULL;
+	int rc = 0;
+	size_t i;
+	static int info_ids[NB_INFO_FIELDS] = {
+		FDISK_FIELD_NAME, FDISK_FIELD_START, FDISK_FIELD_SIZE,
+		FDISK_FIELD_UUID, FDISK_FIELD_TYPE, FDISK_FIELD_CYLINDERS
+	};
+	static char *fields[NB_INFO_FIELDS] = {
+		"name", "start", "size", "uuid", "type", "C/H/S"
+	};
+
+	if ((rc = fdisk_ask_partnum(cxt, &i, FALSE)))
+		return rc;
+
+	if ((rc = fdisk_get_partition(cxt, i, &pa))) {
+		fdisk_warnx(cxt, _("Partition %zu does not exist yet!"), i + 1);
+		return rc;
+	}
+
+	for (i = 0; i < NB_INFO_FIELDS - 1; ++i) {
+		rc = fdisk_partition_to_string(pa, cxt, info_ids[i], &data);
+		if (rc < 0)
+			goto clean_data;
+		fdisk_info(cxt, _("%s:\t%s"), fields[i], data);
+		free(data);
+	}
+	if ((rc = fdisk_partition_to_string(pa, cxt, info_ids[i], &data)) < 0)
+		goto clean_data;
+	fdisk_info(cxt, _("%s:\t%s/%d/%s"), fields[i], data, 1, data);
+
+clean_data:
+	fdisk_unref_partition(pa);
+	free(data);
+	return rc;
+}
+
+#undef NB_INFO_FIELDS
+
 static size_t skip_empty(const unsigned char *buf, size_t i, size_t sz)
 {
 	size_t next;
diff --git a/disk-utils/fdisk.h b/disk-utils/fdisk.h
index 4bd4733..aadd802 100644
--- a/disk-utils/fdisk.h
+++ b/disk-utils/fdisk.h
@@ -36,6 +36,8 @@ extern int process_fdisk_menu(struct fdisk_context **cxt);
 extern int ask_callback(struct fdisk_context *cxt, struct fdisk_ask *ask,
 		    void *data __attribute__((__unused__)));
 
+extern int print_partition_infos(struct fdisk_context *cxt);
+
 /* prototypes for fdisk.c */
 extern void dump_firstsector(struct fdisk_context *cxt);
 extern void dump_disklabel(struct fdisk_context *cxt);

-- 
Jean-Loup 'clippix' Bogalho
LSE 2016
