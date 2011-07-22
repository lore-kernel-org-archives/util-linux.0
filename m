Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110721181012.GA6672@nb.net.home>
References: <CAG27Bk1uKnqR62SRNgTXFPGfTseraC0AUgpAMQ5zhdcsAM-79w@mail.gmail.com>
	<20110721181012.GA6672@nb.net.home>
Date: Fri, 22 Jul 2011 09:56:24 +0200
Message-ID: <CAG27Bk2eA7gypziZ7RSD=CR_XiYvQvGEz-AGq_aYHGe++sZuhw@mail.gmail.com>
Subject: Re: [git pull] cramfs fixes
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 21, 2011 at 20:10, Karel Zak <kzak@redhat.com> wrote:
>> =A0 =A0 =A0 u32 namelen:6, offset:26;
> =A0 =A0^^^
> =A0uint32_t

Oops. Fixed.

>> +/* Exit codes used by fsck-type programs */
>> +#define FSCK_OK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00 =A0 =A0 =
=A0 /* No errors */
>> +#define FSCK_NONDESTRUCT =A0 =A0 1 =A0 =A0 =A0 /* File system errors co=
rrected */
>> +#define FSCK_REBOOT =A0 =A0 =A0 =A0 =A02 =A0 =A0 =A0 /* System should b=
e rebooted */
>> +#define FSCK_UNCORRECTED =A0 =A0 4 =A0 =A0 =A0 /* File system errors le=
ft uncorrected */
>> +#define FSCK_ERROR =A0 =A0 =A0 =A0 =A0 8 =A0 =A0 =A0 /* Operational err=
or */
>> +#define FSCK_USAGE =A0 =A0 =A0 =A0 =A0 16 =A0 =A0 =A0/* Usage or syntax=
 error */
>> +#define FSCK_LIBRARY =A0 =A0 =A0 =A0 128 =A0 =A0 /* Shared library erro=
r */
>
> =A0I see magic numbers also in fsck.minix ;-)
>
> =A0What about to add include/exitcodes.h and move this and
> =A0disk-utils/mkfs.h to this file?

True. I added two patches which does exactly that.

      include: move disk-utils/mkfs.h -> include/exitcodes.h
      include: move fsck return values to exitcodes.h

>> [snip]
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 err(FSCK_ERROR, _("write failed: %s"),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 path);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 curr =3D next;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 ^^^
>
> the 'if (opt_extract)' block is outsize 'if (size >=3D page_size)'...

Correct, the mistake is fixed.

>> [snip]
>> + =A0 =A0 =A0 =A0 =A0 =A0 if ((S_ISUID | S_ISGID) & i->mode)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chmod(path, i->mode) < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err(FSCK_ERROR=
, _("chown failed: %s"), path);
>> =A0 =A0 =A0 }
>
> =A0 =A0 =A0if (((S_ISUID | S_ISGID) & i->mode) && chmod(path, i->mode) < =
0)
> =A0 =A0 =A0 =A0 =A0 err(FSCK_ERROR, _("chown failed: %s"), path);

Changed to single if.

>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blksize =3D atoi(optarg);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blksize =3D strtoll_or_err(opt=
arg, _("blocksize argument failed"));
>
> =A0hmm... "failed to parse blocksize argument" ?

Changed to "failed to parse".

>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (strcmp(optarg, "hos=
t") =3D=3D 0); =A0/* default */
>> [snip]
>
> =A0 else if (strcmp(optarg, "host") =3D=3D 0)
> =A0 =A0 =A0 =A0; /* default */

This and...

>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 case 'V':
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printf(_("%s (%s)\n"),
>
> =A0"%s from %s\n" :-)

the version string are in new patch.

      mkfs.cramfs: coding style


The fixed & few new patches are available in the git repository at:
 https://github.com/kerolasa/lelux-utiliteetit cramfs

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
