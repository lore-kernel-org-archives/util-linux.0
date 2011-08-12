Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110808114617.GL2204@nb.net.home>
References: <CAG27Bk0wyFiELxMA2Rj9DyqqMkP9dGm4J1Y=yU4S7gZFo00QFw@mail.gmail.com>
	<20110808114617.GL2204@nb.net.home>
Date: Fri, 12 Aug 2011 22:58:09 +0200
Message-ID: <CAG27Bk3uvpMC=Hx0cn25mAOGHxwFVNNXOWW3fyfvAEYrBA5+BA@mail.gmail.com>
Subject: Re: [git pull] documentation directory
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Mon, Aug 8, 2011 at 13:46, Karel Zak <kzak@redhat.com> wrote:
> On Sat, Aug 06, 2011 at 07:57:53PM +0200, Sami Kerola wrote:
>> are available in the git repository at:
>> =A0 https://github.com/kerolasa/lelux-utiliteetit docs-dir
>>
>> discussion, and few rejects, before the Documentation/ is done to
>> upstream. For instance you might disagree with contents of
>> 00-about-docs.txt, and perhaps example.files/ should be deleted.
>
> =A0The 'Warning about content' in 00-about-docs.txt is too crazy :-)
> =A0Let's:

I thought you might say something like that.

> =A0- cleanup the files
>  - remove obsolete information

Done in new patch `docs: clean up old readme files'. The clean up
could be more aggressive. For instance the fdisk.txt sounds very 90's
and has only a limited amount of usable information. Perhaps the file
be simply removed, or should someone be asked to volunteer to clean up
all {c,s,}fdisk documentation & manual pages? By glance that looks
quite large task.

> =A0- move valid information to the man pages

Perhaps I lacked imagination what could be moved coz I found so
little. See hwclock change for details.

> =A0- add info about authors to the AUTHORS file

I went through everything in Documentation/* and notice there's more
in NEWS file. Should that be migrated as well?

> =A0I have updated the example.files/ in the master branch.

Noted.

>> =A0README.devel =3D> Documentation/README.devel =A0 =A0 =A0 =A0 | =A0 =
=A00
>
> =A0see below
>
>> =A0.../ReleaseNotes}/v2.13-ReleaseNotes =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A00
>
> =A0What about to rename the directory to releases/ ? The NEWS file should
> =A0be updated too.

Done.

>> =A0README.licensing =3D> Documentation/licensing.txt =A0 =A0| =A0 =A00
>
> =A0It would be nice to keep this file in the top-level directory.

Put back to root.

>> =A0tests/README =3D> Documentation/tests.txt =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 =A00
>
> =A0howto-tests.txt

Renamed.

>> =A0Documentation/usage-howto.txt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0 73 ++++++++++++++++++++
>
> =A0howto-usage-function.txt
>
> =A0 and s/output/display/ in the file

Renamed & the wording is checked.

> =A0we also need howto-man-page.txt :-)

Something done, comments are welcome.

> =A0I think we can split the README file:
>
> =A0 =A0README =A0(basic info about project)
>
> =A0 =A0Documentation/howto-compilation.txt
>
> =A0In the howto-compilation.txt file should be also a note about
> =A0autogen.sh, static linking, klib and uClib and maybe some preferred
> =A0compiler options, I use:
>
> =A0 -Wmissing-parameter-type -Wsign-compare -Wtype-limits -Wuninitialized=
 \
> =A0 -Wunused-parameter -Wunused-but-set-parameter -fno-common
>
> =A0We can also split README.devel to:
>
> =A0 =A0Documentation/howto-compilation.txt (add extra section for
> =A0 =A0developers (or SCM users) about about autotools).
>
> =A0 =A0Documentation/howto-contribute.txt with info about "ideal
> =A0 =A0patches", coding style.
>
> =A0 =A0Documentation/source-code-management.txt

This README.devel split was done as well.


The following changes since commit 344f73442d3a45db5927c049eef1ed8cf5d13934=
:

  ipcs: use unsigned type for uid/gid (2011-08-09 15:30:19 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit docs-dir

Sami Kerola (11):
      docs: remove README.clear
      docs: Documentation directory added
      docs: add usage() howto for contributors
      docs: tell what the Documentation/ is about
      docs: new file Documentation/howto-compilation.txt
      docs: new file Documentation/howto-contribute.txt
      docs: new file Documentation/source-code-management.txt
      docs: new file Documentation/howto-man-page.txt
      docs: copy contributors from legacy files to AUTHORS
      docs: clean up old readme files
      docs: move setuid information from reame to hwclock.8

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
