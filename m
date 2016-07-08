Return-Path: mail@bernhard-voelker.de
Subject: Re: question about raw(1)
To: Ruediger Meier <sweet_f_a@gmx.de>, Karel Zak <kzak@redhat.com>
References: <201607041539.37149.sweet_f_a@gmx.de>
 <871t38djgn.fsf@hobgoblin.ariadne.com>
 <20160707202734.tuoshkpnoxlnr5w5@ws.net.home>
 <201607080101.35139.sweet_f_a@gmx.de>
Cc: "Dale R. Worley" <worley@alum.mit.edu>, util-linux@vger.kernel.org
From: Bernhard Voelker <mail@bernhard-voelker.de>
Message-ID: <577EF423.7060703@bernhard-voelker.de>
Date: Fri, 8 Jul 2016 02:30:27 +0200
MIME-Version: 1.0
In-Reply-To: <201607080101.35139.sweet_f_a@gmx.de>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>

On 07/08/2016 01:01 AM, Ruediger Meier wrote:
> It's about this openSUSE init script pull request
> https://build.opensuse.org/request/show/405725
> 
> He removed the existing "sleep 2" after modprobe but I guess somebody 
> had added that sleep for a good reason in past. Of course sleep is 
> ugly, maybe "udevadm settle" would work too!? I simply don't know if 
> udev or sleep would have any affect here at all. When testing locally 
> the thing always works without any sleep. But this may not mean 
> anything (as I've learned from ul test suite issues).

maybe use timeout(1) instead of waiting the full 2 seconds?

  timeout 2 sh -c 'while [ ! -e /dev/raw/$rawdev ]; do sleep .1; done'

Still pretty ugly, but performs better. ;-)

Have a nice day,
Berny
