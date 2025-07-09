Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE92270ECD
	for <util-linux@vger.kernel.org>; Wed,  9 Jul 2025 09:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052076; cv=none; b=YvGShQDRbqLMSo7jxDbAdWMsPEOH95I8CZP3fWotlj0mjfjqmgBaD6Z/hmunn4yx+dPXSok2RM2R+U+Lj7upYZ9mUKUjzFfcpt5E52elSL2P79NG5hjmSBmriQCaa8l2CrEm1XSj2Tj2yLu0NDWcXkYIw5nNRV0NeE28SSVA0N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052076; c=relaxed/simple;
	bh=Y64rueePlydz2m9ruVKk9Ze6jsWWh0OfAPdJ+vXSnEU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JocrVUejuI/HuASR0TsSZSjBulYLVqqSk7UHcO6xEDD6fLc1O9Z39mafKb4T7BuyiVpuFYfop+0HU6+klMxLMpupHpV+e8agO8UlkslvsuvrZskiDw61c5YCF5IDZpmm5F29tOGsCxo17J2XqyPt50vjj/ysiv0TPlVD3ZrAmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=Pz5jUjLe; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="Pz5jUjLe"
X-KPN-MessageId: 607abffd-5ca4-11f0-bc2f-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 607abffd-5ca4-11f0-bc2f-005056ab378f;
	Wed, 09 Jul 2025 11:09:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=SipNEnLEiQpR2djx08Ew4PW5jxZ8Q/tzhL1wrC4INoU=;
	b=Pz5jUjLeAP8iC7NNvgpVly61iy65oG9QghJdz5kRW9v8OewZDisc4D84swwff81vbe7qA9plIZtcn
	 apUzKsr8VPDzjQuodpXI6ua8dz/1qeISbCJqVYS/lQcge4am9yS/ebMDys3dka/848XZc3i4Zv+b+t
	 UO0UYmPSCvZ0P/CE=
X-KPN-MID: 33|Iid228HIjZJnhl5faBnPxJy/W/ghzrM8Lu/EYAQqZzTtwkGpapmo7JDsjFcpHx4
 EWVK+73q5WX4SrDg10nyfcw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|9pf2oXPQRtP8oweYEng409bynO1qdOkhIN2uJLi3Lz2DAql5UgtFsdJvzZ3pmkB
 idCF6Ihtw/TxoxL5U9JcnUQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 2df4d948-5ca4-11f0-85b8-005056ab7584;
	Wed, 09 Jul 2025 11:07:46 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] textual: harmonize the messages for an invalid size, length, and offset
Date: Wed,  9 Jul 2025 11:07:33 +0200
Message-ID: <20250709090734.18263-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.2
In-Reply-To: <20250709090734.18263-1-bensberg@telfort.nl>
References: <20250709090734.18263-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The added words "argument" or "value" or "specified" don't make things
clearer and are just unneeded verbosity.  Also, use all lowercase.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/addpart.c    | 2 +-
 disk-utils/mkswap.c     | 4 ++--
 disk-utils/resizepart.c | 2 +-
 misc-utils/blkid.c      | 4 ++--
 misc-utils/fadvise.c    | 4 ++--
 misc-utils/lsclocks.c   | 2 +-
 misc-utils/pipesz.c     | 2 +-
 misc-utils/wipefs.c     | 2 +-
 sys-utils/fallocate.c   | 6 +++---
 9 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/disk-utils/addpart.c b/disk-utils/addpart.c
index 6bdb33662..5f45bbc3a 100644
--- a/disk-utils/addpart.c
+++ b/disk-utils/addpart.c
@@ -69,7 +69,7 @@ int main(int argc, char **argv)
 	if (partx_add_partition(fd,
 			strtou32_or_err(argv[2], _("invalid partition number argument")),
 			strtou64_or_err(argv[3], _("invalid start argument")),
-			strtou64_or_err(argv[4], _("invalid length argument"))))
+			strtou64_or_err(argv[4], _("invalid length"))))
 		err(EXIT_FAILURE, _("failed to add partition"));
 
 	return EXIT_SUCCESS;
diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index 609ecadd0..3cb7a043b 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -641,10 +641,10 @@ int main(int argc, char **argv)
 			break;
 		case 'o':
 			ctl.offset = str2unum_or_err(optarg,
-					10, _("Invalid offset"), SINT_MAX(off_t));
+					10, _("invalid offset"), SINT_MAX(off_t));
 			break;
 		case 's':
-			ctl.filesz = strtosize_or_err(optarg, _("Invalid size"));
+			ctl.filesz = strtosize_or_err(optarg, _("invalid size"));
 			break;
 		case 'F':
 			ctl.file = 1;
