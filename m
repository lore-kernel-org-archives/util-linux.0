Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47590 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbbGBIc3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 2 Jul 2015 04:32:29 -0400
Date: Thu, 2 Jul 2015 10:32:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: script, broken test options/return
Message-ID: <20150702083227.GE26962@ws.net.home>
References: <201507020203.21632.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201507020203.21632.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 02, 2015 at 02:03:21AM +0200, Ruediger Meier wrote:
> 25708: script:       IO: master fd: 3
> 25708: script:   SIGNAL: signal fd=5
> 25708: script:     POLL: calling poll()
> 25708: script:     POLL: poll() rc=1
> 25708: script:     POLL:  active pfd[stdin].fd=0 POLLIN
> 25708: script:       IO: 0 FD active
> 25708: script:     POLL: calling poll()
> 25708: script:     POLL: poll() rc=1
> 25708: script:     POLL:  active pfd[stdin].fd=0 POLLIN
> 25708: script:       IO: 0 FD active
> 25708: script:     POLL: calling poll()
> 25708: script:     POLL: poll() rc=1
> 25708: script:     POLL:  active pfd[stdin].fd=0 POLLIN
> 25708: script:       IO: 0 FD active
> 25708: script:     POLL: calling poll()
> 25708: script:     POLL: poll() rc=1
> 25708: script:     POLL:  active pfd[stdin].fd=0 POLLIN
> 25708: script:       IO: 0 FD active
> 25708: script:     POLL: calling poll()
> 25708: script:     POLL: poll() rc=1

It seems that handle_io() is not able to detect EOF, I have pushed a
commit that makes sure errno is zero (I guess it's the problem).

Please, try it. Thanks.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
