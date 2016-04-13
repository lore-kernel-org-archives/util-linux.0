Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:34518 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751747AbcDML6T (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Apr 2016 07:58:19 -0400
Date: Wed, 13 Apr 2016 13:58:17 +0200
From: Karel Zak <kzak@redhat.com>
To: Ponomarenko Andrey <andrewponomarenko@yandex.ru>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.28
Message-ID: <20160413115817.zcynugu6uxiewouj@ws.net.home>
References: <20160412113004.zog62jry7cv7cv67@ws.net.home>
 <3763281460543608@web6g.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <3763281460543608@web6g.yandex.ru>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Apr 13, 2016 at 01:33:28PM +0300, Ponomarenko Andrey wrote:
> 12.04.2016, 14:30, "Karel Zak":
> > The util-linux release v2.28 is available at
> >
> >   http://ftp.kernel.org/pub/linux/utils/util-linux/v2.28
> >
> > Feedback and bug reports, as always, are welcomed.
> >
> 
> The ABI report for 2.28: http://abi-laboratory.pro/tracker/timeline/util-linux/
 
That's nice tool. It would be nice to use it before release (for
example for rc1 or rc2) next time. Thanks!

(Note that 2.26.2 has been about symbol versioning script bugfix,
 fortunately libfdisk has been used by util-linux only.)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
