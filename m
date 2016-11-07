Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46564 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752434AbcKGNiM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 7 Nov 2016 08:38:12 -0500
Date: Mon, 7 Nov 2016 14:38:10 +0100
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH 3/3] tests: always quote $LODEV
Message-ID: <20161107133810.2jvyfrye74d2mozi@ws.net.home>
References: <1478358489-18103-1-git-send-email-sweet_f_a@gmx.de>
 <201611071121.55542.sweet_f_a@gmx.de>
 <20161107113721.z53bvekbw3swgaxc@ws.net.home>
 <201611071348.23789.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201611071348.23789.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 07, 2016 at 01:48:23PM +0100, Ruediger Meier wrote:
> On Monday 07 November 2016, Karel Zak wrote:
> > On Mon, Nov 07, 2016 at 11:21:55AM +0100, Ruediger Meier wrote:
> 
> > > BTW would be also very nice to ensure by design that --help,
> > > manpage and the actual commands are always synchron.
> >
> > It depends what do you mean with synchron. All options should be
> > documented by --help and man page, [...]
> 
> Yes it should, but we have very often inconsistencies, like
> 
> 89de71b3
> 3fabc363
> 21c6bcbd
> ce969b16
> 
> Bugs like these are IMO waste of human life time. They can be avoided 
> automatically from the beginning.

Depends how expensive (maintenance overhead, extra changes in code)
will be the smart solution. The nice thing on getopt_long is that it
does not add any extra abstract layer -- it just tokenize command 
line and all is in your hands.

> > Frankly, all we need is to detect mistakes (undocumented options).
> 
> Why would you want to detect this but not want to use existing tools?

when I think about external tool, then:

 * is it commonly used tool?
 * is it fine to depend on the tool from bootstrap point of view?
   (for example gtk-docs is absolutely optional and unnecessary for users).
 * is it easy to integrate to our code?
 * how expensive is to maintain it?

For example if there is way how to generate the getopt stuff by m4
without any additional dependence, it's easy to maintain (include
translations by .po files) then it sounds good.

If you believe that yuck is the right way then send a patch for some
new tool (e.g. lsns) and we can test it and try it -- but don't forget
I'm stubborn for such things :-)

> > I'd like to be conservative and avoid complex solutions. I think our
> > --help is nice and works as expected :-)
> 
> Even I've just run a stupid shell command line to find out that our 
> getopt and flock have broken --help implementations.

Bug, like many others.

> stderr or do not return 0. I'm sure that we would find much more 
> problems with the non-trivial options.
> 
> whereis has no such options --help/--version. Is this on purpose?

We maintain many random tools with very different history, not all is
already completely refactored to be compatible with our "current
standard".

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
