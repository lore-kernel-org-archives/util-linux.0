Return-Path: bensberg@justemail.net
Message-Id: <1381840942.1853.34205941.61403749@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <20131015113117.GC31477@x2.net.home>
References: <1381783511.18298.33939989.442C9894@webmail.messagingengine.com>
 <20131015082731.GA31477@x2.net.home>
 <1381830660.19586.34144785.7C200E19@webmail.messagingengine.com>
 <20131015113117.GC31477@x2.net.home>
Subject: Re: [patches] a few more man-page improvements
Date: Tue, 15 Oct 2013 14:42:22 +0200
List-ID: <util-linux.vger.kernel.org>


On Tue, Oct 15, 2013, at 13:31, Karel Zak wrote:
> On Tue, Oct 15, 2013 at 11:51:00AM +0200, Benno Schulenberg wrote:
> > Now it compiles fine, with only those five warnings in libfdisk/src/ask=
.c:
> > =C2=ABformat '%zd' expects argument of type 'signed size_t', but...=C2=
=BB and two
> > unused variables in misc-utils/cal.c (when compiled without ncurses).
>=20
>  Thanks! Fixed.

Well... the warnings for ask.c have gone, but now I get these three for gpt=
.c:

libfdisk/src/gpt.c: In function 'gpt_verify_disklabel':
libfdisk/src/gpt.c:1540:7: warning: format '%ld' expects argument of type '=
long int', but argument 3 has type 'uint64_t' [-Wformat]
libfdisk/src/gpt.c:1540:7: warning: format '%ld' expects argument of type '=
long int', but argument 5 has type 'uint64_t' [-Wformat]
libfdisk/src/gpt.c:1540:7: warning: format '%ld' expects argument of type '=
long int', but argument 3 has type 'uint64_t' [-Wformat]

And the ones for cal.c are still there:

misc-utils/cal.c:139:20: warning: 'term' defined but not used [-Wunused-var=
iable]
misc-utils/cal.c:141:13: warning: 'Slen' defined but not used [-Wunused-var=
iable]

Benno

--=20
http://www.fastmail.fm - Send your email first class
