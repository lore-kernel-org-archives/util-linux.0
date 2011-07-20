Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110718221926.GE4354@nb.redhat.com>
References: <1310485846-3685-1-git-send-email-kerolasa@iki.fi>
	<1310529931.4444.7.camel@offbook>
	<CAG27Bk0vW2LZySAf8B38OBbVaXpSDP81C+wVuA1vSW1rwhgwgg@mail.gmail.com>
	<20110713121232.GC3486@nb.net.home>
	<CAG27Bk2m+d=N9yVTSbByzhfkMUmP-d7heQXS643uWE3n+05+Mw@mail.gmail.com>
	<20110713173430.GD3486@nb.net.home>
	<1310609005.3482.0.camel@offbook>
	<20110714091829.GE3486@nb.net.home>
	<CAG27Bk0DYx+jCD-iqQvt1n=VdHszceTEAQQRvCKLvPXqpagTXA@mail.gmail.com>
	<20110718221926.GE4354@nb.redhat.com>
Date: Wed, 20 Jul 2011 20:53:11 +0200
Message-ID: <CAG27Bk3pxKEUPVE92=rZwA-FDHqA81TSM71J0Ati3mFXcGvE3g@mail.gmail.com>
Subject: Re: [PATCH] minix: v3 super-block does not have s_state field
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Davidlohr Bueso <dave@gnu.org>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 19, 2011 at 00:19, Karel Zak <kzak@redhat.com> wrote:
> On Thu, Jul 14, 2011 at 05:47:39PM +0200, Sami Kerola wrote:
>> +++ b/include/minix.h
>> @@ -1,69 +1,65 @@
>> =A0#ifndef __MINIX_H__
>> =A0#define __MINIX_H__
>
> =A0we usually use UTIL_LINUX prefix, so #ifndef UTIL_LINUX_MINIX_H.

Changed.

>> =A0#define BLOCK_SIZE_BITS 10
>> =A0#define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)
>
> =A0This is too generic. Please, use MINIX_ prefix.

Adding MINIX_ prefix will cause a greater change, but as you wish I did tha=
t.

>> =A0#define Inode (((struct minix_inode *) inode_buffer)-1)
>> =A0#define Inode2 (((struct minix2_inode *) inode_buffer)-1)
>>
>> =A0#define INODE_SIZE (sizeof(struct minix_inode))
>> =A0#define INODE2_SIZE (sizeof(struct minix2_inode))
>>
>> -int fs_version =3D 1; /* this default value needs to change in a near f=
uture */
>> -char *super_block_buffer, *inode_buffer =3D NULL;
>> +static int fs_version =3D 1; /* this default value needs to change in a
>> near future */
>> +static char *super_block_buffer, *inode_buffer =3D NULL;
>>
>> =A0static char *inode_map;
>> =A0static char *zone_map;
>
> =A0The global variables don't belong to this generic header file. The
> =A0stuff around inode_buffer, fs_version and the inline functions are
> =A0specific to the disk-utils/ utils. Please, add
> =A0disk-utils/minix_programs.h and use it in {mkfs,fsck}.minix.

Done.

The following changes since commit 872a1575e81f5ed1e871d4ed9558f43effe96423=
:

  dmesg: fix typo in usage() (2011-07-14 13:46:13 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit minix

Sami Kerola (7):
      include: minix.h: use data types from stdint.h
      include: remove kernel headers from minix.h
      include: move minix.h to include directory
      libblkid: use superblock structure from minix.h
      libblkid: use MINIX_BLOCK_SIZE from minix.h
      minix: move globals and inline functions to minix_programs.h
      libblkid: move MINIX_MAXPARTITIONS to minix.h

 disk-utils/Makefile.am           |    4 +-
 disk-utils/fsck.minix.c          |   99 ++++++++++---------
 disk-utils/minix.h               |  202 ----------------------------------=
----
 disk-utils/minix_programs.h      |  113 +++++++++++++++++++++
 disk-utils/mkfs.minix.c          |   77 +++++++-------
 include/Makefile.am              |    1 +
 include/minix.h                  |   97 ++++++++++++++++++
 libblkid/src/partitions/minix.c  |    6 +-
 libblkid/src/superblocks/minix.c |   33 +------
 9 files changed, 304 insertions(+), 328 deletions(-)
 delete mode 100644 disk-utils/minix.h
 create mode 100644 disk-utils/minix_programs.h
 create mode 100644 include/minix.h

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
