Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E43E1624E8
	for <util-linux@vger.kernel.org>; Sat, 15 Feb 2025 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636388; cv=none; b=edj3EkEzXx4ztz+5EmNAoE1sGzwhpxfrpUXJDEvXEfH4BTE2i24fHhqVx0myeZenvGydt4MF5z3JrKbV9EnWjIXWe9korsrUnWsnLEOR3PHVQ2vfv5P7jNs+KX69LlKF2K/7WmSWhAVh1lUDb+mxXp42UG3WpDttjhFnQqq2X/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636388; c=relaxed/simple;
	bh=tLz6tua1FGoZuUH0+AyKiJk0zVn5hmNXGgvZPtTK0w4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ug3zZS9NhjJbcoSLeb6CUocWZ5naNeLq/sjAi5FD+n1t6rJqj7hDQWahoaL+i9ZX5D13HvQo3P3FDXpAmNIxDAjjvQt0FUfbuPlKl/ROHjO0CyJqEVSjByWFSk2rRQOii4V9VXh4fFBXSsfCq0H+1QwbTZiipL7c6OOoPyu0QUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=YlywDpvu; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="YlywDpvu"
X-KPN-MessageId: ab77fc78-ebb8-11ef-99cf-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ab77fc78-ebb8-11ef-99cf-005056abbe64;
	Sat, 15 Feb 2025 17:19:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=nW5njlyPWP3U2EGDXewNFJdXdn9j68HZ4Wj8BZ/jutk=;
	b=YlywDpvuz4F5G0GaQJMfn42jqZ/LFEYNp6ttgeE8Ce/jtkOby5ls5zWjLiqiKthG50VgF0P42OnkG
	 XdLwUSGA7KWGg/ScJXH+8o2nwUYa8PzqSrIa3UUscqz3Fw8Tf5zv2LTJg9uVm6GAbu1XRbc8vXhESX
	 o0YLCJiIyeppPcWk=
X-KPN-MID: 33|UqEQh2lK6OjD/2QxjzVTgjHnfooM2pGhUKIXzM1TjdX3kaNIO7kH0+MpgWp/gbQ
 VidQRJbz1Dwqc6dhmffMm3YARAHTpuVRHvZ0CPj8It/U=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|jJlA78qmjrfJ2Rd1ZhSOKfKSraWT8s4lb1gTOWAUq2eYF8AizavHrO7e7fzhXwy
 r7xDFsg4aP6+ziGsf0NA9Ng==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id ab76bb16-ebb8-11ef-92ee-005056ab7447;
	Sat, 15 Feb 2025 17:19:45 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 05/10] script: mention in usage that value for <size> may have a suffix
Date: Sat, 15 Feb 2025 17:18:38 +0100
Message-ID: <20250215161843.12053-5-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250215161843.12053-1-bensberg@telfort.nl>
References: <20250215161843.12053-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 term-utils/script.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/term-utils/script.c b/term-utils/script.c
index 78ab3f4ca..4da25fa2e 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -216,6 +216,10 @@ static void __attribute__((__noreturn__)) usage(void)
 
 	fputs(USAGE_SEPARATOR, out);
 	fprintf(out, USAGE_HELP_OPTIONS(31));
+
+	fputs(USAGE_ARGUMENTS, out);
+	fprintf(out, USAGE_ARG_SIZE(_("<size>")));
+
 	fprintf(out, USAGE_MAN_TAIL("script(1)"));
 
 	exit(EXIT_SUCCESS);
-- 
2.48.1

