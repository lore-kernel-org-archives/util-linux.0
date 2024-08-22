Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3011C9EBD
	for <util-linux@vger.kernel.org>; Thu, 22 Aug 2024 14:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724335751; cv=none; b=PF5qU3JQEOm16jSEbMgDhG+h4T1vRRYaht2mk46wAOiojDcXS6B1pFL4iQ+kxNE8NbUbBdSt5ZNi3FLR6FLMjdLWClr25U0vO0E3Mq8Okmt3BmOd/MxxAG5ep8hVOx/J1Yj1m+499kAet8nJ+7ZRTXIZdQubZMoGAemRxm5sgto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724335751; c=relaxed/simple;
	bh=3TmULVRdpLVlTIgao843tAXGZfapAFfoi8/P2d4Oj1Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqWE4mtswPTLasFgktGVRUHCKz6LwSLbJEan7sq7AFX6KtsgPwBcTobpIV5WskIyShYA38xv2l6S9ZaUegzOqTW9ToypneltEFSTy2eE8oejvD6MOrpwSE8jDcSbFx4mJ5H3OBCW9nPOoCiSPvOeRzlHF/0Y0KS0O44E0R4HqEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=TKQSa6sn; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TKQSa6sn"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a86910caf9cso126133166b.1
        for <util-linux@vger.kernel.org>; Thu, 22 Aug 2024 07:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1724335748; x=1724940548; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HsDqlWEmmKz6GUviE/x6dcVh50+HKbGyNA3nSz+0CNA=;
        b=TKQSa6sns+CG5MFgMaEAy498UKlSCbf5pN4l0yEj9x0Sb+aNxXM4gqGdBJer1P1oyg
         eQYYUUYt4a7lTfOr7txwkBztuKFFjXwdmyI4rno/fX2UotIfov/NkR0G4jy7uANrMn4S
         pZA7T5JFUTpNQMyVKfPOjjSCWBoSslvePIzHk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724335748; x=1724940548;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HsDqlWEmmKz6GUviE/x6dcVh50+HKbGyNA3nSz+0CNA=;
        b=fGKJd0uniOKqyR4QnmCZ9vR7rHeSs/rDkaGQLUDxEpYnUoBpJKJKAkglyeSJ8AFRrR
         k0K0m9Oz8aR1YDFjQrvllEXUdWhGbMUJo1iiFu392yhoscLaQKY+hPJS2FY0B0+svw2R
         JexSeECa4ZYtoxVxkyRl7ZlrvWBZdh8obSIqbpeBh3H5kTg8khWYsQYr56n207VnQIMy
         MDjip7C8ifEz85rfgSr4IpV2dfkhOGYLSsnqWm5LhspUZg1OJizo+Cc6JoQ2yILQi32I
         iBYOHoobmCi0ZseL+GQ8eKc1pByrK3UgS/cfXvN9VIhhhV+mTJEGDlGAZ9ScwDDKmNXl
         W4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTCkWlv2pZmxli8O4VXLfPaA9+wEc9/PWLWtKpw9MbHx+V/glPmt5hUT3pDPjz9utb+T6KNkQh3DGL@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+iD7y3vpmImSs5mkcNjfEWPRVJvEgJgw/A3KkXzaMQaVVVdDs
	l+vrdmb5rPmDARkcPVVg/8fTt/bTFfZKW17aHvi4dKDIsQB04x8fdzh+hkFvXjM/21QWpj5JHqC
	naWVj52bJG6lGAtNVrysjxONVAyRDNovxkOaNAdyp07thxNA6xY4=
X-Google-Smtp-Source: AGHT+IE0pdHJCDL2Uy+cRDfUDdCrL07MHvH/4xsUX2+wx1/phCYZ4sSU4Tt1WsOIQ9oc3XmsqWQ3KmyniTqZWb609ao=
X-Received: by 2002:a17:907:720c:b0:a7a:b561:358e with SMTP id
 a640c23a62f3a-a868a97d625mr333728366b.33.1724335747635; Thu, 22 Aug 2024
 07:09:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGc5Yo9G2mJkbgVAbZESVvBVCK9OF7MWbEf=Mt0tY2XBFg+=yQ@mail.gmail.com>
 <bytzy2l3mhrcxpcmhqqmyxj7jeu6jafbyu7pmkx3ocupii5tue@qeiobojgjess>
In-Reply-To: <bytzy2l3mhrcxpcmhqqmyxj7jeu6jafbyu7pmkx3ocupii5tue@qeiobojgjess>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 22 Aug 2024 16:08:55 +0200
Message-ID: <CAJfpegtgyyEv1O5D43J=DWP+CqyJEsg=dteT9T0yPxqsnArkMw@mail.gmail.com>
Subject: Re: fuse mount failure when type contains '.'
To: Karel Zak <kzak@redhat.com>
Cc: John Rinehart <johnrichardrinehart@gmail.com>, util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 11:49, Karel Zak <kzak@redhat.com> wrote:
>
>
>  Hi John,
>
> On Thu, Aug 01, 2024 at 11:16:30AM GMT, John Rinehart wrote:
> > `util-linux` seems to fail to handle a use case that users like me seem to
> > be hitting with some frequency. The issue is around
> > https://github.com/util-linux/util-linux/blob/86b6684e7a215a0608bd130371bd7b3faae67aca/libmount/src/context.c#L2115-L2121
> > and seems rooted in the fact that `util-linux` operates on `type` where
> > type is always of the form <a>.<b> but where <b> is apparently assumed to
> > not contain Unicode U+002E (ASCII 2E): '.' ("dotless"). I say it "appears
> > to assume" this since the logic which appears to remove the subtype does so
> > by using `strrchr`, which addresses only the last period in the `helper`
> > string. If the `subtype`, itself, has a U+002E character then this won't
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
>
> Miklos (CC:), what is your opinion? Is it correct to assume that <subtype>
> is whatever?

We can assume that subtype is just [a-zA-Z0-9_]*, I think.

Thanks,
Miklos



>
>     Karel
>
>
> > This crops up for users like me because  I use NixOS which is a store-based
> > Linux operating system using paths like:
> > ```
> > $ readlink -f $(which s3fs)
> >
> > /nix/store/xwbx0fbg65ml2qjl86p9p2w58kghqn8r-s3fs-fuse-1.94/bin/s3fs
> > ```
> > (So, paths like `/nix/store/<hash>-<name>-<version>/bin/<cmd>`). `version`
> > is usually a dot-delimited string like `1.23`.
> >
> > I've generated a patch which seems to ameliorate this behavior. It's
> > attached (sorry if attachments are not the way to go with this mailing
> > list, specifically, or mailing lists, generally - this is my first time
> > submitting a patch to a mailing list). The logic is simple, but it
> > basically iterates through all possible substrings according to the number
> > of U+002E characters in the `type` string. It's a more generic form of the
> > logic already present, but it's a little heavy-handed. Happy with any and
> > all changes which preserve the apparently-corrected behavior.
> >
> > Please let me know if I should make any changes or if a change like this
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
