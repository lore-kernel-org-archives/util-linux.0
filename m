Return-Path: bjarniig@hi.is
Date: Mon, 9 Jan 2017 20:48:15 +0000
From: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, Sami Kerola <kerolasa@iki.fi>,
        util-linux@vger.kernel.org
Subject: Re: pull: hwclock 27 changes
Message-ID: <20170109204815.GA22113@rhi.hi.is>
References: <20161231214107.8658-1-kerolasa@iki.fi>
 <05e4405f-8096-9261-f9f2-d2c6b84675bc@gmx.com>
 <070fc458-ed69-a09c-11cc-42bb50fec888@gmx.com>
 <alpine.LNX.2.20.1701072212010.9096@imuri>
 <20170109113201.kt3mmxr7fqlwscdm@ws.net.home>
 <0e70d024-09f0-929f-f22f-ba29d3909e00@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0e70d024-09f0-929f-f22f-ba29d3909e00@gmx.com>
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 09, 2017 at 08:53:27AM -0500, J William Piggott wrote:
> 
> 
[...]
> 
> It is true, I suggested picking up the orphaned adjtimex(8) code as an
> alternative to inserting it's functionality into hwclock(8). However, I
> have since learned that the useful functions of adjtimex(8) are
> available via the ntp utilities.  The rest of its (dis)abilities have
> the same problems we are seeing when reimplementing them into
> hwclock(8). I think perhaps there were good reasons adjtimex(8) was
> abandoned. Before, I believed adjtimex(8) might be a good fit for
> util-linux, now I am not so sure. If someone demonstrates a useful
> purpose for it I will change my position.
> 
> 

  I use "adjtimex" from the package in "Debian" to regulate the system
clock.  "Debian" has made some changes and I too, that I have not yet sent
to them.

  I do not use NTP (ntpdate-debian) except when the system clock deviates
more than 3 seconds from the right time.  Then I update the system clock and
correct the hardware clock accordingly and let "hwclock" calculate a new
value for the drift (hwclock --systohc --update-drift).

  I have added a option '-A' to my version of "adjtimex", to compare the
system and hardware clock about every 11 minutes (after a period of
different long pauses of comparisons) and change frequency and tick to keep
the system clock in compliance with the drift-corrected hardware clock.

  My computer is only on for a few hours a day.  The hardware clock is never
automatically updated on shutdown nor in the process of booting.

N.B.  The WARNING is caused by not updating the hardware clock but relying on
the calculated drift to correct it.  The offset of the system clock is now
-0.692 seconds.  The hardware clock was last updated 1st June 2016.

  The time between comparisons is 30 seconds multiplied by the first
Fibonacci numbers, excluding a repeated number.

  Example of comparisons:

######## Start
1483984488  Mon Jan  9 17:54:48 UTC 2017
WARNING: CMOS time is 6.25 min behind system clock
                                      --- current ---   -- suggested --
cmos time     system-cmos  error_ppm   tick      freq    tick      freq
1483984488       0.005348              9999   4012975
1483984518       0.005172       -5.9   9999   4012975    9999   4397870
WARNING: CMOS time is 6.25 min behind system clock
                                      --- current ---   -- suggested --
cmos time     system-cmos  error_ppm   tick      freq    tick      freq
1483984519       0.002689              9999   4397870
1483984579       0.001900      -13.1   9999   4397870    9999   5259588
WARNING: CMOS time is 6.25 min behind system clock
                                      --- current ---   -- suggested --
cmos time     system-cmos  error_ppm   tick      freq    tick      freq
1483984580       0.004296              9999   5259588
1483984670       0.002953      -14.9   9999   5259588    9999   6237539
WARNING: CMOS time is 6.25 min behind system clock
                                      --- current ---   -- suggested --
cmos time     system-cmos  error_ppm   tick      freq    tick      freq
1483984671       0.009972              9999   6237539
1483984821       0.007474      -16.7   9999   6237539   10000    775398
WARNING: CMOS time is 6.25 min behind system clock
                                      --- current ---   -- suggested --
cmos time     system-cmos  error_ppm   tick      freq    tick      freq
1483984822      -0.005831             10000    775398
1483985062       0.005554       47.4  10000    775398    9999   4220208
WARNING: CMOS time is 6.25 min behind system clock
                                      --- current ---   -- suggested --
cmos time     system-cmos  error_ppm   tick      freq    tick      freq
1483985063       0.007414              9999   4220208
1483985453       0.000203      -18.5   9999   4220208    9999   5432026
WARNING: CMOS time is 6.25 min behind system clock
                                      --- current ---   -- suggested --
cmos time     system-cmos  error_ppm   tick      freq    tick      freq
1483985454       0.001917              9999   5432026
1483986084       0.005602        5.8   9999   5432026    9999   5048743
WARNING: CMOS time is 6.25 min behind system clock
                                      --- current ---   -- suggested --
cmos time     system-cmos  error_ppm   tick      freq    tick      freq
1483986085       0.016335              9999   5048743
1483986715       0.004416      -18.9   9999   5048743    9999   6288698
1483987345       0.023767       30.7   9999   6288698    9999   4275678
1483987975       0.027384        5.7   9999   4275678    9999   3899389
1483988605       0.015368      -19.1   9999   3899389    9999   5149314
1483989235       0.019079        5.9   9999   5149314    9999   4763352
1483989865       0.022661        5.7   9999   4763352    9999   4390684
1483990495       0.026288        5.8   9999   4390684    9999   4013452
1483991125       0.014275      -19.1   9999   4013452    9999   5263079
1483991755       0.033575       30.6   9999   5263079    9999   3255391
1483992385       0.021591      -19.0   9999   3255391    9999   4501993
1483993015       0.025241        5.8   9999   4501993    9999   4122356

  The offset of the system clock is now -0.677 seconds.

-- 
Bjarni I. Gislason
