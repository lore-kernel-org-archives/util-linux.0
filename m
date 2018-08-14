Return-Path: martin@lichtvoll.de
From: Martin Steigerwald <martin@lichtvoll.de>
To: Karel Zak <kzak@redhat.com>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>, Bruce Dubbs <bruce.dubbs@gmail.com>, util-linux@vger.kernel.org
Subject: Re: su(1) --whitelist-environment
Date: Tue, 14 Aug 2018 12:47:39 +0200
Message-ID: <13005040.2n2PM0qaVI@merkaba>
In-Reply-To: <20180814093257.nglcor4c3jagjyxv@ws.net.home>
References: <20180810092401.inc32ady3eidzyjo@ws.net.home> <745f75b6-d849-a519-7855-9de62d999e06@bernhard-voelker.de> <20180814093257.nglcor4c3jagjyxv@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
List-ID: <util-linux.vger.kernel.org>

Karel, thank you for considering to add an option to whitelist certain=20
environment variables. I bet my feedback my have given some inspiration=20
to this.

Karel Zak - 14.08.18, 11:32:
> On Mon, Aug 13, 2018 at 10:57:01PM +0200, Bernhard Voelker wrote:
> > On 08/10/2018 11:06 PM, Bruce Dubbs wrote:
[=E2=80=A6]
> > I'm 50:50.  The point was to pass in variables values per
> > environment
> > to a process inside 'su' (or 'sudo'), and one can achieve that with
> > e.g.
> BTW, sudo has env_check, env_delete, or env_keep to control
> environment in the sudoers.

I meanwhile use sudo for taking over SSH_AUTH_SOCK exactly for this=20
reason. Initializing SSH_AUTH_SOCK manually in a script that runs as=20
root seems much more error prone to me. I chose to have exactly the=20
SSH_AUTH_SOCK of the user who did sudo in the root environment and not=20
the SSH_AUTH_SOCK of another user.

It may be better to use sudo anyway, but I am not going to lock my root=20
account on my laptop like its done with Ubuntu by default. I even=20
switched sudo to require the root password on my laptop meanwhile. As=20
sudo can do all this, I don=C2=B4t really need su, but I think it would not=
=20
hurt to add an option like it and recommend it over just using su=20
without "-".

> >   $ su -c 'env VAR=3D"val" myscript' user
> >=20
> > Well, this might become slightly trickier with real shell or
> > environment>=20
> > variables wrt/ correct shell quoting:
> >   $ VAR=3D'some value'
> >   $ su -c 'env VAR=3D"'"$VAR"'" myscript' user
>=20
> Well, probably usable way for scripts, but ugly for users on command
> line.
>=20
> All the idea behind the patch is make things more user-friendly
>=20
>     su -w GREP_COLOR,COLORFGBG - kzak
>=20
> seems better than assume -c 'env VAR ..."

I quite like this approach after I got why just taking over the complete=20
environment of the user can cause security and other issues in script=20
behavior at least on machines used by mutiple users. And can cause=20
issues if someone else manages to manipulate the environment of a user=20
only I should have access to.

Thanks,
=2D-=20
Martin
