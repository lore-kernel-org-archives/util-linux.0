Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="fzvxEaRD"
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687F1198
	for <util-linux@vger.kernel.org>; Mon, 27 Nov 2023 10:26:52 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-67a4645fdc3so7086936d6.0
        for <util-linux@vger.kernel.org>; Mon, 27 Nov 2023 10:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701109611; x=1701714411; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIji7EaTA2NmjKJBC6OMvz1vF3bEivLgvfksEsBQmuk=;
        b=fzvxEaRDbkWngYYwYITOOSe00WahvqIcGfITV28QNuInpUGKrm7U8i3JFNFzGUy2jb
         tTqzAmo/oQXlPKOB33PVu9AWcxXeDdG3E4RTznTbrlvG2Pwu+yB7orqqsuumCyDAdQgH
         hXFIUTIIBPl86iN4uzwOjrX9v1MHayBnmmWtw2GGje1HO3rw8lBciCPvvC+S2qBUMtSi
         VvNezo81FS6Z+nMaZfo57UB6jBjqm9BbjI6T6aZd+55AVP/MYXEgTr0gp9QkDJbpY/+v
         H4wRDamengGKVqZBmaAVrHG8lLWYvGN825Yn8qr4rSJxugKVmFnEvaRlyNMKS02iMczf
         JsOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109611; x=1701714411;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIji7EaTA2NmjKJBC6OMvz1vF3bEivLgvfksEsBQmuk=;
        b=bVPOsg/07o9iHjfay0eWtNZIOmUaHVrc45BFIcJ8C2GCbzSO6XfQLLt+ffAentOPAZ
         QkS0TDjeAmgaJoMcnDUoMiKa2z2afaWybnM8le9EXyIXclkhVsO0bs2dKsXgGiPks9cr
         vnqXThiVNl46du1ccMly4tAV3BCQqunnE31UgkZ0IiRjI8v8d+W73nbQq/K8qVYWT/l/
         PawSMcq4whztTbojhB2IpLc8KqBQErcfAF1gkWKIx5eQKDPn/ybmPd81T7y5u0h4PgNC
         oCPs83PNBmpW29WqW58BPd8HL/6Rv2RGOjj/kd7hodO4xBCNujCPhpta/UAiedFr6ztk
         VJEA==
X-Gm-Message-State: AOJu0Yxy59m7t0t6/hTRqIb22FIbfwgII4PxhwGjYjiyh/YWgR7QTRaz
	s53e4D3qJbu8pnOqvPeHo0DowCEIH1Av9QRZca6GRMrJBqTbZgtTx6k55w==
X-Google-Smtp-Source: AGHT+IGoDfcUPXkcvzl05V+zqaxHYrZtWRakW2haW7nkL1KvkW0DNBRwnybzTATAvkZ6eewr+BAi1KPLjpQZcl/8rQ4=
X-Received: by 2002:ad4:4e02:0:b0:66f:bcc5:cf70 with SMTP id
 dl2-20020ad44e02000000b0066fbcc5cf70mr12730053qvb.42.1701109611277; Mon, 27
 Nov 2023 10:26:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110232612.10969-1-rthukral@arista.com> <20231123093045.c5cmdviyupxr2wn7@ws.net.home>
In-Reply-To: <20231123093045.c5cmdviyupxr2wn7@ws.net.home>
From: Rishabh Thukral <rthukral@arista.com>
Date: Mon, 27 Nov 2023 12:26:40 -0600
Message-ID: <CAPfLGEFzMe2qXTE=wXiWNBkHk=F0wsASmUFnzd+9N+XwPUQOSg@mail.gmail.com>
Subject: Re: [PATCH] util-linux/sys-utils dmesg support for additional human
 readable timestamp
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Karel,
Thanks for reviewing the patch and sharing your feedback. I'll work on
the changes that are recommended. I also wanted to share the thought
behind this design approach to stick with a fixed order of timestamp
formats. Since we are allowing users to specify the `--time-format`
option multiple times, there is no potential limit to how many times
the user might specify it. There could be duplicate entries of the
same time format appearing again and again and we'll have to collect
the entire user input requiring an arbitrarily large input buffer.
With a fixed-size buffer, there might be a possibility of buffer
overflow. One alternative here is to have a complex data structure
that is fixed in size and keeps track of unique time formats in a
sequence of appearance in user input. Would it be a good idea to have
something like this?

The existing approach of marking which timestamps were included in
user input makes it easier to deal with the interactions with other
time-format options like `-d (--delta)`, `-T (--ctime)`, `-H
(--human)`, `-e (--reltime)`, `-r (--raw)`, `-t (--notime)`. If we
maintain a list of all user input we might have to insert, delete, or
replace some entries based on these other specified options and follow
a convention in what order should new values be inserted.

