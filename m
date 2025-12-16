Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134EE3A1E83
	for <util-linux@vger.kernel.org>; Tue, 16 Dec 2025 20:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765917625; cv=none; b=GJCyIcZEPDRct6HXrhxNF1B154TtU5/sxFmxBOYJLtcIkc5Ss2B3kcI2ASafuhtTy88QmqlEC/0OIHTBdlkhhvhUnqKZYSnAUOkG8tHHmxgZYEsYA7/JIdjOXIIFRBponBFSiJfbPhIjPFuFuwbGBLhBvVFpg9uI46edGBm9lmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765917625; c=relaxed/simple;
	bh=h7Cm/fd8JPw8q/drnwu7C2gBIxW4vqRD73gIMO50CMQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4veR0PSJcqRCRI9RRzI4Sg6c4OJeMFNzk/Ik+xrfYG4jH6nyoCH8mfIafAOUK89OpiSOA4hpU1/3jspjAm7OXKAd/CgtGir1SyuIsg41rAaFlYV5Dm7QtC4qDlZDuey1nLg9e5MAn4+vWbI9liSkmPb1LwL41b91bFGUwuwS2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwqvFwCD; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwqvFwCD"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88a367a1dbbso34752026d6.0
        for <util-linux@vger.kernel.org>; Tue, 16 Dec 2025 12:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765917623; x=1766522423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLOyF7XcI/3YtgWZZpRaefu/sLLRJqgTiLdT9i64D94=;
        b=IwqvFwCDX7ozbtCj16/2GH4f2dQBokTWGEZvE5WrF8f/vm0DUjJNg3nVCZX9hqE6Fa
         bhI63wTqyVRFgql/9coE1zad56vjrFRVPhQpbXsLf6bRLj+j9VvEyDqglmUCsXezewG0
         TyWsO+KIeaDpTkUJA/xuTVweyrJE88w7fqEkNof6ir+1T5HZs1lOLK89VIYSEg4eHRlP
         NFOnARPBZ2b/qgdSIEB7WzcRXjCwXnNI7e6tlNBo38+DS+Mbx3j8Y8gNx3S9F5qd80jc
         eoFkEHLjmNi/hjBhEGTPsED/HDUQa9EMjqHJi0J2WjFzAJNHOoU1Bu7Ix0rGoF07Rmst
         Yubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765917623; x=1766522423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nLOyF7XcI/3YtgWZZpRaefu/sLLRJqgTiLdT9i64D94=;
        b=kwNCW7Srd3DiON8+owFbwyk/NRy9DKYiapiOUrGwL2LJpt+3jRlB97BiY5a6v0jPyn
         N2mTtwzk9+hj4zT5ZaX5/ssUyiKJioqjGTnuzelE7LwWOgFJIHuEnRqSS5LqTJYgamK5
         v6dhxIKJA6QBKDDVyyaqpxjgtq16d84hA5eXDDnRQbqfSxtbgITqKPrxQGs63ysobVep
         M6p5myN02ytDyH4pIdSxy9+Kk1klmqGy4RNJ2g7vdE/5lsxAQA8IMIwOKUJ13WA4HF++
         8DGf5PlXLNMuhtACqVgIbrrN9uf1iqJZfUTdrh33xYaZfUsJlLE4RXogvah7W8SEEVVv
         lKsQ==
X-Gm-Message-State: AOJu0Ywm1ALFvz2PbcCwM2rv3mbMeJvxXgmjD/+hoqgJA6LvRhb0//CG
	ALQBVhGzTJK2+kLaXcDwFfwXmxI2dlmkaAcHgRcYNJPXn5jp3RGtQ3IC43aOdm9EY2iijV6Krup
	BUQLxr4D5q62wvCZLNA7FfRNqeX36AxkbBqVJbcVDbA==
X-Gm-Gg: AY/fxX4JWGoczkYsFY76QTY6HfoB/okUBhhGISRFoTy7QlTY4ygyTr7J5UloHylTYpZ
	LOP/H9XKvaGhYzfqVu+/LV+GB+QVTOAoFD639cKAmfId0e78jKNJoZ/6YiXlo3M9QYnB13UcWQK
	CClF3cuYA/0zqG5YHbrwb6tzLKpKUbVu5UnOcCntX3S0U1U1RvZGpvDO358pUvnJhHfca0/fgpx
	bxMFAPUqM4X6ZStlAWlSeCVpC6WJJAHc5j64DS0KjIBeJbx2QeFPydKmE0XbYa3NtRNtEB4
X-Google-Smtp-Source: AGHT+IHdPHzPScA0KEmXCZLn8MKPbwkHgXhcOLuxDeEFxKnNrBKvbWF+CCwCW88hetx1oIVRdoX9KDGqcqTXh0KEaY8=
X-Received: by 2002:a05:6214:5091:b0:87d:cb8d:2a98 with SMTP id
 6a1803df08f44-8887dfeddb5mr257320476d6.2.1765917622748; Tue, 16 Dec 2025
 12:40:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251213200410.31256-1-kiranrangoon0@gmail.com>
 <20251214010108.29535-1-kiranrangoon0@gmail.com> <5a20c5ee-b56c-472e-94a2-c7223c281b3e@t-8ch.de>
