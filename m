Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: libfdisk show stopper on i586?
Date: Wed, 26 Oct 2016 14:37:43 +0200
Cc: util-linux@vger.kernel.org
References: <201610260000.12844.sweet_f_a@gmx.de> <201610261227.55777.sweet_f_a@gmx.de> <20161026104713.chfwao7rbnxbxkdv@ws.net.home>
In-Reply-To: <20161026104713.chfwao7rbnxbxkdv@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201610261437.44016.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 26 October 2016, Karel Zak wrote:
> On Wed, Oct 26, 2016 at 12:27:55PM +0200, Ruediger Meier wrote:
> > On Wednesday 26 October 2016, Karel Zak wrote:
> > > On Wed, Oct 26, 2016 at 11:53:51AM +0200, Ruediger Meier wrote:
> > > > commit 8430b9b88426eb3c273b02a2d9505d839913317c
> > > > Author: Karel Zak <kzak@redhat.com>
> > > > Date:   Tue Oct 25 13:41:10 2016 +0200
> > > >
> > > >     libfdisk: make script token parser more robust
> > >
> > > Strange, don't see relation between the script parser and fdisk
> > > -l. Do you have LIBFDISK_DEBUG output?
> > >
> > >     Karel
> >
> > [   65s] +14318: libfdisk:     INIT: library debug mask: 0xffff
> > [   65s] +Available "LIBFDISK_DEBUG=<name>[,...]|<mask>" debug
> > masks:
>
> Can you send me the disk image? dd(1) + gzip, it's full of zeros, so
> it should be relatively small.

Hehe, I've made a lot of debugging in a chrooted openSUSE 42.1/i586 and 
found out that the problem was

disk-utils/fdisk-menu.c:709:
-	unsigned long length;
+	uintmax_t length = 0;

which you have fixed in the meanwhile in e4015b34 ...


But this does not fix the bug in Fedora 19, WTF!?


For the record on openSUSE 42.1/i586 to reproduce the bug these compiler 
flags were needed:
   CFLAGS='-O2 -D_FORTIFY_SOURCE=2 -fstack-protector'

and this:

$ rm /tmp/gpt.img; truncate -s 1M /tmp/gpt.img
$ echo -e "g\nw\nq\n" | ./fdisk /tmp/gpt.img
$ ./fdisk -l /tmp/gpt.img
 <segfault>

Now I'm going to check that on Fedora 19 ...

cu,
Rudi
