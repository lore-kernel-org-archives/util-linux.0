Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110713121232.GC3486@nb.net.home>
References: <1310485846-3685-1-git-send-email-kerolasa@iki.fi>
	<1310529931.4444.7.camel@offbook>
	<CAG27Bk0vW2LZySAf8B38OBbVaXpSDP81C+wVuA1vSW1rwhgwgg@mail.gmail.com>
	<20110713121232.GC3486@nb.net.home>
Date: Wed, 13 Jul 2011 16:54:22 +0200
Message-ID: <CAG27Bk2m+d=N9yVTSbByzhfkMUmP-d7heQXS643uWE3n+05+Mw@mail.gmail.com>
Subject: Re: [PATCH] minix: v3 super-block does not have s_state field
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: dave@gnu.org, util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Wed, Jul 13, 2011 at 14:12, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Jul 13, 2011 at 01:33:03PM +0200, Sami Kerola wrote:
>> On Wed, Jul 13, 2011 at 06:05, Davidlohr Bueso <dave@gnu.org> wrote:
>> > I don't think we should always rely on having the kernel headers, that=
's
>> > why the fallback is provided.
>> [snip]
>> > I think with this patch we address the issue without removing our
>> > fallback.
>>
>> The preprocessor directive bellow is problematic. I don't see where,
>> or how, it might get satisfied so I am afraid the 'fall back' is
>> always in use regardless whether an user has kernel headers or not.
>>
>> #ifdef KERNEL_INCLUDES_ARE_CLEAN
>>
>> To fix that I modified the patch to use autoconf to check whether each
>> necessary header is present, and use them if possible. Notice that
>> Dave that I wrote your name to Reviewed-by patch line so it would be
>> nice to hear that you're OK with the change. See the attachment, or
>> pull from my repository.
>
> =A0This is wrong way... the kernel types (e.g. u32, s64) are
> =A0*unexpected* in util-linux. The new code should not use this junk. We
> =A0have <stdint.h> and <inttypes.h>.

Fixed.

> =A0The mkfs.minix should not depend on kernel headers. It's normal that
> =A0we use our own (on kernel independent) copy of FS superbloks. See
> =A0libblkid code.

By depend do you mean;

1. Distrust that kernel headers are present, and have alternative
copy, but use them when they are present.
2. Use always util-linux copy of structures ignoring the possible
header even they might be present.

I assumed the 1 is correct. If the 2 is correct then Dave's patch
should be applied and I'll redo rest of the patches.

> =A0There is libblkid/src/superblocks/minix.c where are minix
> =A0superblocks, it would be probably better to move the superblocks to
> =A0iniclude/minix.h and use it everywhere.

So something like the next 4 changes.

The following changes since commit bfa8d39b5826b928deb6d84aee3a4a1d6557364c=
:

  build-sys: fix spaces versus tabs conflict (2011-07-11 15:12:06 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit minix

Sami Kerola (5):
      minix: v3 super-block does not have s_state field
      minix: use data types from stdint.h
      minix: move minix.h to include directory
      libblkid: use superblock structure from minix.h
      libblkid: use BLOCK_SIZE from minix.h

 configure.ac                     |    5 ++
 disk-utils/Makefile.am           |    4 +-
 disk-utils/mkfs.minix.c          |    2 -
 include/Makefile.am              |    1 +
 {disk-utils =3D> include}/minix.h  |  148 ++++++++++++++++++++++----------=
------
 libblkid/src/superblocks/minix.c |   37 +---------
 6 files changed, 96 insertions(+), 101 deletions(-)
 rename {disk-utils =3D> include}/minix.h (59%)

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
