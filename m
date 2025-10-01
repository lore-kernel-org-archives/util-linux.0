Received: from mx0.herbolt.com (mx0.herbolt.com [5.59.97.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCCE23313E
	for <util-linux@vger.kernel.org>; Wed,  1 Oct 2025 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.59.97.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759321448; cv=none; b=hU1RGltngJtFq4Vdd9BVTQYj0OdEhC0O+O5ZsJD/omQ8+1dqGiDvPffuoWQOvir2unJL/bG3L4vgliZgtjA39feZF2lXQz5iwgLNUXHRn1gdhmgiiinZ+MOGQJRfNwMRm+C0Ymf/lE9lsFEjVPVybcCpyiFdd05qMLW+1bj6aoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759321448; c=relaxed/simple;
	bh=x5elm60N9FP1/NQVgQWzZkOJ+/pgrn6rpWJ/kJhGRSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TpITr1U5aPUIQ+L40Sg100RzU4QCrBVfF+/kzQivPGXA1Al+YZtek60WZBY2QQxFPppQ1IIgWBdpMc+QbNMH5jTcQ0J6tF4fqtsgG2pHWmvRDLPWFzNIRCDuap8qcSGoeZW3UD2OuSmYHkwrZbI6i6ZecjViZeFGAj8NRw0P9K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com; spf=pass smtp.mailfrom=herbolt.com; arc=none smtp.client-ip=5.59.97.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herbolt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbolt.com
Received: from mx0.herbolt.com (localhost [127.0.0.1])
	by mx0.herbolt.com (Postfix) with ESMTP id 4BAFF180FCC2;
	Wed, 01 Oct 2025 14:23:54 +0200 (CEST)
Received: from trufa.intra.herbolt.com.herbolt.com ([172.168.31.30])
	by mx0.herbolt.com with ESMTPSA
	id sYvrB1od3WisIwQAKEJqOA
	(envelope-from <lukas@herbolt.com>); Wed, 01 Oct 2025 14:23:54 +0200
From: Lukas Herbolt <lukas@herbolt.com>
To: kzak@redhat.com
Cc: util-linux@vger.kernel.org,
	Lukas Herbolt <lukas@herbolt.com>
Subject: [PATCH] fallocate: allow O_CREATE if mode is FALLOC_FL_WRITE_ZEROES
Date: Wed,  1 Oct 2025 13:54:50 +0200
Message-ID: <20251001115448.1646647-3-lukas@herbolt.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the new flag we can create the ZEROED allcoated files directly and not 
in the two steps. Removing FALLOC_FL_WRITE_ZEROES from the flags of not using
O_CREATE on open().

Signed-off-by: Lukas Herbolt <lukas@herbolt.com>
---
 sys-utils/fallocate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index f06009483..686e4925e 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -408,7 +408,7 @@ int main(int argc, char **argv)
 
 	/* O_CREAT makes sense only for the default fallocate(2) behavior
 	 * when mode is no specified and new space is allocated */
-	fd = open(filename, O_RDWR | (!dig && !mode ? O_CREAT : 0),
+	fd = open(filename, O_RDWR | (!dig && !(mode & ~FALLOC_FL_WRITE_ZEROES) ? O_CREAT : 0),
 		  S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP | S_IROTH | S_IWOTH);
 	if (fd < 0)
 		err(EXIT_FAILURE, _("cannot open %s"), filename);
-- 
2.51.0

