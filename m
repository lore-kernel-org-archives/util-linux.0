Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3A71C84AF
	for <util-linux@vger.kernel.org>; Sat, 15 Feb 2025 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739636441; cv=none; b=UKxKAY5oQ4fhrjq1TMh5cXNYfGnW7HT8tl4prggXLCPG4ag/NeGamycg39lRcBUNz6EXY80muVMHEs633R4N2Cp/tD1/ZrshTGSfS4atHBAv6Ogcxyk9CAQ+cQ4KcyMna886asZJGlvaISQWPCSBd8YUgb8nq4T+CeLS1FJrino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739636441; c=relaxed/simple;
	bh=3gUyyLwHyEsHaBH8daHnXZg1C0WuQCnEGW20zqw4E6c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yj6Zj9dsA1V+tYqhM9MwSNdm7rKbtD/Fu+A/lxdu3QBHLJgBpLl+N453k5RZeW3e+dpzXI9d2tg61LFLMUqw/9kdKtSOsTbdxk986rqwC2UTqbVYs5MKa2TVyK+EbQmIvv5bTlQrmQcrjZ3BWxwGkT970PcCKzX+oHGoQmG5HIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=DAEGWzJh; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="DAEGWzJh"
X-KPN-MessageId: ccf34b8c-ebb8-11ef-9fb2-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ccf34b8c-ebb8-11ef-9fb2-005056abad63;
	Sat, 15 Feb 2025 17:20:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=UxMQxTia5g8p0/CAIj6EapYJ8wFNywYCXQB672RndQQ=;
	b=DAEGWzJhCx6RIMivzcKkZmnmvmTLFe2zmnvhdirleR0FnQqu7vfSTqT2iXtNmJNwyd1hIXtHfYMqZ
	 UZExORLB96oWVAOYRtR3dINEyJjVoBuVALzNsj2ukLAW9PFZ9LEeCs0ctt9JaTTUk/VunTZqPq2z6n
	 Gd3CvKu9V6DSmrXM=
X-KPN-MID: 33|wu48UC2AMv3sPCQsl7G0cIpKgh1blhpcT8dNxLWMOxpZcgrTHwx3tvSquZUKJwL
 DNWGMMxoipssWeW08PUgLOwR0jXpQHHt1YFQqeFBH6yc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|6J0mQ9+dUFFKFMgC+TtlJR1KNXMY9X760PVhGE7sh6YNQq4g82rLTCg+ZSE+2Xq
 Oxw8Cc+Fjp802kVEy7k2hGQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id cb0d579a-ebb8-11ef-92ee-005056ab7447;
	Sat, 15 Feb 2025 17:20:38 +0100 (CET)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 09/10] prlimit: in man page, mark --resource as placeholder, not literal option
Date: Sat, 15 Feb 2025 17:18:42 +0100
Message-ID: <20250215161843.12053-9-bensberg@telfort.nl>
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

Also, show that --pid takes an argument, and improve its description.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/prlimit.1.adoc | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sys-utils/prlimit.1.adoc b/sys-utils/prlimit.1.adoc
index 49534cd52..4e839016d 100644
--- a/sys-utils/prlimit.1.adoc
+++ b/sys-utils/prlimit.1.adoc
@@ -18,9 +18,9 @@ prlimit - get and set process resource limits
 
 == SYNOPSIS
 
-*prlimit* [options] [*--resource*[**=**_limits_]] [*--pid* _PID_]
+*prlimit* [options] [**--**_resource_[**=**_limits_]] [*--pid* _PID_]
 
-*prlimit* [options] [*--resource*[**=**_limits_]] _command_ [_argument_...]
+*prlimit* [options] [**--**_resource_[**=**_limits_]] _command_ [_argument_...]
 
 == DESCRIPTION
 
@@ -46,8 +46,9 @@ Do not print a header line.
 *-o*, *--output* _list_::
 Define the output columns to use. If no output arrangement is specified, then a default set is used. Use *--help* to get a list of all supported columns.
 
-*-p*, *--pid*::
-Specify the process id; if none is given, the running process will be used.
+*-p*, *--pid* _PID_::
+Specify the process ID.  Without this option (and without a _command_),
+the running process will be used.
 
 *--raw*::
 Use the raw output format.
-- 
2.48.1

