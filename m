Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:56858 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320AbbK1AP5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 27 Nov 2015 19:15:57 -0500
Date: Sat, 28 Nov 2015 01:15:55 +0100
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
Cc: Evgenii Sovetkin <e.sovetkin@gmail.com>, util-linux@vger.kernel.org
Subject: Re: bug in the cal
Message-ID: <20151128001550.GG4955@ws.net.home>
References: <20151127142227.GA28400@bigbear.stochastik.rwth-aachen.de>
 <56589098.1080209@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <56589098.1080209@zoho.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Nov 27, 2015 at 06:19:20PM +0100, Ángel González wrote:
> So the problem is that
> > cal -n 3
> > cal --months 3
> 
> is acting as
> > cal -3

 Already fixed in git three.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
