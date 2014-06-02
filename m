Return-Path: mail@bernhard-voelker.de
Message-ID: <538CEB62.4020102@bernhard-voelker.de>
Date: Mon, 02 Jun 2014 23:23:46 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Ruediger Meier <sweet_f_a@gmx.de>
CC: kerolasa@gmail.com, Karel Zak <kzak@redhat.com>,
        Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 4/4] docs: setterm.1 clean up manual page groff style
References: <1400929696-12548-1-git-send-email-kerolasa@iki.fi>	<201405291223.40734.sweet_f_a@gmx.de>	<CAG27Bk02R6UE4qqws=KOh5YKZ+hZJUyM1i8Z2dZ0h65a5Bpu2A@mail.gmail.com>	<201406020035.40358.sweet_f_a@gmx.de> <CAG27Bk09hbETdviRdWyQ6QrrUOj-VUxqUurWAMTZuWFF4k=H9Q@mail.gmail.com>
In-Reply-To: <CAG27Bk09hbETdviRdWyQ6QrrUOj-VUxqUurWAMTZuWFF4k=H9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

> On 1 June 2014 23:35, Ruediger Meier <sweet_f_a@gmx.de> wrote:
> BTW I just noticed that bash's
> $ cd ''
> does NOT return error. But
> $ /usr/bin/cd ''
> does like it should IMO.

What is /usr/bin/cd? As this would do the chdir() in
a very-short-living sub-process, I'd consider this a
useless program (apart from checking whether chdir()ing
into the given directory would succeed).

Have a nice day,
Berny
