Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55BC146531
	for <util-linux@vger.kernel.org>; Mon,  8 Jan 2024 14:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFgBhrW5"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a28d61ba65eso195217966b.3
        for <util-linux@vger.kernel.org>; Mon, 08 Jan 2024 06:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704722847; x=1705327647; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FHVFWkqcsXFgSXt59WG6m3S0UaT1nd0bpbUndIAQNk=;
        b=nFgBhrW5a1ipqHiWl0hlBjVoITaERpfus20yybO1+NS2Ynbclfr8o1ijW6AcmGjsWL
         q13trOcUKwRiDWQdwD1r9OuyRb1vu02pUdgpoqVZsUX0q6Mo1Uvh+rGtgmHpqDqfH9Kb
         bYV1aMzmuQdk91KorSNpcWacASq4yEfw42gEaFjXBg2gpTs+HS941GMlIV7dLfI0/sf/
         JXDQJJCdBGYfaEzzkZQD0O+mUff/0gBpxdeLLjTmW5T3ItNnJa1qqvFKzZaPNo5jFh/5
         Nqu8OPBj4D2JeJ2EnfCAxcnB3kFO/mcbn8TIUbezGBTVh6o173xV97PkYc//Nv1sXvl9
         lRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704722847; x=1705327647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1FHVFWkqcsXFgSXt59WG6m3S0UaT1nd0bpbUndIAQNk=;
        b=Ga+Vu8WJ9XYIB+4QIHwqo4A+aQrwgyNd2G3CZzo+LqLh9jmOhMG9pixzt0rxT9WIa7
         thkXOEuZS3/m8j/W+soz+JKOQ1+C008vGgSGzqdjHFe64py6HRQHkHxCAsH8Md6L/kCv
         H+Be6+e/UVWAJaN+iq/V1GMd31pOOiXrKjG84MayO5yqe0hUBAR1sArApWZk3kmqNKbW
         wPTMGjRxmWHCeWp252fNMSsfni1wTGKMPcszJUaxZlfGQZlp1JdSMFT0vTlQzMf5ntAE
         QhnMZiU6AXqKr0OvALyFSVEBOQ/jpQkaExVEl1XUxb+quSuUy6aRVNekZfh6DaYJcYTB
         T5Qg==
X-Gm-Message-State: AOJu0Yy4FRIVz6xk9ZzNKb/gZOgreP6VRGrGme8aG7uC5jZIu2HrTnSz
	9n/k7ja2mLof5w/dGH4W8fm2dIjxB+A3T04NYaI=
X-Google-Smtp-Source: AGHT+IEZqlfX0SgKhi16cdojsVjF5zPrRwhGuyqg+WLQdYnz/iS9g5Vz9PjbWOwvLz5m9zyzrdImpH/WkvX6OSHu29k=
X-Received: by 2002:a17:906:225d:b0:a23:68c7:fe93 with SMTP id
 29-20020a170906225d00b00a2368c7fe93mr902074ejr.194.1704722847402; Mon, 08 Jan
 2024 06:07:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231183336.18934-1-echron@arista.com> <20240102115815.av7ges3f47m6bciq@ws.net.home>
 <CAFbqbibqO9wNc1JgaQ6FPTgoUP9u9J1wnTGxp+6W_QcAryLKAw@mail.gmail.com>
In-Reply-To: <CAFbqbibqO9wNc1JgaQ6FPTgoUP9u9J1wnTGxp+6W_QcAryLKAw@mail.gmail.com>
From: Edward Chron <echron@gmail.com>
Date: Mon, 8 Jan 2024 06:07:16 -0800
Message-ID: <CAFbqbibTppnw40BfdqjKfLHOiDFaJWD4nypMp6vrVnL5VMqcpg@mail.gmail.com>
Subject: Re: [PATCH] util-linux-demsg-issue-2666-patch-1.patch
To: Karel Zak <kzak@redhat.com>
Cc: Edward Chron <echron@arista.com>, util-linux@vger.kernel.org, colona@arista.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I've posted the revised patch series with the recommended fix.

Let me know if there is any additional work needed.

Thank you,

Edward

On Wed, Jan 3, 2024 at 6:51=E2=80=AFAM Edward Chron <echron@gmail.com> wrot=
e:
>
> Thank you Karel, I will fix this test issue and resubmit the patch series=
.
>
> On Tue, Jan 2, 2024 at 3:58=E2=80=AFAM Karel Zak <kzak@redhat.com> wrote:
> >
> > On Sun, Dec 31, 2023 at 10:33:36AM -0800, Edward Chron wrote:
> > > +     if (*rec->caller_id) {
> > > +             if (ctl->json) {
> > > +                     ul_jsonwrt_value_s(&ctl->jfmt, "caller", rec->c=
aller_id);
> > > +             } else {
> > > +                     char cidbuf[PID_CHARS_MAX+3] =3D {'\0'};
> > > +
> > > +                     sprintf(cidbuf, "[%*s] ",
> > > +                             (char)ctl->caller_id_size, rec->caller_=
id);
> > > +                     ctl->indent +=3D strnlen(cidbuf, sizeof(cidbuf)=
);
> > > +                     fputs(cidbuf, stdout);
> > > +             }
> > > +     }
> >
> > The variable width (ctl->caller_id_size) of caller ID makes your
> > regression test fragile, see:
> >
> > https://github.com/util-linux/util-linux/actions/runs/7384780996/job/20=
088287790?pr=3D2647
> >
> > --- /home/runner/work/util-linux/util-linux/tests/expected/dmesg/cid-li=
mit      2024-01-02 10:34:02.893193174 +0000
> > +++ /home/runner/work/util-linux/util-linux/tests/output/dmesg/cid-limi=
t        2024-01-02 10:38:29.209015303 +0000
> > @@ -1,4 +1,4 @@
> > -[    1.000000] [    T1] example[1]
> > -[    8.000000] [    T2] example[2]
> > -[   27.000000] [    T3] example[3]
> > -[   64.000000] [    T4] example[4]
> > +[    1.000000] [   T1] example[1]
> > +[    8.000000] [   T2] example[2]
> > +[   27.000000] [   T3] example[3]
> > +[   64.000000] [   T4] example[4]
> >
> >
> > I see two possible ways to fix it:
> >
> >  * "normalize" the output in the tests -- just use sed(1) to
> >    remove all the blanks space "[    T4]" to "[T4]", so the output
> >    will be always the same
> >
> >  * or use fixed width for the caller_id in dmesg.c
> >
> >
> >     Karel
> >
> > --
> >  Karel Zak  <kzak@redhat.com>
> >  http://karelzak.blogspot.com
> >
