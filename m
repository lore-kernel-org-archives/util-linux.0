Return-Path: casantos@datacom.ind.br
Date: Tue, 1 Aug 2017 09:09:22 -0300 (BRT)
From: Carlos Santos <casantos@datacom.ind.br>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <1033867833.2726878.1501589362348.JavaMail.zimbra@datacom.ind.br>
In-Reply-To: <20170801072017.yl7mgv64pq7ccj5e@ws.net.home>
References: <1971282138.2691482.1501546323018.JavaMail.zimbra@datacom.ind.br> <1705151756.2691717.1501548399616.JavaMail.zimbra@datacom.ind.br> <20170801072017.yl7mgv64pq7ccj5e@ws.net.home>
Subject: Re: Problem building util-linux without a separate ncursesw include
 dir
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <util-linux.vger.kernel.org>

> From: "Karel Zak" <kzak@redhat.com>
> To: "Carlos Santos" <casantos@datacom.ind.br>
> Cc: util-linux@vger.kernel.org
> Sent: Tuesday, August 1, 2017 4:20:17 AM
> Subject: Re: Problem building util-linux without a separate ncursesw incl=
ude dir

> On Mon, Jul 31, 2017 at 09:46:39PM -0300, Carlos Santos wrote:
>> > From: "Carlos Santos" <casantos@datacom.ind.br>
>> > To: util-linux@vger.kernel.org
>> > Sent: Monday, July 31, 2017 9:12:03 PM
>> > Subject: Problem building util-linux without a separate ncursesw inclu=
de dir
>>=20
>> > of util-linux. Would it be possible to make the location of ncursesw
>> > headers configurable, instead?
>=20
> We test for alone ncurses.h and term.h in the for non-wide ncurses.
> Can you send output from your configure from the current master
> branch (or v2.30.1)?

config.log: https://pastebin.com/DVAyx1Zb
defconfig for buildroot: https://pastebin.com/U3pz0hvm

>> I was thinking on something simple, like https://pastebin.com/VqM9G9yu
>=20
> Hmm, but you don't distinguish between wide and non-wide ncurses.

That's because on Buildroot only one of the variants can exist.

BTW I noticed that on Fedora each /usr/include/ncurses/<foo> is a
symlink to ../<foo>, so the situation is exactly the same.

--=20
Carlos Santos (Casantos) - DATACOM, P&D
=E2=80=9CThe greatest triumph that modern PR can offer is the transcendent=
=20
success of having your words and actions judged by your reputation,=20
rather than the other way about.=E2=80=9D =E2=80=94 Christopher Hitchens
