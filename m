Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48383 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754074AbbFONJg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 15 Jun 2015 09:09:36 -0400
Date: Mon, 15 Jun 2015 15:09:33 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Martin Steigerwald <ms@teamix.de>, Util-Linux <util-linux@vger.kernel.org>
Subject: Re: chrt: inconsistency in --help
Message-ID: <20150615130933.GU1992@ws.net.home>
References: <716925135.onXIMLDpa0@merkaba>
 <20150609092412.GG1992@ws.net.home>
 <1434013428.75585.292665745.17FBFAD5@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434013428.75585.292665745.17FBFAD5@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jun 11, 2015 at 11:03:48AM +0200, Benno Schulenberg wrote:
> So, to make usage synopsis clearer and correct I would suggest
> rewriting it as:
> 
> Set policy:
>     chrt [options] <priority> <command> [<arg>...]
>     chrt [options] -p <priority> <pid>

 OK, it looks better.
 
> The first of the upcoming two patches makes this change.

 Applied, thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
