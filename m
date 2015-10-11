Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:56856
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbbJKVHD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 Oct 2015 17:07:03 -0400
Date: Sun, 11 Oct 2015 22:58:48 +0200
From: Andreas Henriksson <andreas@fatal.se>
To: Anthony DeRobertis <anthony@derobert.net>, 801527@bugs.debian.org
Cc: util-linux@vger.kernel.org
Subject: Re: Bug#801527: mount believes correctly-formatted UDF uid=forget
 option is in error
Message-ID: <20151011205848.GA16027@fatal.se>
References: <20151011172712.28932.10676.reportbug@Watt.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151011172712.28932.10676.reportbug@Watt.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Control: tags -1 + upstream

Hello Anthony DeRobertis.

Thanks for your bug report.

On Sun, Oct 11, 2015 at 01:27:12PM -0400, Anthony DeRobertis wrote:
> Package: mount
> Version: 2.27-3
> Severity: important
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I recently upgraded a system to Jessie (from Wheezy), and mounting UDF
> filesystems broke. I confirmed the bug still exists on the machine I'm
> reporting from (which runs testing/unstable).

Jessie and onwards uses a new mount implementation based on libmount.

> 
> It appears mount has decided that "uid=ignore", "uid=forget",
> "gid=ignore", and "gid=forget" are invalid mount options. Instead of
> passing them to the kernel as it used to, it now prints "mount: failed
> to parse mount options"

Using LIBMOUNT_DEBUG=all mount -t udf -o uid=ignore,gid=forget ...
shows the following message (among others):

24171: libmount:    UTILS: cannot convert 'ignore' username to UID

... and according to the following code you seem to be very right
that except an actual uid you can also pass 'uid=ignore' or
'uid=forget' explicitly:

https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/udf/super.c#n352

I see several possible options for implementing this in the future:
 - special-case 'ignore' and 'forget' and pass those as is.
 - if uid-lookup fails, try the above.
 - (assuming different filesystems have different special options)
   let any fs-option through as-is if 'smart lookup' fails.
 - ...

I'm adding the upstream mailing list to CC in the hope that someone
has a suggestion on how to best handle this case.


> 
> busybox mount works fine, so the kernel is still happy with the options.
> And even in 4.2, they're still documented in
> Documentation/filesystems/udf.txt, so they should work.

Thanks for the extra data point.


Regards,
Andreas Henriksson
