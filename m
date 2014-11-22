Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:56602 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751575AbaKVVVa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 22 Nov 2014 16:21:30 -0500
Message-ID: <5470FE32.9030805@gmx.com>
Date: Sat, 22 Nov 2014 16:20:50 -0500
From: JWP <elseifthen@gmx.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux <util-linux@vger.kernel.org>
Subject: RFC hwclock: refactoring
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

So, I noticed when *fdisk were rewritten that some antiquated
code was dropped.  I would like some opinions on whether this
should be done when refactoring hwclock.

For example, do we need a workaround for the 1994 Award BIOS
bug? Do we need Alpha code?  Is there a Linux distro that
still officially supports Alpha machines?

Any other ideas regarding this topic are welcome. Thank you in
advance for your time.

Here are some options up for discussion:

ALPHA ONLY
       --getepoch
              Print  the  kernel's Hardware Clock epoch value to standard out-
              put.  This is the number of years into AD to which a  zero  year
              value  in  the  Hardware  Clock refers.  For example, if you are
              using the convention that the  year  counter  in  your  Hardware
              Clock  contains  the  number  of full years since 1952, then the
              kernel's Hardware Clock epoch value must be 1952.

              This epoch value is used whenever  hwclock  reads  or  sets  the
              Hardware Clock.

       --setepoch
              Set the kernel's Hardware Clock epoch value to the value  speci-
              fied  by  the  --epoch  option.   See  the --getepoch option for
              details.

       --epoch=year
              Specifies the year  which  is  the  beginning  of  the  Hardware
              Clock's  epoch,  that  is the number of years into AD to which a
              zero value in the Hardware Clock's year counter refers.   It  is
              used  together  with  the  --setepoch option to set the kernel's
              idea of the epoch of the Hardware Clock, or otherwise to specify
              the epoch for use with direct ISA access.

              For example, on a Digital Unix machine:

                  hwclock --setepoch --epoch=1952

       --arc  This option is equivalent to --epoch=1980 and is used to specify
              the most common epoch on Alphas with ARC console  (but  Ruffians
              have epoch 1900).

       --srm  This option is equivalent to --epoch=1900 and is used to specify
              the most common epoch on Alphas with SRM console.

       --funky-toy

       --jensen
              These two options specify what kind of Alpha machine  you  have.
              They  are  invalid  if  you  don't have an Alpha and are usually
              unnecessary if you do, because hwclock should be able to  deter-
              mine  by  itself  what  it's  running on, at least when /proc is
              mounted.  (If you find you need one of  these  options  to  make
              hwclock  work,  contact the maintainer to see if the program can
              be improved to detect  your  system  automatically.   Output  of
              `hwclock --debug' and `cat /proc/cpuinfo' may be of interest.)

              Option  --jensen  means  you are running on a Jensen model.  And
              --funky-toy means that on your machine one has to use the UF bit
              instead  of  the  UIP bit in the Hardware Clock to detect a time
              transition.  "Toy" in the option name refers to the Time Of Year
              facility of the machine.

AWARD BIOS BUG

       --badyear
              Indicate  that  the Hardware Clock is incapable of storing years
              outside the range 1994-1999.  There is a problem in some  BIOSes
              (almost  all  Award  BIOSes  made  between  4/26/94 and 5/31/95)
              wherein they are unable to deal with years after 1999.   If  one
              attempts to set the year-of-century value to something less than
              94 (or 95 in some cases), the value that actually gets set is 94
              (or  95).  Thus, if you have one of these machines, hwclock can-
              not set the year after 1999 and cannot  use  the  value  of  the
              clock as the true time in the normal way.

              To  compensate  for  this  (without  your getting a BIOS update,
              which would definitely be preferable), always use  --badyear  if
              you have one of these machines.  When hwclock knows it's working
              with a brain-damaged clock, it ignores  the  year  part  of  the
              Hardware  Clock  value and instead tries to guess the year based
              on the last calibrated date in the  adjtime  file,  by  assuming
              that  date  is  within the past year.  For this to work, you had
              better do a hwclock --set or hwclock --systohc at least  once  a
              year!

              Though hwclock ignores the year value when it reads the Hardware
              Clock, it sets the year value when it sets the clock.   It  sets
              it  to  1995,  1996,  1997,  or 1998, whichever one has the same
              position in the leap year cycle as the true year.  That way, the
              Hardware  Clock  inserts leap days where they belong.  Again, if
              you let the Hardware Clock run for more than a year without set-
              ting it, this scheme could be defeated and you could end up los-
              ing a day.

              hwclock warns you that you probably need --badyear  whenever  it
              finds your Hardware Clock set to 1994 or 1995.

