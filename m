Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:57793 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754922AbaC0Ski (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 27 Mar 2014 14:40:38 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1WTFEB-0005Zw-PV
	for util-linux@vger.kernel.org; Thu, 27 Mar 2014 19:40:35 +0100
Received: from 78-60-211-195.static.zebra.lt ([78.60.211.195])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 27 Mar 2014 19:40:35 +0100
Received: from grawity by 78-60-211-195.static.zebra.lt with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Thu, 27 Mar 2014 19:40:35 +0100
To: util-linux@vger.kernel.org
From: =?UTF-8?B?TWFudGFzIE1pa3VsxJduYXM=?= <grawity@gmail.com>
Subject: Re: tty swtch key
Date: Thu, 27 Mar 2014 20:40:22 +0200
Message-ID: <lh1ra8$dd7$1@ger.gmane.org>
References: <533320C5.7040609@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <533320C5.7040609@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2014-03-26 20:47, Phillip Susi wrote:
> I could have sworn that I used the tty swtch feature once many years
> ago and that it sent a special signal to the shell, causing it to be
> suspended and return you to the parent shell, as if you had entered
> the suspend command.  I can't find the signal in the man pages now,
> and using stty to set a swtch key and hitting it does nothing.  Is
> this unimplemented on linux, and if so, shouldn't the man page be
> updated to reflect that?

AFAIK, Linux never had this feature built-in. I'm not quite old enough
to have actually used it, but I've read and saved a few Usenet posts
that say `shl` ("shell layers") only existed in very old Unix versions
like SVR3, to compete with BSD-style job control.

(Looks like Google Groups removed find-by-Message-ID, unfortunately. I
guess I could just attach all of the posts...)

On the other hand, there _is_ a reimplementation of shl for Linux and
Solaris, as part of heirloom-toolchest
<http://heirloom.sourceforge.net/tools.html> and
<http://heirloom.sourceforge.net/man/shl.1.html>.

-- 
Mantas Mikulėnas <grawity@gmail.com>

