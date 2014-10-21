Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:45747 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932382AbaJUTll (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 21 Oct 2014 15:41:41 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by gateway2.nyi.internal (Postfix) with ESMTP id 7A14920B76
	for <util-linux@vger.kernel.org>; Tue, 21 Oct 2014 15:41:40 -0400 (EDT)
Message-Id: <1413920500.3703323.181688729.28BEAB7D@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: Robert Milasan <rmilasan@suse.com>,
        "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: swapon: fix -d short option
Date: Tue, 21 Oct 2014 21:41:40 +0200
In-Reply-To: <20141021103817.GH8057@x2.net.home>
References: <20141021100246.3e956b6d@viper.suse.cz>
 <20141021095525.GG8057@x2.net.home>
 <20141021120741.39f63265@viper.suse.cz>
 <20141021103817.GH8057@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Tue, Oct 21, 2014, at 12:38, Karel Zak wrote:
> Maybe we can add something like
> 
>      Note that the optional policy argument cannot be separated from the -d option by a space, 

It shouldn't be needed to mention this.  It is just common sense that
when an option argument is optional, you cannot separate it from the
option itself by any whitespace because then the parsing cannot decide
whether the thing is the optional option argument or simply another
plain argument.

>      the correct form is for example '-d=pages'.

Another correct form is '-dpages'.  For the short forms of the options
the '=' is not required.

Benno

-- 
http://www.fastmail.fm - Faster than the air-speed velocity of an
                          unladen european swallow

