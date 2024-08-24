Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789ED2AF15
	for <util-linux@vger.kernel.org>; Sat, 24 Aug 2024 02:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724466203; cv=none; b=g7Kh/kwFuOqOp7mOzLUDozoIDrSjP3ErSBqrTHOV6kaAwHPj5gbUHVzAL4ZeauRyTt2k1f+0NEZfTIHMt2h9JoFH/WXCJanL2UkiuCiH0C7hh2cAxYI5dk0yLTGATE08lOoYqZBp3njUtAWnY7NTkLyFI56Ht1xjRetN2HTBz64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724466203; c=relaxed/simple;
	bh=l3cIDp9Q8TikeEGLy5Sd5NxT26AaEG2lzQsmSwL3f5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ch55tfnsNCmx7JjlgvnAQHGMikDfP8h9TQAjsF7QaIyaTFDo0QPDkcAFq8FtDQss+Uq4Xvk2rbF21Z79OTu5oC5OhF7CaKYnB7OLwD48YZZdUBnnUHgez8TXR0wJGO7btHdkycm6ylNUe1rD+75QTi9wdEwDQWhec/Y7KMXGbMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqZpWqLG; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqZpWqLG"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5343d2af735so857967e87.1
        for <util-linux@vger.kernel.org>; Fri, 23 Aug 2024 19:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724466199; x=1725070999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=94k0JbEJbWFw+MyDsLhRXyuu5kqu5+SgckTl7U4b5Hs=;
        b=iqZpWqLGfvcgRy+xJhzCJuHYGDGJNofUK1RDcrI44dxPWP9CR2WzVde5EuiajfrOGz
         jni94VU8CVnz1yssu5XRYt8loD2BHXgOWlcJKBR6b9vonOHVQov+QsQs3VkHAlgj0nyI
         0t7qej0bqp2GY+khvMgZ7xp8rXC+GmxdJw6GsxB2fRtNAPFHCAspr6K8QFX3jxhiIijU
         EURipV//FaX+M2WjffzeY8iWQmDlmXGK0munJ0wBFBpRIzh6vS12wggN552znsYN2e0/
         ZvgoKVCzBesafhj+gp0DndrGaJkSeTzumazq7n2cCgQrUEzCxSdGo74Q5m5rhpkj/9ZY
         t4OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724466199; x=1725070999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=94k0JbEJbWFw+MyDsLhRXyuu5kqu5+SgckTl7U4b5Hs=;
        b=xUnsPUOMDukgINttKG4X1xYpeCTzVxx1MflpeW0Ba5ruusL4vs3j4/k77ENLdFI0XB
         w2eYs/oiaeTrlLUYUZu6oIf+KOOei2X7KfE/L0W5OIN4EM9r/ffcNh6hHqEMHWTrPtQn
         cZjsDi9jK4leAU1EumZP0gHsksZz4tJBZO9LjJjM10gMWBzzVIQ+NoZ75066QvwlEiE2
         N3TaSiNijaL5bPYHNNxJ26recP/qlSInpXCn9e6AZ1dneFTwzK9H7NNGSKr0EzQ0ntM2
         iPZmqrU/XUnjqreAlFtuUOuN448QgnJI9cBwefVyiogoA79qtNDCIzQXvZW1/f+m0Jwj
         95xA==
X-Forwarded-Encrypted: i=1; AJvYcCViIKOBVeVMFQhRaUaH8yRhDXpZzubAzATx/TMM1fxEDgG4Hs8XuXpumMmjg7CMoc1sZKJaLdeKKnV5@vger.kernel.org
X-Gm-Message-State: AOJu0YzjtJ1Ys7dbcy1F9lhipCk9BHfwuap5B01cZa74AfAfJvNx9AV0
	k/CIXRCEyjx87qWB8iAQaustgc7nM+zUJcoqdydfenojvDO/3fV+8/BlCHxkouKFUcFKERhN0UF
	AmGkbd2zDdOdItgFzKV84n1Rjc5FdvTcUH4o=
X-Google-Smtp-Source: AGHT+IHKDgmeBFNk7UjQ/Xz1apUSHI1hH9AeeHJbSWHNxsH0kPHVyJ70Bh8vti9wxlLbp0Tg7AfhBLPpAxc6oVnr6+k=
X-Received: by 2002:a05:6512:39d5:b0:52c:90b6:170f with SMTP id
 2adb3069b0e04-53438783a93mr3428525e87.29.1724466199096; Fri, 23 Aug 2024
 19:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGc5Yo9G2mJkbgVAbZESVvBVCK9OF7MWbEf=Mt0tY2XBFg+=yQ@mail.gmail.com>
 <bytzy2l3mhrcxpcmhqqmyxj7jeu6jafbyu7pmkx3ocupii5tue@qeiobojgjess> <CAJfpegtgyyEv1O5D43J=DWP+CqyJEsg=dteT9T0yPxqsnArkMw@mail.gmail.com>
