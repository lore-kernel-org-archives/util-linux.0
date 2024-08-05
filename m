Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BCA364AB
	for <util-linux@vger.kernel.org>; Mon,  5 Aug 2024 19:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885582; cv=none; b=CGTgxdW0y2w8epQdm9L5oJ6rs1Vwq1Kp0Q2mwUzZgTinbGx2My+saNH4yYvsqOEJF4j2585P9p4OGoJX2CY3UGk62JopVrjfFa9ts6PPB2L44ygyc8ziAv1imYybgYcF4rXXr84e9Fe9siwUDl40k7VZXEfn9uywsgk9mVj3zMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885582; c=relaxed/simple;
	bh=ChOIPc4q/cF7Tt/i8bspfVRxxYui8yIXfU7fiuRgdZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZ9alOfltlDBNy2VYtJUzcFy0T2bPqbE96eds8bEGEoBEbj/rTzaixGahcOTJfuJ94/NL2LpzO+wlFZkTxDpvCHUb9JvYVxd/LIYb+NgrF7FwpK+Gi/CtFilmiD82R2MwmokiundTCqNAdLfdX7dud8MZ1ziDIvE92TnPhLBEc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FvWbvvTY; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvWbvvTY"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so936963466b.3
        for <util-linux@vger.kernel.org>; Mon, 05 Aug 2024 12:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722885579; x=1723490379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WRLKHuRw+3AO/1V0+ABEfpj7twlCpQ6hYjN5D/5orbg=;
        b=FvWbvvTYNspKgICuue7l1JEq/bMBR/4P6AVmaNW4iWjilFcd/WUqqwgtduO5KNeypx
         E3ISZdXi9F+zlnGsR6lafAVgnsRPmCKBIbNsqSGHjx+BUa4EAR4BBz9m/ht/q0xMuCwy
         0tM7MosPau1saCURmtUxY4y1jbw3JTCmR4nZvM1rGUMsp50Ox4yF84pWRIvXk+s3zt0N
         vUOpx03vTilWsK0zqSBp1tp0HIgEu/3ex7/GGzshNdYjoEptRR57aGwWwACVlvWtrTv7
         5nN11UfF5VtObnIAvWZBmjOALC7O5LlWQl4A7tKuFznbeaqv+r14mlzbJa33VqeSulgI
         vBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722885579; x=1723490379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WRLKHuRw+3AO/1V0+ABEfpj7twlCpQ6hYjN5D/5orbg=;
        b=u6ivD9NNexQdQvMvHi0g49AFkBATsJ4t3q9XPhLO7GSqpuWRalcfh92fBMiOBzyZwB
         cR6dhuwG3I+rPcGuFC57p2q/1x1zHTLsCXVDtp2SnqB70yC5FReJdKBWYF43218IDba2
         Dlw7e7XAM69Mb4qXFnKUgQZlxNjs9wI7KjWfC10JHteMe6SS6ZfuOlHxTSANfOCmywMf
         T4taL6OWAtPkY4gXmGwsyKy00Sja/QP18KXhsn9F1pjtFG00rvAyoMxL5j/I69ivkqyz
         c+Wrkj6LxU7pZpHDNhtM8i+R8USmK91TL2U/58r7io7PnugtcODjDdDcbmPoShEplsHN
         Modw==
X-Gm-Message-State: AOJu0YzSD8xEfykviR6p9jKWJM/1cvmZjBY1smtUNBX/vEQ8BWmCT3xZ
	H3TdM8CPGgq8sS4T0UhL99fajZ4LM9KkZ116ew3jVQzTt7L2ROAsV+WSJwVE7CwCPSNFi+ZAJKP
	Qbj1FA5hq355cvLp5tVujAUF6YxMP7R3unOI=
X-Google-Smtp-Source: AGHT+IHi12omqjSEQU1W+BM4Ow5YG90y3Wa07cf3leexEwXct4XJdj0Injr/bh9eHZm4Eb79x6skc9SiKyj4bDkQPyE=
X-Received: by 2002:a17:907:6d09:b0:a7a:bae8:f29e with SMTP id
 a640c23a62f3a-a7dc4e91d8bmr904659966b.29.1722885578463; Mon, 05 Aug 2024
 12:19:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGc5Yo9G2mJkbgVAbZESVvBVCK9OF7MWbEf=Mt0tY2XBFg+=yQ@mail.gmail.com>
 <bytzy2l3mhrcxpcmhqqmyxj7jeu6jafbyu7pmkx3ocupii5tue@qeiobojgjess>
In-Reply-To: <bytzy2l3mhrcxpcmhqqmyxj7jeu6jafbyu7pmkx3ocupii5tue@qeiobojgjess>
From: John Rinehart <johnrichardrinehart@gmail.com>
Date: Mon, 5 Aug 2024 12:19:27 -0700
Message-ID: <CAGc5Yo8MR8S+VdkLt9FHJ-buOsesKfrWFVrv3FzuMXyQBUvQXg@mail.gmail.com>
Subject: Re: fuse mount failure when type contains '.'
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>  Hi John,

