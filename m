Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDAA1EA91
	for <util-linux@vger.kernel.org>; Sun, 23 Feb 2025 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740316025; cv=none; b=NPP/qv3hGCCyRSoKHzS8wIuhwHvfyWAmotqYBph9UUeP40uebaiAQFEOJkig6HrGmYDQzh5tBSOcLEi1j0qnLmp3k0pxNhHiRBV22UrLkYDMamiJFcIrQG9aASYonoh5eRoGYg+q1iZwl/QSsxmH5wRbHRX2XzWB+kfdmjpblF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740316025; c=relaxed/simple;
	bh=+msFSo+F9STIMGaZLcd1DMaRjOGSWdYXNwmen62lHmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRWy6j5pBvCahUmI1yb2SGR1FpJEhBEu/4jhPn8u1rtFaN8pQRtlynVnWkUzNZI/XTJxtwKQ72xGv7LkRd6fgVMLp0W+jqM2soWAiRVwY4O8z7NIxsIFxiOmsGtxKA7lC2u5WFyBwPiSjkGSzIXEpEU2RwRK6dZMcB4OCVjjy4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=NaluNwuc; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="NaluNwuc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U7uYCLg36TNk5siPqXAZD7fqWW08YzZp6PIBthzZUuo=; b=NaluNwucFY+XsiKips1z7RTJYd
	VNCQbrrgNmE9XftvVyoj5Z0V7JOXF24/rR1fqt2tLqdb8o3nWCl9QYkwKtzG/pi2Q4U7gG87Vcvbn
	EGHGJQExISqzJ3bdlaFuhUtYoYOs7vfPQKfF0duTGZYGBwqnfYz6xbV7oPJ78RFQHhsVsqca+/pnS
	VkNISKPeiz4EGHon/AitN5gZGMDKHKEQ47zUotIhN0Xov1RgE2tEfAKGwcbnd5rw8GqGLo+FQPwM0
	Za4slPUJxuAa+oMOT+aZ53rNWf2xqJoIOhO667whSEJ10rqKu1XUyn3YZG6w4sE9l6ggcuVbWyuS2
	ca6XsbWg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <zeha@debian.org>)
	id 1tmBh9-00H6gd-Lt; Sun, 23 Feb 2025 13:06:55 +0000
Date: Sun, 23 Feb 2025 14:06:54 +0100
From: Chris Hofstaedtler <zeha@debian.org>
To: Florian Bach <Leseratte10@vodafone.de>, 1098694@bugs.debian.org
Cc: util-linux@vger.kernel.org
Subject: Re: Bug#1098694: Crash in agetty due to invalid strncmp call in
 Trixie
Message-ID: <tzuam3pqfrm6g7t4hwwapmpxxux75bf4vxd42qb6iode2hqnnx@ve4h5lyd3yp6>
References: <5534c6e1-b819-4aaa-a8c1-fa22852e327b@vodafone.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5534c6e1-b819-4aaa-a8c1-fa22852e327b@vodafone.de>
X-Debian-User: zeha

Hello Florian,

thanks for your report.

I'm CC:ing upstream.

* Florian Bach <Leseratte10@vodafone.de> [250222 21:39]:
> I am running Debian Trixie in a Proxmox VM. I noticed that on the login
> screen there are errors of agetty crashing with a segfault. There's nothing
> special about the VM, it's a blank VM running the daily cloud images of
> Debian Trixie.
> 
> The VM is running Linux 6.12.12-1 with util-linux 2.40.4-3 and libc6 2.40-7.

Could you provide some more info and also try something:

1) is this on amd64?

2) which terminal is this? tty1 or something else?

3) whats your kernel command line?

4) which image did you use exactly?

5) could you try util-linux 2.41-rc1 from experimental?

> I debugged this with ltrace and believe I found the error, or at least some
> invalid behaviour.
> 
> In agetty.c in the debian sources for util-linux, right at the end of the
> function parse_args, there's code that tries to figure out the terminal name
> using a call to get_terminal_name. For some reason, this function call seems
> to fail on my machine and it prints the error "could not get terminal name".
> 
> This causes it to set &op->tty to NULL, and unfortunately, a couple lines
> later, that variable is used in a strncmp call, causing it to crash.
> 
> Here's the corresponding lines from the ltrace log:
> 
> strtok(nil, ",")                                 = nil
> free(0x557c64154be0)                             = <void>
> strcmp("-", "-")                                 = 0

Looks like we're in term-utils/agetty.c line 929ff, which has a
comment:
    /* resolve the tty path in case it was provided as stdin */

Which seems to be the default code path on systemd systems.

> isatty(0)                                        = 0
> isatty(1)                                        = 0
> isatty(2)                                        = 0

This must have been get_terminal_stdfd from lib/ttyutils.c

> dcgettext(nil, "could not get terminal name: %d", 5) = "could not get
> terminal name: %d"
[..]

I think the relevant part would be seeing what /proc/<pid>/fd/0 ,
/proc/<pid>/fd/1 , /proc/<pid>/fd/2 point to.

> Upload at a filehoster and send the link in response to this bug report?

Attaching should be fine, possibly compressed. Probably an strace
log could be more insightful than the ltrace log.

> Unfortunately, I was not yet able to figure out why on my machine the code
> seems to run into this code path with the "could not get terminal name"
> warning.

> But nevertheless, it's a valid code path, and it's just a warning
> not an error, so the code that comes after it should be able to handle this
> without crashing.

Looks like commit 47831cc02ac0d71c335caecef1753f4c8861277c did not
take this into account fully. get_terminal_name resets *name to
NULL, and I think then op->tty ends up being NULL.

Related: https://github.com/util-linux/util-linux/issues/1546#issuecomment-1005855533

Chris

