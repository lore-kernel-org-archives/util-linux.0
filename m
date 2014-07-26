Return-Path: lkml@tlinx.org
Message-ID: <53D33297.20502@tlinx.org>
Date: Fri, 25 Jul 2014 21:46:15 -0700
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
>>>> no-canonicalize in /etc/fstab?
>>> Why do you want something like this?
> Well, I'm trying to help you, so it would be nice to have more
> information about your use-case...
---
    Was my description still unclear?  when I use a "symbolic link"
to a file or to a device, when I look at where I am, I want to
see what I typed in as part of the path.

If I'm in my home dir, I can cd into
bin/audio to work on scripts.  If I want to test with large
files, they are in /Audio, where the scripts dir is
under /Audio/scripts.

If I am making a short change and not testing, I usually
work by cd'ing into the local path ~/bin/audio -- I wouldn't
be real happy if it dumped me in /Audio/scripts each time, even
though that would be a canonical name.

Same with Devnames -- If I use the standard /dev/VG/LV in
constructing a name, being passed a mutated form forces an
automated script to go belly up -- looking for the VG after
/dev/, and looking for LV's under the VG.

So in my usecase, I'd like to mount the volumes using
/etc/fstab and still be able to use the no-canonicalize
option. 


??  Reasonable to be able to specify the switch
via fstab and provide consistency with the command
line option?
