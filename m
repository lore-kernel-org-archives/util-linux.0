Return-Path: bensberg@justemail.net
Message-Id: <1405351467.26224.141460601.7C1F0818@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20140714145759.GM30288@x2.net.home>
References: <1405331864.10850.141333833.2F92BBFD@webmail.messagingengine.com>
 <20140714145759.GM30288@x2.net.home>
Subject: Re: mount: what is the point of 'nouser' on the command line?
Date: Mon, 14 Jul 2014 17:24:27 +0200
List-ID: <util-linux.vger.kernel.org>


On Mon, Jul 14, 2014, at 16:57, Karel Zak wrote:
>  The "user" option is alias to "noexec,nosuid,nodev" mount flags. 

Ehm...  Not quite.  It *implies* those options, to lightly protect
the user from some dangers, but its main purpose is to allow
ordinary users to mount the filesystem so marked in fstab.  No?

> > So, is it ever useful to specify '-o nouser' on the command line?
> 
>  No, it would be better to remove it from the example

Will submit a patch later.


> > Something else.  On the man page of umount, shouldn't it say that
> > the -O and -t options are only effective in combination with -a?
> 
>  The -t is generic and it's usable in more case (for example to
>  specify filesystem that should be tried for the device).

Ehm...  I was talking about umount here, not mount.  :)

Benno

-- 
http://www.fastmail.fm - A no graphics, no pop-ups email service
