Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f48.google.com ([209.85.216.48]:39812 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbaBLPiJ (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 12 Feb 2014 10:38:09 -0500
Received: by mail-qa0-f48.google.com with SMTP id f11so14155582qae.35
        for <util-linux-ng@vger.kernel.org>; Wed, 12 Feb 2014 07:38:08 -0800 (PST)
Date: Wed, 12 Feb 2014 10:38:06 -0500
From: Dave Reisner <d@falconindy.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux-ng@vger.kernel.org
Subject: Re: findmnt/df discrepancy
Message-ID: <20140212153806.GB583@rampage>
References: <52FB9355.3090702@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52FB9355.3090702@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 12, 2014 at 09:29:25AM -0600, Bruce Dubbs wrote:
> I've noticed a discrepancy in percent free between findmnt and df:
> 
> $ df -h|grep /tmp
> /dev/sdb5        9.8G  8.3G  967M  90% /tmp
> $ findmnt --df|grep /tmp
> /dev/sdb5  ext4  9.7G  8.3G  967M  85% /tmp
> 
> Actually, the discrepancy seems to be df as 8.3/9.8 is 84.7%.
> Can anyone here explain the difference?  Should it be submitted to
> coreutils as a bug?

It's the reserved space on the filesystem. On an ext4 FS where the
reserved space is 0%, df and findmnt (mostly) agree:

$ df -h | grep Gluttony
 /dev/sdb2             1.8T  701G     1.1T  39% /mnt/Gluttony

$ findmnt --df | grep Gluttony
 /dev/sdb2     ext4    1.8T  700.1G   1.1T  39% /mnt/Gluttony


