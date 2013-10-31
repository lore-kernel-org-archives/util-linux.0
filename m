Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f44.google.com ([209.85.216.44]:39177 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751456Ab3JaQHW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 31 Oct 2013 12:07:22 -0400
Received: by mail-qa0-f44.google.com with SMTP id cm18so4678271qab.10
        for <util-linux@vger.kernel.org>; Thu, 31 Oct 2013 09:07:21 -0700 (PDT)
Date: Thu, 31 Oct 2013 12:07:19 -0400
From: Dave Reisner <d@falconindy.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: umount: it seems %s is mounted multiple times
Message-ID: <20131031160719.GP735@rampage>
References: <52727CF6.5050604@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52727CF6.5050604@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 31, 2013 at 11:53:26AM -0400, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> When non root tries to umount a directory that has multiple mounts in
> it, mount dies with this error message.  Why is this?  Why doesn't it
> check for the user option and either give the permission error, or
> allow the umount?

I'd urge you to verify this behavior on the new umount tool. This error
message is only thrown by the deprecated umount tool slated to be
removed from util-linux between now and 2.25.

Cheers,
Dave
