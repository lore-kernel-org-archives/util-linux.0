Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:14130 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377Ab2LJLtG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 10 Dec 2012 06:49:06 -0500
Date: Mon, 10 Dec 2012 12:49:01 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: blkid: exit code as non-root user, and segfault
Message-ID: <20121210114901.GD21405@x2.net.home>
References: <50C4CFDD.1070405@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50C4CFDD.1070405@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 09, 2012 at 06:52:29PM +0100, Bernhard Voelker wrote:
> blkid returns 0 without output when running as non-root user
> and when the cache /dev/.blkid.tab is not yet there:
> 
>   ./blkid /dev/sdb3 ; echo $?
>   0

 [...]

>   access("/dev/sdb3", F_OK)               = 0
>   stat("/dev/sdb3", {st_mode=S_IFBLK|0660, st_rdev=makedev(8, 19), ...}) = 0

 [...]

> I'd have expected either an error message along with exit code 1,
> or success with some useful output.

 Well, it seems that the code differentiate between:

  a) device does not exist:

      $ blkid /dev/FooBar; echo $?
      2

     or exists but does not match:

      $ blkid -t LABEL=xyz /dev/sda1; echo $?
      2

  b) device exists, but there is nothing to print

      $ blkid /dev/sda1; echo $?
      0

     just for the record, you can always print device name:

      $ blkid -o device /dev/sda1; echo $?
      /dev/sda1
      0


 maybe it's not obvious at a first glance, but the current behavior
 seems correct.

 Maybe we can detect the special situation (and print a warning
 message) when the cache is empty and user is non-root to make it more
 user-friendly. I'm not sure if any change in return code is necessary.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
