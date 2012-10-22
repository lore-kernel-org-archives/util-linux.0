Return-Path: util-linux-owner@vger.kernel.org
Received: from comal.ext.ti.com ([198.47.26.152]:59702 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755443Ab2JVQ6R (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Oct 2012 12:58:17 -0400
From: Venkatraman S <venkat@linaro.org>
To: <kzak@redhat.com>
CC: <util-linux@vger.kernel.org>, <arnd.bergmann@linaro.org>,
        Venkatraman S <venkat@linaro.org>
Subject: [RFC PATCH 1/4] libblkid/topology: add preferred_erase_size to topology probe
Date: Mon, 22 Oct 2012 22:27:24 +0530
Message-ID: <1350925048-31084-2-git-send-email-venkat@linaro.org>
In-Reply-To: <1350925048-31084-1-git-send-email-venkat@linaro.org>
References: <1350925048-31084-1-git-send-email-venkat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add device/preferred_erase_size into sysfs params to lookup.
Add blkid_topology_get/set interface for access.

Not-yet-Signed-off-by: Venkatraman S <venkat@linaro.org>
---
 libblkid/src/topology/sysfs.c    |  1 +
 libblkid/src/topology/topology.c | 19 +++++++++++++++++++
 libblkid/src/topology/topology.h |  1 +
 3 files changed, 21 insertions(+)

diff --git a/libblkid/src/topology/sysfs.c b/libblkid/src/topology/sysfs.c
index a04b20a..e080a18 100644
--- a/libblkid/src/topology/sysfs.c
+++ b/libblkid/src/topology/sysfs.c
@@ -37,6 +37,7 @@ static struct topology_val {
 	{ "queue/minimum_io_size", blkid_topology_set_minimum_io_size },
 	{ "queue/optimal_io_size", blkid_topology_set_optimal_io_size },
 	{ "queue/physical_block_size", blkid_topology_set_physical_sector_size },
+	{ "device/preferred_erase_size", blkid_topology_set_erase_block_size },
 };
 
 static int probe_sysfs_tp(blkid_probe pr,
diff --git a/libblkid/src/topology/topology.c b/libblkid/src/topology/topology.c
index 73a397a..bae2a1e 100644
--- a/libblkid/src/topology/topology.c
+++ b/libblkid/src/topology/topology.c
@@ -67,6 +67,7 @@ struct blkid_struct_topology {
 	unsigned long	optimal_io_size;
 	unsigned long	logical_sector_size;
 	unsigned long	physical_sector_size;
+	unsigned long	erase_block_size;
 };
 
 /*
@@ -309,6 +310,14 @@ int blkid_topology_set_physical_sector_size(blkid_probe pr, unsigned long val)
 			val);
 }
 
+int blkid_topology_set_erase_block_size(blkid_probe pr, unsigned long val)
+{
+	return topology_set_value(pr,
+			"ERASE_BLOCK_SIZE",
+			offsetof(struct blkid_struct_topology, erase_block_size),
+			val);
+}
+
 /**
  * blkid_topology_get_alignment_offset:
  * @tp: topology
@@ -364,3 +373,13 @@ unsigned long blkid_topology_get_physical_sector_size(blkid_topology tp)
 	return tp ? tp->physical_sector_size : 0;
 }
 
+/**
+ * blkid_topology_get_erase_block_size
+ * @tp: topology
+ * Returns: Erase block size property of flash devices in bytes or 0.
+ */
+unsigned long blkid_topology_get_erase_block_size(blkid_topology tp)
+{
+	return tp ? tp->erase_block_size: 0;
+}
+
diff --git a/libblkid/src/topology/topology.h b/libblkid/src/topology/topology.h
index 6d2f433..7b61dec 100644
--- a/libblkid/src/topology/topology.h
+++ b/libblkid/src/topology/topology.h
@@ -7,6 +7,7 @@ extern int blkid_topology_set_alignment_offset(blkid_probe pr, int val);
 extern int blkid_topology_set_minimum_io_size(blkid_probe pr, unsigned long val);
 extern int blkid_topology_set_optimal_io_size(blkid_probe pr, unsigned long val);
 extern int blkid_topology_set_physical_sector_size(blkid_probe pr, unsigned long val);
+extern int blkid_topology_set_erase_block_size(blkid_probe pr, unsigned long val);
 
 /*
  * topology probers
-- 
1.7.11.1.25.g0e18bef

