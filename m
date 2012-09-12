Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59755 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757819Ab2ILMw4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 12 Sep 2012 08:52:56 -0400
Date: Wed, 12 Sep 2012 14:52:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Ludwig Nussel <ludwig.nussel@suse.de>, util-linux@vger.kernel.org
Subject: Re: [PATCH] remove obsolete encryption support from losetup
Message-ID: <20120912125248.GD17256@x2.net.home>
References: <1339747456-30761-1-git-send-email-ludwig.nussel@suse.de>
 <20120911084908.GA30228@x2.net.home>
 <1098712216.1298354.1347356412043.JavaMail.open-xchange@email.1und1.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1098712216.1298354.1347356412043.JavaMail.open-xchange@email.1und1.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 11, 2012 at 11:40:11AM +0200, Bernhard Voelker wrote:
> I think there are still a few fragments left, aren't there?
> At least in include/loopdev.h, in lib/loopdev.c and in

 Well, this is API for kernel struct loop_info64 and we still prints
 info about encrypted loopdevs in losetup output.

> tests/ts/mount/ecrypted.

 Good point. Removed. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
