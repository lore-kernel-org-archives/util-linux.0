Return-Path: dave@gnu.org
Subject: Re: eject merged into util-linux
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        David Zeuthen
 <davidz@redhat.com>, Michal Luscon <mluscon@redhat.com>
In-Reply-To: <20120405143032.GC20515@x2.net.home>
References: <20120405143032.GC20515@x2.net.home>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Apr 2012 17:00:07 +0200
Message-ID: <1333638007.2628.1.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Thu, 2012-04-05 at 16:30 +0200, Karel Zak wrote:
> The original eject project (at sourceforge.net) is inactive for more
>  than 4 year. Unfortunately, the command is still used in mainstream
>  Linux distributions (for example udisks depends on the eject
>  functionality). 

Great news! This was one of my favorite tools when I first began using
Linux, nice to have it in u-l now.

> Changes:
> 
>   * complete refactoring (the original code was real mess...)
> 
>   * merged patches from Fedora (auto-eject, manual-eject, close-tray
>     list-speed and removable/hotpluggable-check patches)
> 
>   * removed support for incomplete paths (for example "eject foo" was
>     interpreted as "eject /media/foo" or "eject /mnt/foo". The
>     incomplete paths are supported for devices only (e.g. "eject sda").
> 
>     FOR MOUNTPOINT YOU HAVE TO SPECIFY COMPLETE PATH!
> 
>   * enabled by default (and added --disable-eject)
> 
>   * if a partition is specified, whole-disk device is used for eject
>     ioctl(s), for example "eject /dev/sda1" is the same as "eject /dev/sda"
> 
> 
>  Thanks to Michal Luscon for help.
> 
>     Karel
> 
