Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36603 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbbEBWw4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 2 May 2015 18:52:56 -0400
Received: by pdea3 with SMTP id a3so127876913pde.3
        for <util-linux@vger.kernel.org>; Sat, 02 May 2015 15:52:56 -0700 (PDT)
From: Michael Marineau <michael.marineau@coreos.com>
To: util-linux@vger.kernel.org
Cc: Michael Marineau <michael.marineau@coreos.com>
Subject: [PATCH] libfdisk: (gpt) add API for raw partition attributes
Date: Sat,  2 May 2015 15:52:48 -0700
Message-Id: <1430607168-3783-1-git-send-email-michael.marineau@coreos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The existing APIs can only toggle individual bits or get and set bits in
a complex text representation, making it impractical to use libfdisk for
manipulating the GPT partition attribute field in more complex ways such
as updating a value that is multiple bits wide. For example priority
based partition selection originally designed for ChromeOS includes two
integer values that are 4-bits wide.

http://www.chromium.org/chromium-os/chromiumos-design-docs/disk-format#TOC-Trusting-the-GPT

Signed-off-by: Michael Marineau <michael.marineau@coreos.com>
---
 libfdisk/src/Makemodule.am               |   6 ++
 libfdisk/src/gpt.c                       | 128 +++++++++++++++++++++++++++++++
 libfdisk/src/libfdisk.h.in               |   2 +
 tests/commands.sh                        |   1 +
 tests/expected/libfdisk/gpt-all-defaults |  21 +++++
 tests/expected/libfdisk/gpt-getattr      |   2 +
 tests/expected/libfdisk/gpt-setattr      |   2 +
 tests/ts/libfdisk/gpt                    |  52 +++++++++++++
 8 files changed, 214 insertions(+)
 create mode 100644 tests/expected/libfdisk/gpt-all-defaults
 create mode 100644 tests/expected/libfdisk/gpt-getattr
 create mode 100644 tests/expected/libfdisk/gpt-setattr
 create mode 100755 tests/ts/libfdisk/gpt

diff --git a/libfdisk/src/Makemodule.am b/libfdisk/src/Makemodule.am
index 347ea8e..00c3d9f 100644
--- a/libfdisk/src/Makemodule.am
+++ b/libfdisk/src/Makemodule.am
@@ -64,6 +64,7 @@ EXTRA_DIST += \
 if BUILD_LIBFDISK_TESTS
 check_PROGRAMS += \
 	test_fdisk_ask \
+	test_fdisk_gpt \
 	test_fdisk_script \
 	test_fdisk_utils \
 	test_fdisk_version 
@@ -81,6 +82,11 @@ test_fdisk_ask_CFLAGS = $(libfdisk_tests_cflags)
 test_fdisk_ask_LDFLAGS = $(libfdisk_tests_ldflags)
 test_fdisk_ask_LDADD = $(libfdisk_tests_ldadd)
 
+test_fdisk_gpt_SOURCES = libfdisk/src/gpt.c
+test_fdisk_gpt_CFLAGS = $(libfdisk_tests_cflags)
+test_fdisk_gpt_LDFLAGS = $(libfdisk_tests_ldflags)
+test_fdisk_gpt_LDADD = $(libfdisk_tests_ldadd)
+
 test_fdisk_utils_SOURCES = libfdisk/src/utils.c
 test_fdisk_utils_CFLAGS = $(libfdisk_tests_cflags)
 test_fdisk_utils_LDFLAGS = $(libfdisk_tests_ldflags)
diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index 989fd75..e901a4a 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -2429,6 +2429,73 @@ int fdisk_gpt_is_hybrid(struct fdisk_context *cxt)
 	return valid_pmbr(cxt) == GPT_MBR_HYBRID;
 }
 
