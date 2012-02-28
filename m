Return-Path: util-linux-owner@vger.kernel.org
Received: from enyo.dsw2k3.info ([195.71.86.239]:50025 "EHLO enyo.dsw2k3.info"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754703Ab2B1XaI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Feb 2012 18:30:08 -0500
Date: Wed, 29 Feb 2012 00:29:52 +0100
From: Matthias Schniedermeyer <ms@citd.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: What about a premount/postumount option for mount?
Message-ID: <20120228232952.GA25151@citd.de>
References: <20120211123016.GA15097@citd.de>
 <20120228135918.GB22034@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120228135918.GB22034@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 28.02.2012 14:59, Karel Zak wrote:
> On Sat, Feb 11, 2012 at 01:30:16PM +0100, Matthias Schniedermeyer wrote:
> > For the umount thing, i think i could use inotify and wait for the 
> > "umount"-event as inotify fortunately doesn't prevent umount, but that 
> 
>  See:
>  http://karelzak.blogspot.com/2011/12/monitor-list-of-currently-mounted.html
> 
> > works a little against the spirit of autofs, as it only would work once 
> > (at least in the case of setup by udev).
> > 
> > All "solutions" taste a little strange for me, the udev-solution mainly 
> > because i would have a dm-crypt "laying" around which may or may not be
> 
>  It's usually bad idea to call mount (or so) from udev rules (and it's
>  often topic in udev mailing list).

My "ideal" setup is actually the one i have running for loop-aes.

For "autofs"ability i needed something discoverable.
An encrypted loop-aes disc, by itself, has nothing discoverable except 
maybe the disc-serial-number. But an USB-enclosure can kill that too.

So i decided leave 4k at the beginne of each disc and install a 
dummy-mbr and use the "disk signature" to identify each HDD:
http://en.wikipedia.org/wiki/Master_boot_record

For all my discs i put a 4 byte "name" string into that field.
I then added a udev-script that checks for the signature and adds a 
symlink in /dev/disk/by<whatever>/<signature> if a valid signature is 
found.

Then i can use that /dev/disk/by... symlink in autofs and the circle 
closes because the patched mount-command for loop-aes does the setup of 
the encryption-loop-device transparently.

For dm-crypt i'm currently missing the "transparent" setup/tear-down of 
the dm-crypt device.


Lastly, and not really relevant here, i have a perl-script running in a 
'screen' that get 'kill -HUP'ed by the same udev-script and checks if 
there are files in the tmp-dir for the HDD, copies the files, (umount), 
verifys the files, updates the inventory and finaly umounts a last time.

So in the end all i have to do is connect a disc, switch it on, wait 
till everything is done and switch it off.

(In the past i also had a big USB-Tree of Power-Plugs and 
USB-HDD-Enclosures. Back then i only needed to start the distribution 
script. Which, in a loop, checked which disc had files to be copied to, 
switched the discs on waited for the files to be copied and switched the 
disc off ... But that USB-Tree got unstable somewhere around 40 discs, 
which meant i about 10 USB-Power-Plugs (4 switches each) and something 
around 16 4-Port USB-Hubs when i finally gave up that experiment.)




Bis denn

-- 
Real Programmers consider "what you see is what you get" to be just as 
bad a concept in Text Editors as it is in women. No, the Real Programmer
wants a "you asked for it, you got it" text editor -- complicated, 
cryptic, powerful, unforgiving, dangerous.

