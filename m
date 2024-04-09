Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C956FB0
	for <util-linux@vger.kernel.org>; Tue,  9 Apr 2024 08:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651714; cv=none; b=Hf0ucDQrccWwL9pWIj2fuR2aCnaZXOSFSeEqCj7MluWEPC6LVtSNPpIjV9RpngqSniFZzISJXb7I5RdxToxpy+a5wXictsPzYojblX5Hby9tux3ntcDyoSdtSVJSXqoFxvb9UGZqSxbnE1rxBo77MmlIX9HUUsFGnNqAlRSOz4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651714; c=relaxed/simple;
	bh=eSvodd9MpQToDGtlMa1zai3zwyr1PU2wcv1RdtmqGHk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GAjfgcZPqx0aAvGDTQWTn8GtkX4oeoz/TbogxrOeY2h954ZFuYNNsHNFb7F2K+lkcI+K/nlMb4x3L1+CbGcyeggQB/FY6CIu+s5Vnbvg1J3xXnzqQMiqljgZozy5egtoSPo7lTrnuosFLHy4b7PRW7M9+AhyDqcy+9D/7+/uTf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=iN6I7z2o; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="iN6I7z2o"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=0i8FlvB6nIXcx/h4yMKhchFmiOEBL5W+u32gUZBejYQ=; b=iN6I7z2ofuFUv4zrwMczI0hzLG
	BfeeOgt1PoHPr72jk/vCUp5VZPCR3JhiDuHg6OJWh66YrTz6AWK2f53kdbQ2u59JPAtkv4A27d6LP
	w72oUTDuNjgxQEeqwhOO9ixNv/Xrjl/GpRIqVPnOxZZCtFO0zMbAIASk7bshYs1NE7zfIRpBFyfuB
	1N7mo0U1+w2+UkUAbVXxGoEdr8Hf+j/PnBuib0kTSvhIxxVEUACdtcqTkISfo0uza8G+u4uKbnf4L
	MnrESNQocRSeheapvZxUlMtaKzmzxcKnV3opY/evULWEX3qvV3VaC8/A0a7vgri4VP7yIz0XC/Ntn
	ymBjWZfw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1ru6wZ-00HXN4-87; Tue, 09 Apr 2024 08:35:03 +0000
From: Chris Hofstaedtler <zeha@debian.org>
To: util-linux@vger.kernel.org
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Chris Hofstaedtler <zeha@debian.org>
Subject: [PATCH] audit-arch.h: add defines for m68k, sh
Date: Tue,  9 Apr 2024 10:34:59 +0200
Message-Id: <20240409083459.346888-1-zeha@debian.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Debian-User: zeha

John Paul Adrian Glaubitz points out that libseccomp needs to release 2.6.0,
too.

Signed-off-by: Chris Hofstaedtler <zeha@debian.org>
---
 include/audit-arch.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/audit-arch.h b/include/audit-arch.h
index ade182417..9afc663cd 100644
--- a/include/audit-arch.h
+++ b/include/audit-arch.h
@@ -35,6 +35,8 @@
 #    endif
 #elif __powerpc__
 #    define SECCOMP_ARCH_NATIVE AUDIT_ARCH_PPC
+#elif __m68k__
+#    define SECCOMP_ARCH_NATIVE AUDIT_ARCH_M68K
 #elif __mips__
 #    if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
 # 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_MIPS
@@ -47,6 +49,12 @@
 #    else
 # 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_ARCV2
 #    endif
+#elif __sh__
+#    if __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+# 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_SH
+#    else
+# 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_SHEL
+#    endif
 #elif __sparc__
 #    if __SIZEOF_POINTER__ == 4
 # 	 define SECCOMP_ARCH_NATIVE AUDIT_ARCH_SPARC
-- 
2.39.2

