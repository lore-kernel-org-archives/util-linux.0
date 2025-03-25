Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BD11C84A7
	for <util-linux@vger.kernel.org>; Tue, 25 Mar 2025 10:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899474; cv=none; b=rmXWAclz3a+jp2nUn1Ql9j+B/lhNI49t5/MVQNAn05UufLYMHdo/FxENQH0ktWheIEcv2QusJL6rvD+vwfJPLeFlArPeIE6f+QlRZCUuHlVwdWIbffCYxYE1v4FF1h1QI7EA3w8Mo+9ppEBhlDwIExPju6xeNpGTgnK/oAz4FfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899474; c=relaxed/simple;
	bh=xhP0Tj9aSFXkjlIk/E9eNsgWxwVi4p0NzCg/weK99mM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DrfaRk0Rj5jTe8jtAecTedOHjHZKff5QFsy6XcQuvXNIB89/sGZHAJgrFFxHS5Zhvci53+D88iW/FWL3r/he23ubDPXTAGbPKYUY5SXhFY/vb9bZ6eA2IB4JxcS0xmUNJEEY49tKpXBp3HugOWusFcaosxlIK7CUQB9j/7NUHC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=fgLPVfwG; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="fgLPVfwG"
X-KPN-MessageId: 31640c4e-0966-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 31640c4e-0966-11f0-86cb-005056aba152;
	Tue, 25 Mar 2025 11:44:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=EISgPavhEqs32zzZrbsZjI2Gl91vQ7SaGBfMdAU1H80=;
	b=fgLPVfwGnQ4wjzgLJjoX/i1716xfMQcA+cKeK69D4FKpCrTHmEpkxpH21GgF4ay91DAyZdib2C3ln
	 zealzDM8TrHbOYyvldwECmsigDoxksYU5ga0GPzdcwtSW7Z9tJDLiAIsfZLnaHN1IlExGfqJ4ETzE1
	 OwM0ZhesqFDSlets=
X-KPN-MID: 33|FZrEcNwegqOQItC9HfbJ4e5JF+IQbs65BmJ6ehA7U/D0odJIcvxBQSx50WtdAFv
 1/4YFhjj3QREWzlolktH4mduK8AcyCEFknEh9PenmBzw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Z1Y0g7SxBxOCBMCv4rSuCG9gQwLwspPAMGES762v1NtT9tPrXn3TN4zrMoeM3i2
 VGTuapahLA6bf6uKR6JtXaw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 221b857b-0966-11f0-9bed-005056ab7447;
	Tue, 25 Mar 2025 11:44:31 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 10/11] mkfs.cramfs: (man) mark arguments of -N and -l in bold, not italics
Date: Tue, 25 Mar 2025 11:43:04 +0100
Message-ID: <20250325104305.23980-10-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325104305.23980-1-bensberg@telfort.nl>
References: <20250325104305.23980-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Those possible arguments are literal values, not placeholder words.

Also, improve the description of option -l.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 disk-utils/mkfs.cramfs.8.adoc | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/disk-utils/mkfs.cramfs.8.adoc b/disk-utils/mkfs.cramfs.8.adoc
index 56e5065b9..5c6b1f971 100644
--- a/disk-utils/mkfs.cramfs.8.adoc
+++ b/disk-utils/mkfs.cramfs.8.adoc
@@ -44,8 +44,8 @@ Use defined block size, which has to be divisible by page size.
 *-e* _edition_::
 Use defined file system edition number in superblock.
 
-*-N* _big, little, host_::
-Use defined endianness. Value defaults to _host_.
+*-N* *big*|*little*|*host*::
+Use the specified endianness. The default is *host*.
 
 *-i* _file_::
 Insert a _file_ to cramfs file system.
@@ -63,12 +63,12 @@ This option is ignored. Originally the *-s* turned on directory entry sorting.
 Make explicit holes.
 
 *-l*[**=**_mode_]::
- Use exclusive BSD lock for device or file it operates.  The optional argument
- _mode_ can be _yes_, _no_ (or 1 and 0) or _nonblock_.  If the _mode_
- argument is omitted, it defaults to _"yes"_.  This option overwrites
- environment variable *$LOCK_BLOCK_DEVICE*.  The default is not to use any
- lock at all, but it's recommended to avoid collisions with udevd or other
- tools.
+Use an exclusive BSD lock for the device or file that is operated upon.
+The optional argument _mode_ can be *yes* (*1*), *no* (*0*), or *nonblock*.
+If the _mode_ argument is omitted, it defaults to *yes*.
+This option overrides the environment variable *$LOCK_BLOCK_DEVICE*.
+The default is to not use any lock at all, but using a lock
+is recommended to avoid collisions with udevd or other tools.
 
 include::man-common/help-version.adoc[]
 
-- 
2.48.1

