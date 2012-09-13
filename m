Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20229 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754843Ab2IMLFn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 13 Sep 2012 07:05:43 -0400
Date: Thu, 13 Sep 2012 13:05:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Andrea Bonomi <a.bonomi@endian.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/2] agetty: display network address in issue
Message-ID: <20120913110539.GA13016@x2.net.home>
References: <2B6CF89C-6218-4289-B116-27108562664F@endian.com>
 <BBDB2F27-F199-4F90-B393-569763011661@endian.com>
 <20120912093728.GA17256@x2.net.home>
 <49CAD42E-995E-4C66-A9AD-5939968A54F7@endian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <49CAD42E-995E-4C66-A9AD-5939968A54F7@endian.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Sep 12, 2012 at 07:29:19PM +0200, Andrea Bonomi wrote:
> Hi,
> good idea, much better without the hardcoded interface name.
> I think that the --interface option is useful for the machine with a dynamic IP address.
> (in my experience, the getaddrinfo based on the hostname returns the loopback address)
> 
> Another idea will be to add the interface name after the \4 or \6, something like:
> \4eth0 (or similar…)

Excellent idea. It also means that --interface is unnecessary and
more than one interface IP maybe be printed by the issue file.

> to get the IPv4 address of the interface eth0
> So the user can specify the interface name directly in the issue file.
> What do you think?

Implemented, merged into master branch. For example:

    lo = \4{lo}
   em1 = \4{em1}  (IPv6 \6{em1})
virbr0 = \4{virbr0}

The {..} is optional argument, if not given, host IP is printed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
