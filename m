Return-Path: the.ridikulus.rat@gmail.com
MIME-Version: 1.0
In-Reply-To: <20120229154420.GD8471@x2.net.home>
References: <20120229154420.GD8471@x2.net.home>
From: Keshav P R <the.ridikulus.rat@gmail.com>
Date: Wed, 29 Feb 2012 21:32:23 +0530
Message-ID: <CAMPnHXx7V3nu73DN8QXzxJotbNsGDETyrOWNz+5jv1Mcp8gShw@mail.gmail.com>
Subject: Re: v2.22 wish list
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 29, 2012 at 21:14, Karel Zak <kzak@redhat.com> wrote:
>
> This is my v2.22 wish list. The list contains large/invasive tasks only.
> Comments, volunteers, .... ? ;-)
>
> =C2=A0* release in May/Jun 2012
>
> =C2=A0* add PARTUUID=3D and PARTLABEL=3D support to mount/fsck by partiti=
on UUID/LABEL
> =C2=A0 - add to libblkid blkid_evaluate_* API
> =C2=A0 - support in libmount
> =C2=A0 - add regression tests
>

Waiting for a long time for this.

> =C2=A0* make uuidd (uuid daemon) compatible with systemd
> =C2=A0 - add --no-fork
> =C2=A0 - add --no-pid (pid file)
> =C2=A0 - add systemd unit file
> =C2=A0 - add #ifdef LIBUUID_EXEC_UUIDD to disable uuidd exec from library
>
> =C2=A0* fdisk
> =C2=A0 - move mbr (dos) stuff to fdiskmbrlabel.c
> =C2=A0 - add GPT support
>

You can maybe merge gptfdisk with fdisk
http://gptfdisk.git.sourceforge.net/git/gitweb.cgi?p=3Dgptfdisk/gptfdisk;a=
=3Dsummary
.

> =C2=A0* clean up DBG() macro in libblkid
> =C2=A0 - see libmount version
>
> =C2=A0* add dasd support to libblkid
>
> =C2=A0* non-recursive build-system (now many files from lib/ are compilet=
ed
> =C2=A0 more than once), see:
> =C2=A0 http://thread.gmane.org/gmane.linux.utilities.util-linux-ng/3297
>
> =C2=A0* merge reject

reject or eject - typo?

> =C2=A0 Michal L. is working on this task
> =C2=A0 https://github.com/mluscon/util-linux/tree/eject
>
> =C2=A0* ???
>
>
> --
> =C2=A0Karel Zak =C2=A0<kzak@redhat.com>
> =C2=A0http://karelzak.blogspot.com
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
