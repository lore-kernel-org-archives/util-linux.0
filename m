Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:61470 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753811AbdFSJzm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 19 Jun 2017 05:55:42 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] uuidparse: add new command
Date: Mon, 19 Jun 2017 11:55:22 +0200
Cc: Sami Kerola <kerolasa@iki.fi>, util-linux@vger.kernel.org
References: <20170618172536.21544-1-kerolasa@iki.fi> <201706191122.48481.sweet_f_a@gmx.de> <20170619092813.evirrk3zy6omv6xi@ws.net.home>
In-Reply-To: <20170619092813.evirrk3zy6omv6xi@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201706191155.23149.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Monday 19 June 2017, Karel Zak wrote:
> On Mon, Jun 19, 2017 at 11:22:48AM +0200, Ruediger Meier wrote:
> > > +static void __attribute__((__noreturn__)) usage(FILE *out)
> >
> > Do we really need this FILE argument? You are using only stdout in
> > uuidparse and that's good and should never change ;) I can't
> > imagine any good reason why usage should ever go to stderr and
> > exit(1).
> >
> > BTW currently I'm going through the whole project to correct all
> > commands where we spam the whole usage in case of errors.
>
> That's legacy from time we used usage(stderr) for command line
> parsing errors. Now we use errtryhelp().

Yes I know, but there are still a few commands where we could 
correct --help, etc.

FYI I've made a little script to find candidates to fix, see below. I 
will send some patches.

$ ./tools/check_help.sh
flock: --help, no stdout
flock: --help, non-empty stderr
getopt: --help, returns error
kill: --unknownopt, stderr too short: 1
mkfs.cramfs: --help, returns error
mkfs.cramfs: --version, returns error
whereis: --help, returns error
whereis: --version, returns error
whereis: --unknownopt, stderr too long: 18
agetty: --unknownopt, stderr too long: 45
blockdev: --unknownopt, stderr too long: 28
fsck: --help, returns error
fsck: --version, returns error
fsck: --unknownopt, non-empty stdout
fsck: --unknownopt, stderr too long: 18
login: --help, returns error
login: --version, returns error
login: --unknownopt, stderr too long: 4
lsipc: --unknownopt, stderr too long: 77
mkfs: --unknownopt, stderr too long: 8
more: --help, returns error
more: --version, returns error
more: --unknownopt, stderr too long: 21
nologin: --help, returns error
nologin: --version, returns error
pg: --unknownopt, stderr too long: 23
renice: --unknownopt, stderr too long: 18
rtcwake: --unknownopt, non-empty stdout
rtcwake: --unknownopt, stderr too long: 21
sulogin: --unknownopt, stderr too long: 17
write: --unknownopt, stderr too long: 12

(There are also some false positives like nologin.)

cu,
Rudi
