Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20120611094851.GA21893@x2.net.home>
References: <CAG27Bk1p9gqdiZSjmHcsWvTTs9WKU=vx0dYvtZVLCGJ1iuAnyg@mail.gmail.com>
	<20120611094851.GA21893@x2.net.home>
Date: Mon, 11 Jun 2012 22:19:02 +0200
Message-ID: <CAG27Bk0AK4rA9TGczXzSnUABd29p0krr-vdPH=Eyp8LO8GpVFw@mail.gmail.com>
Subject: Re: [pull] require C99, add robustness and small fixes
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 11, 2012 at 11:48 AM, Karel Zak <kzak@redhat.com> wrote:

New try available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2012wk23

for you to fetch changes up to 1edd8af70b4794c796d0faed0cf763ff3474b92e:

  lsblk: use blkdev_scsi_type_to_name() (2012-06-11 22:06:06 +0200)

----------------------------------------------------------------
Sami Kerola (13):
      setarch: do not use -1 as array index [cppcheck]
      blkid: fix realloc memory leak [cppcheck]
      uuidd: use output redirection which works [checkbashisms]
      include: fix spurious list.h warnings
      build: fix redundant redeclaration warnings
      build: fix unused parameter warnings
      sysfs: fix printf format warnings
      include: fix void pointer arithmetics warnings
      docs: clean up partx.8 manual
      eject: inform if CD-ROM drive is not ready
      wipefs: use symbolic value for markup mode
      blkdev: add blkdev_scsi_type_to_name()
      lsblk: use blkdev_scsi_type_to_name()

> On Sun, Jun 10, 2012 at 11:11:34PM +0200, Sami Kerola wrote:
>> diff --git a/configure.ac b/configure.ac
>> index 2280e7e..13c9637 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -80,6 +80,24 @@ AC_CANONICAL_HOST
>> =A0AC_C_CONST
>> =A0AC_C_VOLATILE
>> =A0AC_C_BIGENDIAN
>> +if test "$cross_compiling" =3D no; then
>> + =A0if test "x$ac_cv_prog_cc_c99" =3D "xno" || test "x$ac_cv_prog_cc_c9=
9"
>> =3D "x"; then
>> + =A0# We might be on RHEL5 with a git checkout and so broken
>> + =A0# autoconf. Check if CC is gcc and if it bails when given -std=3Dgn=
u99.
>> + =A0# If not, use that. =A0Yuck.
>> + =A0 =A0if test "x$ac_cv_c_compiler_gnu" =3D "xyes"; then
>> + =A0 =A0 =A0 CC=3D"$CC -std=3Dgnu99"
>> + =A0 =A0 =A0 AC_RUN_IFELSE(
>> + =A0 =A0 =A0 =A0 =A0[AC_LANG_PROGRAM([],[[
>> + =A0return 0;
>> + =A0 =A0 =A0]])],
>> + =A0 =A0 =A0[],
>> + =A0 =A0 =A0[AC_MSG_ERROR([Could not find a C99 compatible compiler])])
>> + =A0 =A0else
>> + =A0 =A0 =A0AC_MSG_ERROR([Could not find a C99 compatible compiler])
>> + =A0 =A0fi
>> + =A0fi
>> +fi
>
> =A0AC_PROG_CC_C99 sounds really like a better solution, although I have
> =A0autoconf 2.68 on Fedora 16 :-(

I will leave the C99 update to someone who has better insight how not
to shoot oneself to foot. In other words dropped from the most recent
pull request.

>> --- a/misc-utils/blkid.c
>> +++ b/misc-utils/blkid.c
>> @@ -365,8 +365,10 @@ static int append_str(char **res, size_t *sz,
>> const char *a, const char *b)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>>
>> =A0 =A0 =A0 str =3D realloc(str, len + 1);
>> - =A0 =A0 if (!str)
>> + =A0 =A0 if (!str) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 free(res);
>
> =A0 =A0 =A0 =A0free(*res);

This is fixed.

>> diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
>> index 9e894ef..f9e05b6 100644
>> --- a/misc-utils/lsblk.c
>> +++ b/misc-utils/lsblk.c
>> @@ -527,6 +527,12 @@ static char *get_type(struct blkdev_cxt *cxt)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type =3D "mo=
-disk"; break;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 0x0e: /* TYPE_RBC */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type =3D "rb=
c"; break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Perhaps inc=
lude/scsi/scsi.h in
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* kernel gi=
t section 'DEVICE TYPES'
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* will know=
 what was found. =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sprintf(type, =
"0x%02x", x);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> =A0What about to add scsi_type_to_name() to lib/blkdev.c and add
> =A0SCSI_TYPE_* macros (TYPE_* sounds too generic) to include/blkdev.h
> =A0with fallbacks for too old /usr/include/scsi/scsi.h files.

I like this. Have a look of the second last patch which will add
function to blkdev. Perhaps it reassembles to some extent what you
where thinking of.

>> +static void set_exclusive(int *what, int how)
>> +{
>> + =A0 =A0 if (*what =3D=3D ACT_NONE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 *what =3D how;
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 }
>> + =A0 =A0 if (*what =3D=3D how)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 errx_mutually_exclusive("--{add,delete,show,list,raw,pairs}");
>> +}
>
> =A0This is good idea, I guess we have the same problem on more places
> =A0where is the "mutually exclusive" error message.

With quick search I found the following files having some sort of
option exclusiveness going on.  I do not like to add that many changes
to a branch which already has +10 patches, so I dropped the patch for
now. The fix will be included to branch for the ongoing week, which
hopefully has unified way to deal all of the exclusive options.

hwclock/hwclock.c
misc-utils/blkid.c
misc-utils/findmnt.c
misc-utils/lsblk.c
partx/partx.c
sys-utils/losetup.c
sys-utils/lscpu.c
sys-utils/mount.c
sys-utils/prlimit.c
sys-utils/wdctl.c

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
