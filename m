Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35228 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750782AbaLOMri (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Dec 2014 07:47:38 -0500
Date: Mon, 15 Dec 2014 13:47:35 +0100
From: Karel Zak <kzak@redhat.com>
To: Will Johansson <will.johansson@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: login-utils: Enable building util-linux against OpenPAM
Message-ID: <20141215124735.GB19904@x2.net.home>
References: <1418179231-21326-1-git-send-email-will.johansson@gmail.com>
 <20141215091931.GW19904@x2.net.home>
 <CAE83jyxVG_CKR6rzmdO==rJB7aA8kWasXvXyK_PW8C6SAbzLAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAE83jyxVG_CKR6rzmdO==rJB7aA8kWasXvXyK_PW8C6SAbzLAg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 15, 2014 at 03:46:55AM -0800, Will Johansson wrote:
> Hi Karel,
> 
> Thanks for applying. I have a small patch for _HAVE_UT_TV incoming in
> a few minutes.
> 
> Turns out it was because musl-libc doesn't define _HAVE_UT_TV, even
> though musl-libc's utmp struct does have a ut_tv field. There are two
> options: 1.) I could patch upstream musl-libc to define _HAVE_UT_TV or
> 2.) detect musl-libc somehow. I think I prefer the first option.

Well, you have to care about already released musl-libc -- it's easy to detect 
that by AC_CHECK_MEMBERS() in configure.ac. It would be nice to fix
the problem in util-linux code independently on your item 1).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
