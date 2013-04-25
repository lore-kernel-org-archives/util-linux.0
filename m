Return-Path: linux-fsdevel-owner@vger.kernel.org
MIME-Version: 1.0
In-Reply-To: <20130425110450.GF2244@x2.net.home>
References: <20130425110450.GF2244@x2.net.home>
Date: Thu, 25 Apr 2013 13:59:51 +0200
Message-ID: <CAFLxGvyBc2c95BGQ78vuz0iofGB65RD6bFxF3kQpg48-ViZQsw@mail.gmail.com>
Subject: Re: [ANNOUNCE] util-linux 2.23
From: richard -rw- weinberger <richard.weinberger@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 25, 2013 at 1:04 PM, Karel Zak <kzak@redhat.com> wrote:
> The util-linux release 2.23 is available at
>
>    ftp://ftp.kernel.org/pub/linux/utils/util-linux/v2.23
>
> Feedback and bug reports, as always, are welcomed.
>
>        Karel
>
>
>
> Util-linux 2.23 Release Notes
> =============================
>
> The cryptoloop support in the commands mount(8) and losetup(8) has been
> REMOVED. The encryption= mount option and -e,-E,--encryption losetup options
> are no more supported.
>
> The command arch(1) has been REMOVED from util-linux in favour of coreutils
> version.
>
> The command chkdupexe has been REMOVED from util-linux.
>
> The library libblkid supports LIBBLKID_DEBUG=<mask> environment variable to
> print debug messages on stderr. The old BLKID_DEBUG= is no more supported.
>
> Release highlights
> ------------------
>
> nsenter(1):
>   - this NEW COMMAND provides command line interface to setns() Linux syscall
>     and allows to run program with namespaces of other processes

It would be nice if nsenter(1) would allow us to specify a uid/gid
which is switched to
if a user namespace is entered. Otherwise we become nobody:nogroup
after entering the
user namespace.

I.e. ./nsenter -t <pid> -U --setuid=0 --setgid=0

Would you accept such a patch? :)

--
Thanks,
//richard
