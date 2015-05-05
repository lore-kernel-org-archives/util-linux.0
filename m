Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:37575 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbbEEHC3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 5 May 2015 03:02:29 -0400
Received: by widdi4 with SMTP id di4so134110629wid.0
        for <util-linux@vger.kernel.org>; Tue, 05 May 2015 00:02:28 -0700 (PDT)
Date: Tue, 5 May 2015 09:02:19 +0200
From: "Jean-Loup 'clippix' Bogalho" <clippix@lse.epita.fr>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com
Subject: [PATCH v1] fdisk: add the 'i'nfo command
Message-ID: <20150505070218.GA15800@clippix.lab.lse.epita.fr>
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

This is a first draft to add the 'i'nfo command. There's some infos given by
the TODO that are still missing (like the fstype).
Moreover, some infos aren't correct (from my tests) like the device name or the
uuid (which are always NULL).
Please, feel free to give me any pointers (haha) on how to make this patch
better.


 disk-utils/fdisk-menu.c    |  4 ++++
 disk-utils/fdisk.c         | 30 ++++++++++++++++++++++++++
 disk-utils/fdisk.h         |  2 ++
 libfdisk/src/libfdisk.h.in |  3 +++
 libfdisk/src/libfdisk.sym  |  1 +
 libfdisk/src/partition.c   | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 93 insertions(+)

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
index a1e7259..2e90530 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -564,6 +564,36 @@ void change_partition_type(struct fdisk_context *cxt)
 	fdisk_unref_partition(pa);
 }
 
+int print_partition_infos(struct fdisk_context *cxt)
+{
+	struct fdisk_partition *pa = NULL;
+	char *data = NULL;
+	int rc = 0;
+	size_t i;
+
+	if ((rc = fdisk_ask_partnum(cxt, &i, FALSE)))
+		return rc;
+
+	if ((rc = fdisk_get_partition(cxt, i, &pa))) {
+		fdisk_warnx(cxt, _("Partition %zu does not exist yet!"), i + 1);
+		return rc;
+	}
+
+	if ((rc = fdisk_get_partition_infos(cxt, pa, &data) || !data)) {
+		fdisk_warnx(cxt,
+			_("Could not get informations about partition %zu"),
+			i + 1);
+		goto clean_data;
+	}
+
+	fdisk_info(cxt, _("%s\n"), data);
+
+clean_data:
+	fdisk_unref_partition(pa);
+	free(data);
+	return rc;
+}
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
diff --git a/libfdisk/src/libfdisk.h.in b/libfdisk/src/libfdisk.h.in
index 5f75ecd..26150e2 100644
--- a/libfdisk/src/libfdisk.h.in
+++ b/libfdisk/src/libfdisk.h.in
@@ -378,6 +378,9 @@ extern int fdisk_partition_is_wholedisk(struct fdisk_partition *pa);
 extern int fdisk_partition_to_string(struct fdisk_partition *pa,
 				     struct fdisk_context *cxt,
 				     int id, char **data);
+extern int fdisk_get_partition_infos(struct fdisk_context *cxt,
+				     struct fdisk_partition *pa,
+				     char **data);
 
 int fdisk_partition_next_partno(struct fdisk_partition *pa,
 				       struct fdisk_context *cxt,
diff --git a/libfdisk/src/libfdisk.sym b/libfdisk/src/libfdisk.sym
index 456a52d..babb86b 100644
--- a/libfdisk/src/libfdisk.sym
+++ b/libfdisk/src/libfdisk.sym
@@ -82,6 +82,7 @@ global:
 	fdisk_get_parent;
 	fdisk_get_partition;
 	fdisk_get_partitions;
+	fdisk_get_partition_infos;
 	fdisk_get_physector_size;
 	fdisk_get_script;
 	fdisk_get_sector_size;
diff --git a/libfdisk/src/partition.c b/libfdisk/src/partition.c
index e892e9d..4dde973 100644
--- a/libfdisk/src/partition.c
+++ b/libfdisk/src/partition.c
@@ -872,6 +872,59 @@ int fdisk_partition_to_string(struct fdisk_partition *pa,
 	return rc;
 }
 
+#define NB_INFO_FIELDS 7
+
+int fdisk_get_partition_infos(
+			struct fdisk_context *cxt,
+			struct fdisk_partition *pa,
+			char **data)
+{
+	size_t i;
+	char *p = NULL;
+	int rc = 0;
+	static int info_ids[NB_INFO_FIELDS] = {
+		FDISK_FIELD_START, FDISK_FIELD_SIZE, FDISK_FIELD_NAME,
+		FDISK_FIELD_UUID, FDISK_FIELD_TYPE, FDISK_FIELD_CYLINDERS,
+		FDISK_FIELD_SECTORS
+	};
+	char *infos[NB_INFO_FIELDS] = {
+		NULL
+	};
+
+	if (!pa || !cxt || !data)
+		return -EINVAL;
+
+	for (i = 0; i < NB_INFO_FIELDS; ++i) {
+		rc = fdisk_partition_to_string(pa, cxt, info_ids[i], infos + i);
+
+		if (rc < 0)
+			goto clean_infos;
+		if (!infos[i])
+			infos[i] = strdup("N/A");
+	}
+
+	rc = asprintf(&p, "name: \t%s\nstart: \t%s\nsize: \t%s\nuuid: \t%s\n"
+		      "type: \t%s\nC/H/S: \t%s/%s/%s", infos[2], infos[0],
+		      infos[1], infos[3], infos[4], infos[5], "1", infos[6]);
+
+	if (rc < 0) {
+		rc = -ENOMEM;
+		free(p);
+		p = NULL;
+	} else if (rc > 0) {
+		rc = 0;
+	}
+
+	*data = p;
+
+clean_infos:
+	for (i = 0; i < NB_INFO_FIELDS; ++i)
+		free(infos[i]);
+	return rc;
+}
+
+#undef NB_INFO_FIELDS
+
 /**
  * fdisk_get_partition:
  * @cxt: context


-- 
Jean-Loup 'clippix' Bogalho
LSE 2016
