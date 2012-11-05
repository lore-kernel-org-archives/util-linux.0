Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:17471 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932107Ab2KES41 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 5 Nov 2012 13:56:27 -0500
Date: Mon, 5 Nov 2012 19:56:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Toshi Kani <toshi.kani@hp.com>
Cc: util-linux@vger.kernel.org, heiko.carstens@de.ibm.com, kerolasa@iki.fi
Subject: Re: [PATCH RESEND] lscpu: Fix issue found on CPU hot-remove
Message-ID: <20121105185614.GF3799@x2.net.home>
References: <1352135015-13946-1-git-send-email-toshi.kani@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1352135015-13946-1-git-send-email-toshi.kani@hp.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 05, 2012 at 10:03:35AM -0700, Toshi Kani wrote:
> read_basicinfo() relies on sysfs cpu directories
> "/sys/devices/system/cpu/cpu%d" with assumption that cpu
> logical number %d is always sequentially assigned for all

Ah, sorry I have moved the mail to my mail archive without response...
thanks for resend.

It seems correct, I'll apply the patch tomorrow.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
