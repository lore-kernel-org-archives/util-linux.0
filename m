Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Ray Strode <halfline@gmail.com>
Subject: Re: [PATCH] login-utils: import environment from user manager on systemd systems
Date: Wed, 7 Dec 2016 21:04:35 +0100
Cc: util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Ray Strode <rstrode@redhat.com>
References: <1477427661-19788-1-git-send-email-halfline@gmail.com> <CAA_Uwz+od5AwWosSzb_j59v2LvdZ=ipmHe2s+_kZiccC6v-FnQ@mail.gmail.com>
In-Reply-To: <CAA_Uwz+od5AwWosSzb_j59v2LvdZ=ipmHe2s+_kZiccC6v-FnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201612072104.37323.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 07 December 2016, Ray Strode wrote:
> Hi Karel,
>
> On Tue, Oct 25, 2016 at 4:34 PM, Ray Strode <halfline@gmail.com> 
wrote:
> > From: Ray Strode <rstrode@redhat.com>
> >
> > If the user is using a systemd system, then its useful to grab the
> > environment from the systemd user manager process.
> >
> > This allows administrators to initialize the environment of the
> > sessions via systemd configuration.
>
> Any news on this?

I really don't like this as already discussed.

> --Ray
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
