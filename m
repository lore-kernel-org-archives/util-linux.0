Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110721154303.GF22568@nb.net.home>
References: <CAG27Bk0XXawQERH19+iUguDame2Pts_+bvrt8Of0+ib9KSW3NA@mail.gmail.com>
	<20110718221751.GD4354@nb.redhat.com>
	<CAG27Bk3vs54m7b6y_M_uq4RuyPBn-yhAEt2GhicsyY8F_+jJfw@mail.gmail.com>
	<20110721154303.GF22568@nb.net.home>
Date: Thu, 21 Jul 2011 20:37:52 +0200
Message-ID: <CAG27Bk1R_fG+SkFd1JfoiEyg7z8saJv4V+=K02Cz8_OHL9tz=w@mail.gmail.com>
Subject: Re: [git pull] schedutils
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 21, 2011 at 17:43, Karel Zak <kzak@redhat.com> wrote:
> =A0The 'ioprio' in the syscall:
>
> =A0 =A0 syscall(SYS_ioprio_set, which, who, ioprio);
>
> =A0encodes two information:
>
> =A0 =A0IOPRIO_PRIO_CLASS =A0- e.g. realtime, idle, ...
> =A0 =A0IOPRIO_PRIO_DATA =A0 - e.g. 0-7
>
> =A0this is reason why the docs is talking about "class" and "class data".
>
> =A0Anyway, merged with some minor changes and --classdata option :-)

Sounds reasonable.

> =A0Minor notes:
>
> =A0* .PP in man page within .IP block does not have the same meaning
> =A0 like blank line

Oops, that was sloppy from my side. Sorry.

> =A0* I think that
> =A0 =A0 =A0 =A0-c, --class NUM
> =A0 is better than
> =A0 =A0 =A0 =A0-c, --class=3DNUM

With equals sign is FSFism, which seemed like good starting point...

> =A0I have fixed this in ionice man page, but not in usage(). It would be
> =A0nice to use in all man pages and usage() functions the same syntax.
> =A0Maybe we can create any template or so to have it documented.

...but you are absolutely right again. Converting README.devel in
small chunks to a Documentation directory might be a way to go.
Contents of the directory could have help_and_version.txt for what you
said above, and I can recall recent minix & kernel headers
conversation which ought also be documented.

BTW what would you think about having a util-linux.h with inline
function to print in usage help & version option descriptions and
proper version output function. The first would make translation teams
happier when they do not need to write time after time the same
translations. Second would simply unify how version is printed, and if
it ever needs a modification it's easier to do. In practice the file
would be similar to coreutils system.h.

http://git.savannah.gnu.org/gitweb/?p=3Dcoreutils.git;a=3Dblob;f=3Dsrc/syst=
em.h

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
