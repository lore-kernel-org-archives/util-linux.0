Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54858 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757116AbbAZUvt (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 26 Jan 2015 15:51:49 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 9EF11207A8
	for <util-linux@vger.kernel.org>; Mon, 26 Jan 2015 15:51:46 -0500 (EST)
Message-Id: <1422305506.2285220.219171889.60EE85E9@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: Yuri Chornoivan <yurchor@gmail.com>,
        "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] Fix various minor typos
Date: Mon, 26 Jan 2015 21:51:46 +0100
In-Reply-To: <20150126104211.GI6354@x2.net.home>
References: <1422083931-24410-1-git-send-email-yurchor@ukr.net>
 <20150126104211.GI6354@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Mon, Jan 26, 2015, at 11:42, Karel Zak wrote:
> On Sat, Jan 24, 2015 at 09:18:51AM +0200, Yuri Chornoivan wrote:
> > --- a/Documentation/releases/v2.25-ReleaseNotes
> > +++ b/Documentation/releases/v2.25-ReleaseNotes
> > @@ -203,7 +203,7 @@ cal:
> >     - mention where Gregorian reformation happen in September 1752  [Sami Kerola]
> >     - remove optional from short arg -w  [Tommi Kyntola]
> >     - remove unnecessary static variables  [Sami Kerola]
> > -   - remove unnused structure and definition  [Sami Kerola]
> > +   - remove unused structure and definition  [Sami Kerola]
> 
> Benno is right, this is generated and the change will lost after
> ReleaseNotes update for -rc2.

Well, no.  Yuri made a change to the release notes of 2.25, not 2.26.

But never mind, very very few people will read those now.

Benno

-- 
http://www.fastmail.com - Does exactly what it says on the tin

