Return-Path: marc@merlins.org
Date: Mon, 25 Nov 2013 03:59:22 -0800
From: Marc MERLIN <marc@merlins.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Severe fdisk problem leading to data loss?
Message-ID: <20131125115922.GB12566@merlins.org>
References: <20131118102051.GA31813@merlins.org>
 <20131124135226.GH11389@merlins.org>
 <20131125103124.GQ5572@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131125103124.GQ5572@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 25, 2013 at 11:31:24AM +0100, Karel Zak wrote:
> >    Device Boot      Start         End      Blocks   Id  System   
> > /dev/sda1            2048     1050623      524288   83  Linux   
> > /dev/sda2         1050624   105908223    52428800    0  Empty  
> 
> Congratulation, you found very old fdisk bug as well as GNU Parted bug :-)
> 
> The problem is that the partition has no set partition type, and
> fdisk in some situations interprets such partition as unused. 
  
Aaah, I see.
If you wonder why I did that by the way, it's good to set aside portion
of an SSD and never use it. This leaves room for the garbage collector.

> So it lists the partition (print command), but the "add new
> partition" command interprets this partition as unused.

Understood.

> This is definitely bug too, because Linux does not care about
> partition type and kernel is able to use this partition:
 
It is indeed.

> Note, don't use -S and -H, fdisk does not care about CHS by default
> (you have to enable obsolete DOS mode ('c' command)).
 
Thanks for that. It was an old command I had to make sure I would get
big 64K block alignment for my SSD.

> I'm going to make fdisk more robust and prepare also a patch for GNU
> parted.

Thanks for your reply and the fixes.

Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/                         | PGP 1024R/763BE901