diff --git a/disk-utils/resizepart.c b/disk-utils/resizepart.c
index e29021b37..798dd3079 100644
--- a/disk-utils/resizepart.c
+++ b/disk-utils/resizepart.c
@@ -118,7 +118,7 @@ int main(int argc, char **argv)
 				wholedisk, argv[2]);
 
 	if (partx_resize_partition(fd, partno, start,
-			strtou64_or_err(argv[3], _("invalid length argument"))))
+			strtou64_or_err(argv[3], _("invalid length"))))
 		err(EXIT_FAILURE, _("failed to resize partition"));
 
 	if (close_fd(fd) != 0)
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 63e61b5fa..3960b0d97 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -813,7 +813,7 @@ int main(int argc, char **argv)
 				errx(BLKID_EXIT_OTHER, _("unsupported output format %s"), optarg);
 			break;
 		case 'O':
-			ctl.offset = strtosize_or_err(optarg, _("invalid offset argument"));
+			ctl.offset = strtosize_or_err(optarg, _("invalid offset"));
 			break;
 		case 'p':
 			ctl.lowprobe_superblocks = 1;
@@ -826,7 +826,7 @@ int main(int argc, char **argv)
 			ctl.show[numtag++] = optarg;
 			break;
 		case 'S':
-			ctl.size = strtosize_or_err(optarg, _("invalid size argument"));
+			ctl.size = strtosize_or_err(optarg, _("invalid size"));
 			break;
 		case 't':
 			if (search_type) {
diff --git a/misc-utils/fadvise.c b/misc-utils/fadvise.c
index abbc3a62d..da7fc691a 100644
--- a/misc-utils/fadvise.c
+++ b/misc-utils/fadvise.c
@@ -111,11 +111,11 @@ int main(int argc, char ** argv)
 			break;
 		case 'l':
 			len = strtosize_or_err(optarg,
-					       _("invalid length argument"));
+					       _("invalid length"));
 			break;
 		case 'o':
 			offset = strtosize_or_err(optarg,
-						  _("invalid offset argument"));
+						  _("invalid offset"));
 			break;
 		case 'V':
 			print_version(EXIT_SUCCESS);
diff --git a/misc-utils/lsclocks.c b/misc-utils/lsclocks.c
index 435894182..3fdec7ef2 100644
--- a/misc-utils/lsclocks.c
+++ b/misc-utils/lsclocks.c
@@ -266,7 +266,7 @@ static int64_t get_namespace_offset(const char *name)
 		space = strchr(line, ' ');
 		if (space)
 			*space = '\0';
-		ret = strtos64_or_err(line, _("Invalid offset"));
+		ret = strtos64_or_err(line, _("invalid offset"));
 		break;
 	}
 
diff --git a/misc-utils/pipesz.c b/misc-utils/pipesz.c
index 0d1a2fc92..8a3da8612 100644
--- a/misc-utils/pipesz.c
+++ b/misc-utils/pipesz.c
@@ -269,7 +269,7 @@ int main(int argc, char **argv)
 			opt_quiet = TRUE;
 			break;
 		case 's':
-			sz = strtosize_or_err(optarg, _("invalid size argument"));
+			sz = strtosize_or_err(optarg, _("invalid size"));
 			opt_size = sz >= INT_MAX ? INT_MAX : (int)sz;
 			++n_opt_size;
 			break;
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index a215088a4..b712ce700 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -737,7 +737,7 @@ main(int argc, char **argv)
 			break;
 		case 'o':
 			add_offset(&ctl.offsets, strtosize_or_err(optarg,
-					 _("invalid offset argument")));
+						 _("invalid offset")));
 			break;
 		case 'p':
 			ctl.parsable = 1;
diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index 7b65481cc..13bf52915 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -386,16 +386,16 @@ int main(int argc, char **argv)
 		if (length == -2LL)
 			length = 0;
 		if (length < 0)
-			errx(EXIT_FAILURE, _("invalid length value specified"));
+			errx(EXIT_FAILURE, _("invalid length"));
 	} else {
 		/* it's safer to require the range specification (--length --offset) */
 		if (length == -2LL)
 			errx(EXIT_FAILURE, _("no length argument specified"));
 		if (length <= 0)
-			errx(EXIT_FAILURE, _("invalid length value specified"));
+			errx(EXIT_FAILURE, _("invalid length"));
 	}
 	if (offset < 0)
-		errx(EXIT_FAILURE, _("invalid offset value specified"));
+		errx(EXIT_FAILURE, _("invalid offset"));
 
 	/* O_CREAT makes sense only for the default fallocate(2) behavior
 	 * when mode is no specified and new space is allocated */
-- 
2.48.2

