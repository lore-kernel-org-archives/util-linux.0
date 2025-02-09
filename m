Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34536FBF
	for <util-linux@vger.kernel.org>; Sun,  9 Feb 2025 08:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739089489; cv=none; b=JqyKquj3DM+OoqjhqY7flwZ+5TR8lOxVb7SkzQ3lYNd8bW2qStn+hof6/Vy364phltgAKGeeGpptDRaoi+9mwQXcBb4Bvv0qZWqdEey8L/2Vml6pKmDT2Nw59tco6ra2acowD8TsGDWbn/e0o/UeWCWHW3qpEDC8uklUsKorfkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739089489; c=relaxed/simple;
	bh=a9zJc4oNGQ7Djnfo8yTN7p6i1nlQRTs0fR22TC8T5h4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jqlWA25XGfAccf7ogMnxguK2hKootUDgcWxhuTS+8N70UR/5An9KnTV4L5716+5tEvRmqS+b3UhAjRIuoTXYfglkSLK26K9jcNYSQIEGDJ47JMyrW/Vq7hV7kLsgcjCpYdQRCSipe2wzKgQc95YJnWneDpCd97+gTVQSXBv0fas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=gCuOEhCv; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="gCuOEhCv"
X-KPN-MessageId: 9f311394-e6bf-11ef-87ce-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9f311394-e6bf-11ef-87ce-005056abbe64;
	Sun, 09 Feb 2025 09:26:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=kzTLtYJ2ImSnFkrw4VCLbGdL1buZOo2hAlnjJxDhZuE=;
	b=gCuOEhCvlG2zSjz2DFsxhrnfiZfzFvGHwjbuFdky+jE+YpsfvsjpqZgTLOs8YvcL3YVRDzsht9P+X
	 ZDhTongR7AmLpPI2g23B/HHwKxudFEuR6oRykIyvJ8JTH89NU2TnPOrbds2ggAOseFGorv8WgsHiyw
	 zBK7RRxirHOnJUo8=
X-KPN-MID: 33|vIqsKp2lt5lgdQmG2awsSrg80mxln9gvBN2WJwFuvFN1QIwWBlZfWaDvSSNFF2V
 Tar5g6oni+9TcsPWxSrmeMWNIA5/ifrSLcwLkAReDmnQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|tm3oSjNqiGnGExU2odOLyqi4FRJ4Ms2hqlfU3JGQLGxzpnEOuxlyjvRnkZW1YQD
 6LI+Kzl0dcqLFZ2gnrbXsrA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 51c560eb-e6bf-11ef-8e50-005056ab7584;
	Sun, 09 Feb 2025 09:24:45 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 06/14] mount: properly mark the arguments of the 'ro' and 'rw' extended options
Date: Sun,  9 Feb 2025 09:23:22 +0100
Message-ID: <20250209082330.4235-6-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250209082330.4235-1-bensberg@telfort.nl>
References: <20250209082330.4235-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The 'fs', 'vfs', and 'recursive' are literal values, not placeholders
for something else.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/mount.8.adoc | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sys-utils/mount.8.adoc b/sys-utils/mount.8.adoc
index 1ec795056..1ee70096f 100644
--- a/sys-utils/mount.8.adoc
+++ b/sys-utils/mount.8.adoc
@@ -691,19 +691,19 @@ After this call, *mount* reads _fstab_ and merges these options with the options
 +
 remounts all already mounted vfat filesystems in read-only mode. Each of the filesystems is remounted by *mount -o remount,ro* _/dir_ semantic. This means the *mount* command reads _fstab_ or _mtab_ and merges these options with the options from the command line.
 
-*ro*[=_recursive_,_vfs_,_fs_]::
+*ro*[**=**(*recursive*|*vfs*|*fs*)]::
 Mount the filesystem read-only. The optional argument is an experimental feature supported only by
 the file-descriptor based kernel mount API and it is silently ignored for the old *mount*(2) syscall.
 +
-The _recursive_ argument forces the VFS attribute to be applied recursively.
+The *recursive* argument forces the VFS attribute to be applied recursively.
 +
-The _vfs_ and _fs_ arguments specify the layer where the read-only flag should be applied. The _fs_ specifies
-the filesystem superblock (unique filesystem instance in the kernel), and _vfs_ specifies the mount node. If no attribute is specified, then
+The *vfs* and *fs* arguments specify the layer where the read-only flag should be applied. The *fs* specifies
+the filesystem superblock (unique filesystem instance in the kernel), and *vfs* specifies the mount node. If no attribute is specified, then
 both layers are set to read-only.
 +
 For more details, please refer to the *Read-only Setting Notes* section.
 
-*rw*[=_recursive_,_vfs_,_fs_]::
+*rw*[**=**(*recursive*|*vfs*|*fs*)]::
 Mount the filesystem read-write.
 
 *sync*::
-- 
2.48.1

