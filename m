Return-Path: ah@fatal.se
Date: Wed, 17 Sep 2014 16:43:44 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] Patches for kFreeBSD support from Debian
Message-ID: <20140917144344.GA985@fatal.se>
References: <1408896284-14467-1-git-send-email-andreas@fatal.se>
 <20140917090010.GI7867@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140917090010.GI7867@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

Hello Karel Zak!

Thanks for reviewing/merging these. I'll try to find time to do
a test-build on a kfreebsd machine and also forward you the
libmount/fsck related patches soon.

On Wed, Sep 17, 2014 at 11:00:10AM +0200, Karel Zak wrote:
[...]
> > Christoph Egger (1):
> >   Fixing FTBFS on !linux (Debian util-linux 2.20.1-1.2)
> 
>  -lutil everywhere seems like overkill as login_tty() is probably 
>  necessary for BSD only, so I have applied the patch below too.
> 
>     Karel

You are probably right! This is from the i386 build logs in Debian:

[...]
 dh_shlibdeps -a
dpkg-shlibdeps: warning: package could avoid a useless dependency if debian/util-linux/sbin/agetty was not linked against libutil.so.1 (it uses none of the library's symbols)
dpkg-shlibdeps: warning: package could avoid a useless dependency if debian/bsdutils/usr/bin/logger was not linked against libsystemd-id128.so.0 (it uses none of the library's symbols)
   dh_installdeb -a
[...]

Full log at:
https://buildd.debian.org/status/fetch.php?pkg=util-linux&arch=i386&ver=2.25.1-1&stamp=1410137520


Regards,
Andreas Henriksson
