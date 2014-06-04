Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28853 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751335AbaFDJ0G (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 4 Jun 2014 05:26:06 -0400
Date: Wed, 4 Jun 2014 11:26:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: build-sys: minor issues
Message-ID: <20140604092600.GT9000@x2.net.home>
References: <201406020056.17074.sweet_f_a@gmx.de>
 <201406031509.24914.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201406031509.24914.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 03, 2014 at 03:09:24PM +0200, Ruediger Meier wrote:
> On Monday 02 June 2014, Ruediger Meier wrote:
> > I have two minor issues with our build-sys:
> 
> Another issue:
> 
> 4. --disable-all-programs disables pylibmount forever
> 
> --with-python   does not turn it on again
> --enable-pylibmount  does not exist

 OK, I have added --enable-pylibmount, so you have to use:

 ./configure --disable-all-programs \
             --enable-pylibmount \
             --enable-libmount \
             --enable-libblkid

 to compile the binding.


> or do I miss something?

note that we don't have --enable-* for all utils. It's probably
overkill for small utils or utils expected everywhere.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