+/**
+ * fdisk_gpt_get_partition_attrs:
+ * @cxt: context
+ * @partnum: partition number
+ * @attrs: GPT partition attributes
+ *
+ * Sets @attrs for the given partition
+ *
+ * Returns: 0 on success, <0 on error.
+ */
+int fdisk_gpt_get_partition_attrs(
+		struct fdisk_context *cxt,
+		size_t partnum,
+		uint64_t *attrs)
+{
+	struct fdisk_gpt_label *gpt;
+
+	assert(cxt);
+	assert(cxt->label);
+	assert(fdisk_is_label(cxt, GPT));
+
+	gpt = self_label(cxt);
+
+	if ((uint32_t) partnum >= le32_to_cpu(gpt->pheader->npartition_entries))
+		return -EINVAL;
+
+	*attrs = le64_to_cpu(gpt->ents[partnum].attrs);
+	return 0;
+}
+
+/**
+ * fdisk_gpt_set_partition_attrs:
+ * @cxt: context
+ * @partnum: partition number
+ * @attrs: GPT partition attributes
+ *
+ * Sets the GPT partition attributes field to @attrs.
+ *
+ * Returns: 0 on success, <0 on error.
+ */
+int fdisk_gpt_set_partition_attrs(
+		struct fdisk_context *cxt,
+		size_t partnum,
+		uint64_t attrs)
+{
+	struct fdisk_gpt_label *gpt;
+
+	assert(cxt);
+	assert(cxt->label);
+	assert(fdisk_is_label(cxt, GPT));
+
+	DBG(LABEL, ul_debug("GPT entry attributes change requested partno=%zu", partnum));
+	gpt = self_label(cxt);
+
+	if ((uint32_t) partnum >= le32_to_cpu(gpt->pheader->npartition_entries))
+		return -EINVAL;
+
+	gpt->ents[partnum].attrs = cpu_to_le64(attrs);
+	fdisk_info(cxt, _("The attributes on partition %zu changed to 0x%016" PRIx64 "."),
+			partnum + 1, attrs);
+
+	gpt_recompute_crc(gpt->pheader, gpt->ents);
+	gpt_recompute_crc(gpt->bheader, gpt->ents);
+	fdisk_label_set_changed(cxt->label, 1);
+	return 0;
+}
+
 static int gpt_toggle_partition_flag(
 		struct fdisk_context *cxt,
 		size_t i,
@@ -2668,3 +2735,64 @@ struct fdisk_label *fdisk_new_gpt_label(struct fdisk_context *cxt)
 
 	return lb;
 }
+
+#ifdef TEST_PROGRAM
+int test_getattr(struct fdisk_test *ts, int argc, char *argv[])
+{
+	const char *disk = argv[1];
+	size_t part = strtoul(argv[2], NULL, 0) - 1;
+	struct fdisk_context *cxt;
+	struct fdisk_label *lb;
+	uint64_t atters = 0;
+
+	cxt = fdisk_new_context();
+	fdisk_assign_device(cxt, disk, 1);
+
+	if (!fdisk_is_label(cxt, GPT))
+		return EXIT_FAILURE;
+
+	if (fdisk_gpt_get_partition_attrs(cxt, part, &atters))
+		return EXIT_FAILURE;
+
+	printf("%s: 0x%016" PRIx64 "\n", argv[2], atters);
+
+	fdisk_unref_context(cxt);
+	return 0;
+}
+
+int test_setattr(struct fdisk_test *ts, int argc, char *argv[])
+{
+	const char *disk = argv[1];
+	size_t part = strtoul(argv[2], NULL, 0) - 1;
+	uint64_t atters = strtoull(argv[3], NULL, 0);
+	struct fdisk_context *cxt;
+	struct fdisk_label *lb;
+
+	cxt = fdisk_new_context();
+	fdisk_assign_device(cxt, disk, 0);
+
+	if (!fdisk_is_label(cxt, GPT))
+		return EXIT_FAILURE;
+
+	if (fdisk_gpt_set_partition_attrs(cxt, part, atters))
+		return EXIT_FAILURE;
+
+	if (fdisk_write_disklabel(cxt))
+		return EXIT_FAILURE;
+
+	fdisk_unref_context(cxt);
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	struct fdisk_test tss[] = {
+		{ "--getattr",  test_getattr,  "<disk> <partition>             print attributes" },
+		{ "--setattr",  test_setattr,  "<disk> <partition> <value>     set attributes" },
+		{ NULL }
+	};
+
+	return fdisk_run_test(tss, argc, argv);
+}
+
+#endif
diff --git a/libfdisk/src/libfdisk.h.in b/libfdisk/src/libfdisk.h.in
index 5f75ecd..a5a4656 100644
--- a/libfdisk/src/libfdisk.h.in
+++ b/libfdisk/src/libfdisk.h.in
@@ -531,6 +531,8 @@ extern int fdisk_sgi_create_info(struct fdisk_context *cxt);
 #define GPT_FLAG_GUIDSPECIFIC	4
 
 extern int fdisk_gpt_is_hybrid(struct fdisk_context *cxt);
+extern int fdisk_gpt_get_partition_attrs(struct fdisk_context *cxt, size_t partnum, uint64_t *attrs);
+extern int fdisk_gpt_set_partition_attrs(struct fdisk_context *cxt, size_t partnum, uint64_t attrs);
 
 
 /* script.c */
