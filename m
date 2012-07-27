Return-Path: dave@gnu.org
Subject: Re: v2.22-rc2 wish list
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Karel Zak <kzak@redhat.com>, kerolasa@gmail.com,
        util-linux@vger.kernel.org
In-Reply-To: <50127F34.70406@bernhard-voelker.de>
References: <20120727081033.GA14019@x2.net.home>
	 <CAG27Bk1mk08N=0Zbo-Bbd_v93C6cfEcO1chYyiDAtRf1sQOEpw@mail.gmail.com>
	 <20120727103132.GA28708@x2.net.home> <501271D2.8090708@bernhard-voelker.de>
	 <20120727111550.GA29738@x2.net.home>  <50127F34.70406@bernhard-voelker.de>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 27 Jul 2012 15:13:24 +0200
Message-ID: <1343394804.2752.5.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

On Fri, 2012-07-27 at 13:44 +0200, Bernhard Voelker wrote:
> On 07/27/2012 01:15 PM, Karel Zak wrote:
> > On Fri, Jul 27, 2012 at 12:47:46PM +0200, Bernhard Voelker wrote:
> >> On 07/27/2012 12:31 PM, Karel Zak wrote:
> >>>  Maybe, but many of the tests requires root permissions and it's
> >>>  designed for developers only. I'd like to avoid situations when the
> >>>  tests are executed with root permissions by automatic distro build
> >>>  systems etc.
> >>
> >> Why? The more folks run the tests, the more bugs can be reported and fixed.
> >> What's wrong about the tests? And if there's something wrong: shouldn't
> >> they not be made more robust?
> >>
> >> E.g. coreutils also has many tests which "require_root", and I think
> >> it's safe to run these tests.
> > 
> > Does the tests modify /etc/fstab, mount another filesystems and
> > initialize scsi_debug, loop and raid devices?
> 
> yes, but I don't consider mount/umount as too dangerous - coreutils'
> test suite also does it. Some more harmful tests could be guarded by
> some special mechanism, e.g. an environment variable.
> 
> > I have experience that some distros and end-users rebuild packages
> > as superuser.
> 
> Building as root is certainly not okay, but prior to packaging UL into a
> distro or applying it on a few servers, I expect every admin and
> distro maintainer to run 'make check'.
> 
> With a proper test suite, we give him/her a basic test to check whether
> the software is running as expected in his/her environment. Otherwise,
> he doesn't have much chance other than waiting for productive problems.
> 
I partially agree with this. However our test scripts are strictly
regression testing and, of course, that is part of the development
cycle, so end-users have no business dealing with this. For example, we
cannot ask users to rebuild their kernel just to run theses tests (like
scsi_debug module).

> > I don't want to be responsible for possible problems on
> > the target systems.
> 
> You aren't:
>   $ grep -i warranty COPYING
> ;-)
> 
> Have a nice day,
> Berny
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