In-Reply-To: <5a20c5ee-b56c-472e-94a2-c7223c281b3e@t-8ch.de>
From: Kiran <kiranrangoon0@gmail.com>
Date: Tue, 16 Dec 2025 15:40:10 -0500
X-Gm-Features: AQt7F2rT0USoQxhJPccUqh-Lyjy3Wc4UAdZSoaXqPs9PdzKY-vzPXOW3lOjZXGs
Message-ID: <CA+uoJ5sE0uLwidR5_5+BZP3fS=ObYbWHsNQv+k8Na5aWL3ZwDg@mail.gmail.com>
Subject: Re: [PATCH v2] libuuid: Fix pre-1970 UUID v1 timestamp wraparound
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes I could work on this. I'll change pre-Unix-epoch v1/v6 UUID
timestamps to be treated as an error. uuid_time_v1() and
uuid_time_v6() will detect underflow, return failure, and
__uuid_time() will propagate it by returning -1 and setting tv_sec =3D
tv_usec =3D -1, unless you have any objections.


On Tue, Dec 16, 2025 at 8:08=E2=80=AFAM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> On 2025-12-13 20:01:08-0500, Kiran Rangoon wrote:
> > gregorian_to_unix now returns -1 and sets errno=3DEOVERFLOW
> > for timestamps before the Unix epoch. uuid_time_v1 and uuid_time_v6
> > now use signed arithmetic to prevent unsigned wraparound.
> >
> > This fixes uuidparse displaying far-future dates for historical UUIDs.
> >
> > The regression test has been updated to show actual result instead of h=
ardcoded wrong
> > date.
>
> Thanks!
>
> >
> > Example output:
> >     $ ./build/uuidparse bf2eb110-d788-1003-aa59-ce1e9e293641
> > Before:
> >     60041-08-13 16:41:36,271592-04:00
> > After:
> >     1969-12-31 19:00:00,000000-05:00
> >
> > Handling negative timestamps gracefully would require broader changes,
> > so I=E2=80=99ve kept this patch focused on preventing pre-1970 wraparou=
nd.
>
> IMO we should to this properly. Is this something you want to work on?
>
> > Signed-off-by: Kiran Rangoon <kiranrangoon0@gmail.com>
> > ---
> >  libuuid/src/uuid_time.c       | 15 +++++++++++----
> >  tests/expected/uuid/uuidparse |  2 +-
> >  2 files changed, 12 insertions(+), 5 deletions(-)
> >
> > diff --git a/libuuid/src/uuid_time.c b/libuuid/src/uuid_time.c
> > index c7516152b..f0d2c8f36 100644
> > --- a/libuuid/src/uuid_time.c
> > +++ b/libuuid/src/uuid_time.c
> > @@ -60,15 +60,22 @@
> >  /* prototype to make compiler happy */
> >  time_t __uuid_time(const uuid_t uu, struct timeval *ret_tv);
> >
> > -static uint64_t gregorian_to_unix(uint64_t ts)
> > +static int64_t gregorian_to_unix(uint64_t ts)
> >  {
> > -     return ts - ((((uint64_t) 0x01B21DD2) << 32) + 0x13814000);
> > +    const uint64_t offset =3D 0x01B21DD213814000ULL;
> > +
> > +    if (ts < offset) {
> > +        errno =3D EOVERFLOW;
> > +        return -1;
>
> The callers do not check for errors. Instead this gets converted to the
> epoch only by chance.
>
> > +    }
> > +
> > +    return ts - offset;
> >  }
> >
> >  static void uuid_time_v1(const struct uuid *uuid, struct timeval *tv)
> >  {
> >       uint32_t high;
> > -     uint64_t clock_reg;
> > +     int64_t clock_reg;
> >
> >       high =3D uuid->time_mid | ((uuid->time_hi_and_version & 0xFFF) <<=
 16);
> >       clock_reg =3D uuid->time_low | ((uint64_t) high << 32);
> > @@ -80,7 +87,7 @@ static void uuid_time_v1(const struct uuid *uuid, str=
uct timeval *tv)
> >
> >  static void uuid_time_v6(const struct uuid *uuid, struct timeval *tv)
> >  {
> > -     uint64_t clock_reg;
> > +     int64_t clock_reg;
> >
> >       clock_reg =3D uuid->time_low;
> >       clock_reg <<=3D 16;
> > diff --git a/tests/expected/uuid/uuidparse b/tests/expected/uuid/uuidpa=
rse
> > index 9edb05e4e..0f521a760 100644
> > --- a/tests/expected/uuid/uuidparse
> > +++ b/tests/expected/uuid/uuidparse
> > @@ -11,7 +11,7 @@ UUID                                  VARIANT   TYPE =
      TIME
> >  00000000-0000-3000-8000-000000000000  DCE       name-based
> >  00000000-0000-4000-8000-000000000000  DCE       random
> >  00000000-0000-5000-8000-000000000000  DCE       sha1-based
> > -00000000-0000-6000-8000-000000000000  DCE       time-v6    60038-03-11=
 05:36:10,955161+00:00
> > +00000000-0000-6000-8000-000000000000  DCE       time-v6    1970-01-01 =
00:00:00,000000+00:00
>
> If it is an error, the output should be empty.
>
> >  00000000-0000-0000-d000-000000000000  Microsoft
> >  00000000-0000-1000-d000-000000000000  Microsoft
> >  00000000-0000-2000-d000-000000000000  Microsoft
> > --
> > 2.47.3
