Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52147 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933446AbbEMKhR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 May 2015 06:37:17 -0400
Date: Wed, 13 May 2015 12:37:06 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: Ron <ron@debian.org>, 785116@bugs.debian.org, util-linux@vger.kernel.org
Subject: Re: Bug#785116: util-linux: blkid -s returns too much information
Message-ID: <20150513103706.GE4834@ws.net.home>
References: <20150512132634.1127.8640.reportbug@hex.shelbyville.oz>
 <20150513063604.GA466@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150513063604.GA466@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 13, 2015 at 08:36:04AM +0200, Andreas Henriksson wrote:
> Possibly changing the output format now could be risky.

 Yes. Ron is right, the current behaviour is strange, but I'm not sure
 if we want to fix it after 3 years.
 
 And I'm also not sure it the current behavior is so big problem. If you 
 want just one value than it makes more sense to use

    # blkid  -s UUID -o value /dev/sdb1
    f0710187-82bf-4646-b2e3-11b017e31218

 and if you ask for more tags by "-o export" than you cannot rely on 
 order of the lines, so DEVNAME= in the output cannot be a problem.

> Lets ask upstream if DEVNAME is considered a tag which should
> be included in the tag filtering.... CCed.

 I have a patch to fix it, but now when I think about it it's probably
 better to keep the current behavior than fix one regression by
 another regression ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
