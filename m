Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47002 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754664AbaJUJz3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 21 Oct 2014 05:55:29 -0400
Date: Tue, 21 Oct 2014 11:55:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Robert Milasan <rmilasan@suse.com>
Cc: util-linux@vger.kernel.org
Subject: Re: swapon: fix -d short option
Message-ID: <20141021095525.GG8057@x2.net.home>
References: <20141021100246.3e956b6d@viper.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141021100246.3e956b6d@viper.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 21, 2014 at 10:02:46AM +0200, Robert Milasan wrote:
> When -d option is used with swapon, is expected that there is an equal
> '=' which at least according to the man page it doesn't make sense or
> it's not properly explained.

Well, in the man page there was incorrectly extra space between -d and
the optional argument. Fixed yesterday.

> If we use -d as we should, then swapon takes 'once' or 'pages' as an
> actual device:
> 
> dhcp33:~ # swapon -p -2 -d once /dev/sdb1
> swapon: stat failed once: No such file or directory
> 
> The short option -d, should be something like "swapon -d once ...." not
> "swapon -d=once ...."

What? The argument for -d is optional, it's reason why we care about
'='. I think it's obvious from the code.

   swapon -p -2 -d /dev/sdb1 

is pretty valid.

Note that -d,--discard has been implemented in 2010, and extended by
'once' and 'pages' later in 2013.

> I've attached the patch to fix this small issue.

Sorry, but the patch does not make sense.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
