Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16061 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754867AbaENLE5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 May 2014 07:04:57 -0400
Date: Wed, 14 May 2014 13:04:50 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: losesetup -f, broken error handling
Message-ID: <20140514110450.GC26357@x2.net.home>
References: <201405121510.46066.sweet_f_a@gmx.de>
 <20140513092016.GN8951@x2.net.home>
 <201405132311.40706.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201405132311.40706.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, May 13, 2014 at 11:11:40PM +0200, Ruediger Meier wrote:
> Below the otput of following commands. For comparison the first losetupfrom PATH
> is the installed one util-linux 2.20.1. Full build log here
> https://s3.amazonaws.com/archive.travis-ci.org/jobs/25104283/log.txt

 The comparison is unnecessary as the code and semantic is very different.

 Anyway, it's real issue, because on systems without /dev/loop-control
 it might incorrectly returns loop0 although the device does not exist.

> lt-losetup from util-linux 2.24.749-4bbea
> ######## ./losetup -f
> /dev/loop0
> 0

 I hope it's fixed now. Please, try it again.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
