Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC3DF9FE
	for <util-linux@vger.kernel.org>; Mon, 14 Apr 2025 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744624045; cv=none; b=IBAfkutedbko1RCHE3TJa+duk0pxf8E5kOAuXNgjI2qgM4ig6KOY3ZbThBCG3D+GviWPEakSy5VGRfQctdOyoQMbQIXzvPlHGeE4cS8vuFWcPyzPss92rwJtVfB6baLxEUcjsNQojpGa8cpQC65Ou5q8ruqtnZ/3rGwCXFoo/AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744624045; c=relaxed/simple;
	bh=JdvmoLzkx2q8XiQqaNrEngbTW8PHk0eOm0l/SGV12r8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VlPafhGS0NGW/JGSjFXtbePG4y0Ji9kF+LkyH54PGFyPRzGRfEeCQXW7zJFo3kdL8bBh8rDawCClwypmi8tJwg+tIBZOzLfXhIpmX6nY8NVQ2n9lWCD6oC7qYN1roaAdK8i0KzaAk3YRHz4lTfVQzAAE7C+nmyM0NWSwR1sDgYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=oSI3Yo2F; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="oSI3Yo2F"
X-KPN-MessageId: 603b7813-1915-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 603b7813-1915-11f0-86cb-005056aba152;
	Mon, 14 Apr 2025 11:46:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=jFoJlrjO7kBAQtI8FtG2WR/QSP8S2lCwEtNS2YU/ojY=;
	b=oSI3Yo2Fb3WfYOjO7SHnTpd3dVvXYhds3z4XSdaEvaXsbFt5Vf5ATdpuTom9fyKXSh6/S7S7XESZT
	 vhbX/xTp9oD9uOoXmZIB4digGOdo9wi7x+qMa/wlvFjUyGgYtOGxveYfX7zcpT9Lt2H3pG4wMf9xzD
	 glr7hoNS2ZCbzsbo=
X-KPN-MID: 33|PD9dS9Z72gza7XZWZ3pLQIRhIg4hxaSApjdqdDHyR1WZFNV17phDiMTaBaT/FbW
 TzJ1HenjXlg2OFg8m2yBwTg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|6Lwc5cioNBi2pCqmhqUyMM7Rfs5p69FVPTCP+cui137HxlJNSs8UG2+NuDdusUO
 3ZvuriSAFWln9xurft7xARQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 4e3818db-1915-11f0-959e-005056abf0db;
	Mon, 14 Apr 2025 11:46:14 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/8] losetup,lscpu: (man) add the missing -h/--help and -V/--version options
Date: Mon, 14 Apr 2025 11:45:31 +0200
Message-ID: <20250414094534.9504-5-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250414094534.9504-1-bensberg@telfort.nl>
References: <20250414094534.9504-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three years ago, commit 2b2d317242 removed these options from these
two man pages but forgot to replace them with the relevant `include`.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/losetup.8.adoc | 2 ++
 sys-utils/lscpu.1.adoc   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/sys-utils/losetup.8.adoc b/sys-utils/losetup.8.adoc
index e22e650b8..e549ddf1a 100644
--- a/sys-utils/losetup.8.adoc
+++ b/sys-utils/losetup.8.adoc
@@ -116,6 +116,8 @@ Use the raw *--list* output format.
 *-J*, *--json*::
 Use JSON format for *--list* output.
 
+include::man-common/help-version.adoc[]
+
 == ENCRYPTION
 
 *Cryptoloop is no longer supported in favor of dm-crypt.* For more details see *cryptsetup*(8).
diff --git a/sys-utils/lscpu.1.adoc b/sys-utils/lscpu.1.adoc
index f7d9ccf0d..f86f531fd 100644
--- a/sys-utils/lscpu.1.adoc
+++ b/sys-utils/lscpu.1.adoc
@@ -95,6 +95,8 @@ The CPU logical numbers are not affected by this option.
 *--output-all*::
 Output all available columns. This option must be combined with either *--extended*, *--parse* or *--caches*.
 
+include::man-common/help-version.adoc[]
+
 == BUGS
 
 The basic overview of CPU models is based on heuristics, taking into account differences such as
-- 
2.48.1

