Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110830084346.GO1855@nb.net.home>
References: <CAG27Bk0wyFiELxMA2Rj9DyqqMkP9dGm4J1Y=yU4S7gZFo00QFw@mail.gmail.com>
	<20110830084346.GO1855@nb.net.home>
Date: Tue, 30 Aug 2011 20:18:01 +0200
Message-ID: <CAG27Bk08kBQAY7xRZ8VoV4bj6ef6z9dtDBee585Xr6LXbB0kJA@mail.gmail.com>
Subject: Re: [git pull] documentation directory
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 30, 2011 at 10:43, Karel Zak <kzak@redhat.com> wrote:
> On Sat, Aug 06, 2011 at 07:57:53PM +0200, Sami Kerola wrote:
>> are available in the git repository at:
>> =A0 https://github.com/kerolasa/lelux-utiliteetit docs-dir
>
> =A0I found a small problem... IMHO there should be some COPYING
> =A0file in the libmount/ libblkid/ and libuuid/ directories.
>
> =A0It's probably overkill to duplicate the text on all places (or in
> =A0Documentation/licenses directory), so what about to add lib*/COPYING
> =A0with:
>
> =A0 =A0 =A0 =A0This library is free software; you can redistribute it and=
/or
> =A0 =A0 =A0 =A0modify it under the terms of the GNU Lesser General Public
> =A0 =A0 =A0 =A0License as published by the Free Software Foundation; eith=
er
> =A0 =A0 =A0 =A0version 2.1 of the License, or (at your option) any later =
version.
>
> =A0 =A0 =A0 =A0The complete text of the license is available at the
> =A0 =A0 =A0 =A0Documentation/licenses/COPYING.LGPL file.
>
> =A0and add one Documentation/licenses/COPYING.LGPL file for all libraries=
.

Done nearly that way. If I did not see wrong the libuuid uses Modified
BSD License. Secondly instead of writing LGPL I prefer to using v2.1
in file name.

> =A0I'm not sure if we need the LICENSE.pg file, the same text is at the
> =A0begin of the pg.c.

Yup, that seems unnecessary. The file is removed.

Is there anything else which should be changed?

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
