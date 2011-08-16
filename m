Return-Path: bensberg@justemail.net
Message-Id: <1313485424.19019.140258130122469@webmail.messagingengine.com>
From: "Benno Schulenberg" <bensberg@justemail.net>
To: kerolasa@gmail.com
Cc: "Karel Zak" <kzak@redhat.com>, "util-linux"
 <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
In-Reply-To: <CAG27Bk0LpsVdCJhvOAstC_OpckzfBB05kcZcN_ByF_i_JQU6SQ@mail.gmail.com>
References: <20110815141948.GH2038@nb.net.home>
 <CAG27Bk0LpsVdCJhvOAstC_OpckzfBB05kcZcN_ByF_i_JQU6SQ@mail.gmail.com>
Subject: Re: man-pages and usage() howto
Date: Tue, 16 Aug 2011 11:03:44 +0200
List-ID: <util-linux.vger.kernel.org>


On Mon, 15 Aug 2011 21:12 +0200, "Sami Kerola" <kerolasa@iki.fi> wrote:
> On Mon, Aug 15, 2011 at 16:19, Karel Zak <kzak@redhat.com> wrote:
> > =C2=A0* argument required:
> >
> > =C2=A0 -o, --option FILE =C2=A0 =C2=A0# usage()
> > =C2=A0 -o, --option file =C2=A0 =C2=A0# man page
>=20
> I used GNU notation which has 'unnecessary' equals sign.
>=20
> -o, --option=3DFILE

The full GNU style seems to be this (for example in 'man grep'):

  -o FILE, --option=3DFILE

Since the util-linux man pages don't put the argument after the short
version of the option, the '  -o, --option FILE' variant would be for me
the logical condensed intersection.  Also, why give the impression
that the equals sign is needed when it is not?
=20
> The only reason I can think of why the equal sign is there is visual
> similarity with optional argument... [...]
>=20
> I also acknowledge the fact that no-one will ever use equals sign when
> giving required argument. The practise of dropping it is a rational
> reason not to specify it to usage() or man. I would say this is a
> question of choosing a convention in between visual symmetry or actual
> habits of people. IMHO the visual unity is better.

IMHO visual contrast is better.  When my fleeting glance sees an equals
sign OR square brackets, I know the argument is optional; when it does
not see an equals sign OR does not see square brackets, the argument is
required.  Redundancy is good.


> > =C2=A0 =C2=A0 =C2=A0 =C2=A0command [options] file

If in the usage() help text the arguments of options are written in
uppercase, wouldn't it be more consistent to then also write the
arguments of the command itself in uppercase (as for example
'man -h' and 'grep --help' do)?

        command [OPTIONS] FILE

(Also, to be fully correct, it would have to say "[OPTION...]" instead,
but I will let that go.)

About the other things I have not yet an opinion.

Regards,

Benno

--=20
http://www.fastmail.fm - Access all of your messages and folders
                          wherever you are
