Received: from out-93wp-a48.jellyfish.systems (out-93wp-a48.jellyfish.systems [104.207.68.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F0D4BF921
	for <util-linux@vger.kernel.org>; Wed, 16 Sep 2026 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.207.68.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789585643; cv=none; b=XPHQwixXwk6FeOgdL4C7PdYyN5cYydLuA/rI9cc3dmV2GyjcSN1NT045/15Pt78xyNCPbQZRTFwa8yJxJC2LQAwP2EDvZHIPr5x/hFIQDLIUwp0gD4+6dLPZ4Q2AS1ZFaoyN1pLnsueI6cPWnDHhbW350UlosQe1Mci5KOJnSA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789585643; c=relaxed/simple;
	bh=96srs6qiRvsenkOY1pMeYLZVDbUAnLsrWP6pFvZDOAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVohU3ezv1t2eVVrhGfaoSRULw5YhQWm9sLlqs90cHXtXJWTvH4mZaOdM9JfSlHGNJgEx2tlW+v7JyPodqfJlG9Pc1+/VjK/1E/iAZg4ZfoRQlWy7UqNhqix3Kqu6yY1XQTwahF2rMjLR61KBDqEVHyrHzbf57m/cbHPFzRC1bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=azTy9dsN; arc=none smtp.client-ip=104.207.68.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="azTy9dsN"
Received: from fedora (unknown [117.147.120.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hlQHw36xzz2x9C;
	Wed, 16 Sep 2026 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1789578335;
	bh=l5+bN0/72BuTKtCSpzRkXxbVsC21wGOOTEcAHmR2JFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azTy9dsNdCZz0EJYtqEGEGSvwL8TO261dTS2i6hwvVG5WYJFbLAwn4JS/w4ht6Gpi
	 sD7ip1XdZag7md8PurrxAxTR2zKTCyTI4uz5JRUt0LBCkbEaYzVz2wphhkTBLEDmb7
	 6YBF59bQcwtyuEmDmYCdGBshLw1d1kkf3n7YmQoSY2lonIklLHu3u+Z1m4zDuJIVAM
	 6HYCVu7B0a3aiQvHphPM1Rhflx/Skd2QoMq9aEDlK55TbqVsJj3LHmOttPoSpPB7bc
	 dhEuBQtH3UUNf/GlbVVUfhf+wgVKqDt3Yyr+tx3cL2Ba1WgbHvFKw1v5ztGmOPXqj7
	 EDA29izGJwoew==
From: Tianyi Chen <hi@tychen.cc>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com
Subject: [PATCH 3/3] sfdisk: update only changed partitions with -N and --append
Date: Thu, 17 Sep 2026 01:05:14 +0800
Message-ID: <20260916170514.2595842-4-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916170514.2595842-1-hi@tychen.cc>
References: <20260916170514.2595842-1-hi@tychen.cc>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

BLKRRPART fails when an unchanged partition is open, leaving the kernel
layout stale after an otherwise successful -N or --append operation.

Save the original layout and use fdisk_reread_changes() for these edits
on block devices. Keep the full reread path for table replacement and
nested labels, and preserve --no-act and --no-tell-kernel. Report
incremental update failures without skipping device synchronization and
close.

Add DOS and GPT loop-device tests that keep an unchanged partition open,
check kernel geometry after additions, resizing and moves, and cover
suppressed updates and a failed move of the open partition. Adjust
existing expected output for the absence of the full-reread message.

Fixes: https://github.com/util-linux/util-linux/issues/4634
Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 disk-utils/sfdisk.8.adoc                      |  4 +-
 disk-utils/sfdisk.c                           | 20 ++++-
 .../expected/sfdisk/dos-reduce-empty-extended |  1 -
 tests/expected/sfdisk/dos-resize              |  1 -
 .../expected/sfdisk/dos-resize-empty-extended |  1 -
 tests/expected/sfdisk/dos-resize-extended     |  1 -
 tests/expected/sfdisk/dos-resize-logical      |  1 -
 tests/expected/sfdisk/gpt-resize              |  1 -
 tests/expected/sfdisk/movedata-down           |  1 -
 tests/expected/sfdisk/movedata-non-overlay    |  1 -
 tests/expected/sfdisk/movedata-up             |  1 -
 tests/expected/sfdisk/reread-dos              | 19 +++++
 tests/expected/sfdisk/reread-gpt              | 19 +++++
 .../sfdisk/resize-dos-0-move-up-absolute      |  1 -
 .../sfdisk/resize-dos-1-move-down-absolute    |  1 -
 .../sfdisk/resize-dos-10-down-enlarge         |  1 -
 .../sfdisk/resize-dos-11-absolute-move-resize |  1 -
 .../sfdisk/resize-dos-12-reduce-midle         |  1 -
 tests/expected/sfdisk/resize-dos-13-max-last  |  1 -
 .../sfdisk/resize-dos-2-move-up-relative      |  1 -
 .../sfdisk/resize-dos-3-move-down-relative    |  1 -
 .../sfdisk/resize-dos-4-enlarge-absolute      |  1 -
 .../sfdisk/resize-dos-5-reduce-absolute       |  1 -
 .../sfdisk/resize-dos-6-enlarge-relative      |  1 -
 .../sfdisk/resize-dos-7-reduce-relative       |  1 -
 .../expected/sfdisk/resize-dos-8-enlarge-all  |  1 -
 tests/expected/sfdisk/resize-dos-9-up-preduce |  1 -
 tests/expected/sfdisk/resize-dos-unsorted     |  1 -
 .../sfdisk/resize-gpt-0-move-up-absolute      |  1 -
 .../sfdisk/resize-gpt-1-move-down-absolute    |  1 -
 .../sfdisk/resize-gpt-10-down-enlarge         |  1 -
 .../sfdisk/resize-gpt-11-absolute-move-resize |  1 -
 .../sfdisk/resize-gpt-12-reduce-midle         |  1 -
 tests/expected/sfdisk/resize-gpt-13-max-last  |  1 -
 .../sfdisk/resize-gpt-2-move-up-relative      |  1 -
 .../sfdisk/resize-gpt-3-move-down-relative    |  1 -
 .../sfdisk/resize-gpt-4-enlarge-absolute      |  1 -
 .../sfdisk/resize-gpt-5-reduce-absolute       |  1 -
 .../sfdisk/resize-gpt-6-enlarge-relative      |  1 -
 .../sfdisk/resize-gpt-7-reduce-relative       |  1 -
 .../expected/sfdisk/resize-gpt-8-enlarge-all  |  1 -
 tests/expected/sfdisk/resize-gpt-9-up-preduce |  1 -
 tests/ts/sfdisk/reread                        | 75 +++++++++++++++++++
 43 files changed, 133 insertions(+), 42 deletions(-)
 create mode 100644 tests/expected/sfdisk/reread-dos
 create mode 100644 tests/expected/sfdisk/reread-gpt
 create mode 100755 tests/ts/sfdisk/reread

diff --git a/disk-utils/sfdisk.8.adoc b/disk-utils/sfdisk.8.adoc
index 4d7c2ae7..8f39da74 100644
--- a/disk-utils/sfdisk.8.adoc
+++ b/disk-utils/sfdisk.8.adoc
@@ -188,7 +188,9 @@ Do not print device names in *--dump* output.
 Do not check through the re-read-partition-table ioctl whether the device is in use.
 
 *--no-tell-kernel*::
-Don't tell the kernel about partition changes. This option is recommended together with *--no-reread* to modify a partition on used disk. The modified partition should not be used (e.g., mounted).
+Don't tell the kernel about partition changes.
++
+Without this option, *-N* and *--append* update only changed partitions of an existing, non-nested partition table. Unchanged partitions may remain in use; use *--no-reread* to suppress the initial in-use check. The modified partition should not be used (e.g., mounted).
 
 *-O*, *--backup-file* _path_::
 Override the default backup filename. Note that the device name and offset are always appended to the filename.
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 48fee96f..7b8a75a8 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -107,6 +107,7 @@ struct sfdisk {
 
 	struct fdisk_context	*cxt;		/* libfdisk context */
 	struct fdisk_partition  *orig_pa;	/* -N <partno> before the change */
+	struct fdisk_table	*original_layout;
 
 	unsigned int verify : 1,	/* call fdisk_verify_disklabel() */
 		     quiet  : 1,	/* suppress extra messages */
@@ -261,6 +262,7 @@ static int sfdisk_deinit(struct sfdisk *sf)
 	}
 
 	fdisk_unref_context(sf->cxt);
+	fdisk_unref_table(sf->original_layout);
 	free(sf->prompt);
 
 	memset(sf, 0, sizeof(*sf));
@@ -651,7 +653,7 @@ done:
 
 static int write_changes(struct sfdisk *sf)
 {
-	int rc = 0;
+	int rc = 0, reread_rc = 0;
 
 	if (sf->noact)
 		fdisk_info(sf->cxt, _("The partition table is unchanged (--no-act)."));
@@ -670,14 +672,17 @@ static int write_changes(struct sfdisk *sf)
 			 * related to the write to the device.
 			 */
 			xusleep(250000);
-			fdisk_reread_partition_table(sf->cxt);
+			if (sf->original_layout)
+				reread_rc = fdisk_reread_changes(sf->cxt, sf->original_layout);
+			else
+				fdisk_reread_partition_table(sf->cxt);
 		}
 	}
 
 	if (!rc)
 		rc = fdisk_deassign_device(sf->cxt,
 				sf->noact || sf->notell);	/* no-sync */
-	return rc;
+	return rc ? rc : reread_rc;
 }
 
 /*
@@ -1939,6 +1944,15 @@ static int command_fdisk(struct sfdisk *sf, int argc, char **argv)
 			fputs(_(" OK\n\n"), stdout);
 	}
 
+	/* Nested labels do not describe the kernel's partition layout. */
+	if ((partno >= 0 || sf->append) && !sf->noact && !sf->notell
+	    && fdisk_has_label(sf->cxt) && !fdisk_is_regfile(sf->cxt)
+	    && !fdisk_get_parent(sf->cxt)) {
+		rc = fdisk_get_partitions(sf->cxt, &sf->original_layout);
+		if (rc)
+			errx(EXIT_FAILURE, _("failed to read partition table"));
+	}
+
 	if (fdisk_get_collision(sf->cxt))
 		follow_wipe_mode(sf);
 
diff --git a/tests/expected/sfdisk/dos-reduce-empty-extended b/tests/expected/sfdisk/dos-reduce-empty-extended
index f37cdcf3..7daef8a9 100644
--- a/tests/expected/sfdisk/dos-reduce-empty-extended
+++ b/tests/expected/sfdisk/dos-reduce-empty-extended
@@ -22,5 +22,4 @@ Device     Boot Start   End Sectors Size Id Type
 <removed>2        4096 10239    6144   3M  5 Extended
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/dos-resize b/tests/expected/sfdisk/dos-resize
index a39b940f..e02ef76f 100644
--- a/tests/expected/sfdisk/dos-resize
+++ b/tests/expected/sfdisk/dos-resize
@@ -20,5 +20,4 @@ Device     Boot Start    End Sectors Size Id Type
 <removed>1  *     2048 102399  100352  49M 82 Linux swap / Solaris
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/dos-resize-empty-extended b/tests/expected/sfdisk/dos-resize-empty-extended
index 14cecbe0..de5d1ded 100644
--- a/tests/expected/sfdisk/dos-resize-empty-extended
+++ b/tests/expected/sfdisk/dos-resize-empty-extended
@@ -22,5 +22,4 @@ Device     Boot Start    End Sectors Size Id Type
 <removed>2        4096 102399   98304  48M  5 Extended
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/dos-resize-extended b/tests/expected/sfdisk/dos-resize-extended
index 90dce82b..89d46d13 100644
--- a/tests/expected/sfdisk/dos-resize-extended
+++ b/tests/expected/sfdisk/dos-resize-extended
@@ -30,5 +30,4 @@ Device     Boot Start    End Sectors Size Id Type
 <removed>6       14336  16383    2048   1M 83 Linux
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/dos-resize-logical b/tests/expected/sfdisk/dos-resize-logical
index e3b805af..bd3b10c5 100644
--- a/tests/expected/sfdisk/dos-resize-logical
+++ b/tests/expected/sfdisk/dos-resize-logical
@@ -30,5 +30,4 @@ Device     Boot Start   End Sectors Size Id Type
 <removed>6       14336 28671   14336   7M 83 Linux
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/gpt-resize b/tests/expected/sfdisk/gpt-resize
index 6e9d2e5c..58b55317 100644
--- a/tests/expected/sfdisk/gpt-resize
+++ b/tests/expected/sfdisk/gpt-resize
@@ -20,5 +20,4 @@ Device             Start    End Sectors Size Type
 <removed>1   2048 102366  100319  49M Linux swap
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/movedata-down b/tests/expected/sfdisk/movedata-down
index af0f6e87..feaaf477 100644
--- a/tests/expected/sfdisk/movedata-down
+++ b/tests/expected/sfdisk/movedata-down
@@ -27,5 +27,4 @@ Data move:
 
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/movedata-non-overlay b/tests/expected/sfdisk/movedata-non-overlay
index 753a9c35..38dde830 100644
--- a/tests/expected/sfdisk/movedata-non-overlay
+++ b/tests/expected/sfdisk/movedata-non-overlay
@@ -27,5 +27,4 @@ Data move:
 
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/movedata-up b/tests/expected/sfdisk/movedata-up
index 9de06dbd..cae2ac4b 100644
--- a/tests/expected/sfdisk/movedata-up
+++ b/tests/expected/sfdisk/movedata-up
@@ -27,5 +27,4 @@ Data move:
 
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/reread-dos b/tests/expected/sfdisk/reread-dos
new file mode 100644
index 00000000..7857d53c
--- /dev/null
+++ b/tests/expected/sfdisk/reread-dos
@@ -0,0 +1,19 @@
+append: 0
+appended: 16384 2048
+resize: 0
+resized: 8192 6144
+move: 0
+moved: 6144 6144
+add with -N: 0
+added: 20480 2048
+no-act: 0
+unchanged on disk: 0
+no-act: 6144 6144
+no-tell-kernel: 0
+size on disk: 8192
+no-tell-kernel: 6144 6144
+unchanged: 2048 2048
+busy move: 1
+kernel update failed: 0
+start on disk: 4096
+busy: 2048 2048
diff --git a/tests/expected/sfdisk/reread-gpt b/tests/expected/sfdisk/reread-gpt
new file mode 100644
index 00000000..7857d53c
--- /dev/null
+++ b/tests/expected/sfdisk/reread-gpt
@@ -0,0 +1,19 @@
+append: 0
+appended: 16384 2048
+resize: 0
+resized: 8192 6144
+move: 0
+moved: 6144 6144
+add with -N: 0
+added: 20480 2048
+no-act: 0
+unchanged on disk: 0
+no-act: 6144 6144
+no-tell-kernel: 0
+size on disk: 8192
+no-tell-kernel: 6144 6144
+unchanged: 2048 2048
+busy move: 1
+kernel update failed: 0
+start on disk: 4096
+busy: 2048 2048
diff --git a/tests/expected/sfdisk/resize-dos-0-move-up-absolute b/tests/expected/sfdisk/resize-dos-0-move-up-absolute
index e1c069fb..b4e72516 100644
--- a/tests/expected/sfdisk/resize-dos-0-move-up-absolute
+++ b/tests/expected/sfdisk/resize-dos-0-move-up-absolute
@@ -22,5 +22,4 @@ Device     Boot Start   End Sectors Size Id Type
 <removed>1        3000 23479   20480  10M 83 Linux
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-dos-1-move-down-absolute b/tests/expected/sfdisk/resize-dos-1-move-down-absolute
index da886357..24552696 100644
--- a/tests/expected/sfdisk/resize-dos-1-move-down-absolute
+++ b/tests/expected/sfdisk/resize-dos-1-move-down-absolute
@@ -22,5 +22,4 @@ Device     Boot Start   End Sectors Size Id Type
 <removed>1        2048 22527   20480  10M 83 Linux
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-dos-10-down-enlarge b/tests/expected/sfdisk/resize-dos-10-down-enlarge
index df392d83..dfc998d9 100644
--- a/tests/expected/sfdisk/resize-dos-10-down-enlarge
+++ b/tests/expected/sfdisk/resize-dos-10-down-enlarge
@@ -22,5 +22,4 @@ Device     Boot Start    End Sectors Size Id Type
 <removed>1  *     2048 204799  202752  99M 83 Linux
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-dos-11-absolute-move-resize b/tests/expected/sfdisk/resize-dos-11-absolute-move-resize
index 43e6837b..541ee78c 100644
--- a/tests/expected/sfdisk/resize-dos-11-absolute-move-resize
+++ b/tests/expected/sfdisk/resize-dos-11-absolute-move-resize
@@ -22,5 +22,4 @@ Device     Boot Start   End Sectors Size Id Type
 <removed>1  *     2048 22527   20480  10M 83 Linux
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-dos-12-reduce-midle b/tests/expected/sfdisk/resize-dos-12-reduce-midle
index 669fd451..be0043c3 100644
--- a/tests/expected/sfdisk/resize-dos-12-reduce-midle
+++ b/tests/expected/sfdisk/resize-dos-12-reduce-midle
@@ -26,5 +26,4 @@ Device     Boot Start   End Sectors Size Id Type
 <removed>3       43008 63487   20480  10M 83 Linux
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-dos-13-max-last b/tests/expected/sfdisk/resize-dos-13-max-last
index 3664d88e..5db57ebb 100644
--- a/tests/expected/sfdisk/resize-dos-13-max-last
+++ b/tests/expected/sfdisk/resize-dos-13-max-last
@@ -26,5 +26,4 @@ Device     Boot Start    End Sectors Size Id Type
 <removed>3       32768 204799  172032  84M 83 Linux
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-dos-2-move-up-relative b/tests/expected/sfdisk/resize-dos-2-move-up-relative
index 75a95b17..86b77902 100644
--- a/tests/expected/sfdisk/resize-dos-2-move-up-relative
+++ b/tests/expected/sfdisk/resize-dos-2-move-up-relative
@@ -22,5 +22,4 @@ Device     Boot Start   End Sectors Size Id Type
 <removed>1        4096 24575   20480  10M 83 Linux
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-dos-3-move-down-relative b/tests/expected/sfdisk/resize-dos-3-move-down-relative
index b3816e0e..2cb656b5 100644
--- a/tests/expected/sfdisk/resize-dos-3-move-down-relative
+++ b/tests/expected/sfdisk/resize-dos-3-move-down-relative
@@ -22,5 +22,4 @@ Device     Boot Start   End Sectors Size Id Type
 <removed>1        2048 22527   20480  10M 83 Linux
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-dos-4-enlarge-absolute b/tests/expected/sfdisk/resize-dos-4-enlarge-absolute
index 0c18f9fb..404d66c4 100644
--- a/tests/expected/sfdisk/resize-dos-4-enlarge-absolute
+++ b/tests/expected/sfdisk/resize-dos-4-enlarge-absolute
@@ -22,5 +22,4 @@ Device     Boot Start   End Sectors Size Id Type
 <removed>1        2048 32767   30720  15M 83 Linux
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-dos-5-reduce-absolute b/tests/expected/sfdisk/resize-dos-5-reduce-absolute
index 557875d9..39f7df7f 100644
--- a/tests/expected/sfdisk/resize-dos-5-reduce-absolute
+++ b/tests/expected/sfdisk/resize-dos-5-reduce-absolute
@@ -22,5 +22,4 @@ Device     Boot Start   End Sectors Size Id Type
 <removed>1        2048 12287   10240   5M 83 Linux
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-dos-6-enlarge-relative b/tests/expected/sfdisk/resize-dos-6-enlarge-relative
index 528d025a..98f874a3 100644
--- a/tests/expected/sfdisk/resize-dos-6-enlarge-relative
+++ b/tests/expected/sfdisk/resize-dos-6-enlarge-relative
@@ -22,5 +22,4 @@ Device     Boot Start   End Sectors Size Id Type
 <removed>1        2048 32767   30720  15M 83 Linux
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-dos-7-reduce-relative b/tests/expected/sfdisk/resize-dos-7-reduce-relative
index 6a6fa0c5..725e6adc 100644
--- a/tests/expected/sfdisk/resize-dos-7-reduce-relative
+++ b/tests/expected/sfdisk/resize-dos-7-reduce-relative
@@ -22,5 +22,4 @@ Device     Boot Start   End Sectors Size Id Type
 <removed>1        2048 12287   10240   5M 83 Linux
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-dos-8-enlarge-all b/tests/expected/sfdisk/resize-dos-8-enlarge-all
index 2f6b3fb6..dc168fae 100644
--- a/tests/expected/sfdisk/resize-dos-8-enlarge-all
+++ b/tests/expected/sfdisk/resize-dos-8-enlarge-all
@@ -22,5 +22,4 @@ Device     Boot Start    End Sectors Size Id Type
 <removed>1        2048 204799  202752  99M 83 Linux
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-dos-9-up-preduce b/tests/expected/sfdisk/resize-dos-9-up-preduce
index 2ca6f3b1..c6570461 100644
--- a/tests/expected/sfdisk/resize-dos-9-up-preduce
+++ b/tests/expected/sfdisk/resize-dos-9-up-preduce
@@ -22,5 +22,4 @@ Device     Boot Start    End Sectors Size Id Type
 <removed>1       22528 204799  182272  89M 83 Linux
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-dos-unsorted b/tests/expected/sfdisk/resize-dos-unsorted
index a16c3261..6a36bdbf 100644
--- a/tests/expected/sfdisk/resize-dos-unsorted
+++ b/tests/expected/sfdisk/resize-dos-unsorted
@@ -70,5 +70,4 @@ Device     Boot  Start    End Sectors Size Id Type
 Partition table entries are not in disk order.
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-gpt-0-move-up-absolute b/tests/expected/sfdisk/resize-gpt-0-move-up-absolute
index 230841d7..1a294623 100644
--- a/tests/expected/sfdisk/resize-gpt-0-move-up-absolute
+++ b/tests/expected/sfdisk/resize-gpt-0-move-up-absolute
@@ -22,5 +22,4 @@ Device             Start   End Sectors Size Type
 <removed>1   3000 23479   20480  10M Linux filesystem
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-gpt-1-move-down-absolute b/tests/expected/sfdisk/resize-gpt-1-move-down-absolute
index de2a8718..f784cdf6 100644
--- a/tests/expected/sfdisk/resize-gpt-1-move-down-absolute
+++ b/tests/expected/sfdisk/resize-gpt-1-move-down-absolute
@@ -22,5 +22,4 @@ Device             Start   End Sectors Size Type
 <removed>1   2048 22527   20480  10M Linux filesystem
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-gpt-10-down-enlarge b/tests/expected/sfdisk/resize-gpt-10-down-enlarge
index 037d0ab2..e4ce11b6 100644
--- a/tests/expected/sfdisk/resize-gpt-10-down-enlarge
+++ b/tests/expected/sfdisk/resize-gpt-10-down-enlarge
@@ -22,5 +22,4 @@ Device             Start    End Sectors Size Type
 <removed>1   2048 204766  202719  99M Linux filesystem
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-gpt-11-absolute-move-resize b/tests/expected/sfdisk/resize-gpt-11-absolute-move-resize
index 351e8584..74bfbbed 100644
--- a/tests/expected/sfdisk/resize-gpt-11-absolute-move-resize
+++ b/tests/expected/sfdisk/resize-gpt-11-absolute-move-resize
@@ -22,5 +22,4 @@ Device             Start   End Sectors Size Type
 <removed>1   2048 22527   20480  10M Linux filesystem
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-gpt-12-reduce-midle b/tests/expected/sfdisk/resize-gpt-12-reduce-midle
index 683cedee..4909cf67 100644
--- a/tests/expected/sfdisk/resize-gpt-12-reduce-midle
+++ b/tests/expected/sfdisk/resize-gpt-12-reduce-midle
@@ -26,5 +26,4 @@ Device             Start   End Sectors Size Type
 <removed>3  43008 63487   20480  10M Linux filesystem
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-gpt-13-max-last b/tests/expected/sfdisk/resize-gpt-13-max-last
index b0483f7a..a85cf741 100644
--- a/tests/expected/sfdisk/resize-gpt-13-max-last
+++ b/tests/expected/sfdisk/resize-gpt-13-max-last
@@ -26,5 +26,4 @@ Device             Start    End Sectors Size Type
 <removed>3  32768 204766  171999  84M Linux filesystem
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-gpt-2-move-up-relative b/tests/expected/sfdisk/resize-gpt-2-move-up-relative
index 7669dab5..8ae59ef5 100644
--- a/tests/expected/sfdisk/resize-gpt-2-move-up-relative
+++ b/tests/expected/sfdisk/resize-gpt-2-move-up-relative
@@ -22,5 +22,4 @@ Device             Start   End Sectors Size Type
 <removed>1   4096 24575   20480  10M Linux filesystem
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-gpt-3-move-down-relative b/tests/expected/sfdisk/resize-gpt-3-move-down-relative
index c8aa63ac..22bca894 100644
--- a/tests/expected/sfdisk/resize-gpt-3-move-down-relative
+++ b/tests/expected/sfdisk/resize-gpt-3-move-down-relative
@@ -22,5 +22,4 @@ Device             Start   End Sectors Size Type
 <removed>1   2048 22527   20480  10M Linux filesystem
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-gpt-4-enlarge-absolute b/tests/expected/sfdisk/resize-gpt-4-enlarge-absolute
index 832e112b..6394ab5f 100644
--- a/tests/expected/sfdisk/resize-gpt-4-enlarge-absolute
+++ b/tests/expected/sfdisk/resize-gpt-4-enlarge-absolute
@@ -22,5 +22,4 @@ Device             Start   End Sectors Size Type
 <removed>1   2048 32767   30720  15M Linux filesystem
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-gpt-5-reduce-absolute b/tests/expected/sfdisk/resize-gpt-5-reduce-absolute
index b2141834..6d159db1 100644
--- a/tests/expected/sfdisk/resize-gpt-5-reduce-absolute
+++ b/tests/expected/sfdisk/resize-gpt-5-reduce-absolute
@@ -22,5 +22,4 @@ Device             Start   End Sectors Size Type
 <removed>1   2048 12287   10240   5M Linux filesystem
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-gpt-6-enlarge-relative b/tests/expected/sfdisk/resize-gpt-6-enlarge-relative
index a9090e22..c82b7130 100644
--- a/tests/expected/sfdisk/resize-gpt-6-enlarge-relative
+++ b/tests/expected/sfdisk/resize-gpt-6-enlarge-relative
@@ -22,5 +22,4 @@ Device             Start   End Sectors Size Type
 <removed>1   2048 32767   30720  15M Linux filesystem
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-gpt-7-reduce-relative b/tests/expected/sfdisk/resize-gpt-7-reduce-relative
index 7e391cda..e62e6bac 100644
--- a/tests/expected/sfdisk/resize-gpt-7-reduce-relative
+++ b/tests/expected/sfdisk/resize-gpt-7-reduce-relative
@@ -22,5 +22,4 @@ Device             Start   End Sectors Size Type
 <removed>1   2048 12287   10240   5M Linux filesystem
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-gpt-8-enlarge-all b/tests/expected/sfdisk/resize-gpt-8-enlarge-all
index d0c4c5e6..77f5b0ab 100644
--- a/tests/expected/sfdisk/resize-gpt-8-enlarge-all
+++ b/tests/expected/sfdisk/resize-gpt-8-enlarge-all
@@ -22,5 +22,4 @@ Device             Start    End Sectors Size Type
 <removed>1   2048 204766  202719  99M Linux filesystem
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/expected/sfdisk/resize-gpt-9-up-preduce b/tests/expected/sfdisk/resize-gpt-9-up-preduce
index 16d348a5..d194320a 100644
--- a/tests/expected/sfdisk/resize-gpt-9-up-preduce
+++ b/tests/expected/sfdisk/resize-gpt-9-up-preduce
@@ -22,5 +22,4 @@ Device             Start    End Sectors Size Type
 <removed>1  22528 204766  182239  89M Linux filesystem
 
 The partition table has been altered.
-Calling ioctl() to re-read partition table.
 Syncing disks.
diff --git a/tests/ts/sfdisk/reread b/tests/ts/sfdisk/reread
new file mode 100755
index 00000000..957a664f
--- /dev/null
+++ b/tests/ts/sfdisk/reread
@@ -0,0 +1,75 @@
+#!/usr/bin/env bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="incremental partition updates"
+
+. "$TS_TOPDIR"/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_SFDISK"
+ts_skip_nonroot
+ts_check_losetup
+
+export LOCK_BLOCK_DEVICE=1
+
+function kernel_partition {
+	local sysfs="/sys/class/block/${TS_LODEV##*/}p$1"
+
+	printf '%s: %s %s\n' "$2" "$(cat "$sysfs/start")" "$(cat "$sysfs/size")"
+}
+
+for label in dos gpt; do
+	ts_device_init 64 "$TS_OUTDIR/$TS_TESTNAME-$label.img"
+	printf 'label: %s\n2048,2048\n8192,4096\n' "$label" |
+		$TS_CMD_SFDISK "$TS_LODEV" &> /dev/null || ts_die "cannot create partitions"
+
+	ts_init_subtest "$label"
+	# Keep an unchanged partition open so BLKRRPART would fail with EBUSY.
+	(
+		exec 3<"${TS_LODEV}p1" || exit 1
+
+		echo '16384,2048' | $TS_CMD_SFDISK --no-reread --append "$TS_LODEV" &> /dev/null
+		echo "append: $?"
+		kernel_partition 3 appended
+
+		echo ',6144' | $TS_CMD_SFDISK --no-reread -N 2 "$TS_LODEV" &> /dev/null
+		echo "resize: $?"
+		kernel_partition 2 resized
+
+		echo '6144,6144' | $TS_CMD_SFDISK --no-reread -N 2 "$TS_LODEV" &> /dev/null
+		echo "move: $?"
+		kernel_partition 2 moved
+
+		echo '20480,2048' | $TS_CMD_SFDISK --no-reread -N 4 "$TS_LODEV" &> /dev/null
+		echo "add with -N: $?"
+		kernel_partition 4 added
+
+		$TS_CMD_SFDISK --dump "$TS_LODEV" > "$TS_OUTPUT.before"
+		echo ',8192' | $TS_CMD_SFDISK --no-reread --no-act -N 2 "$TS_LODEV" &> /dev/null
+		echo "no-act: $?"
+		$TS_CMD_SFDISK --dump "$TS_LODEV" > "$TS_OUTPUT.after"
+		cmp -s "$TS_OUTPUT.before" "$TS_OUTPUT.after"
+		echo "unchanged on disk: $?"
+		kernel_partition 2 no-act
+
+		echo ',8192' | $TS_CMD_SFDISK --no-reread --no-tell-kernel -N 2 "$TS_LODEV" &> /dev/null
+		echo "no-tell-kernel: $?"
+		$TS_CMD_SFDISK --dump "$TS_LODEV" |
+			sed -n "\|^${TS_LODEV}p2 |s/.*size= *\([0-9]*\).*/size on disk: \1/p"
+		kernel_partition 2 no-tell-kernel
+		kernel_partition 1 unchanged
+
+		# Moving the open partition must report the kernel update failure.
+		echo '4096,2048' | $TS_CMD_SFDISK --no-reread -N 1 "$TS_LODEV" &> "$TS_OUTPUT.busy"
+		echo "busy move: $?"
+		grep -q 'Failed to remove partition 1 from system' "$TS_OUTPUT.busy"
+		echo "kernel update failed: $?"
+		$TS_CMD_SFDISK --dump "$TS_LODEV" |
+			sed -n "\|^${TS_LODEV}p1 |s/.*start= *\([0-9]*\).*/start on disk: \1/p"
+		kernel_partition 1 busy
+	) >> "$TS_OUTPUT" 2>> "$TS_ERRLOG"
+	ts_finalize_subtest
+done
+
+ts_finalize
-- 
2.55.0

