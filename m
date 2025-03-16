Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAFA42A8B
	for <util-linux@vger.kernel.org>; Sun, 16 Mar 2025 15:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742138480; cv=none; b=O9TY3tlM+BnOGZJyy8+nveFbr2tQtwd0/WXn9/DXukZDa+9VuxBS0gM+xRB/EnXo45tgID/BBvPttcP1EfRLaZQC4tNaZ5wX9qtWaLjRlwBZ3vvzna5IRmXokii1eVeybEQlOTbgE8AMaTcIOklsqfWMQ0uaH0q81MejEthhM4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742138480; c=relaxed/simple;
	bh=UwQe2UY8j3SYMJ3vY8+ydWZ111AkBm3mMlQCW4806Ys=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDGcIuvDZXo//Zqa5I3oaWyafuS1vrSskTaGMeZcXSzprFkPt00VMMp/IBUygYsk5jLrVOlosDyuXVzlxpq2yMIFfcGmhljVIh3pE+qwOE2J8FdKp7X6XkyefXtErfFFZMuIV2iS34mnjsqZDodeORkp0ilIHhsVmRay76df0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=MNgMtohZ; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="MNgMtohZ"
X-KPN-MessageId: 52a43dac-027a-11f0-86c9-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 52a43dac-027a-11f0-86c9-005056aba152;
	Sun, 16 Mar 2025 16:21:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=H1FiylttNp/MQdoEvMmEik3fJKSlzXGCVg0jGJCyAK8=;
	b=MNgMtohZM9IYu2RtpGTq/6814QbWmAtq1KOrM1gQSa6agjblZOmtCHG9RZ1blkhsfhjdDDNF4Dm5t
	 pkM+k1e1pxyNQHzeEPjNM6KSnQzkJ+03IBMZO09EJjWquTcZ2rpYSFYXmtNHGfBh1ka7QmR6uPjQaL
	 fDNhRZJoUBkD3u1E=
X-KPN-MID: 33|SXEilE+32aK6A2sWJo+r5G9EOccv9B1ZG7kA2yq6s4fcgHdxjlFKb+2jocMbdy6
 F/cgNexaAbGO03VK8ktGm2rR36dSoEa0Bb+Lpdu1hSzk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|JrIPhgNgwjtx4QfsZ1VALRU1meuG27pJhcELJmImDW77GY4zhpVyS3/TIUsuvJ8
 odZy5qG4YBVbU+EFLXQU2OA==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 483eb42b-027a-11f0-9be3-005056ab7447;
	Sun, 16 Mar 2025 16:21:07 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/3] more: remove a duplicate call of setlocale()
Date: Sun, 16 Mar 2025 16:20:38 +0100
Message-ID: <20250316152040.44163-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316152040.44163-1-bensberg@telfort.nl>
References: <20250316152040.44163-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 text-utils/more.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index e39fe724c..48f27f9e9 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -2094,9 +2094,8 @@ int main(int argc, char **argv)
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	close_stdout_atexit();
-	setlocale(LC_ALL, "");
 
 	/* Auto set no scroll on when binary is called page */
 	if (!(strcmp(program_invocation_short_name, "page")))
 		ctl.no_scroll++;
-- 
2.48.1

