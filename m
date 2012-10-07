Return-Path: util-linux-owner@vger.kernel.org
Received: from mailbigip.dreamhost.com ([208.97.132.5]:58001 "EHLO
	homiemail-a38.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753129Ab2JGOds (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Oct 2012 10:33:48 -0400
Message-ID: <1349620425.2548.7.camel@offbook>
Subject: [PATCH 2/5] fdisk: api: improve some comments
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Date: Sun, 07 Oct 2012 16:33:45 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisks/utils.c |   48 ++++++++++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 14 deletions(-)

diff --git a/fdisks/utils.c b/fdisks/utils.c
index 0b65186..e20c42f 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -50,7 +50,7 @@ static const struct fdisk_label *labels[] =
 };
 
 /**
- * fdisk_write_disklabel
+ * fdisk_write_disklabel:
  * @cxt: fdisk context
  *
  * Write in-memory changes to disk
@@ -71,7 +71,7 @@ int fdisk_write_disklabel(struct fdisk_context *cxt)
  * fdisk_verify_disklabel:
  * @cxt: fdisk context
  *
- * Verifies the partition tabe.
+ * Verifies the partition table.
  *
  * Returns 0.
  */
@@ -452,14 +452,14 @@ void fdisk_init_debug(int mask)
 
 /**
  * fdisk_new_context:
- * @filename: path to the device to be handled
+ * @fname: path to the device to be handled
  * @readonly: how to open the device
  *
  * If the @readonly flag is set to false, fdisk will attempt to open
  * the device with read-write mode and will fallback to read-only if
  * unsuccessful.
  *
- * Returns: newly allocated fdisk context
+ * Returns: newly allocated fdisk context or NULL upon failure.
  */
 struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int readonly)
 {
@@ -526,8 +526,9 @@ void fdisk_free_context(struct fdisk_context *cxt)
 	free(cxt);
 }
 
-/*
+/**
  * fdisk_get_nparttypes:
+ * @cxt: fdisk context
  *
  * Returns: number of partition types supported by the current label
  */
@@ -539,8 +540,14 @@ size_t fdisk_get_nparttypes(struct fdisk_context *cxt)
 	return cxt->label->nparttypes;
 }
 
-/*
+/**
+ * fdisk_get_parttype_from_code:
+ * @cxt: fdisk context
+ * @code: code to search for
+ * 
  * Search in lable-specific table of supported partition types by code.
+ *
+ * Returns partition type or NULL upon failure or invalid @code.
  */
 struct fdisk_parttype *fdisk_get_parttype_from_code(
 				struct fdisk_context *cxt,
@@ -558,8 +565,14 @@ struct fdisk_parttype *fdisk_get_parttype_from_code(
 	return NULL;
 }
 
-/*
+/**
+ * fdisk_get_parttype_from_string:
+ * @cxt: fdisk context
+ * @str: string to search for
+ *
  * Search in lable-specific table of supported partition types by typestr.
+ *
+ * Returns partition type or NULL upon failure or invalid @str.
  */
 struct fdisk_parttype *fdisk_get_parttype_from_string(
 				struct fdisk_context *cxt,
@@ -578,9 +591,15 @@ struct fdisk_parttype *fdisk_get_parttype_from_string(
 	return NULL;
 }
 
-/*
+/**
+ * fdisk_new_unknown_parttype:
+ * @type: type as number
+ * @typestr: type as string
+
  * Allocates new 'unknown' partition type. Use fdisk_free_parttype() to
  * deallocate.
+ *
+ * Returns newly allocated partition type, or NULL upon failure.
  */
 struct fdisk_parttype *fdisk_new_unknown_parttype(unsigned int type,
 						  const char *typestr)
@@ -606,10 +625,10 @@ struct fdisk_parttype *fdisk_new_unknown_parttype(unsigned int type,
 	return t;
 }
 
-/*
- * fdisk_parse_parttype
+/**
+ * fdisk_parse_parttype:
  * @cxt: fdisk context
- * @str: string
+ * @str: string to parse from
  *
  * Returns pointer to static table of the partition types, or newly allocated
  * partition type for unknown types. It's safe to call fdisk_free_parttype()
@@ -666,8 +685,9 @@ done:
 	return ret;
 }
 
-/*
+/**
  * fdisk_free_parttype:
+ * @t: new type
  *
  * Free the @type.
  */
@@ -685,7 +705,7 @@ void fdisk_free_parttype(struct fdisk_parttype *t)
  * @cxt: fdisk context
  * @partnum: partition number
  *
- * Returns partition type
+ * Returns partition type or NULL upon failure.
  */
 struct fdisk_parttype *fdisk_get_partition_type(struct fdisk_context *cxt, int partnum)
 {
@@ -702,7 +722,7 @@ struct fdisk_parttype *fdisk_get_partition_type(struct fdisk_context *cxt, int p
  * @partnum: partition number
  * @t: new type
  *
- * Returns partition type
+ * Returns 0 on success, < 0 on error.
  */
 int fdisk_set_partition_type(struct fdisk_context *cxt, int partnum,
 			     struct fdisk_parttype *t)
-- 
1.7.9.5




