Return-Path: lczerner@redhat.com
Date: Tue, 16 Oct 2012 21:07:26 +0200 (CEST)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
To: Andreas Hartmann <andihartmann@01019freenet.de>
cc: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>,
        util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
Subject: Re: Questions concerning fstrim and online discard.
In-Reply-To: <507D8B15.5050004@01019freenet.de>
Message-ID: <alpine.LFD.2.00.1210162056290.18184@localhost>
References: <20121004064736.64caef77@dualc.maya.org> <alpine.LFD.2.00.1210151649540.15261@dhcp-1-104.brq.redhat.com> <507D8B15.5050004@01019freenet.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-932257974-1350414457=:18184"
List-ID: <util-linux.vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-932257974-1350414457=:18184
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: 8BIT

On Tue, 16 Oct 2012, Andreas Hartmann wrote:

> Date: Tue, 16 Oct 2012 18:28:05 +0200
> From: Andreas Hartmann <andihartmann@01019freenet.de>
> To: Lukáš Czerner <lczerner@redhat.com>
> Cc: Andreas Hartmann <andihartmann@01019freenet.de>,
>     util-linux@vger.kernel.org, Karel Zak <kzak@redhat.com>
> Subject: Re: Questions concerning fstrim and online discard.
> 
> Hello Lukas!
> 
> I'm really happy about your detailed comments! Thanks a lot!
> 
> On Tue, 16 Oct 2012, Andreas Hartmann wrote: Lukáš Czerner wrote:
> > On Thu, 4 Oct 2012, Andreas Hartmann wrote:
> > 
> >> Date: Thu, 4 Oct 2012 06:47:36 +0200
> >> From: Andreas Hartmann <andihartmann@01019freenet.de>
> >> To: util-linux@vger.kernel.org
> >> Subject: Questions concerning fstrim and online discard.
> >> Resent-Date: Mon, 15 Oct 2012 16:10:43 +0200
> >> Resent-From: Karel Zak <kzak@redhat.com>
> >> Resent-To: Lukas Czerner <lczerner@redhat.com>
> >>
> >> Hello!
> >>
> >> Please, may I ask you some questions because I'm a little bit confused
> >> about the behaviour of fstrim and online discard (ext4)?
> >>
> >>
> >> I'm using the following configuration / partitioning with a SSD
> >> (Controller: SF-2281; Corsair Force GT 240GB):
> >>
> >> - dm_crypt: cryptsetup luksOpen - version 1.4.1, device-mapper
> >>   version 1.02.75
> > 
> > Hi Andreas,
> > 
> > I hope that you realize that using discard with dm_crypt is not
> > safe.
> 
> I know about this problem. My understanding is: trim usually writes 0 to
> the free addresses, hence it is possible to see which addresses are used
> and which are unused.

This is not exactly right. TRIM does not write anything to the
device, but you can read zeroes (or some other values, see bellow) when
reading previously trimmed blocks. The reason being that when when
it's tirmmed firmware does not actually need to read data from the flash.

> 
> The SF-2281 controller seems not to write zero to the addresses, hence
> the problem shouldn't be with this controller? Or did I got something wrong?
> 
> cat /sys/block/sda/queue/discard_zeroes_data
> 0

That's just one case. IIRC the device can return zeores after trim (which
will be advertised through sysfs interface), some other deterministic data
or pseudorandom data. The device would not be able to always return what
has been there before simply because those blocks might have already been
reused in wear levelling process, so it has to be substituted. And when it
comes to cryptography, all those options are bad.

> 
> > 
> >> - lvm version 2.02.96
> >> - ext4, option discard; kernel version 3.4.11
> >>
> >> All seems to work fine, I can't see any errors in messages or in dmesg
> >> according trim / discard.
> > 
> > The question is what kernel version do you use ?
> 
> 3.4.11 :-)
> 
> > Currnently we will
> > ignore all errors coming from the online discard including the
> > situation where the device does not support discard.
> > 
> > This is not exactly ideal, because we should really inform user that
> > there was an error.
> 
> Yes, this would be really important!
> 
> > However we should _NOT_ inform user about every
> > discard request failed with EOPNOTSUPP because we can have
> > multi-disk devices where some of the devices support discard and
> > some of the does not, this is perfectly valid situation and kernel
> > should not scream.
> 
> Once at the moment the device is mounted would be enough.
> 
> > Nevertheless I am going to change things so that we inform use about
> > problem (other than EOPNOTSUPP). And maybe warn once a day that
> > part, or whole device does not support discard at all - I think that
> > this should not hurt.
> > 
> >>
> >> Now, I tested fstrim from util-linux version 2.19, and surprisingly got
> >> this unexpected error:
> >>
> >> fstrim: /: FITRIM ioctl failed: Operation not supported
> > 
> > Actually kernel version is what matters.
> > 
> >>
> >> Why do I get this error? Online discard always seemed to work fine (= I
> >> didn't get any error).
> > 
> > Those errors probably got silently dropped so you did not know about
> > them.
> 
> But if fstrim works, online discard will work, too? Or is this
> conclusion wrong (ext4)?

Yes, if the file system supports both (which is the case for ext4).

> 
> [....]
> 
> > I hope it helps.
> 
> Yes, it really helped a lot!
> 

I am glad to help.

Thanks!
-Lukas

> 
> Kind regards,
> Andreas Hartmann
--8323328-932257974-1350414457=:18184--