In-Reply-To: <CAJfpegtgyyEv1O5D43J=DWP+CqyJEsg=dteT9T0yPxqsnArkMw@mail.gmail.com>
From: John Rinehart <johnrichardrinehart@gmail.com>
Date: Fri, 23 Aug 2024 19:23:07 -0700
Message-ID: <CAGc5Yo8zDt1T_J=OW+m7L8fQJMk0uQy=ky5G7cQw4TdoSh41Gw@mail.gmail.com>
Subject: Re: fuse mount failure when type contains '.'
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for your response.

But, hold up. I demonstrated a(n apparently) valid use case, shared
links where other people have hit this problem over the years, and
proposed an implementation accommodating it (which I'm using in a
patched/forked version of `util-linux`, currently). Since the
requested change would allow for subtypes to include `.` in addition
to [a-zA-Z0-9_]* I don't see a theoretical restriction (even if the
implementation as proposed is unacceptable as-is based on style or
unforeseen edge cases). Users want to use `.` in subtypes, it's
backward-compatible, it doesn't violate any documentation/guarantee
(as far as I can tell) and a working solution has been provided.
What's the rationale for prohibiting this use case?

Thank you.

On Thu, Aug 22, 2024, 07:09 Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Mon, 5 Aug 2024 at 11:49, Karel Zak <kzak@redhat.com> wrote:
> >
> >
> >  Hi John,
> >
> > On Thu, Aug 01, 2024 at 11:16:30AM GMT, John Rinehart wrote:
> > > `util-linux` seems to fail to handle a use case that users like me seem to
> > > be hitting with some frequency. The issue is around
> > > https://github.com/util-linux/util-linux/blob/86b6684e7a215a0608bd130371bd7b3faae67aca/libmount/src/context.c#L2115-L2121
> > > and seems rooted in the fact that `util-linux` operates on `type` where
> > > type is always of the form <a>.<b> but where <b> is apparently assumed to
> > > not contain Unicode U+002E (ASCII 2E): '.' ("dotless"). I say it "appears
> > > to assume" this since the logic which appears to remove the subtype does so
> > > by using `strrchr`, which addresses only the last period in the `helper`
> > > string. If the `subtype`, itself, has a U+002E character then this won't
> > > remove the subtype.
> > >
> > > As an example, if `helper` looks like
> > > `path/name.type./subtype/path/with/a.period` then the modified `helper`
> > > after `strrchr` will look like `path/name.type./subtype/path/with/a`
> > > instead of the apparently-intended `path/name.type`.
> >
> > the convention for filesystem names is (was):
> >
> >     <type>[.<subtype>]
> >
> > For example, for the "mount" helper, it is:
> >
> >     /path/mount.<type>[.<subtype>]
> >
> > I believe it is acceptable for the "path" to contain dots (or any
> > other characters). The important thing is the last segment of the path
> > (e.g. /mount.<type>[.<subtype>]). We should not be concerned with
> > anything else besides the last segment.
> >
> > It is strange to assume that <subtype> can also contain path-like
> > segments and dots. It seems like someone may want to use <subtype> to
> > encode additional information ...
> >
> > Miklos (CC:), what is your opinion? Is it correct to assume that <subtype>
> > is whatever?
>
> We can assume that subtype is just [a-zA-Z0-9_]*, I think.
>
> Thanks,
> Miklos
>
>
>
> >
> >     Karel
> >
> >
> > > This crops up for users like me because  I use NixOS which is a store-based
> > > Linux operating system using paths like:
> > > ```
> > > $ readlink -f $(which s3fs)
> > >
> > > /nix/store/xwbx0fbg65ml2qjl86p9p2w58kghqn8r-s3fs-fuse-1.94/bin/s3fs
> > > ```
> > > (So, paths like `/nix/store/<hash>-<name>-<version>/bin/<cmd>`). `version`
> > > is usually a dot-delimited string like `1.23`.
> > >
> > > I've generated a patch which seems to ameliorate this behavior. It's
> > > attached (sorry if attachments are not the way to go with this mailing
> > > list, specifically, or mailing lists, generally - this is my first time
> > > submitting a patch to a mailing list). The logic is simple, but it
> > > basically iterates through all possible substrings according to the number
> > > of U+002E characters in the `type` string. It's a more generic form of the
> > > logic already present, but it's a little heavy-handed. Happy with any and
> > > all changes which preserve the apparently-corrected behavior.
> > >
> > > Please let me know if I should make any changes or if a change like this
> > > won't be accepted for some reason or if I'm misunderstanding the
> > > problem/solution.
> > >
> > > Thank you!
> > >
> > > Cf.
> > > 1. https://discourse.nixos.org/t/how-to-setup-s3fs-mount/6283/5
> > > 2. https://github.com/NixOS/nixpkgs/issues/46529#issuecomment-655536831
> > >
> > > -- John Rinehart
> >
> >
> >
> > --
> >  Karel Zak  <kzak@redhat.com>
> >  http://karelzak.blogspot.com
> >
