Return-Path: util-linux-owner@vger.kernel.org
Received: from ppp118-210-236-190.lns20.adl6.internode.on.net ([118.210.236.190]:52632
	"EHLO mailservice.shelbyville.oz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S965709AbbEMV2V (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 13 May 2015 17:28:21 -0400
Date: Thu, 14 May 2015 06:50:52 +0930
From: Ron <ron@debian.org>
To: Karel Zak <kzak@redhat.com>
Cc: Andreas Henriksson <andreas@fatal.se>, Ron <ron@debian.org>,
        785116@bugs.debian.org, util-linux@vger.kernel.org
Subject: Re: Bug#785116: util-linux: blkid -s returns too much information
Message-ID: <20150513212052.GM27477@hex.shelbyville.oz>
References: <20150512132634.1127.8640.reportbug@hex.shelbyville.oz>
 <20150513063604.GA466@fatal.se>
 <20150513103706.GE4834@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150513103706.GE4834@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 13, 2015 at 12:37:06PM +0200, Karel Zak wrote:
> On Wed, May 13, 2015 at 08:36:04AM +0200, Andreas Henriksson wrote:
> > Possibly changing the output format now could be risky.
> 
>  Yes. Ron is right, the current behaviour is strange, but I'm not sure
>  if we want to fix it after 3 years.

Hmm.  Being that old complicates things a bit more, yeah.  I guess Wheezy
missed out on getting that update, because in the case of Debian stable
releases at least, right now it's a regression that's still only about
a month old :)

>  And I'm also not sure it the current behavior is so big problem. If you 
>  want just one value than it makes more sense to use
> 
>     # blkid  -s UUID -o value /dev/sdb1
>     f0710187-82bf-4646-b2e3-11b017e31218

The use case I have for it that bit me here was using it for installer
preseeding for pxe booting new VMs, where I do something like:

 echo "$(blkid -s UUID -o export /dev/sdb1) none swap sw,discard,nofail 0 0" >> /target/etc/fstab;

and for which the export format with UUID= was perfect out of the box.
Changing that to use -o value isn't a huge problem, but getting the
extra DEVNAME in there kind of was.

>  and if you ask for more tags by "-o export" than you cannot rely on 
>  order of the lines, so DEVNAME= in the output cannot be a problem.

Right, in the situation where you *do* want multiple values, caring
about the order should be less of a problem, since you'd just access
the variables being set rather than trying to parse or interpret
them literally.  If for some reason you did care about the order,
you'd run that multiple times with one value for each invocation.

Which, right now if you do that, you'll end up with something like:

 # blkid -s UUID -o export /dev/sda2; blkid -s TYPE -o export /dev/sda2
 DEVNAME=/dev/sda2
 UUID=9621a7e3-14a1-4d03-8250-b4fbeb79999b
 DEVNAME=/dev/sda2
 TYPE=ext4

I guess the other case where that might bite you is if you were already
using DEVNAME as a local variable for something else ...

Or if you'd run the first one of those, changed the value of DEVNAME in
some way, and then run the second somewhere later in a script.


> > Lets ask upstream if DEVNAME is considered a tag which should
> > be included in the tag filtering.... CCed.
> 
>  I have a patch to fix it, but now when I think about it it's probably
>  better to keep the current behavior than fix one regression by
>  another regression ;-)

Yeah, I completely sympathise with the pain in that line of thinking.
I guess the question for me would be is there really any use case
where someone might actually be relying on this (mis)behaviour?
One where they aren't already explicitly passing -s DEVNAME as one
of the tags they want exported (which really is what you should be
doing if that's what you want).

I'm weighing up the damage that changing it again might do relative to
the damage of having this behave oddly forever more.  Leaving it like
this sort of means you can't ever really use 'export' with -s at all,
it only makes sense to let it output everything (since you'll get some
subset of everything regardless of what you ask for anyway).

If the risk of changing it is too great, because there is some existing
user or use case that reasonably depends on it, that would sort of mean
we now need to add a -o export-just-what-i-asked-for-really-i-mean-it
format, which does the job that export was originally intended for.


In my particular case this time, a workaround to use -o value will be
ok (and I'll need to do that for the next few years now whatever we
do, to be compatible with things that are in the wild), but it seems
like there is value in doing *something* to fix this in the long term,
whether that is changing what export does again, or adding a new
export-strict or some such to provide that function in a forward safe
way.

  Thanks!
  Ron


