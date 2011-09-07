Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20898 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753874Ab1IGFp3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Sep 2011 01:45:29 -0400
Date: Wed, 7 Sep 2011 07:45:23 +0200
From: Karel Zak <kzak@redhat.com>
To: Francesco Cosoleto <cosoleto@gmail.com>
Cc: util-linux <util-linux@vger.kernel.org>, werner@suse.de
Subject: Re: agetty: double equals sign typo in opentty()
Message-ID: <20110907054523.GC2496@nb.redhat.com>
References: <CAMFXF50k2Q7JAQH8kkZkqVCf9SM9ava1EmxRmBzqhdhqO8uQLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAMFXF50k2Q7JAQH8kkZkqVCf9SM9ava1EmxRmBzqhdhqO8uQLA@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 06, 2011 at 10:50:58PM +0200, Francesco Cosoleto wrote:
> agetty.c(988): warning #187: use of "=" where "==" may have been intended
>         if (ioctl(STDIN_FILENO, TIOCMGET, &serial) < 0 && (errno = EINVAL)) {

 Fixed. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
