Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F1F1C280
	for <util-linux@vger.kernel.org>; Wed,  3 Jan 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCOO7eRS"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-556cd81163fso710405a12.1
        for <util-linux@vger.kernel.org>; Wed, 03 Jan 2024 06:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704293512; x=1704898312; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Avwe/fc9stIhe1UuWWulD2jVq1Lbt8eqJQjorIXTeuU=;
        b=hCOO7eRSpROH9EHkI6Xr4sZI7yO+T3wkd59mBC+jkKjo9HFTyk2frofV8NkrnvC5IR
         iTIjW9Ns9YDXPujmbH5lU40ttmPJpKgGQeN3As5YxTQi2wX8q78mRSnB192G7Z/0x4dG
         DHQQyOPo4FLaR+44aFB31OWaW6/K63azo9tg+IdygWDX3Vnqj3G2C+379lZx9bO4dZq+
         WZhtWMsLOF/2spqPhH+heAQ8IeBQa7P0Rh8tYd4LzpcC6ACLFyufXaJPqkHasJws7wuD
         TjxTpIYYMJNxcsBDh11+QfWktKhbdp3jl8+qSkAUFfzE3BEgZGdnixQeGQoB9litkKkN
         IDfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704293512; x=1704898312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Avwe/fc9stIhe1UuWWulD2jVq1Lbt8eqJQjorIXTeuU=;
        b=WIqcaCngfzZtzhYR+0lSWd04mAelkxmkJ8SFvhAeC68ExsRlhhxp3/T4d/b+Jqov1/
         WodcrTX9r5vuDBhngLjIN1ajWEaNDV/mfmshHLLz/Q1hT/y7BNROm3PdZTnKa5bHYlSi
         mrEK219T0xepwuIrDxsw3ba3YDvApq7+UP1tQSTn9SU1wNDON/mfrkwoSHjS3lUKYVRi
         +uUsHBafCQTsgzdQmgVxRx6UH7CniGCAtLn4MAgNA7Vhdpz8UivVKhgxN9EpI4PiFmVH
         i8dBx7fHJR5DrpbipaEWZXu6MlnLXgEF3BOddcmJGbEaXJbRtSSi60MQyge4M8rr7Snz
         0wvg==
X-Gm-Message-State: AOJu0YxaDoKoH5dQ7sKtLo1glI7Wx/1rJnrS9LY6z5m6i0VEagn5uvcr
	cKHNrdBd0N7eZgnkE3YP95tCGkvlecjkJMTtXek=
X-Google-Smtp-Source: AGHT+IEQOa+LOLDqhH1oxchzWnYY7CWOrdLA7H8z/MseWaKue2vMq542kFQBdhLkF/Lho3syM5n+QO4NGKT89xJMDtw=
X-Received: by 2002:a17:907:592:b0:a28:ad3f:73e8 with SMTP id
 vw18-20020a170907059200b00a28ad3f73e8mr174329ejb.30.1704293512084; Wed, 03
 Jan 2024 06:51:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231231183336.18934-1-echron@arista.com> <20240102115815.av7ges3f47m6bciq@ws.net.home>
In-Reply-To: <20240102115815.av7ges3f47m6bciq@ws.net.home>
From: Edward Chron <echron@gmail.com>
Date: Wed, 3 Jan 2024 06:51:41 -0800
Message-ID: <CAFbqbibqO9wNc1JgaQ6FPTgoUP9u9J1wnTGxp+6W_QcAryLKAw@mail.gmail.com>
Subject: Re: [PATCH] util-linux-demsg-issue-2666-patch-1.patch
To: Karel Zak <kzak@redhat.com>
Cc: Edward Chron <echron@arista.com>, util-linux@vger.kernel.org, colona@arista.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Karel, I will fix this test issue and resubmit the patch series.

On Tue, Jan 2, 2024 at 3:58=E2=80=AFAM Karel Zak <kzak@redhat.com> wrote:
>
> On Sun, Dec 31, 2023 at 10:33:36AM -0800, Edward Chron wrote:
> > +     if (*rec->caller_id) {
> > +             if (ctl->json) {
> > +                     ul_jsonwrt_value_s(&ctl->jfmt, "caller", rec->cal=
ler_id);
> > +             } else {
> > +                     char cidbuf[PID_CHARS_MAX+3] =3D {'\0'};
> > +
> > +                     sprintf(cidbuf, "[%*s] ",
> > +                             (char)ctl->caller_id_size, rec->caller_id=
);
> > +                     ctl->indent +=3D strnlen(cidbuf, sizeof(cidbuf));
> > +                     fputs(cidbuf, stdout);
> > +             }
> > +     }
>
> The variable width (ctl->caller_id_size) of caller ID makes your
> regression test fragile, see:
>
> https://github.com/util-linux/util-linux/actions/runs/7384780996/job/2008=
8287790?pr=3D2647
>
> --- /home/runner/work/util-linux/util-linux/tests/expected/dmesg/cid-limi=
t      2024-01-02 10:34:02.893193174 +0000
> +++ /home/runner/work/util-linux/util-linux/tests/output/dmesg/cid-limit =
       2024-01-02 10:38:29.209015303 +0000
> @@ -1,4 +1,4 @@
> -[    1.000000] [    T1] example[1]
> -[    8.000000] [    T2] example[2]
> -[   27.000000] [    T3] example[3]
> -[   64.000000] [    T4] example[4]
> +[    1.000000] [   T1] example[1]
> +[    8.000000] [   T2] example[2]
> +[   27.000000] [   T3] example[3]
> +[   64.000000] [   T4] example[4]
>
>
> I see two possible ways to fix it:
>
>  * "normalize" the output in the tests -- just use sed(1) to
>    remove all the blanks space "[    T4]" to "[T4]", so the output
>    will be always the same
>
>  * or use fixed width for the caller_id in dmesg.c
>
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
>
