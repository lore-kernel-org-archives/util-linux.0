Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:21444 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751102Ab3JNHwv (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Oct 2013 03:52:51 -0400
Date: Mon, 14 Oct 2013 09:52:48 +0200
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.24-rc2
Message-ID: <20131014075248.GA28914@x2.net.home>
References: <20131011114403.GB24613@x2.net.home>
 <5258C359.9010407@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5258C359.9010407@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Oct 11, 2013 at 10:34:49PM -0500, Bruce Dubbs wrote:
> Surely bindir should not be /lib.  I can't even override it with
> --bindir=/bin

 Oh, this is stupid bug. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
