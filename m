Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50822 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751350AbdIEMgC (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 5 Sep 2017 08:36:02 -0400
Date: Tue, 5 Sep 2017 14:35:59 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] hwclock: add -a that is short of --adjust to manual page
 and usage
Message-ID: <20170905123559.x7boyjsao45gqltq@ws>
References: <20170903223407.5459-1-kerolasa@iki.fi>
 <20170905110154.s3ld4ziq2fifprj2@ws>
 <CAG27Bk3HmcYA6FQqKS-Q5y4cd88MVeawb3b5O9nOBG3fGWqXrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk3HmcYA6FQqKS-Q5y4cd88MVeawb3b5O9nOBG3fGWqXrw@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 05, 2017 at 01:01:08PM +0100, Sami Kerola wrote:
> >> -             { "version",      no_argument,       NULL, 'v'            },
> >> +             { "version",      no_argument,       NULL, 'V'            },
> >
> > What about backward compatibility? I can imagine script with "hwclock -v".
> 
> I should have been more clear in commit message. Sorry about that.
> 
> Backward compatibility is taken care by getops_long() optstring and
> later case match:

Oh, I see. Sorry. Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
