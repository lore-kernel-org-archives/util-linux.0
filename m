Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42174 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952Ab2CBNYz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 2 Mar 2012 08:24:55 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q22DOt70006464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Fri, 2 Mar 2012 08:24:55 -0500
Date: Fri, 2 Mar 2012 14:24:53 +0100
From: Karel Zak <kzak@redhat.com>
To: Balamurugan Arumugam <barumuga@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: unclear udev format output of blkid
Message-ID: <20120302132453.GG18642@x2.net.home>
References: <5f2c4b72-cda0-4618-ae7c-b89333c1d2b9@zmail01.collab.prod.int.phx2.redhat.com>
 <249be96a-803a-4d00-b5b1-ff3f18722a36@zmail01.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <249be96a-803a-4d00-b5b1-ff3f18722a36@zmail01.collab.prod.int.phx2.redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Mar 02, 2012 at 06:18:13AM -0500, Balamurugan Arumugam wrote:
> We are trying to parse blkid output in python for all devices and their attributes.

 Why? Maybe we can help you...

 Do you know that udev db already contains all the attributes? Try:

    udevadm info --export-db

 See also lsblk --help, it returns many information about block devices.

> I found two strange things.
> 1. udev format output is grouped by empty newline, but I see an extra newline in between.
> Below is the example,

 See Thomas's response, this output format is deprecated. Use "-o export".

 Unfortunately, the "export" format does not contain devname too. This
 problem should be fixed in git tree now. (Thanks for bug report.)

> [root@fedora-16-test ~]# blkid -c /dev/null -o udev

 The command blkid without '-p' returns only small subset of all
 available attributes. The command blkid was originally designed 
 for LABEL/UUID conversion to devname. The cache (high-level API of
 the library) does not contain more information.

 I'd like to remove the cache from blkid command and use the low-level
 (-p) by default one day. The cache is confusing for many people...


 My suggestion is to read the information from udev db (you can use
 libudev too) or use something like:

  for x in $(lsblk --output KNAME); do
    blkid -p -o export /dev/$x
    echo
  done
 
 I hope that one day the for() will be unnecessary and blkid without
 -p will return all information.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
