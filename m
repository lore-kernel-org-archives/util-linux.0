Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BBD26FA6F;
	Sun, 29 Mar 2026 10:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774781677; cv=none; b=aGKCH9snNUqCBe7Wll0MS0GwKUFUjMduH1f7EzRQSCHCRraA3ElQ/mPXdUnUlYJEtTWmKTIm29PjslThc9vmYDBuvcKct0xd9s7h0RRASTX/cgSfGi7r0fhNhyUpiJg7eOEUIluTzOJleENMn3iUwvTu1liixaM1ZiHzpgmI9IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774781677; c=relaxed/simple;
	bh=dT2qA6aZVfjiPPJT73pea/ktjc3HMrRRPVzTps0LIdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/zjcMuIrZWiF1xzAVtd6lEKdnvBa8Z5w5ABBv7RQt0nXap/tZrdI8unKvCmyjFat5gqEJWPqZwcX70/V72zW7ehi5D4YXYiXfC5jKDN1j9LqFz8ctG82xKQRKOvdD8HDHiGD3HoucUZ9Obi4yFiRL/aT+wgP6utrAndVVVP0o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=jRrOhFbw; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="jRrOhFbw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MfgbsFHO4daydCv5aduyJSSSj40QMps65Z/65z7W3KE=; b=jRrOhFbwlWMkujuYaeyEwPSBRF
	Sx9aq70ZzoauT/POtnzV1GLJJ02TsomcWcvHBC2Tzj7b64byzNkN1Qb/pkopY6de01pKSws4kQD5e
	fywYY9wm/drv/6zEVWfuSLdogDkqKFC8PxsVvP/cse4Pw/ql1ABgFZKrXT74l3aBsK83tlA5S8rkC
	HLACkPZVDX5+Y3iL056hrUTBhOOVVRGY9Bd2wqCTxl2RODDWY7aVtrkd8yDZ8Wv4ptXB/QHHMmEsD
	PoXugNcV7PxYkdAN7MTgn2WS/yUgBRELLLBeC4pg3kh8/LZXGW/psFsYNMG3CiQ0xjCPL/vf+me4B
	wqvZNjuw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <zeha@debian.org>)
	id 1w6nms-000crl-0t;
	Sun, 29 Mar 2026 10:54:33 +0000
Date: Sun, 29 Mar 2026 12:54:30 +0200
From: Chris Hofstaedtler <zeha@debian.org>
To: Christian Albrecht Goeschel Ndjomouo <cgoesc2@wgu.edu>
Cc: Karel Zak <kzak@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, 
	"util-linux@vger.kernel.org" <util-linux@vger.kernel.org>, Helmut Grohne <helmut@subdivi.de>
Subject: Re: unshare regression in 2.42-rc1
Message-ID: <acfvsnyxAM00mKVq@zeha.at>
References: <wid276gkq7tblvkfwc6kum4nacamstiigqjj5ux6j6zd4blz4l@jzq3sgfh6cj5>
 <ab_SfC1JDOhNmg6D@zeha.at>
 <SJ0P220MB05417CC33D6BA305A9CEE320E94AA@SJ0P220MB0541.NAMP220.PROD.OUTLOOK.COM>
 <acU7uB76HwZlBu6B@zeha.at>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <acU7uB76HwZlBu6B@zeha.at>
X-Debian-User: zeha

* Chris Hofstaedtler <zeha@debian.org> [260326 15:12]:
>I see Karel has in the meantime merged a different approach. I'll 
>recheck with 2.42-rc2.

The debvm CI tests also pass with 2.42-rc2.

Thanks!

Chris

