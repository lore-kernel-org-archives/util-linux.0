Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB9E6FBF
	for <util-linux@vger.kernel.org>; Sun,  9 Feb 2025 08:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739089591; cv=none; b=BLyQSMn2ybjlOyNYoQ/KYx4N31oZqnVBHvk7amARyJJ63o0GM0B+FflhZiv3fRYWBhm3lhNNaaINwmwL6jRXzi4i+bdkIjYe0O9b+/uAGBJhq5WHhT22aF5NI1vlkf7Pf6Yee/7/JJVhPrcUJcn8F9u6xEDXHLacgZ2+JBGCrcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739089591; c=relaxed/simple;
	bh=Ry41nW998tuimmL7XAjEILW15LmhAKsO05DLr3ajbaM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aidHfcNHZ9iHPMdEz63SOwA4tYm5ywZg7WykLXH/emSuzj9zOn1vpHwYrCKhLCCDXdeKSKpxZDFPUedClXvDfSSpmjHAwzUEZ04xeD+FQe1Nh1hvbpGMdKIYLSVItfc/N+DH75NMXAXm0nhlxfJCfa2/xEvHAaYC6OGK0Fw4aEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=cEs34ZIF; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="cEs34ZIF"
X-KPN-MessageId: cf81d61f-e6bf-11ef-aff5-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id cf81d61f-e6bf-11ef-aff5-005056abad63;
	Sun, 09 Feb 2025 09:28:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=x/MkQ/svzaco2FhN3m/TlxGUu1dt3Bh1iofd9mg7beo=;
	b=cEs34ZIFVmhrU7Pmtm0KudLeZ2Hdr1CR0rZCaGlnG67MFTQmMN9R8YtHUhSzJICzrctdubcy1GBig
	 pXQYReb5qn1xDXX95T/WEb8eAHHaChR/Awv76JWVsKGr05E4usZmv8kdqWOffwpVVIIp2A1ErXGLk1
	 SzFclCOx6Wm9BvPw=
X-KPN-MID: 33|xPLge+7zKjKls+bFXqccv48I9ZoMgagnbKGL0xILzuhk4ebXFuH64QZTqE0vK2D
 dwh+paOD6gsA2wxxQJB2VMSJWfHp3IhKJ3rY78pUdPPg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|7dIAHZ/+x/G02Zp3kMH1bsdukHMIQRxSJMXQojPbZN0T2/VtOxVpoZ32CuujqT5
 Sk+nHrrq6DU4AZCMnOOMrfw==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 8eaceb74-e6bf-11ef-8e50-005056ab7584;
	Sun, 09 Feb 2025 09:26:27 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 14/14] zramctl: improve grammar in usage and don't gettextize list of algorithms
Date: Sun,  9 Feb 2025 09:23:30 +0100
Message-ID: <20250209082330.4235-14-bensberg@telfort.nl>
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

There is no need to translate this list as they are all literal values
-- the word "and" is not needed: a comma will do.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/zramctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/zramctl.c b/sys-utils/zramctl.c
index bdc3679cf..dfe752bc4 100644
--- a/sys-utils/zramctl.c
+++ b/sys-utils/zramctl.c
@@ -599,8 +599,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(USAGE_ARGUMENTS, out);
 	fprintf(out, USAGE_ARG_SIZE(_("<size>")));
 
-	fputs(_(" <alg> specify algorithm, supported are:\n"), out);
-	fputs(_("   lzo, lz4, lz4hc, deflate, 842 and zstd\n"), out);
+	fputs(_(" <alg> is the name of an algorithm; supported are:\n"), out);
+	fputs(  "   lzo, lz4, lz4hc, deflate, 842, zstd\n", out);
 	fputs(_("   (List may be inaccurate, consult man page.)\n"), out);
 
 	fputs(USAGE_COLUMNS, out);
-- 
2.48.1

