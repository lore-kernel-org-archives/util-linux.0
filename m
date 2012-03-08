Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52164 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752132Ab2CHLLO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 Mar 2012 06:11:14 -0500
Date: Thu, 8 Mar 2012 12:11:10 +0100
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: util-linux <util-linux@vger.kernel.org>,
        Michael Kerrisk <mtk.manpages@googlemail.com>
Subject: Re: online man pages
Message-ID: <20120308111110.GA17711@x2.net.home>
References: <4F42FC23.1020602@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4F42FC23.1020602@draigBrady.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 21, 2012 at 02:06:27AM +0000, Pádraig Brady wrote:
> I was looking to reference online util-linux man pages,
> and found the options spammy or out of date.
> I was wondering could they be hosted something like:
> http://www.kernel.org/doc/man-pages/online_pages.html

We can create

 http://ftp.kernel.org/pub/linux/utils/util-linux/man-pages/

it would be nice to have a script in tools/ (e.g. tools/ko-manpages-gen)
to generate a directory with the html man pages, then I can upload it
easily to kernel.org.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
