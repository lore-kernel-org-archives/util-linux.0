Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F32A932;
	Sun,  1 Mar 2026 08:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772354440; cv=none; b=XrlozgNUrCaGsitugOjVRAv47OoOXAA9++RXQ1qY9gl4/hZYp2mOEmu3UkihTVHSV1g2mA21HOGsQ8C9alfTqLsjAdB4dIYzvsJb9wFy6jqE5eimqnkBgCwWSDOP2HsfLplkpdaXsH2ZISjqStNiMUuRF0bPvN2pnbri83K8+QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772354440; c=relaxed/simple;
	bh=QXC4GGpRUNa98ffrfmxlM4QdE5cMsb5xA4dsxoNHgcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jnXoQu4WSI0+uKhbB3gnX1MB3VTViezG2Ax0GX8GAonev0WvbSqU4A8Dv6YHEUYN6AjUbhBF9Pa9PntX2Ug5MgnPsZo330RNXJfkwAvzE0rjTZar61OVyttuspvlyXw+dQ7HWBGmgaUJGrE1/EA5iNayEzIF4pO0CukZ6bNKswE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Ek2T8Bcf; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Ek2T8Bcf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PFp2jwYoJiwmHoZgumraJXdJLAau7/xpL1zGznQ0p4A=; b=Ek2T8Bcf0qd2IcGD9c6aEKkby4
	MTj0F3QPFeWyISNPdDba/GT+KXGhATS+MRWMJDtbKDOZUGWeVn4aqpEK6a/KrxsrGNBubTPYoz5rV
	EmIW4IwFaXlV5yeZHkTi8GK1TdT6nnirTEYrBHgSZiPGJLLOLJXpLCuYD9BUgQm9gJsMd+9xVeHIy
	hNVaRNpTIT/FL/5aI03iSGX/pmjRM9QikrkQSHJwSYg5VYVQQ4RSBUYciXUYgBD5liS1u2oHF2ne/
	Y+b/wvZIngs2LkbhAZ25GcpvouP7gViTXSE3qF1S4zST2POzC2VlAtvXNomN7D9xdkgTRFnmZA4wH
	L03qxFDQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1vwcLm-00DVlM-Lo; Sun, 01 Mar 2026 08:40:31 +0000
Date: Sun, 1 Mar 2026 10:40:28 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: Sumanth Korikkar <sumanthk@linux.ibm.com>, 
	debian-loongarch@lists.debian.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: [ANNOUNCE] util-linux v2.42-rc1
Message-ID: <aaP6atFYpVqulTO1@zeha.at>
References: <wid276gkq7tblvkfwc6kum4nacamstiigqjj5ux6j6zd4blz4l@jzq3sgfh6cj5>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <wid276gkq7tblvkfwc6kum4nacamstiigqjj5ux6j6zd4blz4l@jzq3sgfh6cj5>
X-Debian-User: zeha

Hi Sumanth, looong64 porters,

* Karel Zak <kzak@redhat.com> [260226 14:53]:
>The util-linux release v2.42-rc1 is now available at
>  http://www.kernel.org/pub/linux/utils/util-linux/v2.42/
[..]
>lsmem:
>    - display global memmap on memory parameter (by Sumanth Korikkar)

It appears the test for this is run on looong64 and fails there (failing the
entire build), at least in the Debian build infra.
https://buildd.debian.org/status/fetch.php?pkg=util-linux&arch=loong64&ver=2.42%7Erc1-1&stamp=1772312955&raw=0

See below for log output excerpts.

Thanks,
Chris


log snippets:

================= O/E diff ===================
--- /build/reproducible-path/util-linux-2.42~rc1/tests/output/lsmem/lsmem-s390-zvm-6g	2026-02-28 21:08:31.577617951 +0000
+++ /build/reproducible-path/util-linux-2.42~rc1/tests/expected/lsmem/lsmem-s390-zvm-6g	2026-02-18 11:33:47.804188659 +0000
@@ -17,6 +17,7 @@
  Memory block size:                256M
  Total online memory:              4.8G
  Total offline memory:             1.3G
+Memmap on memory parameter:         no
  
  ---
  
@@ -27,6 +28,7 @@
  Memory block size:                256M
  Total online memory:              4.8G
  Total offline memory:             1.3G
+Memmap on memory parameter:         no
  
  ---
  
@@ -40,6 +42,7 @@
  Memory block size:                256M
  Total online memory:              4.8G
  Total offline memory:             1.3G
+Memmap on memory parameter:         no
  
  ---
  
@@ -73,6 +76,7 @@
  Memory block size:                256M
  Total online memory:              4.8G
  Total offline memory:             1.3G
+Memmap on memory parameter:         no
  
  ---
  
@@ -216,6 +220,7 @@
  Memory block size:                256M
  Total online memory:              4.8G
  Total offline memory:             1.3G
+Memmap on memory parameter:         no
  
  ---
  
@@ -237,6 +242,7 @@
  Memory block size:                256M
  Total online memory:              4.8G
  Total offline memory:             1.3G
+Memmap on memory parameter:         no
  
  ---
  
@@ -256,3 +262,4 @@
  Memory block size:                256M
  Total online memory:              4.8G
  Total offline memory:             1.3G
+Memmap on memory parameter:         no
==============================================

...

--- /build/reproducible-path/util-linux-2.42~rc1/tests/expected/lsmem/lsmem-x86_64-16g	2026-02-18 11:33:47.804978102 +0000
+++ /build/reproducible-path/util-linux-2.42~rc1/tests/output/lsmem/lsmem-x86_64-16g	2026-02-28 21:08:31.887234145 +0000
@@ -37,7 +37,6 @@
  Memory block size:                128M
  Total online memory:               16G
  Total offline memory:               0B
-Memmap on memory parameter:         no
  
  ---
  
@@ -49,7 +48,6 @@
  Memory block size:                128M
  Total online memory:               16G
  Total offline memory:               0B
-Memmap on memory parameter:         no
  
  ---
  
@@ -61,7 +59,6 @@
  Memory block size:                128M
  Total online memory:               16G
  Total offline memory:               0B
-Memmap on memory parameter:         no
  
  ---
  
@@ -199,7 +196,6 @@
  Memory block size:                128M
  Total online memory:               16G
  Total offline memory:               0B
-Memmap on memory parameter:         no
  
  ---
  
@@ -523,7 +519,6 @@
  Memory block size:                128M
  Total online memory:               16G
  Total offline memory:               0B
-Memmap on memory parameter:         no
  
  ---
  
@@ -563,7 +558,6 @@
  Memory block size:                128M
  Total online memory:               16G
  Total offline memory:               0B
-Memmap on memory parameter:         no
  
  ---
  
@@ -603,4 +597,3 @@
  Memory block size:                128M
  Total online memory:               16G
  Total offline memory:               0B
-Memmap on memory parameter:         no
}}}-diff

  FAILED (lsmem/lsmem-x86_64-16g)
========= script: /build/reproducible-path/util-linux-2.42~rc1/tests/ts/lsmem/lsmem =================

