Return-Path: sweet_f_a@gmx.de
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH 2/2] build-sys: install missing bash completions
Date: Thu, 17 Mar 2016 17:52:27 +0100
Cc: util-linux@vger.kernel.org
References: <1458209046-18526-1-git-send-email-sweet_f_a@gmx.de> <1458209046-18526-2-git-send-email-sweet_f_a@gmx.de> <20160317131320.tj343znddbo6vqex@ws.net.home>
In-Reply-To: <20160317131320.tj343znddbo6vqex@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201603171752.27998.sweet_f_a@gmx.de>
List-ID: <util-linux.vger.kernel.org>

On Thursday 17 March 2016, Karel Zak wrote:
> On Thu, Mar 17, 2016 at 11:04:06AM +0100, Ruediger Meier wrote:
> > We haven't installed these files since three years. Hopefully
> > they will work.
>
>  I have added tools/checkcompletion.sh (sorry about my shell
>  programming skills, it requires bash:-), so now:
>
>  $ make checkcompletion
>  Missing completion scripts:
>     agetty
>     findfs
>     kill
>     line
>     login
>     runuser
>     sulogin
>     switch_root
>     vipw

> > +if BUILD_MOUNT
> > +dist_bashcompletion_DATA += bash-completion/mount
> > +dist_bashcompletion_DATA += bash-completion/umount
> > +endif
>
>  ... and checkcompletion does not check for incomplete Makefiles of
>  course, but better than nothing.

Maybe checkcompletion.sh would be more simple and safe if we do
"make install DESTDIR=/tmp/dest" and compare installed *bin/ binaries.
with installed completions (and BTW manpages!). It would also discover
Makefile bugs. I'm sure that such distcheck-hook scripts should
already exist. Like rpmlint does such checks for the distro packages
and prints warnings plus counts negative scores:

RPMLINT report:
===============
[...]
util-linux.x86_64: W: no-manual-page-for-binary flushb
util-linux.x86_64: W: no-manual-page-for-binary chrp-addnote
Each executable in standard binary directories should have a man page.
[...]



But actually the most simple way to find non-distributed
files in _general_ is IMO this:

$ make distdir
$ find util-linux-2.28.rc1-65-5ae7a/ -type f -printf "%P\n" | sort > files-dist
$ git ls-files | sort > files-git
$ diff files-git files-dist | grep "^<"

These are so few (or generic) currently that we could maintain a
whitelist "non-distributed-files". And add such a check to the
distcheck somehow.

cu,
Rudi