I added the value TIMESTAMP_FMT_INIT_SET in addition to just SET and
UNSET counterparts to support the overriding behavior that we
currently have where the default value is overridden if the user has
specified `--time-format` option but it should not be overridden if
the user has explicitly specified the default option as one of the
timestamp formats. You're right, we would not need this if we just
maintained a list of user input.

Let me know your thoughts on this and I can proceed to implement
changes based on your suggestions.

Regards
Rishabh Thukral


On Thu, Nov 23, 2023 at 3:30=E2=80=AFAM Karel Zak <kzak@redhat.com> wrote:
>
>
>  Hi Rishabh,
>
> sorry for delay
>
> On Fri, Nov 10, 2023 at 03:26:12PM -0800, Rishabh Thukral wrote:
> > This change updates the --time-format option in dmesg to enable the
> > user to specify it multiple times with different formats with each
>
> good idea
>
> > input providing a timestamp format among the currently supported
> > choices. This enables seeing the dmesg logs in both seconds since boot
> > and human readable format simultaneously in each row of the log output.
> > The sequence of timestamp format is fixed and independent of the order
> > in which the user provides the desired formats.
>
> and would be better to support arbitrary (user defined) order?
>
>   ctl->time_fmts[ ctl->ntime_fmts++ ] =3D DMESG_TIMEFTM_FOO;
>   ctl->time_fmts[ ctl->ntime_fmts++ ] =3D DMESG_TIMEFTM_BAR;
>
> and print it by a simple loop
>
>   for (i =3D 0; i < ctl->ntime_fmts; i++)
>     switch (ctl->time_fmts[ i ]) {
>        ...
>     }
>
> I guess the implementation will be more simple.
>
> > -             if (ctl->time_fmt !=3D DMESG_TIMEFTM_RELTIME) {
> > +             if (ctl->time_fmts[DMESG_TIMEFTM_RELTIME] =3D=3D TIMESTAM=
P_FMT_UNSET) {
>
> This code pattern is used pretty often in your patch, maybe add macros
>
>  #define is_timefmt_set(c, f)       ((c)->time_fmts[DMESG_TIMEFTM_ ##f] =
=3D=3D TIMESTAMP_FMT_SET))
>  #define is_timefmt_unset(c, f)     ((c)->time_fmts[DMESG_TIMEFTM_ ##f] =
=3D=3D TIMESTAMP_FMT_UNSET))
>  #define is_timefmt_initset(c, f)   ((c)->time_fmts[DMESG_TIMEFTM_ ##f] =
=3D=3D TIMESTAMP_FMT_INIT_SET))
>
> and use
>
>   if (is_timefmt_set(ctl, RELTIME))
>
> in code.
>
> > @@ -1388,9 +1416,11 @@ int main(int argc, char *argv[])
> >               .action =3D SYSLOG_ACTION_READ_ALL,
> >               .method =3D DMESG_METHOD_KMSG,
> >               .kmsg =3D -1,
> > -             .time_fmt =3D DMESG_TIMEFTM_TIME,
>
> I guess you can use
>
>         .time_fmts[DMESG_TIMEFTM_TIME] =3D TIMESTAMP_FMT_INIT_SET,
>
> >               .indent =3D 0,
> >       };
> > +     memset(ctl.time_fmts, 0,
> > +             TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED * sizeof(*(ctl.ti=
me_fmts)));
>
> You do not need memset() here. All unspecified struct fields in 'ctl'
> are set zero according to C standards (if any other fields are
> explicitly initialized).
>
> > +     ctl.time_fmts[DMESG_TIMEFTM_TIME] =3D TIMESTAMP_FMT_INIT_SET;
> >       int colormode =3D UL_COLORMODE_UNDEF;
> >       enum {
> >               OPT_TIME_FORMAT =3D CHAR_MAX + 1,
> > @@ -1475,7 +1505,9 @@ int main(int argc, char *argv[])
> >                       ctl.action =3D SYSLOG_ACTION_CONSOLE_ON;
> >                       break;
> >               case 'e':
> > -                     ctl.time_fmt =3D DMESG_TIMEFTM_RELTIME;
> > +                     if (ctl.time_fmts[DMESG_TIMEFTM_TIME] =3D=3D TIME=
STAMP_FMT_INIT_SET)
> > +                             ctl.time_fmts[DMESG_TIMEFTM_TIME] =3D TIM=
ESTAMP_FMT_UNSET;
> > +                     ctl.time_fmts[DMESG_TIMEFTM_RELTIME] =3D TIMESTAM=
P_FMT_SET;
>
> This complicated setup will be unnecessary if we will not need fixed
> order, right? :-)
>
>     Karel
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
>
