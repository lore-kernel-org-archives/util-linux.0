Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:45272 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755073AbdC2Jlq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 29 Mar 2017 05:41:46 -0400
Date: Wed, 29 Mar 2017 11:41:36 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: col issue
Message-ID: <20170329094136.u4m7gqpqohm6nsvn@ws.net.home>
References: <20170328121630.prr5s6aikqvt2awt@ws.net.home>
 <CAG27Bk2OsrRkvnUZEPjRPVFVgiow2iY4-yCszOU=KAfNYAcX5w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk2OsrRkvnUZEPjRPVFVgiow2iY4-yCszOU=KAfNYAcX5w@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Mar 28, 2017 at 10:38:46PM +0100, Sami Kerola wrote:
> This is what Open Group[1] has to say about col(1) input handling.
> 
> On input, the only control characters accepted are space, backspace, tab,
> carriage-return and newline characters, SI, SO, VT, reverse line-feed,
> forward half-line-feed and reverse half-line-feed.  The VT character
> is an alternative form of full reverse line-feed, included for
> compatibility with some earlier programs of this type.  The only
> other characters to be copied to the output are those that are printable.
> 
> Last sentence is pretty clear that control characters must be removed.  I am
> not sure if the definition was meant to include control sequences, but it
> feels that is the spirit of the definition.  Maybe a silly question how to
> choose control sequences that are recognised?  Maybe ECMA-48, VT100, and
> Unicode.

I think to keep the col(1) usable there is necessary to have a way how
to filter out the sequences *or* keep the sequences unchanged (-p). The
current behavior produces malformed output. From my point of view it
would be enough to fix -p (at least for ^[..m).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
