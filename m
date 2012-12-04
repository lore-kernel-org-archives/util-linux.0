Return-Path: werner@suse.de
Date: Tue, 4 Dec 2012 13:12:13 +0100
From: "Dr. Werner Fink" <werner@suse.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [util-linux] [PATCH 00/13] Initial import of sulogin
Message-ID: <20121204121213.GA25376@boole.suse.de>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
 <20120228164840.GH21406@rampage>
 <20121012125309.GA20273@boole.suse.de>
 <20121012132336.GC23945@x2.net.home>
 <20121012140757.GA10101@boole.suse.de>
 <20121109120919.GC26857@x2.net.home>
 <20121130155726.GA30517@boole.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20121130155726.GA30517@boole.suse.de>
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 30, 2012 at 04:57:26PM +0100, Werner Fink wrote:
> On Fri, Nov 09, 2012 at 01:09:19PM +0100, Karel Zak wrote:
> > On Fri, Oct 12, 2012 at 04:07:57PM +0200, Dr. Werner Fink wrote:
> > > >  Time... (the patch is one huge rewrite, I'd like to split it to more
> > > >  patches). I'm busy with some others things, so next week.
> > > 
> > > Yep, this missing feature is also known here ;)
> > > Maybe the attached patch help as it only adds the /proc/consoles and
> > > /sys/class/tty/ scanner into common lib and leave sulogin untouched.
> > > 
> > > The integration into sulogin.c could then be done later
> > 
> >  Good idea. I have merged the lib/consoles.c with some changes:
> > 
> >     - removed all global variables
> >     - refactoring (one separate function for each detection method)
> >     - add debug messages
> >     - fix some disadvantages
> >     - add small test program
> > 
> >  Now we need a patch(s) for sulogin.c. It should be relatively simple
> >  task as we already have Philipp's prototype.
> > 
> >  http://www.spinics.net/lists/util-linux-ng/msg06916.html
> > 
> >  Any suggestion how to test the code?

I've up and running a VirtualBox guest with a serial as well as a virtual
console. From the compiled consoles test (-DTEST_PROGRAM) I see:

  g243:~ # ./consoles /dev/console 
  /dev/tty7: id=0 (reconnect) 
  /dev/ttyS0: id=1 (reconnect) 
  g243:~ # cat /proc/cmdline
  BOOT_IMAGE=/boot/vmlinuz-3.4.11-2.16-desktop root=UUID=5ece074f-824b-45b0-8fa6-aa61c06beb87 resume=/dev/disk/by-id/ata-VBOX_HARDDISK_VB96c77b27-f0603953-part1 splash=silent console=ttyS0,115200 console=tty0 showopts

> For such things a VirtualBox or KVM client is usefull, if a serial
> console is used then you can see both of the consoles.  In the meanwhile
> I've tried to move from single linked lists to double linked list as
> found in include/list.h.  Now the usage of posix_memalign() makes sense
> as with this the area for the structure as well as for the string in the
> structure can be allocated in one step (and also freed in one step).

For the VirtualBox I use a sub directory /dev/vboxtty/ owned and writable by
the group vboxusers.  Below this the VirtualBox creates the ttyS0 as a socket
pair and I start a simple script using socat and screen with:

 #!/bin/bash
 : ${tty:=ttyS0}
 dir=/dev/vboxtty
 pty=$dir/tty${tty#ttyS}
 socat unix-connect:$dir/ttyS0,oobinline pty,link=$pty,b38400,parenb=1,cs8,istrip=0,icanon=1 &
 exec screen -O -A -f $pty b38400,parenb=1,cs8,istrip=0,icanon=1

with this one can see the boot messages on both the serial console and on the
window used by the VirtualBox for its own virtual console(s).

   Werner

-- 
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr
