Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751178AbdGQJ3C (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 Jul 2017 05:29:02 -0400
Date: Mon, 17 Jul 2017 11:28:58 +0200
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 0/5] pull: five mutually unrelated changes
Message-ID: <20170717092858.xoxpracpdbbv6xvo@ws.net.home>
References: <20170715212046.1655-1-kerolasa@iki.fi>
 <596A9B0D.6060400@gmail.com>
 <CAG27Bk0TFAUb_cDv9fADiFpVzwP_fboUP6o9ZrZELQiCa=Vq3Q@mail.gmail.com>
 <596B8585.2060405@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <596B8585.2060405@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jul 16, 2017 at 10:25:57AM -0500, Bruce Dubbs wrote:
> Sami Kerola wrote:
> > On 15 July 2017 at 23:45, Bruce Dubbs <bruce.dubbs@gmail.com> wrote:
> > > > The 'big' change in this pull request is to drop reset(1) from util-linux.
> > > > I don't think there is any point of keep this script hanging around.
> > > 
> > > Why do you think that.  I find it useful when some application corrupts the
> > > screen.  I realize that reset is a symlink to tset, but I find reset easier
> > > to remember/use.
> > 
> > The ncurses package contains both binaries tput(1) and reset(1). So this
> > script will not work without ncurses, and the very same package has the
> > binary that obsoletes the script.
> 
> Thanks.  I agree that duplicate functions should be removed.

And note that it's already deprecated and disabled by default. You
need --enable-reset now. I guess distros use reset(1) from ncurses for
really long time.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
