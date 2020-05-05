Return-Path: <SRS0=yJR+=6T=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31A7C47247
	for <util-linux@archiver.kernel.org>; Tue,  5 May 2020 14:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AABD72073B
	for <util-linux@archiver.kernel.org>; Tue,  5 May 2020 14:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729178AbgEEOcM (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 5 May 2020 10:32:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:56518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729123AbgEEOcM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 5 May 2020 10:32:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B1E2FABB2;
        Tue,  5 May 2020 14:32:12 +0000 (UTC)
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     util-linux@vger.kernel.org
Cc:     ailiop@suse.com
Subject: [PATCH] libblkid: add dax capability detection in topology probing
Date:   Tue,  5 May 2020 16:31:45 +0200
Message-Id: <20200505143145.9852-2-ailiop@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The dax (direct access) blockdev capability is exposed via sysfs, add it
to the list of topology values to be obtained while probing.

Expose blkid_topology_get_dax() symbol that programs can link against
for querying the capability.

Reorder the idinfos array to give precedence to the sysfs over ioctl so
that the dax probe has a chance to be executed, as there is no ioctl
interface for it.

Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 libblkid/samples/topology.c      |  2 ++
 libblkid/src/blkid.h.in          |  2 ++
 libblkid/src/libblkid.sym        |  4 ++++
 libblkid/src/topology/sysfs.c    |  1 +
 libblkid/src/topology/topology.c | 21 ++++++++++++++++++++-
 libblkid/src/topology/topology.h |  1 +
 6 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/libblkid/samples/topology.c b/libblkid/samples/topology.c
index 4112ba36e..7d21567d5 100644
--- a/libblkid/samples/topology.c
+++ b/libblkid/samples/topology.c
@@ -51,6 +51,8 @@ int main(int argc, char *argv[])
 				blkid_topology_get_logical_sector_size(tp));
 		printf("\tphysical sector size : %lu\n",
 				blkid_topology_get_physical_sector_size(tp));
+		printf("\tdax support          : %lu\n",
+				blkid_topology_get_dax(tp));
 	}
 
 	/*
diff --git a/libblkid/src/blkid.h.in b/libblkid/src/blkid.h.in
index d09d60c38..7328d0e30 100644
--- a/libblkid/src/blkid.h.in
+++ b/libblkid/src/blkid.h.in
@@ -325,6 +325,8 @@ extern unsigned long blkid_topology_get_logical_sector_size(blkid_topology tp)
 			__ul_attribute__((nonnull));
 extern unsigned long blkid_topology_get_physical_sector_size(blkid_topology tp)
 			__ul_attribute__((nonnull));
+extern unsigned long blkid_topology_get_dax(blkid_topology tp)
+			__ul_attribute__((nonnull));
 
 /*
  * partitions probing
diff --git a/libblkid/src/libblkid.sym b/libblkid/src/libblkid.sym
index bac443823..eff1f7774 100644
--- a/libblkid/src/libblkid.sym
+++ b/libblkid/src/libblkid.sym
@@ -174,3 +174,7 @@ BLKID_2_31 {
 	blkid_probe_reset_buffers;
 	blkid_probe_hide_range;
 } BLKID_2.30;
+
+BLKID_2_35 {
+	blkid_topology_get_dax;
+} BLKID_2_31;
diff --git a/libblkid/src/topology/sysfs.c b/libblkid/src/topology/sysfs.c
index 0605c3558..745cd115a 100644
--- a/libblkid/src/topology/sysfs.c
+++ b/libblkid/src/topology/sysfs.c
@@ -37,6 +37,7 @@ static struct topology_val {
 	{ "queue/minimum_io_size", blkid_topology_set_minimum_io_size },
 	{ "queue/optimal_io_size", blkid_topology_set_optimal_io_size },
 	{ "queue/physical_block_size", blkid_topology_set_physical_sector_size },
+	{ "queue/dax", blkid_topology_set_dax },
 };
 
 static int probe_sysfs_tp(blkid_probe pr,
diff --git a/libblkid/src/topology/topology.c b/libblkid/src/topology/topology.c
index 38e4c950d..34ef40800 100644
--- a/libblkid/src/topology/topology.c
+++ b/libblkid/src/topology/topology.c
@@ -67,6 +67,7 @@ struct blkid_struct_topology {
 	unsigned long	optimal_io_size;
 	unsigned long	logical_sector_size;
 	unsigned long	physical_sector_size;
+	unsigned long   dax;
 };
 
 /*
@@ -75,8 +76,8 @@ struct blkid_struct_topology {
 static const struct blkid_idinfo *idinfos[] =
 {
 #ifdef __linux__
-	&ioctl_tp_idinfo,
 	&sysfs_tp_idinfo,
+	&ioctl_tp_idinfo,
 	&md_tp_idinfo,
 	&dm_tp_idinfo,
 	&lvm_tp_idinfo,
@@ -303,6 +304,14 @@ int blkid_topology_set_physical_sector_size(blkid_probe pr, unsigned long val)
 			val);
 }
 
+int blkid_topology_set_dax(blkid_probe pr, unsigned long val)
+{
+	return topology_set_value(pr,
+			"DAX",
+			offsetof(struct blkid_struct_topology, dax),
+			val);
+}
+
 /**
  * blkid_topology_get_alignment_offset:
  * @tp: topology
@@ -358,3 +367,13 @@ unsigned long blkid_topology_get_physical_sector_size(blkid_topology tp)
 	return tp->physical_sector_size;
 }
 
+/**
+ * blkid_topology_get_dax
+ * @tp: topology
+ *
+ * Returns: 1 if dax is supported, 0 otherwise.
+ */
+unsigned long blkid_topology_get_dax(blkid_topology tp)
+{
+	return tp->dax;
+}
diff --git a/libblkid/src/topology/topology.h b/libblkid/src/topology/topology.h
index 6d2f43345..3e46af9ac 100644
--- a/libblkid/src/topology/topology.h
+++ b/libblkid/src/topology/topology.h
@@ -7,6 +7,7 @@ extern int blkid_topology_set_alignment_offset(blkid_probe pr, int val);
 extern int blkid_topology_set_minimum_io_size(blkid_probe pr, unsigned long val);
 extern int blkid_topology_set_optimal_io_size(blkid_probe pr, unsigned long val);
 extern int blkid_topology_set_physical_sector_size(blkid_probe pr, unsigned long val);
+extern int blkid_topology_set_dax(blkid_probe pr, unsigned long val);
 
 /*
  * topology probers
-- 
2.26.2

