Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58263 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761AbaLOJTf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Dec 2014 04:19:35 -0500
Date: Mon, 15 Dec 2014 10:19:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Will Johansson <will.johansson@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: login-utils: Enable building util-linux against OpenPAM
Message-ID: <20141215091931.GW19904@x2.net.home>
References: <1418179231-21326-1-git-send-email-will.johansson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1418179231-21326-1-git-send-email-will.johansson@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 09, 2014 at 06:40:30PM -0800, Will Johansson wrote:
> I recently experimented with cross-compiling for embedded devices, and
> sought to try out util-linux with OpenPAM instead of Linux-PAM because
> OpenPAM was simpler to cross-compile. Unfortunately for me, it did not
> work out of the box, so I decided to try to patch util-linux to support
> compiling against OpenPAM. Turned out to be a fairly simple exercise.
> 
> This is the fruit of my efforts. There is a caveat, which I will

 Applied, thanks.

> be happy to address if it's a problem. The patch's configuration does
> not support building if you happen to have both Linux-PAM and OpenPAM
> in your build paths. I could update it to prefer Linux-PAM by default.
> I'm not sure how it'd would work if OpenPAM libraries is also in the
> search path, as -lpam is used by both Linux-PAM and OpenPAM (probably
> undefined behavior).
> 
> Either way, it should compile fine against Linux-PAM and OpenPAM.
> There are some unused variables in login.c, but seems to have to do
> with _HAVE_UT_TV, which is not the case in my configuration. I'm
> more than happy to provide a separate patch to wrap the unused
> variables with an #ifdef _HAVE_UT_TV.

 I don't have OpenPAM, so I'm not able to verify usability, but it
 would be nice to have build without warnings.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
