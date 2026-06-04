Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7789A4014AB
	for <util-linux@vger.kernel.org>; Thu,  4 Jun 2026 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780575664; cv=none; b=Lq1DfmB/88PJoDj9mJJWZIzEoYNpg8IHCIR8ee9O/zd6rZkaj7N4XnqoAegQcJTlyTgPQIhYkaePm6BPELNhmV6brtbU8qV+eqNL377UYcS5s1OnM30jngdE7dQMYlNJuaJjEQdtnCqDkBFRMPlrEisQ5j9BRmVk4Y5GFTje5G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780575664; c=relaxed/simple;
	bh=lcvHmhCdM+nw0Hqtpv4mCOcYXRqd+nYkURGXdk1IYTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tv2itmzeW05WJLdlJMiRTWsIKYXTpmVs22LcQS2KCmBGNLgcXDSKQhxb9EW6zaqDLM00L+CY1GVi6Jcb52CiOpu3NY5TJxblO3DI07vK+SYJWd1fz1CTYzP//A88kLwcUT0RtrmyWH8z0yoq49o0VU+Ycv4cri7q3y6mldzG6VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dg7dBWFZ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dg7dBWFZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=onoVMErlSQPp8cRBNwRwI81KI+nT1NBr0J61907YA4c=; b=dg7dBWFZy5CFCpLwQS6rK29Mjj
	DWLQ3JDM4rLXlwXWleOcaAKn9pt4Ac0i55JoN+3r/HIwVXJXliGFv41W1zvIRgmneNiW5Fl6Et2ly
	t/+RsV7VzORdc7Nv9zzgQg5A9888Uz0c6/OxF/n0OgsPvZlfJXt+E+RGfqkV4BFyGp19S3bw9uk1K
	TBHs/5P2g7hcdv5GCVeoH3JUC1mpWbzrB6fEhyGyXADcC7fA1vjJBQUqkugMBAg5H62qBPFx1ytx9
	p0UINKw6hjXWkW9TDd/Mmb1Dw0sBWPCqbiL1+OQXw5aOwHe30rBJWbhX8lDFU1LKlF5/WhiTu/YE4
	O455GJfw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <zeha@debian.org>)
	id 1wV74E-004VfG-1J;
	Thu, 04 Jun 2026 12:20:58 +0000
Date: Thu, 4 Jun 2026 14:20:56 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: util-linux@vger.kernel.org, 
	Johannes =?utf-8?Q?W=C3=BCller?= <johanneswueller@gmail.com>
Cc: 1138789@bugs.debian.org, debian-loongarch@lists.debian.org
Subject: [PATCH] mkswap: use 64k pages in file-existing test
Message-ID: <aiFqhPSChxTxAuZv@zeha.at>
References: <aiCHUJ8pmy_Atx2S@per.namespace.at>
 <aiCHUJ8pmy_Atx2S@per.namespace.at>
 <aiCI1IeBms90Uzy0@per.namespace.at>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <aiCI1IeBms90Uzy0@per.namespace.at>
X-Debian-User: zeha

Some systems run with kernels using page sizes other than 4K. The
file-existing test used a file of 10 pages at 4K. This would fail on
kernels with higher page sizes (here 16K) like this:

   mkswap: error: swap area needs to be at least 160 KiB

Use 10 * 64K pages, hopefully allowing all kernels with 4K, 16K, 64K
pages to pass the tests.

Noticed on Debian loong64 kernel 7.0.9+deb14-loong64, and on 
sparc64 and alpha. 

Bug: https://bugs.debian.org/1138789
Fixes: 775729884a3945a53df33e0d3ff2ba263b96b59e
Signed-off-by: Chris Hofstaedtler <zeha@debian.org>
---
  tests/ts/mkswap/mkswap | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/ts/mkswap/mkswap b/tests/ts/mkswap/mkswap
index 19111971c..fa7e6b462 100755
--- a/tests/ts/mkswap/mkswap
+++ b/tests/ts/mkswap/mkswap
@@ -105,11 +105,11 @@ ts_init_subtest file-existing
  outimg="$TS_OUTDIR/existing.img"
  rm -f "$outimg"
  
-"$TS_CMD_MKSWAP" -q -U "$UUID" -F -s $((4096 * 10)) "$outimg" \
+"$TS_CMD_MKSWAP" -q -U "$UUID" -F -s $((65536 * 10)) "$outimg" \
      >> "$TS_OUTPUT" 2>/dev/null \
      || ts_log "mkswap failed"
  
-"$TS_CMD_MKSWAP" -q -U "$UUID" -F -s $((4096 * 10)) "$outimg" \
+"$TS_CMD_MKSWAP" -q -U "$UUID" -F -s $((65536 * 10)) "$outimg" \
      >> "$TS_OUTPUT" 2>&1 \
      || ts_log "mkswap -F failed on existing file"
  
-- 
2.53.0