diff --git a/tests/commands.sh b/tests/commands.sh
index e3ac433..dfb19e3 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -7,6 +7,7 @@ TS_HELPER_CPUSET="$top_builddir/test_cpuset"
 TS_HELPER_DMESG="$top_builddir/test_dmesg"
 TS_HELPER_ISLOCAL="$top_builddir/test_islocal"
 TS_HELPER_ISMOUNTED="$top_builddir/test_ismounted"
+TS_HELPER_LIBFDISK_GPT="$top_builddir/test_fdisk_gpt"
 TS_HELPER_LIBMOUNT_CONTEXT="$top_builddir/test_mount_context"
 TS_HELPER_LIBMOUNT_LOCK="$top_builddir/test_mount_lock"
 TS_HELPER_LIBMOUNT_OPTSTR="$top_builddir/test_mount_optstr"
diff --git a/tests/expected/libfdisk/gpt-all-defaults b/tests/expected/libfdisk/gpt-all-defaults
new file mode 100644
index 0000000..8836807
--- /dev/null
+++ b/tests/expected/libfdisk/gpt-all-defaults
@@ -0,0 +1,21 @@
+Checking that no-one is using this disk right now ... OK
+
+Disk <removed>: 10 MiB, 10485760 bytes, 20480 sectors
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / 512 bytes
+
+>>> Script header accepted.
+>>> Script header accepted.
+>>> Created a new <removed>.
+Created a new <removed>.
+<removed>2: Created a new <removed>.
+<removed>3: 
+New situation:
+
+Device             Start   End Sectors Size Type
+<removed>1  2048 12287   10240   5M Linux filesystem
+<removed>2 12288 20446    8159   4M Linux filesystem
+
+The partition table has been altered.
+Syncing disks.
diff --git a/tests/expected/libfdisk/gpt-getattr b/tests/expected/libfdisk/gpt-getattr
new file mode 100644
index 0000000..559a9ae
--- /dev/null
+++ b/tests/expected/libfdisk/gpt-getattr
@@ -0,0 +1,2 @@
+1: 0x0001000000000001
+2: 0x4030000000000000
diff --git a/tests/expected/libfdisk/gpt-setattr b/tests/expected/libfdisk/gpt-setattr
new file mode 100644
index 0000000..41af260
--- /dev/null
+++ b/tests/expected/libfdisk/gpt-setattr
@@ -0,0 +1,2 @@
+GUID:56,57,58,59,60,61,62,63
+LegacyBIOSBootable
diff --git a/tests/ts/libfdisk/gpt b/tests/ts/libfdisk/gpt
new file mode 100755
index 0000000..2de6b1a
--- /dev/null
+++ b/tests/ts/libfdisk/gpt
@@ -0,0 +1,52 @@
+#!/bin/bash
+#
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+#
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="GPT"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+TESTPROG="$TS_HELPER_LIBFDISK_GPT"
+ts_check_test_command "$TESTPROG"
+ts_check_test_command "$TS_CMD_SFDISK"
+
+TEST_IMAGE_NAME=$(ts_image_init 10)
+
+ts_init_subtest "all-defaults"
+$TS_CMD_SFDISK --unit S ${TEST_IMAGE_NAME} >> $TS_OUTPUT 2>&1 <<EOF
+label: gpt
+label-id: b181c399-4711-4c52-8b65-9e764541218d
+
+size=5M, attrs="RequiredPartiton,48"
+attrs="52,53,62"
+EOF
+ts_fdisk_clean ${TEST_IMAGE_NAME}
+ts_finalize_subtest
+
+ts_init_subtest "getattr"
+ts_valgrind $TESTPROG --getattr ${TEST_IMAGE_NAME} 1 >> $TS_OUTPUT 2>&1
+ts_valgrind $TESTPROG --getattr ${TEST_IMAGE_NAME} 2 >> $TS_OUTPUT 2>&1
+ts_finalize_subtest
+
+ts_init_subtest "setattr"
+ts_valgrind $TESTPROG --setattr ${TEST_IMAGE_NAME} 1 0xff00000000000000 >> $TS_OUTPUT 2>&1
+ts_valgrind $TESTPROG --setattr ${TEST_IMAGE_NAME} 2 0x4 >> $TS_OUTPUT 2>&1
+$TS_CMD_SFDISK --part-attrs ${TEST_IMAGE_NAME} 1 >> $TS_OUTPUT 2>&1
+$TS_CMD_SFDISK --part-attrs ${TEST_IMAGE_NAME} 2 >> $TS_OUTPUT 2>&1
+ts_finalize_subtest
+
+ts_finalize
-- 
2.0.5

