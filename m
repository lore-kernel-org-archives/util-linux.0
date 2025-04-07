Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3498E1F892E
	for <util-linux@vger.kernel.org>; Mon,  7 Apr 2025 15:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744038982; cv=none; b=scmyc6PKbkZ5hk4hlA2Qvq1MSsBig4zrZRNu7VbIOoXHfOO+QbGDzwBkNkeS7bGh4lWoOLtQzvlJrhs3HLh108WzI9nec+JSMu71rlKI5gQ93h7dTLeoY+kS5CaMHB9rgDbgyT79MRZwEpu4efPeS6Tpy05E3/qATNZ8HbLp89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744038982; c=relaxed/simple;
	bh=rCzAsiOwuBjtigFeVqQmCNFFKqPYydxPymv3jPQr7uw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HFObebpEVtjlr7iKIFfZ6S75EGU6+5LlmAtXdUUuOU2fRIV8ooBl9k6uSq6/iUHZaDDhIo6YT4BAO37jTSoOnzCeEluVwPYP9Il5yI3sK0uhFnhsRsSUNPw76Tf98e6h7nxTBjEFnWoXtO5K+L3VC2DgT9rKu5AwV9c+xfk23zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl; spf=pass smtp.mailfrom=telfort.nl; dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b=ayAhXHH0; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telfort.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telfort.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=telfort.nl header.i=@telfort.nl header.b="ayAhXHH0"
X-KPN-MessageId: 38e7dc10-13c3-11f0-b9a0-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 38e7dc10-13c3-11f0-b9a0-005056abbe64;
	Mon, 07 Apr 2025 17:16:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=telfort.nl; s=telfort01;
	h=mime-version:message-id:date:subject:to:from;
	bh=0aOv98u6+wpzGFWpGHt/lCCth153mvID+/g4F9IojPk=;
	b=ayAhXHH0iLDQ0vMM56o8f2W7/k/9SI5/HKgHGi8IYCsyTWSjK9HF6KK5Bqm50+Eo9j+ZmvdrBGSif
	 NXUTgzaJ+pZhfmmT1/5n/JvfdiySWZH3U2o683IPSWrWZhAHISSVBEbOPlil1FxqWkLPOtMPer+pzF
	 zoT4TtgJkLcsyiIY=
X-KPN-MID: 33|1UI/JlsmqmwiK7wMfCfBzhqu9WFBxsToIF25ZerJQu4jaS7MGA07Wu0lTCsvMy3
 4Wn35DU+ZU6SuuHKeCIlGtgUm/lwkTBC0dRHsGMxNx6Y=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Rl92V5mtaNP2aPH1+XezViNxhmTLhZrpRRo3rnpQ5y4Gt/wFYilrMV9nDcXiP9L
 wtovkQM5lKxkzawdYulDuGQ==
Received: from localhost (77-163-176-192.fixed.kpn.net [77.163.176.192])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id 18f318b0-13c3-11f0-852c-005056ab7584;
	Mon, 07 Apr 2025 17:15:10 +0200 (CEST)
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/8] setarch: (man) remove a synopsis line that mistakenly mentions `arch`
Date: Mon,  7 Apr 2025 17:14:32 +0200
Message-ID: <20250407151503.23394-1-bensberg@telfort.nl>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bug existed since commit 0554182555 from seven years ago.

Also, correct the markup for --show and --pid, improve the wording,
and reduce redundancy by reshuffling the --pid option.

Signed-off-by: Benno Schulenberg <bensberg@telfort.nl>
---
 sys-utils/setarch.8.adoc | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/sys-utils/setarch.8.adoc b/sys-utils/setarch.8.adoc
index 1d8c390b3..7ad710dff 100644
--- a/sys-utils/setarch.8.adoc
+++ b/sys-utils/setarch.8.adoc
@@ -16,8 +16,6 @@ setarch - change reported architecture in new program environment and/or set per
 
 *setarch* *--list*|*-h*|*-V*
 
-*arch* [options] [_program_ [_argument_...]]
-
 == DESCRIPTION
 
 *setarch* modifies execution domains and process personality flags.
@@ -31,28 +29,26 @@ Since version 2.33 the _arch_ command line argument is optional and *setarch* ma
 *--list*::
 List the architectures that *setarch* knows about. Whether *setarch* can actually set each of these architectures depends on the running kernel.
 
-*--show[=personality]*::
+*--show*[**=**_personality_]::
 Show the currently active personality and flags.
-If the *personality* argument is provided, it is shown instead of the current one.
-*personality* is a hexadecimal number with values was described in *sys/personality.h*.
-+
-If *--pid=pid* option is provided, show them of the specifies process.
+If the _personality_ argument is provided, that personality is shown instead of the current one.
+_personality_ is a hexadecimal number whose possible values are described in *sys/personality.h*.
+
+*-p*, **--pid=**_pid_::
+When used with *--show*, show the personality and flags of the specified process.
 
 *--uname-2.6*::
-Causes the _program_ to see a kernel version number beginning with 2.6. Turns on *UNAME26*.
+Causes the specified _program_ to see a kernel version number beginning with 2.6. Turns on *UNAME26*.
 
 *-v*, *--verbose*::
 Be verbose.
 
 *-3*, *--3gb*::
-Specifies _program_ should use a maximum of 3GB of address space. Supported on x86. Turns on *ADDR_LIMIT_3GB*.
+The specified _program_ should use a maximum of 3GB of address space. Supported on x86. Turns on *ADDR_LIMIT_3GB*.
 
 *--4gb*::
 This option has no effect. It is retained for backward compatibility only, and may be removed in future releases.
 
-*-p*, *--pid=pid*::
-With *--show* option, show the currently active personality and flags of the specifies process.
-
 *-B*, *--32bit*::
 Limit the address space to 32 bits to emulate hardware. Supported on ARM and Alpha. Turns on *ADDR_LIMIT_32BIT*.
 
@@ -82,7 +78,7 @@ SVr4 bug emulation that will set *mmap*(2) page zero as read-only. Use when _pro
 
 include::man-common/help-version.adoc[]
 
-== EXAMPLE
+== EXAMPLES
 
 ....
 setarch --addr-no-randomize mytestprog
-- 
2.48.1

