Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC378C6C
	for <util-linux@vger.kernel.org>; Tue, 16 Apr 2024 07:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713253139; cv=none; b=qcyZG22Q8WzbvYuaKf4x3qW1cktJ9PAJasS6MRkJetioLmcxEX6jXl9RdSutAvp5Jl0sQMZaRHWWIjm2/TY6Kqx+yCK282sbO6jSOMkwatGKauq5E1WhtOS9SR+cu3cPgYzoG90n8w+mnxkKbpdmgFzTYBc37CsRSAazVDS8Ud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713253139; c=relaxed/simple;
	bh=SG9zVMb1Vh0BcvA+8l+dpy6ulc92s17PJJoilMk6TTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrhJC2isUvqK34FkixBib+8i4C5F4oEpwO0PbRlO8pjIFjy7srHXE2Xb0m3WXxC+DTxcfFmGeMnYkUGh/dZ86gEb8lnmTH0XuTfzsJKN3qGb6c4n5L4UoOMiGoA8xMoA0+VNgbYiyyJrnqO7cGRwUmclyPB8ck3DxaCLHb4yUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=Md5HCcey; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="Md5HCcey"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1713253133; bh=SG9zVMb1Vh0BcvA+8l+dpy6ulc92s17PJJoilMk6TTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Md5HCceylZ7IztD22a+8BaHXs8doCZ2WGkM1dkgAO6b+VbGDsBmnrrRxmkMpu8MAQ
	 frLqfRWfa6RD7PIUqaXuWgu/mkbhf97VH8F+HPqVszLkY1cByh/mzAO9Xu5puv05jX
	 AmiT37NGBUc47KBXvZ+ixW874fxJASYGbrbogpSA=
Date: Tue, 16 Apr 2024 09:38:52 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Masatake YAMATO <yamato@redhat.com>, glaubitz@physik.fu-berlin.de
Cc: util-linux@vger.kernel.org
Subject: Re: lsfd/error-eperm test fails on git master
Message-ID: <ed956683-5b2e-4eb5-9056-8c8eedf1c17c@t-8ch.de>
References: <31ccace2e5912ffc428e065cd66764088c625c4d.camel@physik.fu-berlin.de>
 <20240416.092958.1925095964872687612.yamato@redhat.com>
 <873299ec-913a-43a8-ac11-20ca4b03f2f7@t-8ch.de>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <873299ec-913a-43a8-ac11-20ca4b03f2f7@t-8ch.de>

On 2024-04-16 07:59:05+0200, Thomas Weißschuh  wrote:
> Apr 16, 2024 02:30:10 Masatake YAMATO <yamato@redhat.com>:
> > From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > Subject: lsfd/error-eperm test fails on git master
> > Date: Mon, 15 Apr 2024 12:24:08 +0200
> >
> >> lsfd/error-eperm fails for me on git master. I have reproduced the issue
> >> on 32-bit PowerPC, 64-bit SPARC, 64-bit s390x and x86_64.
> >>
> >> Is there a tentative fix for this failure?
> >
> > Thank you for reporting.
> > This may be a bug in a build script.
> >
> >> Thanks,
> >> Adrian
> >>
> >> (sid_powerpc-dchroot)glaubitz@perotto:~/util-linux-git/tests$ ./run.sh lsfd/error-eperm
> >>
> >> -------------------- util-linux regression tests --------------------
> >>
> >>                     For development purpose only.
> >>                  Don't execute on production system!
> >>
> >>        kernel: 6.6.15-powerpc64
> >>
> >>       options: --srcdir=/home/glaubitz/util-linux-git/tests/.. \
> >>                --builddir=/home/glaubitz/util-linux-git/tests/..
> >>
> >>          lsfd: fd opening a file cannot be stat(2)'ed ... FAILED (lsfd/error-eperm)
> >>
> >> ---------------------------------------------------------------------
> >>   1 tests of 1 FAILED
> >>
> >>       lsfd/error-eperm
> >> ---------------------------------------------------------------------
> >> (sid_powerpc-dchroot)glaubitz@perotto:~/util-linux-git/tests$
> >>
> >> diff-{{{
> >> --- /home/glaubitz/util-linux-git/tests/expected/lsfd/error-eperm       2024-04-09 09:22:29.505017516 +0000
> >> +++ /home/glaubitz/util-linux-git/tests/output/lsfd/error-eperm 2024-04-15 08:37:38.326220593 +0000
> >> @@ -1,2 +1,2 @@
> >> -mem ERROR stat:EPERM
> >> +mem ERROR stat:unknown(1)
> >
> > EPERM is defined as 1 in asm-generic/errno-base.h.
> > So `unknown(1)' should be decoded as EPERM.
> >
> > lsns uses errnos.h generated at build-time for decoding the error numbers.
> 
> The build log should be the same as reported before:
> https://buildd.debian.org/status/fetch.php?pkg=util-linux&arch=powerpc&ver=2.40-5&stamp=1712589234&raw=0
> 
> Which indeed contains:
> 
> GEN      syscalls.h
> ./tools/all_syscalls: line 13: gawk: command not found
> 
> So it should be the same issue as
> https://github.com/util-linux/util-linux/pull/2949
> 
> (which needs to be expanded to all_errnos and meson)
> 
> I can send a patch but wanted to wait for the original submitter.

Should be fixed by https://github.com/util-linux/util-linux/pull/2960

> [..]
