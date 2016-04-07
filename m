Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: v2.29 plan: kill mtab
Date: Thu, 7 Apr 2016 12:22:06 +0100
Cc: util-linux@vger.kernel.org
References: <20160407105400.jn66tldxy7s3rqyc@ws.net.home>
In-Reply-To: <20160407105400.jn66tldxy7s3rqyc@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201604071322.07917.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Thursday 07 April 2016, Karel Zak wrote:
> libmount supports three scenarios:
>
>  1) regular classic /etc/mtab
>
>  2) /etc/mtab symlink to /proc/self/mount -- in this case libmount
> uses /proc/self/mountinfo and /run/mount/utab
>
>  The current default is to detect symlink and on-the-fly switch
>  between 1) and 2).
>
>  3) --enable-libmount-force-mountinfo -- don't care about the symlink
> and always use /proc/self/mountinfo. This is robust solution required
> for example by systemd, because unfortunately sometimes people use
> broken stuff (init scripts, tools, etc.) which removes the symlink.
>
>
>  I'd like to make 3) default, the question is what with mtab code:
>
>     a) #ifdef all mtab code (and add --enable-support-mtab)
>
>     b) remove mtab support at all (because it's evil and horrible
> code)
>
>  Comments?

Even if b) is the final goal I would first do a) and mark the new 
option --enable-support-mtab as deprecated from the beginning.

Could be interesting to see who would ever use this option and because 
of which reasons.

About changing the default: We could add a warning somewhere to a 
non-critical tool when printing human-readable output, like lsblk:
  "warning: deprecated /etc/mtab file ingnored"

... just to remind people to fix their system/scripts.

cu,
Rudi
