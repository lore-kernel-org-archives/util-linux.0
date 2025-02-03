Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F601E7C20
	for <util-linux@vger.kernel.org>; Mon,  3 Feb 2025 21:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738616888; cv=none; b=eYR4UNTvtW4K6hja25gYvmSJUuMHfEP64qsq7GZZGmquV4X11CVGjkeZ1wHCY1gi6LPP/ss82Eb8d5MTNGDU55V6LDta0ebJZMFPeaiuYMH3OVJ3xS47cz7KNI0YcgEeuXdqKsxZlDjGGIIdHcupp3aeM8BJYZeMp+Rjx6ncW5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738616888; c=relaxed/simple;
	bh=4uROW0Oe19TDdQfNCObzEeSBw3XgeOvkB4SJ2hNjxm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEHFgIaIi0PWeDTG3rlZqRlWXj84Fx8tG/IhWf6zFG6i46vHUInft6Xc4BOxXjBm3jjnvmE7uIf6SEkRK/0D+v6rAturiOJAP/tHIDmPoLM6efbw9By6Lel9SasjnPVW9xyhjnyezfp5o+g6LG6JMJOGKOVNLyYV1T/qaZ90tMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=cCivAGL/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="cCivAGL/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=5d5uQk2ydCKPXimNIedVP/fkbDkfI3O15Br9rvSAo88=; b=cCivAGL/1uGTKUD2pZXSDlp7xa
	+6ZoS3cxQbp2l3oSyd4oTYOEofKHzOKzl5z68qTH3jWcMzqTBFq+4XRxMyHZQnUp9tFWJXJRdgWo8
	/t6n7sZh1Xnhm2O0/8cqL0kOVcCxioEvOxuM5q1hKODwS0R5mLwrefgnYZ/RiG8uuPn+pZSEoagmH
	ZNHGCZzT1LiCiagIqRJKNM86bxltfQGscw/BAkuKyLF7PDqqBT9xD6Fs6bNOFVGjd33fmsG84IPIe
	JKAA9FRBKk0sH56MdgKmf9x4840mjjS5l4mpIi0qHa23igg/jGD59+eD+ZKfnQOE6ZdhEC5p0CXnz
	PRudNNmg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1tf3fg-000Vtm-Hb; Mon, 03 Feb 2025 21:07:56 +0000
Date: Mon, 3 Feb 2025 22:07:54 +0100
From: Chris Hofstaedtler <zeha@debian.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: util-linux@vger.kernel.org, Axel <axel.scheepers76@gmail.com>, 
	1094283-quiet@bugs.debian.org
Subject: Re: Bug#1094283: util-linux: dmesg shows color when
 /etc/terminal-colors.d/disable is present (and no override in xdg locations)
Message-ID: <sse3v4kouvltpyo6psj33b2ljlfqwr5ww6me7vk5fvrqn7wghq@h3d4hs3ni6q3>
References: <173791554931.11406.7776184826380347386.reportbug@teal.home>
 <Z5a08yD10L1J8AIa@per.namespace.at>
 <1bf60e39-b244-4773-89ed-c2fcdeb7d0bf@t-8ch.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1bf60e39-b244-4773-89ed-c2fcdeb7d0bf@t-8ch.de>
X-Debian-User: zeha

Hi Thomas,

* Thomas Weißschuh <thomas@t-8ch.de> [250203 21:53]:
> On 2025-01-26 23:19:31+0100, Chris Hofstaedtler wrote:
> > it appears commit 4bdf22803f9a41329694e0c3c82189635dccdcd0 breaks
> > disabling colors using the documented mechanism of touching
> > /etc/terminal-colors.d/dmesg.disable. See below for a user report.
> 
> Thanks for the report.
> 
> > On Sun, Jan 26, 2025 at 07:19:09PM +0100, Axel wrote:
> > > Package: util-linux
> > > Version: 2.40.4-1
> > > 
> > > Running dmesg after upgrading to trixie started showing color. The manpage
> > > mentions creating /etc/terminal-colors.d/disable which should disable colors
> > > for all. Creating the also mentioned /etc/terminal-colors.d/dmesg.disable
> > > doesn't disable color output also. I had /etc/terminal-colors.d/disable
> > > configured which did disable colors on -stable.
> > 
> > From what I can tell, the new rc = -ENOENT in colors_readdir
> > introduced in 4bdf22803f9a41329694e0c3c82189635dccdcd0 bubbles up to
> > colors_init:
> > 
> > 	int rc = colors_read_configuration(cc);  // calls colors_readdir, now returns -2
> > 	if (rc)
> > 		cc->mode = UL_COLORMODE_DEFAULT;
> >     else {
> > Evaluating color scores is skipped, effectively ignoring the
> > "disable" file.
> > 
> > Could you please take a look?
> 
> Could you test https://github.com/util-linux/util-linux/pull/3397 ?

Works for me.

Tested-by: Chris Hofstaedtler <zeha@debian.org>

You may want:
Reported-by: Axel <axel.scheepers76@gmail.com>


Thanks!
Chris
