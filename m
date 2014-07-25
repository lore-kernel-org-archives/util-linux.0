Return-Path: lkml@tlinx.org
Message-ID: <53D20AD7.4070006@tlinx.org>
Date: Fri, 25 Jul 2014 00:44:23 -0700
From: "Linda A. Walsh" <lkml@tlinx.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: Q: (RFE?)  How do you specify the 'no-canonicalize' option in fstab?
References: <53D08C77.6010500@tlinx.org> <20140724073222.GI26781@x2.net.home> <53D1BF03.9000201@tlinx.org> <20140725072143.GN26781@x2.net.home>
In-Reply-To: <20140725072143.GN26781@x2.net.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
> Do you mean that you want to see kernel device names for DM when you
> list all mountpoint by 'mount'?
---
That would be worse (I think).
> /dev/dm-0 is internal format that is unexpected for users, DM guys
----
    The time it takes for a computer to translate between formats is
negligible compared to the time it takes for users to find ways to work
around the name mangling.

    What I'd like seems completely straight forward.  Use the names the user
used in their /etc/fstab  or their mount line.  Don't convert it.  MS 
has been
doing this on Windows at least since Vista -- in regards to 'case' -- they
preserve the case the user uses, but ignore it for looking up file names.

    Here, if the user uses the suggested lvm names of /dev/VG/LV, then
I would want to see those names when I type "mount".


    Example from "bash" and path following in presence of symlinks.

If I am in /home/user and cd to "work", where "work" is a symlink pointing
to /Data/Work, if I type "cd .." in work, I want to be back in the directory
I started from not "/Data".  

Honoring user-symbolic names has become the "default" case, because it's 
user
friendly -- it's what users expect to see.  I hold that doing the same thing
in lvm volume names as in filesystem paths including symlinks, would be
consistency -- using the "user's input" to generate and follow state.

Forcing users into some arbitrary nomenclature which changes over the 
years as
new features are implemented, isn't especially user friendly.

So I want to be able to use "no-canonicalize" to KEEP the names I use -- the
*preferred* names, I am told, for the product (lvm).

Ask yourself this question, if you use bash, do you turn on physical
path resolution (set -P in your .bashrc?) (the default is to emulate a
symlinked-structure).  If you don't use -P there, why would you want to
force a physical name on your logical volumes?
