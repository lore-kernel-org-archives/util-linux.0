Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55222 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751109Ab2KPKOZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 16 Nov 2012 05:14:25 -0500
Date: Fri, 16 Nov 2012 11:14:19 +0100
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Lennart Poettering <lennart@poettering.net>
Subject: Re: agetty and special chars @ and #
Message-ID: <20121116101419.GC20338@x2.net.home>
References: <20121107165859.GD4383@x2.net.home>
 <20121112100410.GA1887@boole.suse.de>
 <20121112132926.GD26857@x2.net.home>
 <20121114142720.GA23414@boole.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121114142720.GA23414@boole.suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 14, 2012 at 03:27:20PM +0100, Dr. Werner Fink wrote:
> Indeed this is a good solution ... but in the case of systemd and its
> getty generator we may think about a /etc/agettytab with a similar
> syntax scheme as the old /etc/inittab to be able to provide agetty
> options based on the used tty line.  Clearly this /etc/agettytab should
> be parsed by agetty and options for the specified tty are found:
> 
>   1:tty1:--noclear %p
>   2:tty2:%p
>   3:tty3:%p
>   4:tty4:%p
>   5:tty5:%p
>   6:tty6:%p
>   S0:ttyS0:--erase-chars # --kill-chars @ -mt 60 %p 9600,2400,1200
>   S1:ttyS0:-L 9600 %p 9600 vt102

 Hmm, I guess it's still possible to create tty line specific config
 file on systems with systemd. I'd like to avoid another place where
 will be configuration.

 Lennart?



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
