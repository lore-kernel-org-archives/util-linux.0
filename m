Return-Path: linux-fsdevel-owner@vger.kernel.org
Message-ID: <1366912466.1837.0.camel@buesod1.americas.hpqcorp.net>
Subject: Re: [ANNOUNCE] util-linux 2.23
From: Davidlohr Bueso <davidlohr.bueso@hp.com>
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: Karel Zak <kzak@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        util-linux@vger.kernel.org
Date: Thu, 25 Apr 2013 10:54:26 -0700
In-Reply-To: <CAFLxGvyBc2c95BGQ78vuz0iofGB65RD6bFxF3kQpg48-ViZQsw@mail.gmail.com>
References: <20130425110450.GF2244@x2.net.home>
	 <CAFLxGvyBc2c95BGQ78vuz0iofGB65RD6bFxF3kQpg48-ViZQsw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, 2013-04-25 at 13:59 +0200, richard -rw- weinberger wrote:
> On Thu, Apr 25, 2013 at 1:04 PM, Karel Zak <kzak@redhat.com> wrote:
> > The util-linux release 2.23 is available at
> >
> >    ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.23
> >
> > Feedback and bug reports, as always, are welcomed.
> >
> >        Karel
> >
> >
> >
> > Util-linux 2.23 Release Notes
> > =============================
> >
> > The cryptoloop support in the commands mount(8) and losetup(8) has been
> > REMOVED. The encryption= mount option and -e,-E,--encryption losetup options
> > are no more supported.
> >
> > The command arch(1) has been REMOVED from util-linux in favour of coreutils
> > version.
> >
> > The command chkdupexe has been REMOVED from util-linux.
> >
> > The library libblkid supports LIBBLKID_DEBUG=<mask> environment variable to
> > print debug messages on stderr. The old BLKID_DEBUG= is no more supported.
> >
> > Release highlights
> > ------------------
> >
> > nsenter(1):
> >   - this NEW COMMAND provides command line interface to setns() Linux syscall
> >     and allows to run program with namespaces of other processes
> 
> It would be nice if nsenter(1) would allow us to specify a uid/gid
> which is switched to
> if a user namespace is entered. Otherwise we become nobody:nogroup
> after entering the
> user namespace.

+1

