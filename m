Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: sfdisk, latest fixes break ppc64
Date: Wed, 22 Apr 2015 18:10:46 +0200
Cc: Bernhard Voelker <mail@bernhard-voelker.de>, util-linux@vger.kernel.org
References: <201504211234.27649.sweet_f_a@gmx.de> <5537B53F.2070805@bernhard-voelker.de> <20150422154656.GG27969@ws.net.home>
In-Reply-To: <20150422154656.GG27969@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201504221810.47262.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Wednesday 22 April 2015 at 17:46, you wrote:
> We already use
>
>     https://drone.io/github.com/karelzak/util-linux
>
> and
>
>     https://travis-ci.org/karelzak/util-linux
>
> both connected to github, but for ppc64 and s390 I use machines in
> Red Hat labs and during -rc1 I usually use Coverity analyzer.
>
> It's also possible to use Fedora/Suse build farms, but we don't
> execute all the tests (especially tests where is necessary root
> perms) by default.

You can get root permission there with such a trick "root4abuild" rpm
https://build.opensuse.org/package/view_file/home:rudi_m/root4abuild/root4abuild.spec?expand=1

BTW we could also add some more non-root tests. For example it's very 
easy to duplicate most *fdisk checks to use simple files additionally 
to loop devices only.

> Anyway, this is no problem, the problem is real life testing.
> Fortunately, I can push unstable stuff to Fedora Rawhide :)


cu,
Rudi
