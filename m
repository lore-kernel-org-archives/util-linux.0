Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35455 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbaHUPil (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 21 Aug 2014 11:38:41 -0400
Received: by mail-qg0-f43.google.com with SMTP id a108so8915843qge.16
        for <util-linux@vger.kernel.org>; Thu, 21 Aug 2014 08:38:40 -0700 (PDT)
Date: Thu, 21 Aug 2014 11:38:37 -0400
From: Dave Reisner <d@falconindy.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Dave Reisner <dreisner@archlinux.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] mountpoint: drop S_ISDIR check
Message-ID: <20140821153837.GG511@rampage>
References: <1408625292-2445-1-git-send-email-dreisner@archlinux.org>
 <53F608BA.4080401@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53F608BA.4080401@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Aug 21, 2014 at 04:56:58PM +0200, Bernhard Voelker wrote:
> On 08/21/2014 02:48 PM, Dave Reisner wrote:
> > Files can be mountpoints, too.
> 
> just out of curiosity - how?
> 
>  $ touch /tmp/mountpoint
>  $ mount -t proc proc /tmp/mountpoint
>  mount: mount point /tmp/mountpoint is not a directory
> 
> Thanks & have a nice day,
> Berny

You cannot mount a file on a directory, but you can mount a file on a
file.

Cheers,
d