Hi Karel (and Miklos, CCed) =F0=9F=91=8B!

> On Thu, Aug 01, 2024 at 11:16:30AM GMT, John Rinehart wrote:
> > `util-linux` seems to fail to handle a use case that users like me seem=
 to
> > be hitting with some frequency. The issue is around
> > https://github.com/util-linux/util-linux/blob/86b6684e7a215a0608bd13037=
1bd7b3faae67aca/libmount/src/context.c#L2115-L2121
> > and seems rooted in the fact that `util-linux` operates on `type` where
> > type is always of the form <a>.<b> but where <b> is apparently assumed =
to
> > not contain Unicode U+002E (ASCII 2E): '.' ("dotless"). I say it "appea=
rs
> > to assume" this since the logic which appears to remove the subtype doe=
s so
> > by using `strrchr`, which addresses only the last period in the `helper=
`
> > string. If the `subtype`, itself, has a U+002E character then this won'=
t
> > remove the subtype.
> >
> > As an example, if `helper` looks like
> > `path/name.type./subtype/path/with/a.period` then the modified `helper`
> > after `strrchr` will look like `path/name.type./subtype/path/with/a`
> > instead of the apparently-intended `path/name.type`.
>
> the convention for filesystem names is (was):
>
>     <type>[.<subtype>]
>
> For example, for the "mount" helper, it is:
>
>     /path/mount.<type>[.<subtype>]
>
> I believe it is acceptable for the "path" to contain dots (or any
> other characters). The important thing is the last segment of the path
> (e.g. /mount.<type>[.<subtype>]). We should not be concerned with
> anything else besides the last segment.
>
> It is strange to assume that <subtype> can also contain path-like
> segments and dots. It seems like someone may want to use <subtype> to
> encode additional information ...

Thanks for your response! If I can restate/augment my case:
`util-linux`'s `mount` implementation will fail to properly delimit
`type` from `subtype` if `subtype` contains `.`. `subtype` is expected
by `mount.fuse` to be an executable compatible with `fuse`. If the
executable isn't reachable from the `$PATH` (which appears to be the
case with the `systemd` mount target auto-generated from my fstab)
then it should be specified absolutely (although this isn't documented
in the man pages for `mount.fuse`). You can understand this logic by
taking a look at
https://github.com/libfuse/libfuse/blob/beff8a8ebe1b413b4b572b93ddca24aaeb9=
04f7a/util/mount.fuse.c#L295-L296
followed by
https://github.com/libfuse/libfuse/blob/beff8a8ebe1b413b4b572b93ddca24aaeb9=
04f7a/util/mount.fuse.c#L432

In the case of my OS's absolute path to the `s3fs` binary (compatible
with and called by `mount.fuse`), it contains a `.` (because of the
version string described previously) which breaks `util-linux`'s
`mount` implementation when it attempts to separate the `type` from
the `subtype`.

`util-linux` hasn't documented any restrictions on character values
contained within `subtype`. So, in consideration of Hyrum's law and in
the spirit of being liberal in what's accepted while conservative in
what's emitted, I'd kindly ask `util-linux` maintainers to support `.`
characters in the `subtype` so that users like me can fearlessly
specify absolute paths to FUSE binaries in their subtype.


> Miklos (CC:), what is your opinion? Is it correct to assume that <subtype=
>
> is whatever?
>
>     Karel
>
>
> > This crops up for users like me because  I use NixOS which is a store-b=
ased
> > Linux operating system using paths like:
> > ```
> > $ readlink -f $(which s3fs)
> >
> > /nix/store/xwbx0fbg65ml2qjl86p9p2w58kghqn8r-s3fs-fuse-1.94/bin/s3fs
> > ```
> > (So, paths like `/nix/store/<hash>-<name>-<version>/bin/<cmd>`). `versi=
on`
> > is usually a dot-delimited string like `1.23`.
> >
> > I've generated a patch which seems to ameliorate this behavior. It's
> > attached (sorry if attachments are not the way to go with this mailing
> > list, specifically, or mailing lists, generally - this is my first time
> > submitting a patch to a mailing list). The logic is simple, but it
> > basically iterates through all possible substrings according to the num=
ber
> > of U+002E characters in the `type` string. It's a more generic form of =
the
> > logic already present, but it's a little heavy-handed. Happy with any a=
nd
> > all changes which preserve the apparently-corrected behavior.
> >
> > Please let me know if I should make any changes or if a change like thi=
s
> > won't be accepted for some reason or if I'm misunderstanding the
> > problem/solution.
> >
> > Thank you!
> >
> > Cf.
> > 1. https://discourse.nixos.org/t/how-to-setup-s3fs-mount/6283/5
> > 2. https://github.com/NixOS/nixpkgs/issues/46529#issuecomment-655536831
> >
> > -- John Rinehart
>
>
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
>
