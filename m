Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42627 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754685Ab3I3Nvl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Sep 2013 09:51:41 -0400
Date: Mon, 30 Sep 2013 15:51:39 +0200
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?=C1ngel_Gonz=E1lez?= <ingenit@zoho.com>
Cc: util-linux@vger.kernel.org
Subject: Re: Wrong more(1) bash-completion on filenames with spaces
Message-ID: <20130930135139.GO5101@x2.net.home>
References: <51D196DC.9070401@zoho.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <51D196DC.9070401@zoho.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 01, 2013 at 04:49:00PM +0200, Ángel González wrote:
> The bash completion for more(1) treats the space-separated pieces of
> filenames as different files.
> 
> $ touch foo\ bar
> $ more foo<TAB>
> bar foo

 Fixed. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
