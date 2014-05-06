Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36714 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754459AbaEFMMD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 6 May 2014 08:12:03 -0400
Message-Id: <1399378322.18824.114190781.0FF4ADDF@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: Bjarni Ingi Gislason <bjarniig@rhi.hi.is>,
        "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <20140506101829.GK5962@x2.net.home>
References: <1399084359-28425-1-git-send-email-bjarniig@rhi.hi.is>
 <1399084359-28425-4-git-send-email-bjarniig@rhi.hi.is>
 <1399121099.30443.113236621.44458DE1@webmail.messagingengine.com>
 <20140506101829.GK5962@x2.net.home>
Subject: Re: [PATCH 20/21] login-utils/last.1: Improve the typesetting of the
 manual
Date: Tue, 06 May 2014 14:12:02 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Tue, May 6, 2014, at 12:18, Karel Zak wrote:
> On Sat, May 03, 2014 at 02:44:59PM +0200, Benno Schulenberg wrote:
> > On Sat, May 3, 2014, at 4:32, Bjarni Ingi Gislason wrote:
> > >   Add a space character in front of an ellipsis
> > 
> > Hmm.  I find it clearer when the ellipsis is glued to the thing
> > that it applies to.  But, as a space before it seems to be the
> > accepted convention, okay.
> 
>  But it would be nice to be consistent. Few minutes ago I merged your
>  patch with
> 
>      - <device> [...]
>      + <device>...\
> 
>  I don't have any strong opinion about it, but I'd like to avoid 
>  situation when we every week change it.

:)

Of course.  We'll wait and see what Bjarni has to say.  If he has a
strong opinion about this, we'll go with his.  If not, we'll negotiate
and agree on something.

Benno

-- 
http://www.fastmail.fm - The way an email service should be

