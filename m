Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110729084638.GC24754@nb.net.home>
References: <CAG27Bk1-X+eqrVwP7cfZp-9-aCBwPtnYYBRJGi7wBt2-zaOMjA@mail.gmail.com>
	<20110728224430.GB24754@nb.net.home>
	<20110729084638.GC24754@nb.net.home>
Date: Fri, 29 Jul 2011 11:03:04 +0200
Message-ID: <CAG27Bk2aOxVvj3gpeEnFEP=MSBaH38WuLaDK+F9ggrwen+hhkQ@mail.gmail.com>
Subject: Re: [git pull] miscellaneous compiler warning fixes etc
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 29, 2011 at 10:46, Karel Zak <kzak@redhat.com> wrote:
> On Fri, Jul 29, 2011 at 12:44:30AM +0200, Karel Zak wrote:
>> On Thu, Jul 28, 2011 at 11:33:42PM +0200, Sami Kerola wrote:
>> > - =A0 iter->done =3D 1;
>> > + =A0 iter->done |=3D 1;
>>
>> =A0Why we need this change? IMHO it's unnecessary.
>
> =A0The bit-fields should probably "unsigned int" for better portability,
> =A0(otherwise it's implementation-defined). I'll fix it.

My thinking with implicit overflow fixes where that the warning may
mean there is a weird behaving bug. Making sure that the whole source
compiles without implicit overflow warnings makes tracing of these
easier. I used same rationality to the only `is always true/false'
warnings.

Getting the chrt usage & options right clearly has to wait
instructions in Documentation directory.

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
