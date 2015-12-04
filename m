Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:51045 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754837AbbLDVkZ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 4 Dec 2015 16:40:25 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: "U.Mutlu" <for-gmane@mutluit.com>
Subject: Re: fsck memory leak
Date: Fri, 4 Dec 2015 22:40:19 +0100
Cc: util-linux@vger.kernel.org
References: <n3rei3$8l3$1@ger.gmane.org> <20151204195848.GA18359@thunk.org> <n3st78$77b$1@ger.gmane.org>
In-Reply-To: <n3st78$77b$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <201512042240.19891.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Friday 04 December 2015, U.Mutlu wrote:
> I think it's a double-edged sword: if user has less memory then
> the integrated caching will IMO degrade the performance.

It will use as much memory as available (not more). Ideally Linux would 
use always 100% memory. You've spent money for memory ... why you 
wouldn't want to use it?

After ...
$ echo 3 > /proc/sys/vm/drop_caches

... my memory looks like this:
$ free -h
             total    used    free       shared    buffers     cached
Mem:          7.7G    1.8G    6.0G         230M       4.4M       487M
-/+ buffers/cache:    1.3G    6.5G
Swap:         1.7G     68M    1.6G

Then after ...
$ dd if=/dev/sda of=/dev/null count=8K bs=1M

... cache/buffer is filled
$ free -h
             total    used    free       shared    buffers     cached
Mem:          7.7G    7.6G    168M <=(1)   230M       5.6G       665M
-/+ buffers/cache:    1.3G    6.5G <=(2)
Swap:         1.7G     68M    1.6G

... and this should not change until reboot.

(1) shows that almost 100% memory is "in use"
(2) shows that it's just buffer or cache

sorun yapma ;)
Rudi
