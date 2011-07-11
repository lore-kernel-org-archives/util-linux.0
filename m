Return-Path: dmitry.torokhov@gmail.com
Date: Mon, 11 Jul 2011 09:39:17 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Daniel Drake <dsd@laptop.org>, util-linux@vger.kernel.org, pgf@laptop.org,
        Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH] evstate: new utility for querying evdev key/switch/event
 state
Message-ID: <20110711163917.GA1648@core.coreip.homeip.net>
References: <20110709132046.90A119D401C@zog.reactivated.net>
 <20110711121836.GJ5214@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110711121836.GJ5214@nb.net.home>
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 11, 2011 at 02:18:36PM +0200, Karel Zak wrote:
> On Sat, Jul 09, 2011 at 02:20:46PM +0100, Daniel Drake wrote:
> > evstate is a small utility that queries evdev state of a specific
> > key, switch, button, LED or sound event. This is useful in programs
> > such as powerd (http://wiki.laptop.org/go/Powerd) which need to query
> > things like the state of the laptop lid switch from shell code.
> > 
> > Our earlier non-upstream approach to this was to add sysfs nodes that
> > would indicate button state, but Dmitry Torokhov is against seeing those
> > in the upstream kernel as it is duplicating info from the input layer:
> 
> Sounds too crazy...
> 
> The duplication is normal (see for example block devices). There is
> many places where we have the same information accessible by ioctl()
> as well as by sysfs.

Sometimes it makes sense to provide alternative way of accessing data;
however block devices do not export every block as a binary sysfs
attribute, do they? Same goes for input.

> 
> The sysfs is usually the preferred way, because it does not require root
> permissions to read the attributes and you can use standard file/text
> utils rather than any specialized ioctl wrappers.

Yep, that'd be great. "Look, ma, I can see what root is typing..."

> 
> > http://article.gmane.org/gmane.linux.drivers.platform.x86.devel/1089
> 
> Wow, so you have already implemented a patch that exports the state
> in *human readable format* by sysfs. This patch was NACKed.

Yes, on the ground that it is not a good idea to sprinkle
driver-specific sysfs attributes all over the place when there is
already a generic way of accessing this data.

> 
> Now it's expected that everyone in userspace will use ioctl() (with
> root permissions?)

Yep, see above.

> and translate any crazy bit array to something
> human readable. Right? Really?

Right. Really.

Now I'd say that this utility probably better fit into linuxconsole
project with the rest of input-related utilities...

Thanks.

-- 
Dmitry
