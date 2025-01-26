Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB849443
	for <util-linux@vger.kernel.org>; Sun, 26 Jan 2025 22:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737929984; cv=none; b=J6Aj8oxO6tAxrr0+V2jZi0Zpzx6AgSc7h8jue+8tW9+lgQdsD6N0PbVqkMjwjOTlIUY7zU2VX9qiQP7p2P3e6acTxMIoWX7zp5dFBSkzEI3vxfhQY2W2N2otuWBPwn+K5rh8hh64ONNZmp+TyaqwfsdEuj7zmYLAbvCmvt2ApYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737929984; c=relaxed/simple;
	bh=e51wFRJCVG5c9GN16VF4aCLi3Bk1DfaSvd3B4U14WoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxSlRTvMs/zN1TUTpxX8W5aPICH1Kwxpcfptv9/r/kT7bbsX2irjaJzhfY89TGUsuUuMhByftH98Wup1Vn3eYTJM8jg5nhiRTl4anxgzgyCqT9KOBlsX0fWx/Dr7uNABm3nF+cSNJtOijycK5pGSvC/bO71srgNl5PaRPzS5OfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=EJhB9IRQ; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="EJhB9IRQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kBDpy0yggs1zWDOpimx1dhQlDCDgWgAfdQDplo8XN8Y=; b=EJhB9IRQ5ATqd/be2L04JS+XIV
	FaKzuFcFNKnGj/pG2gayiUALaRJTsQf5oFlqH8cLaLjkiDHYo+chizXuYmXR4BsDjYAOVZevxSkwf
	qfos4T4QryBLSVI5IJZRehZME4SGiO2guwN7G9YLj+Rp/VhyJAzvSdGKNBMQMshHQd0JSZPFCkw7+
	ByR6ip49P8w7YCHtJyMZHYwVHg7JJ1U4yHuSy7u6ZrEnqECvTEY4kDvPJYorngKwXKse8JDZSmOOW
	6xRLQ5wYF2f3Wp5WWF1JJHBJsDmOSnQHj2s6ML1hfsUVy+o4W84TR7SVnWgiYmn9x0mJNdKGPwXSI
	dT+8A/hg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1tcAyb-00BNUb-L0; Sun, 26 Jan 2025 22:19:33 +0000
Date: Sun, 26 Jan 2025 23:19:31 +0100
From: Chris Hofstaedtler <zeha@debian.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: util-linux@vger.kernel.org, Axel <axel.scheepers76@gmail.com>,
	1094283@bugs.debian.org
Subject: Re: Bug#1094283: util-linux: dmesg shows color when
 /etc/terminal-colors.d/disable is present (and no override in xdg locations)
Message-ID: <Z5a08yD10L1J8AIa@per.namespace.at>
References: <173791554931.11406.7776184826380347386.reportbug@teal.home>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <173791554931.11406.7776184826380347386.reportbug@teal.home>
X-Debian-User: zeha

Hello Thomas,

it appears commit 4bdf22803f9a41329694e0c3c82189635dccdcd0 breaks
disabling colors using the documented mechanism of touching
/etc/terminal-colors.d/dmesg.disable. See below for a user report.

On Sun, Jan 26, 2025 at 07:19:09PM +0100, Axel wrote:
> Package: util-linux
> Version: 2.40.4-1
> 
> Running dmesg after upgrading to trixie started showing color. The manpage
> mentions creating /etc/terminal-colors.d/disable which should disable colors
> for all. Creating the also mentioned /etc/terminal-colors.d/dmesg.disable
> doesn't disable color output also. I had /etc/terminal-colors.d/disable
> configured which did disable colors on -stable.

From what I can tell, the new rc = -ENOENT in colors_readdir
introduced in 4bdf22803f9a41329694e0c3c82189635dccdcd0 bubbles up to
colors_init:

	int rc = colors_read_configuration(cc);  // calls colors_readdir, now returns -2
	if (rc)
		cc->mode = UL_COLORMODE_DEFAULT;
    else {
Evaluating color scores is skipped, effectively ignoring the
"disable" file.

Could you please take a look?

Reverting 4bdf22803f9a41329694e0c3c82189635dccdcd0 fixes the problem
for me.

Debug output from TERMINAL_COLORS_DEBUG=0xffff ./dmesg

| 321357: termcolors:     CONF: terminal is ready (supports 256 colors)
| 321357: termcolors:     CONF: reading dir: '/root/.config/terminal-colors.d'
| 321357: termcolors:     CONF: reading dir: '/etc/terminal-colors.d'
| 321357: termcolors:     CONF: item 'dmesg.disable': score=21 [cur: 0, name(5): dmesg.disable, term(0): (null)]
| 321357: termcolors:     CONF: setting 'disable' from 0 -to-> 21
| Colors:
| 	utilname = 'dmesg'
| 	termname = 'xterm-256color'
| 	scheme file = '(null)'
| 	mode = auto
| 	has_colors = 1
| 	disabled = 0
| 	configured = 1
| 	cs configured = 0
| 
| 	score disable = 21
| 	score enable = 0
| 	score scheme = 0


After reverting 4bdf22803f9a41329694e0c3c82189635dccdcd0:

| 321318: termcolors:     CONF: terminal is ready (supports 256 colors)
| 321318: termcolors:     CONF: reading dir: '/root/.config/terminal-colors.d'
| 321318: termcolors:     CONF: reading dir: '/etc/terminal-colors.d'
| 321318: termcolors:     CONF: item 'dmesg.disable': score=21 [cur: 0, name(5): dmesg.disable, term(0): (null)]
| 321318: termcolors:     CONF: setting 'disable' from 0 -to-> 21
| Colors:
| 	utilname = 'dmesg'
| 	termname = 'xterm-256color'
| 	scheme file = '(null)'
| 	mode = never
| 	has_colors = 0
| 	disabled = 0
| 	configured = 1
| 	cs configured = 0
| 
| 	score disable = 21
| 	score enable = 0
| 	score scheme = 0


Thanks,
Chris

