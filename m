Return-Path: mail@bernhard-voelker.de
Message-ID: <50176B4D.2060501@bernhard-voelker.de>
Date: Tue, 31 Jul 2012 07:21:17 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: kerolasa@gmail.com, util-linux@vger.kernel.org
Subject: Re: v2.22-rc2 wish list
References: <20120727081033.GA14019@x2.net.home> <CAG27Bk1mk08N=0Zbo-Bbd_v93C6cfEcO1chYyiDAtRf1sQOEpw@mail.gmail.com> <20120727103132.GA28708@x2.net.home> <501271D2.8090708@bernhard-voelker.de> <20120727111550.GA29738@x2.net.home> <50127F34.70406@bernhard-voelker.de> <20120730163720.GM5845@x2.net.home>
In-Reply-To: <20120730163720.GM5845@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>



On 07/30/2012 06:37 PM, Karel Zak wrote:
> On Fri, Jul 27, 2012 at 01:44:52PM +0200, Bernhard Voelker wrote:
>> Building as root is certainly not okay, but prior to packaging UL into a
>> distro or applying it on a few servers, I expect every admin and
>> distro maintainer to run 'make check'.
> 
> I have added tests/run.sh to 'make check' for non-root users. It should
> be enough for smart people who do not rebuild their packages as root.
> 
> If you want to run all utils-linux tests then you have to
> 
>     cd tests && ./run.sh
> 
> *manually* as root user.

Great, thanks!

Have a nice day,
Berny
