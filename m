Return-Path: walrond.andrew@gimli.pitney-fabs.co.uk
Date: Fri, 9 Dec 2011 12:55:37 +0000
From: Andrew Walrond <andrew@walrond.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Mount -a and bind mounts. Bug?
Message-ID: <20111209125537.GC3173@golden.localdomain>
References: <20111209123357.GA3173@golden.localdomain>
 <20111209124837.GA7960@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111209124837.GA7960@nb.net.home>
Sender: walrond.andrew@gimli.pitney-fabs.co.uk
List-ID: <util-linux.vger.kernel.org>

On Fri, Dec 09, 2011 at 01:48:37PM +0100, Karel Zak wrote:
> On Fri, Dec 09, 2011 at 12:33:58PM +0000, Andrew Walrond wrote:
> >
> > I'm using v2.20.1.
> 
>  - distro?

A custom job of my own

>  - linked with libmount?

Don't think so.

$ ldd /bin/mount
        linux-vdso.so.1 =>  (0x00007fff093af000)
        libblkid.so.1 => //lib/libblkid.so.1 (0x00007f087b755000)
        libuuid.so.1 => //lib/libuuid.so.1 (0x00007f087b551000)
        libc.so.6 => //lib/libc.so.6 (0x00007f087b1ca000)
        /lib64/ld-linux-x86-64.so.2 => //lib64/ld-linux-x86-64.so.2 (0x00007f087b97b000)

Saw some mention of libmount somewhere when I upgraded and built 2.20.1 but didn't have time to read further.
What's the current recommendation? Should I link against it?

>  - do you have regular mtab or symlink to /proc/mounts

symlink to /proc/mounts


Andrew Walrond
