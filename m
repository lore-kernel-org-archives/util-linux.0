Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: Re: [PATCH 4/4] docs: setterm.1 clean up manual page groff style
Date: Mon, 2 Jun 2014 23:35:27 +0200
Cc: kerolasa@gmail.com, Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@justemail.net>,
        "Util-Linux" <util-linux@vger.kernel.org>
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi> <CAG27Bk09hbETdviRdWyQ6QrrUOj-VUxqUurWAMTZuWFF4k=H9Q@mail.gmail.com> <538CEB62.4020102@bernhard-voelker.de>
In-Reply-To: <538CEB62.4020102@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201406022335.27518.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Monday 02 June 2014, Bernhard Voelker wrote:
> > On 1 June 2014 23:35, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> > BTW I just noticed that bash's
> > $ cd ''
> > does NOT return error. But
> > $ /usr/bin/cd ''
> > does like it should IMO.
>
> What is /usr/bin/cd? As this would do the chdir() in
> a very-short-living sub-process, I'd consider this a
> useless program (apart from checking whether chdir()ing
> into the given directory would succeed).
>
> Have a nice day,
> Berny
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux"
> in the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

Ooops :) Of course it does not exist. But the error
looks (almost) plausible, lol

$ /usr/bin/cd ""
sh: /usr/bin/cd: No such file or directory

cu,
Rudi
