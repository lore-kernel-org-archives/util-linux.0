Return-Path: lkml@tlinx.org
Message-ID: <53F690F7.10200@tlinx.org>
Date: Thu, 21 Aug 2014 17:38:15 -0700
From: Linda Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Utilities don't take into account capabilities
References: <fbcec6cf5352.53efd3e4@langara.bc.ca> <3715739.62j44Bg1Aj@vapier> <fb47b4bfaf39.53f23a83@langara.bc.ca> <20140819090737.GA22187@x2.net.home>
In-Reply-To: <20140819090737.GA22187@x2.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> The currently supported scenario is that you can remove suid from
>  mount(8) and replace it with cap_dac_override,cap_sys_admin+ep. Note
>  that in this case mount(8) still requires 'user' in fstab of course.
>   
---

   Is this planned, as the source I looked at still had uid==0 checks.
> 
>  The disadvantage is that mount(8) is not able to update for example
>  /etc/mtab (or /run/mount/utab), because cap_sys_admin is just subset of
>  the original suid privileges.

        This does point out an important issue -- should things like
cap_sys_admin also allow updating of run/mount/utab?  I would say "maybe":

        Updating /etc/mtab -- IF it is a separate file system object would
require write access to the file.  That could be handled with an ACL, or
CAP_DAC_OVERRIDE.  But the former "/run/mount/utab" -- isn't that a kernel
based file?  I.e. a pointer to /proc/self/mounts?  Either way -- if it is
a separate file, then it would be updated based on access and privilege,
but if it is a representation of kernel state, then it seems CAP_SYS_ADMIN
would be sufficient, no?


Linda
