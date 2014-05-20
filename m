Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45435 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751966AbaETILu (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 20 May 2014 04:11:50 -0400
Message-Id: <1400573509.16753.119372357.3CE7F060@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: kerolasa@gmail.com
Cc: "util-linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <CAG27Bk2qzzF2BNp=ec+x4zn8WOc40CNn8qKyG9_H5+mdWHb5ew@mail.gmail.com>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
 <CAG27Bk2qzzF2BNp=ec+x4zn8WOc40CNn8qKyG9_H5+mdWHb5ew@mail.gmail.com>
Subject: Re: [PATCH 00/17] pull: almost complete setterm refactoring
Date: Tue, 20 May 2014 10:11:49 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Some day Karel Zak wrote:
> >     _(" -hbcolor <bright> <color>\n")
> >
> > and describe below in usage():
> >
> >    _(" <color> means black, blue, ...")

But but but... the word "bright" is not a placeholder, it must not
be replaced by something else, as <color> by blue, for example.
It is a literal argument, so should not take <>, and it is optional,
so it should take [].  No?

Benno

-- 
http://www.fastmail.fm - A no graphics, no pop-ups email service

