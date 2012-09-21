Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:64692 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757221Ab2IUKHA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 21 Sep 2012 06:07:00 -0400
Date: Fri, 21 Sep 2012 12:06:53 +0200
From: Karel Zak <kzak@redhat.com>
To: Queen Adam <adam900710@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Default wait time in hwclock is not long enough for some ARM
 devices
Message-ID: <20120921100653.GA17643@x2.net.home>
References: <CAFy8SQX-F5r+ztpJ9ZnBNwSjcbBqBN=g6-ZiSfV2sW_dBRv+tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAFy8SQX-F5r+ztpJ9ZnBNwSjcbBqBN=g6-ZiSfV2sW_dBRv+tQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Sep 16, 2012 at 02:11:48PM +0800, Queen Adam wrote:
> After I change the timeout from 5 to 10, the problem is solved.

 Applied, thanks.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
