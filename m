Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADCB20E01D
	for <util-linux@vger.kernel.org>; Mon,  3 Feb 2025 20:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738616000; cv=none; b=Nwni0Jp1YiHUMk6xFQFvDcB6yWfzskhqA51juNmqRJYYEOBPeM5beinanvfh8YIzmuJpcERW3AnDjLkAa818QY8Y2gUM0OSZwuaiJh8a40v1VrMupTVobylZG7VxVHwA8D3eLN+TCzopsYVqj1tPGhQx9G5nFJBDX+ArUxC8TOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738616000; c=relaxed/simple;
	bh=SIfux78gN0c43SUmiAsHK6xWqxyz76i19okGL7K1+60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c0UjUuEied/fqIeEWH/GQelZryT3inJHzs93ed96htoy3xsnbMFpVjGRxm4p2+juZ6hk3amOGPvpZgQWhTEOk7PObDs1ZIbl3DFdKSqCr2r7ZkYvCUShbcNFAfKJ1PznvoFSoqoNsFy7BfMJwYy9hHaQB986yerJYB0F6392RTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=jVQ60fRp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="jVQ60fRp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1738615995; bh=SIfux78gN0c43SUmiAsHK6xWqxyz76i19okGL7K1+60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jVQ60fRpo3nEYK3/KdABob4cV6QTddS7E2VWmanDH7U0mM2gOehg0XDybtOPbTNKy
	 U+U64sfhmVRuPKT0FXmh/lnnHNf2Px60Q8eEAWXVqRvxqzelSuyNJOxFNz9CERGpe+
	 LspFAm3iGq+SDimrBijW/CtbbNz/nfG799wsx/f0=
Date: Mon, 3 Feb 2025 21:53:15 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Chris Hofstaedtler <zeha@debian.org>
Cc: util-linux@vger.kernel.org, Axel <axel.scheepers76@gmail.com>, 
	1094283@bugs.debian.org
Subject: Re: Bug#1094283: util-linux: dmesg shows color when
 /etc/terminal-colors.d/disable is present (and no override in xdg locations)
Message-ID: <1bf60e39-b244-4773-89ed-c2fcdeb7d0bf@t-8ch.de>
References: <173791554931.11406.7776184826380347386.reportbug@teal.home>
 <Z5a08yD10L1J8AIa@per.namespace.at>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5a08yD10L1J8AIa@per.namespace.at>

Hi Chris,

On 2025-01-26 23:19:31+0100, Chris Hofstaedtler wrote:
> it appears commit 4bdf22803f9a41329694e0c3c82189635dccdcd0 breaks
> disabling colors using the documented mechanism of touching
> /etc/terminal-colors.d/dmesg.disable. See below for a user report.

Thanks for the report.

> On Sun, Jan 26, 2025 at 07:19:09PM +0100, Axel wrote:
> > Package: util-linux
> > Version: 2.40.4-1
> > 
> > Running dmesg after upgrading to trixie started showing color. The manpage
> > mentions creating /etc/terminal-colors.d/disable which should disable colors
> > for all. Creating the also mentioned /etc/terminal-colors.d/dmesg.disable
> > doesn't disable color output also. I had /etc/terminal-colors.d/disable
> > configured which did disable colors on -stable.
> 
> From what I can tell, the new rc = -ENOENT in colors_readdir
> introduced in 4bdf22803f9a41329694e0c3c82189635dccdcd0 bubbles up to
> colors_init:
> 
> 	int rc = colors_read_configuration(cc);  // calls colors_readdir, now returns -2
> 	if (rc)
> 		cc->mode = UL_COLORMODE_DEFAULT;
>     else {
> Evaluating color scores is skipped, effectively ignoring the
> "disable" file.
> 
> Could you please take a look?

Could you test https://github.com/util-linux/util-linux/pull/3397 ?


Thomas
