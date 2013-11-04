Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32768 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753565Ab3KDOQO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Nov 2013 09:16:14 -0500
Date: Mon, 4 Nov 2013 15:16:11 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: external mount utilities and utab
Message-ID: <20131104141611.GD21311@x2.net.home>
References: <5273FF29.1090403@ubuntu.com>
 <20131104133735.GH23604@x2.net.home>
 <5277AA0C.70309@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5277AA0C.70309@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 04, 2013 at 09:07:08AM -0500, Phillip Susi wrote:
> Are you saying then that all of the helpers should now be using
> libmount, and taking care of the utab updates themselves rather than
> just having mount do it?

 That would be the best solution (and not only for utab, but also for
 options parsing, userspace options, command line options used for
 helpers, etc.). It's better to have all the things in one library.

 Anyway, the change I did today allows to use "user" fstab mount
 option also for non-libmount external helper.

 It's already in my TODO list to write libmount patch for mount.cifs.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
