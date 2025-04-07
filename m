Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088371F78E4
	for <util-linux@vger.kernel.org>; Mon,  7 Apr 2025 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038949; cv=none; b=VRfvOapwFaq+9+I33w76eW+X6F+ApZy4RY7TYvboYGNWO3hZ4oIqtCGxsmf1G1BFVk5n2isZZNr0BBt5AeUeD/F9x6ymtVBX7uhcMyqcMM1H5UEIq/d1xsBF0/nkl4hqKrUkMX5hg9iHyoovj9VKIyL2lFNpiqOSYhN0ktGyyLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038949; c=relaxed/simple;
	bh=IMt/rNvRBBHAskK5D9WKtorK5bM6JmBrHHAkuUg4738=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p/vMfvmkQyfrvrbZ82zWwHvp2cuve2T8JznELjAuJgkmlVQgtxl/l6AfwXMKrJ1BaVcLauGgfvAm5+G1YxwMz9rcLsaztv97XujBIF2FnOvvfp6DBLsdBaFADuqAWjGd0ldFHSzzH9Xs36tdI1quBAnHCtzreZjneFKV9cPPIsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=llvnTHEE; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="llvnTHEE"
X-KPN-MessageId: 42032d7c-13c3-11f0-86cb-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 42032d7c-13c3-11f0-86cb-005056aba152;
	Mon, 07 Apr 2025 17:16:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=57DYTM5dLID/zo/ZeI5llFF7solPcM0hXc+xyUZK/G8=;
	b=llvnTHEEpActmX9RLubiczG06oaz99CKjn1M9sINYeYxYg/I8vqmUzW6OUrxH4CfCtVZr9FDUGb3u
	 CMswNcyE7nj8J3RakDGV8YL9TZ+L5jzad4tQOqu6K3FBdvYJYf2TgRPaZRZMGg4Jzair4cej56d+nJ
	 mVriqdvXphyPZSU4=
X-KPN-MID: 33|JyBFXDHpHMSVajfVSl5Sn3HZCL/hVEt5Qe2FUc6ayhgOvlPJ8fzb0psjM5AKXhE
 4DosiwZcwDySbiGJ5A+zRJXlQCb+reh1F/uYXqWM25SM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|K69aJaClVvyo5mXUBvz3KJ/TC20k/WaIqrrxg7UUNdK7BmvtXggHO7OrimEdfbd
 /QuwAQdXjFaJSkQqade1rVg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 2d09e0eb-13c3-11f0-852c-005056ab7584;
	Mon, 07 Apr 2025 17:15:44 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/8] eject: (man) add the missing SYNOPSIS header
Date: Mon,  7 Apr 2025 17:14:36 +0200
Message-ID: <20250407151503.23394-5-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250407151503.23394-1-bensberg@telfort.nl>
References: <20250407151503.23394-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/eject.1.adoc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sys-utils/eject.1.adoc b/sys-utils/eject.1.adoc
index 52988601d..1ee3b2137 100644
--- a/sys-utils/eject.1.adoc
+++ b/sys-utils/eject.1.adoc
@@ -18,6 +18,8 @@ for conditions under which this file may be redistributed.
 
 eject - eject removable media
 
+== SYNOPSIS
+
 *eject* [options] _device_|_mountpoint_
 
 == DESCRIPTION
-- 
2.48.1

