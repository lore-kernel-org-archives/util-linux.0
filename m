Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34578 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752708AbaEFJ06 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 May 2014 05:26:58 -0400
Date: Tue, 6 May 2014 11:26:50 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Benno Schulenberg <bensberg@justemail.net>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: cytune: misnamed long options
Message-ID: <20140506092650.GC5962@x2.net.home>
References: <1398847941.19293.112034049.7CA00422@webmail.messagingengine.com>
 <CAG27Bk0A3cHh1v6Q6yPOqorZ8AkxpxRr3rj_jCnW8NB=FcsmKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk0A3cHh1v6Q6yPOqorZ8AkxpxRr3rj_jCnW8NB=FcsmKQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 30, 2014 at 12:25:49PM +0100, Sami Kerola wrote:
> On 30 April 2014 09:52, Benno Schulenberg <bensberg@justemail.net> wrote:
> > According to the code and the man page of cytune, the option -g
> > shows the current values of the threshold and the flush timeout,
> > and option -G shows the default values.  But the corresponding
> > long options of those two are: --get-threshold and --get-flush.
> > Confusing.  Shouldn't those be changed to --get-current and
> > --get-defaults?  (Or the first one maybe just --get?)  However,
> > the docs say not to change any options.  What to do?  Sami?
> 
> Hi Benno,
> 
> The recommendation never to change options tries to protect a Random J
> Developer in breaking existing scripts. If options are deprecated at
> least there should be a backwards compatibility with a deprecation
> warning for some time (couple years).
> 
> Looking the kernel interface
> 
> http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/tty/cyclades.c#n2639
> 
> the 'threshold' keyword seems to be ok. Use of word 'flush' is a bit
> odd, and 'timeout' would be closer match with what the kernel is
> doing. Karel, are you OK with s/flush/timeout/ ABI change?

 NACK, it seems better to be backwardly compatible than perfect.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
