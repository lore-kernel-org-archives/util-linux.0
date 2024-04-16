Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F335B3BB30
	for <util-linux@vger.kernel.org>; Tue, 16 Apr 2024 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713247158; cv=none; b=slsBMJU7JXNf0+5OpGpxPF0f05n3Ko0R4raKe/4wRExVLNJMD7UrAd/yZwJXtcQlJzfP0oF2B0YHv2bp19nFUmURSwWfxLbC1nZj3baNBHjwQqEaqccgOg2r5eg+KxYKJ7MKXP64bjlEqn7oQNwShd5IG3OikCZ8nC27CVRkdgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713247158; c=relaxed/simple;
	bh=k4j5DW2neDWcw097c6tIiJVYyRyCYe/ptnVOEaZszOA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Sp3FGdyvAK7mCvd3ceTmurHfPf7+H7OCV3BaFU5ErgYOnVuBAkUwOB8C1VqFv3au3+4xVkYdZYxOgwsTWOOr3b7DrYEK1jFlAU1QTsetC5RUmgxZm6J04tQEKrh3IrA9k1oc7u1/Yl1bxhONK2DhZAiwG4cWvz29vLZhxU9/rCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=fGsPtq+2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="fGsPtq+2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1713247146; bh=k4j5DW2neDWcw097c6tIiJVYyRyCYe/ptnVOEaZszOA=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=fGsPtq+2Q9BgJ1teetO+z1DaKptlrCb6w6cjxdWCbf9xDoDdqcKbZv8m36M87R33H
	 abJf2lsRsgn8met0rbxbhcX2ZG3k/2Myfmyq1EX17yk4Rcf8lq1/9BSGgEEepJRp/E
	 NxrDOsOmUytS3AgMI0SNelbOSCIvMdTapLUIJ2bM=
Date: Tue, 16 Apr 2024 07:59:05 +0200 (GMT+02:00)
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh_?= <thomas@t-8ch.de>
To: Masatake YAMATO <yamato@redhat.com>
Cc: glaubitz@physik.fu-berlin.de, util-linux@vger.kernel.org
Message-ID: <873299ec-913a-43a8-ac11-20ca4b03f2f7@t-8ch.de>
In-Reply-To: <20240416.092958.1925095964872687612.yamato@redhat.com>
References: <31ccace2e5912ffc428e065cd66764088c625c4d.camel@physik.fu-berlin.de> <20240416.092958.1925095964872687612.yamato@redhat.com>
Subject: Re: lsfd/error-eperm test fails on git master
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <873299ec-913a-43a8-ac11-20ca4b03f2f7@t-8ch.de>

Hi,

Apr 16, 2024 02:30:10 Masatake YAMATO <yamato@redhat.com>:

> From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Subject: lsfd/error-eperm test fails on git master
> Date: Mon, 15 Apr 2024 12:24:08 +0200
>
>> Hello,
>>
>> lsfd/error-eperm fails for me on git master. I have reproduced the issue
>> on 32-bit PowerPC, 64-bit SPARC, 64-bit s390x and x86_64.
>>
>> Is there a tentative fix for this failure?
>
> Thank you for reporting.
> This may be a bug in a build script.
>
>> Thanks,
>> Adrian
>>
>> (sid_powerpc-dchroot)glaubitz@perotto:~/util-linux-git/tests$ ./run.sh l=
sfd/error-eperm
>>
>> -------------------- util-linux regression tests --------------------
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 For development purpose only.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Don't execute on production system!
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel: 6.6.15-powerpc64
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 options: --srcdir=3D/home/glaubitz/util-l=
inux-git/tests/.. \
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 --builddir=3D/home/glaubitz/util-linux-git/tests/..
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lsfd: fd opening a file=
 cannot be stat(2)'ed ... FAILED (lsfd/error-eperm)
>>
>> ---------------------------------------------------------------------
>> =C2=A0 1 tests of 1 FAILED
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lsfd/error-eperm
>> ---------------------------------------------------------------------
>> (sid_powerpc-dchroot)glaubitz@perotto:~/util-linux-git/tests$
>>
>> diff-{{{
>> --- /home/glaubitz/util-linux-git/tests/expected/lsfd/error-eperm=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2024-04-09 09:22:29.505017516 +0000
>> +++ /home/glaubitz/util-linux-git/tests/output/lsfd/error-eperm 2024-04-=
15 08:37:38.326220593 +0000
>> @@ -1,2 +1,2 @@
>> -mem ERROR stat:EPERM
>> +mem ERROR stat:unknown(1)
>
> EPERM is defined as 1 in asm-generic/errno-base.h.
> So `unknown(1)' should be decoded as EPERM.
>
> lsns uses errnos.h generated at build-time for decoding the error numbers=
.

The build log should be the same as reported before:
https://buildd.debian.org/status/fetch.php?pkg=3Dutil-linux&arch=3Dpowerpc&=
ver=3D2.40-5&stamp=3D1712589234&raw=3D0

Which indeed contains:

GEN=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 syscalls.h
./tools/all_syscalls: line 13: gawk: command not found

So it should be the same issue as
https://github.com/util-linux/util-linux/pull/2949

(which needs to be expanded to all_errnos and meson)

I can send a patch but wanted to wait for the original submitter.

> Can I see errnos.h at the top of the build directory ?
> I guess the file is at ~/util-linux-git/errnos.h.
>
>
> On my environment, the head of the file is:
>
> =C2=A0=C2=A0=C2=A0 UL_ERRNO("E2BIG", E2BIG)
> =C2=A0=C2=A0=C2=A0 UL_ERRNO("EACCES", EACCES)
> =C2=A0=C2=A0=C2=A0 UL_ERRNO("EADDRINUSE", EADDRINUSE)
> =C2=A0=C2=A0=C2=A0 UL_ERRNO("EADDRNOTAVAIL", EADDRNOTAVAIL)
> =C2=A0=C2=A0=C2=A0 UL_ERRNO("EADV", EADV)
> =C2=A0=C2=A0=C2=A0 UL_ERRNO("EAFNOSUPPORT", EAFNOSUPPORT)
> =C2=A0=C2=A0=C2=A0 ...
>
> Masatake YAMATO
>
>> ASSOC,TYPE,SOURCE:=C2=A0 0
>> }}}-diff
>>
>> libsmartcols: fromfile: [15] wrap-tree=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ... OK
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 lsfd: fd opening a file=
 cannot be stat(2)'ed=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ... FAILED =
(lsfd/error-eperm)
