Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422F319F461
	for <util-linux@vger.kernel.org>; Fri, 27 Jun 2025 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751025868; cv=none; b=M5StRzgJrgyYxloJi2xW80rMQ4oV5GqwTIPiuAAOlxcFqffTBk1pJEZuHkYuH9lp76yxoU1JHpkRL3dZHACbSnmIrXd79H5H4hmU7++tbxTJHqWc2e3er9+jJi6cbJiLecYYrQMyPC9xc91ne4jPQHXamUhkp/SSHxMN2EP+zE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751025868; c=relaxed/simple;
	bh=N8s806n3hjXOjprwbhVTl43BFgki2YJz1NbjPJwbD4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CByPS0gfW9n+ZvY5jn4tp23Sxt8l63FjFWpv5FDJJ6wWHir9cSIKk5x1j9EYuTC4/N4/zD2MbtOdEQi9jtwl7brUglGE5DNgUmYX5fNnpOGrB/iV1B1DHRbk24VhDkimzRgE1PElieqCgNdUgkA779eHmuiIZAzsdiczm3lcexk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=QiXG4qps; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="QiXG4qps"
X-KPN-MessageId: 0a57801a-534f-11f0-86d0-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0a57801a-534f-11f0-86d0-005056aba152;
	Fri, 27 Jun 2025 14:05:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=content-type:mime-version:message-id:date:subject:to:from;
	bh=+Y+JhPrc2x3lTXQJJltVQdGmDtvPvSX2wxVYhiEF2lY=;
	b=QiXG4qps1s3Ch/tdWwULE1XKCf27DVO94wrSx7o4gre8U8X05SoNpLfCgYQTin0wZIuVNBDbPatMJ
	 rRJCF5kXJgfFWOaluPUqtEaieEBj2NUH7t7QeR/nJDzcM6gHBUA2uEzbA2QxrjKgKVVE3UOG32JlMC
	 QORs4GKuFzcMHagE=
X-KPN-MID: 33|xucYTe1cuDdgtMIEolf6c/av1nYpvZNCjdmQqG2ED7RmYIrm8o1Agpx9mLacsdH
 jxP0JFMdc+eRsLetPAIR/pRv34hqqRQ8oonfj+5GEeKY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|kDdkNAjlUam26j9GS3BcVcsNa2YdpEZx28wf0zrc0m4NxYlIptQHYACg6Mr9ZoY
 xAINz4eR7RdZ/PlN4zgtMcg==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id dc94c4ff-534e-11f0-9c24-005056ab1411;
	Fri, 27 Jun 2025 14:04:22 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH 2/2] lsclocks: (man) remove stray backslash, and correct short form of --time
Date: Fri, 27 Jun 2025 14:04:08 +0200
Message-ID: <20250627120408.11036-2-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250627120408.11036-1-bensberg@telfort.nl>
References: <20250627120408.11036-1-bensberg@telfort.nl>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This fixes commits 98f4e4833c and e9ddea7912.

CC: Thomas Weißschuh <thomas@t-8ch.de>
Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 misc-utils/lsclocks.1.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/lsclocks.1.adoc b/misc-utils/lsclocks.1.adoc
index cfe984d5e..ffd3c4049 100644
--- a/misc-utils/lsclocks.1.adoc
+++ b/misc-utils/lsclocks.1.adoc
@@ -21,7 +21,7 @@ lsclocks - display system clocks
 It allows to display information like current time and resolution of clocks.
 Different kinds of clocks are supported.
 
-* POSIX clocks: *CLOCK_MONOTONIC*, *CLOCK_REALTIME*, *CLOCK_BOOTTIME*\, etc.
+* POSIX clocks: *CLOCK_MONOTONIC*, *CLOCK_REALTIME*, *CLOCK_BOOTTIME*, etc.
 * CPU clocks: *clock_getcpuclockid()*.
 * PTP clocks: */dev/ptp0*.
 * RTC clocks: */dev/rtc0*.
@@ -44,7 +44,7 @@ Output all columns.
 *-r*, *--raw*::
 Use raw output format.
 
-*-r*, *--time* _clock_::
+*-t*, *--time* _clock_::
 Show current time of one specific clock.
 
 *--no-discover-dynamic*::
-- 
2.48.1

