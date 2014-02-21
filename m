Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:65096 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755098AbaBUMJv (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 21 Feb 2014 07:09:51 -0500
Date: Fri, 21 Feb 2014 13:09:46 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Bruce Dubbs <bruce.dubbs@gmail.com>, util-linux-ng@vger.kernel.org
Subject: Re: findmnt/df discrepancy
Message-ID: <20140221120946.GD30903@x2.net.home>
References: <52FB9355.3090702@gmail.com>
 <20140212153806.GB583@rampage>
 <52FEE6E5.7010206@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52FEE6E5.7010206@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Feb 14, 2014 at 11:02:45PM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA512
> 
> On 02/12/2014 10:38 AM, Dave Reisner wrote:
> > It's the reserved space on the filesystem. On an ext4 FS where the 
> > reserved space is 0%, df and findmnt (mostly) agree:
> 
> Why would findmnt report a different value?  It is the kernel that
> adjusts the numbers it returns in statfs(), which both should be using.

I have added a new option --bytes to findmnt(8) (we already have the
same option in lsblk(8)), so now it's more obvious:

        $ df --block-size=1 /dev/sda5
        Filesystem         1B-blocks        Used   Available Use% Mounted on
        /dev/sda5        66650419200 39057010688 24184123392  62% /home

        $ findmnt --df --bytes
        /dev/sda5
        SOURCE    FSTYPE        SIZE        USED       AVAIL USE% TARGET
        /dev/sda5 ext4   66650419200 39057010688 24184123392  59% /home


so yes, both use the same numbers from statvfs(), but findmnt(8)
counts USE% from the USED field, but df(1) counts Use% from the
Available column.

The conversion to human readable sizes is another story:

        $ findmnt --df  /dev/sda5
        SOURCE    FSTYPE  SIZE  USED AVAIL USE% TARGET
        /dev/sda5 ext4   62.1G 36.4G 22.5G  59% /home

        $ df -h /dev/sda5
        master
        Filesystem      Size  Used Avail Use% Mounted on
        /dev/sda5        63G   37G   23G  62% /home


for example available space:

        $ echo "24184123392 / (1024 * 1024 * 1024)" | bc -l
        22.52322006225585937500


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
