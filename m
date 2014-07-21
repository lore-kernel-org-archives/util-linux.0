Return-Path: bensberg@justemail.net
Message-Id: <1405977369.18035.144118445.737362A9@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        =?ISO-8859-1?Q?P=E1draig=20Brady?= <P@draigbrady.com>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20140721082859.GD17373@x2.net.home>
References: <53CCADA9.3020703@bernhard-voelker.de>
 <20140721082859.GD17373@x2.net.home>
Subject: Re: mount.8: mtab as symlink
Date: Mon, 21 Jul 2014 23:16:09 +0200
List-ID: <util-linux.vger.kernel.org>


On Mon, Jul 21, 2014, at 10:28, Karel Zak wrote:
> On Mon, Jul 21, 2014 at 08:05:29AM +0200, Bernhard Voelker wrote:
> >   It is  possible to replace /etc/mtab by a symbolic link to
> >   /proc/mounts, and especially when you have very large numbers
> >   of mounts things will be much faster with that symlink, but some
> >   information is lost that way, and in particular using the "user"
> >   option will fail.
>  
>   Oops, this is really obsolete info. Fixed. Thanks!

So how does umount determine that a device was mounted by a user
and thus that the user is alllowed to unmount it again?  In my
/proc/mounts there is no indication that a user mounted a partition
(apart from the "nosuid,nodev,noexec" hint, but that is no guarantee).
Does it require a certain minimum kernel version?

And what if the mount option is "users"?  And in both cases, what if
root mounted such a partition?  How does umount figure out that a
user may still not unmount it?

Benno

-- 
http://www.fastmail.fm - Same, same, but different...
