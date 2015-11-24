Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59073 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751939AbbKXPdF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Nov 2015 10:33:05 -0500
Date: Tue, 24 Nov 2015 16:33:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Tzafrir Cohen <tzafrir@cohens.org.il>
Cc: util-linux@vger.kernel.org
Subject: Re: sfdisk: dump format changed in 2.26
Message-ID: <20151124153300.GD4955@ws.net.home>
References: <20151119092827.GJ23928@lemon.cohens.org.il>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151119092827.GJ23928@lemon.cohens.org.il>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Nov 19, 2015 at 10:28:28AM +0100, Tzafrir Cohen wrote:
> New versions seem to be able to use old dumps.

This has been the most important :-)

> A simple script I use here to convert new format to old:
> 
> sed \
>         -e 's/type=/Id=/' \
>         -e '/^label:/d' \
>         -e '/^label-id:/d' \
>         -e '/^device:/d' \
>         #
> 
> From what I could see, "Id" was changed to "type" in the body and
> various extra header lines were added. Al of those changes make the dump
> file unreadable by older versions.
> 
> Is there any intention to support some sort of compatibility through an
> extra option?

I'm not sure if we really need (and want) to provide compatibility in
this way. Maybe we can add the sed command to the man page.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
